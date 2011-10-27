package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

import x10.compiler.Inline;
import x10.compiler.CUDA;
import x10.compiler.CUDADirectParams;

import x10.util.CUDAUtilities;

public class Engine {

    public globalWidth:Int;
    public globalHeight:Int;
    public localBlockWidth:Int;
    public localBlockHeight:Int;
    public localWidth:Int;
    public localHeight:Int;
    public horzSplits:Int;
    public vertSplits:Int;
    public horzBlocks:Int;
    public vertBlocks:Int;
    public localFrame:Array[RGB](1){self!=null};
    public verbose:Boolean;
    public quiet:Boolean;
    public dumpOctree:Boolean;
    public mipmapBias:Int;
    

    val octree : SpatialDatastructure;

    val vertexes : Array[MeshVertex](1);
    val skybox : Array[Texture2D](1);

    static val heightFieldDimX = 128;
    static val heightFieldDimY = 256;
    val heightFieldHost : Array[Float](1){rail};

    val gpu : Place;

    val gpuHeightField : RemoteArray[Float]{rank==1, home==gpu};
    val gpuVelocityField : RemoteArray[Float]{rank==1, home==gpu};

    static val RADIUS = 1;
    static val BLOCK_DIMX = 16;
    static val BLOCK_DIMY = BLOCK_DIMX;
    static val THREADS = BLOCK_DIMX*BLOCK_DIMY;
    static val BLOCKS_X = heightFieldDimX/BLOCK_DIMX;
    static val BLOCKS_Y = heightFieldDimY/BLOCK_DIMY;
    static val S_DATA_STRIDE = BLOCK_DIMX+2*RADIUS;
    static val S_DATA_SIZE = (BLOCK_DIMY+2*RADIUS)*S_DATA_STRIDE;

    var lastTime : Float;

    @Inline private static def lerp (v1:Float, v2:Float, a:Float) = (1-a)*v1 + a*v2;

    @Inline private final def heightFieldHeight(x:Int, y:Int) = heightFieldHost(y*heightFieldDimX + x);

    public final def heightFieldPerturb(xm:Int, ym:Int) {
        val x = Math.max(0, xm-1);
        val X = Math.min(heightFieldDimX, xm+1);
        val y = Math.max(0, ym-1);
        val Y = Math.min(heightFieldDimY, ym+1);

        val hy = heightFieldHeight(xm, y);
        val hY = heightFieldHeight(xm, Y);
        val hx = heightFieldHeight(x, ym);
        val hX = heightFieldHeight(X, ym);
        val r = 0.5f*Vector2(hx-hX, hy-hY);
        return Vector3(r.x, r.y, 1);
    }

    public final def heightFieldNormal(coord:Vector2) {
        val coord2 = coord * Vector2(heightFieldDimX,heightFieldDimY);
        val x0 = coord2.x as Int;
        val y0 = coord2.y as Int;
        val coord_fract = coord2 - Vector2(x0,y0);
        val n00 = heightFieldPerturb(x0+0,y0+0);
        val n01 = heightFieldPerturb(x0+1,y0+0);
        val n10 = heightFieldPerturb(x0+0,y0+1);
        val n11 = heightFieldPerturb(x0+1,y0+1);
        val n0 = Vector3.lerp(n00, n01, coord_fract.x);
        val n1 = Vector3.lerp(n10, n11, coord_fract.x);
        val n = Vector3.lerp(n0, n1, coord_fract.y);
        return n.normalised();
        //return Vector3(n00.x, n00.y, Math.sqrtf(1 - n00.x*n00.x - n00.y*n00.y));
        //return Vector3(n.x, n.y, Math.sqrtf(1 - n.x*n.x - n.y*n.y));
    }

    public def this (opts:OptionsParser, global_width:Int, global_height:Int, prims:Array[Primitive](1), vertexes:Array[MeshVertex](1), skybox:Array[Texture2D](1)) {

        verbose = opts("-v");
        quiet = opts("-q");

        dumpOctree = opts("-o");

        globalWidth = global_width;
        globalHeight = global_height;

        var horz_splits:Int = 1;
        switch (Place.MAX_PLACES) {
            case 1: horz_splits = 1; break;
            case 2: horz_splits = 2; break;
            case 3: horz_splits = 3; break;
            case 4: horz_splits = 2; break;
            case 6: horz_splits = 3; break;
            case 8: horz_splits = 4; break;
            case 9: horz_splits = 3; break;
            case 10: horz_splits = 5; break;
            default:
        }
        horzSplits = opts("-w",horz_splits);
        vertSplits = opts("-h",Place.MAX_PLACES / horz_splits);
        if (horzSplits * vertSplits != Place.MAX_PLACES) {
            throw new Error("Number of places not appropriate for given horizontal / vertical splits");
        }
        horzBlocks = opts("-x",4);
        vertBlocks = opts("-y",4);

        localWidth = global_width / horzSplits;
        localHeight = global_height / vertSplits;

        localBlockWidth = localWidth / horzBlocks;
        localBlockHeight = localHeight / vertBlocks;

        if (!quiet) {
            Console.OUT.println("horzSplits: "+horzSplits);
            Console.OUT.println("vertSplits: "+vertSplits);
            Console.OUT.println("localWidth: "+localWidth);
            Console.OUT.println("localHeight: "+localHeight);
            Console.OUT.println();
            Console.OUT.println("horzBlocks: "+horzBlocks);
            Console.OUT.println("vertBlocks: "+vertBlocks);
            Console.OUT.println("localBlockWidth: "+localBlockWidth);
            Console.OUT.println("localBlockHeight: "+localBlockHeight);
        }

        localFrame = new Array[RGB](localWidth * localHeight);

        octree = opts("-l")
               ? new LooseOctree(opts("-d",10), AABB(Vector3(-10,-10,-10),Vector3(10,10,10)), 20.0f)
               : new      Octree(opts("-d",10), AABB(Vector3(-10,-10,-10),Vector3(10,10,10)));

        mipmapBias = opts("-b",0);

        this.vertexes = vertexes;
        this.skybox = skybox;

        for (p in prims.values()) {
            octree.insert(p);
        }

        octree.bake();

        if (dumpOctree) Console.OUT.println(octree);

        heightFieldHost = new Array[Float](heightFieldDimX * heightFieldDimY, 0.0f);

        gpu = here.children().size==0 ? here : here.child(0);

        gpuHeightField = CUDAUtilities.makeRemoteArray[Float](gpu, heightFieldDimX*heightFieldDimY, heightFieldHost);
        gpuVelocityField = CUDAUtilities.makeRemoteArray[Float](gpu, heightFieldDimX*heightFieldDimY, 0.0f);

    }

    public static struct DirectionalLight(dir:Vector3, diff:Vector3, spec:Vector3) {
    };

    val sun = DirectionalLight(Vector3(0.4f,0.6f,1.0f).normalised(), Vector3(1,1,1), Vector3(2,2,2));

    val ambLight = 0.3f;

    public final def lightingEquation(s:RayState,
                                      surf_amb:Vector3, surf_diff:Vector3, surf_spec:Vector3, surf_gloss:Float, surf_normal:Vector3,
                                      surf_pos:Vector3, cam_dir:Vector3) {

        // ambient component
        val amb_comp = ambLight * surf_amb;

        // shadow test
        var shadowyness : Float = 0;
        if (s != null) {
            s.o = surf_pos;
            s.d = sun.dir;
            s.l = 50.0f;
            castRay(s);
            if (s.t < s.l) shadowyness = 1.0f;
        }

        // diffuse component
        val diff_exp = surf_normal.dot(sun.dir); 
        // half lambert shading 
        //val diff_ill = (diff_exp * 0.5f + 0.5f) * (diff_exp * 0.5f + 0.5f); 
        // standard shading 
        val diff_ill = Math.max(0.0f, diff_exp); 
        val diff_comp = (1 - shadowyness) * diff_ill * sun.diff * surf_diff;

        // specular component (phong)
        val spec_exp = -cam_dir.dot(Vector3.reflect(sun.dir, surf_normal));
        val spec_ill = Math.pow(Math.max(0.0000001f,spec_exp),surf_gloss) as Float;
        val spec_comp = (1 - shadowyness) * spec_ill * sun.spec * surf_spec;

        // sum up all the components for the final colour
        return (amb_comp + diff_comp + spec_comp);
    }


    public static def to_col(x:Vector3) {
        val scaled = x*0.5f + Vector3(0.5f,0.5f,0.5f);
        return RGB(scaled.x, scaled.y, scaled.z);
    }

    public final def castRay (s:RayState) {
        s.t = s.l;
        // use line below to bypass octree optimisation
        //octree.iterateCargo((p:Primitive) => { p.intersectRay(s); });
        octree.castRay(s);
    }

    public final def skyboxRender(d:Vector3) : Vector3 {
        // <front> <back> <left> <right> <up> <down>
        if (d.y > 0 && Math.abs(d.x/d.y) <= 1 && Math.abs(d.z/d.y) <= 1) return skybox(0).clampedLookup(Vector2(d.x/d.y+1.0f,-d.z/d.y+1.0f)*0.5f,mipmapBias); 
        if (d.y < 0 && Math.abs(d.x/d.y) <= 1 && Math.abs(d.z/d.y) <= 1) return skybox(1).clampedLookup(Vector2(d.x/d.y+1.0f,  d.z/d.y+1.0f)*0.5f,mipmapBias);
        if (d.x < 0 && Math.abs(d.y/d.x) <= 1 && Math.abs(d.z/d.x) <= 1) return skybox(2).clampedLookup(Vector2(-d.y/d.x+1.0f,  d.z/d.x+1.0f)*0.5f,mipmapBias);
        if (d.x > 0 && Math.abs(d.y/d.x) <= 1 && Math.abs(d.z/d.x) <= 1) return skybox(3).clampedLookup(Vector2(-d.y/d.x+1.0f,-d.z/d.x+1.0f)*0.5f,mipmapBias);
        if (d.z > 0 && Math.abs(d.x/d.z) <= 1 && Math.abs(d.y/d.z) <= 1) return skybox(4).clampedLookup(Vector2(d.x/d.z+1.0f,  d.y/d.z+1.0f)*0.5f,mipmapBias);
        return skybox(5).clampedLookup(Vector2(-d.x/d.z+1.0f,  d.y/d.z+1.0f)*0.5f,mipmapBias);
    }

    public final def castRayAndRender (s:RayState) {
        castRay(s);
        if (s.t >= s.l) {
            return skybox==null ? RGB.DARK_BLUE as Vector3 : skyboxRender(s.d);
        } else {
            return s.mat.render(this,s) ;
        }
    }

    public def renderFrame (frameBuffer:RemoteIndexedMemoryChunk[RGB], denting_water:Boolean, pos:Vector3, orientation:Quat, time:Float) {
        
        val horz_split = here.id % horzSplits;
        val vert_split = here.id / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);

        finish {

            if (gpu != here) async {
                // update heightfield front buffer
                val heightField = gpuHeightField;
                val vel = gpuVelocityField;
                val dimx = heightFieldDimX;
                val dimy = heightFieldDimY;
                val BLOCKS_X_ = BLOCKS_X;
                val interval = 0.2f;
                val iters = ((time - lastTime) / interval) as Int;
                lastTime += iters * interval;
                val hit_pos_x : Int;
                val hit_pos_y : Int;
                if (denting_water) {
                    val dir = orientation * Vector3(0,1,0);
                    val t = - pos.z / dir.z;
                    val hit_pos = pos + t*dir;
                    val hit_pos2 = (Vector2(hit_pos.x/7.0f, hit_pos.y/13.0f) + Vector2(0.5f,0.5f));
                    hit_pos_x = (hit_pos2.x * heightFieldDimX) as Int;
                    hit_pos_y = (hit_pos2.y * heightFieldDimY) as Int;
                } else {
                    hit_pos_x = -1;
                    hit_pos_y = -1;
                }
                for (i in 1 .. iters) {
                    val g = gpu;
                    finish async at (g) @CUDA @CUDADirectParams {
                        finish for (block in 0..(BLOCKS_X_*BLOCKS_Y-1)) async {
                            val s_data_h = new Array[Float](S_DATA_SIZE, 0.0f);
                            clocked finish for (thread in 0..(THREADS-1)) clocked async {
                                val blockidx = block%BLOCKS_X_;
                                val blockidy = block/BLOCKS_X_;
                                val threadidx = thread%BLOCK_DIMX;
                                val threadidy = thread/BLOCK_DIMX;

                                // populate s_data_h
                                for (sy in 0..(BLOCK_DIMY + 2*RADIUS - 1)) {
                                    val gy = sy - RADIUS + blockidy*BLOCK_DIMY;
                                    for (var sx:Int=thread ; sx<BLOCK_DIMX+2*RADIUS ; sx+=THREADS) {
                                        val gx = sx - RADIUS + blockidx*BLOCK_DIMX;
                                        if (gx==hit_pos_x && gy==hit_pos_y) {
                                            s_data_h(sy*S_DATA_STRIDE + sx) = -1.0f;
                                        } else if (gx>=0 && gx< dimx && gy>=0 && gy<dimy) {
                                            s_data_h(sy*S_DATA_STRIDE + sx) = heightField(gy*dimx + gx);
                                        } else {
                                            s_data_h(sy*S_DATA_STRIDE + sx) = 0.0f;
                                        }
                                    }
                                }

                                Clock.advanceAll();

                                val gtx = (blockidx*BLOCK_DIMX+threadidx);
                                val gty = (blockidy*BLOCK_DIMY+threadidy);

                                val curr_h = s_data_h((threadidy+RADIUS)*S_DATA_STRIDE + threadidx+RADIUS);

                                val curr_v:Float = vel(gty*dimx + gtx);
                                var disp:Float = 0.0f;
                                disp += s_data_h((threadidy+RADIUS-1)*S_DATA_STRIDE + threadidx+RADIUS+0);
                                disp += s_data_h((threadidy+RADIUS+0)*S_DATA_STRIDE + threadidx+RADIUS-1);
                                disp += s_data_h((threadidy+RADIUS+0)*S_DATA_STRIDE + threadidx+RADIUS+1);
                                disp += s_data_h((threadidy+RADIUS+1)*S_DATA_STRIDE + threadidx+RADIUS+0);
                                disp = 0.25f*disp - curr_h;
                                val accel = 5.0f * disp - 0.05f * curr_v;
                                val new_v = curr_v + interval*accel;

                                vel(gty*dimx + gtx) = new_v;
                                heightField(gty*dimx + gtx) = curr_h + interval*new_v;
                            }
                        }
                    }
                }
                Array.asyncCopy(gpuHeightField, 0, heightFieldHost, 0, heightFieldHost.size);
            }

            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);

            for (by in 0..(vertBlocks-1)) async {
                val block_off_y = by * localBlockHeight;
                finish for (bx in 0..(horzBlocks-1)) async {
                    val block_off_x = bx * localBlockWidth;
                    val state = new RayState(this, time, 4);
                    state.o = pos;
                    for (y_ in 0..(localBlockHeight-1)) {
                        val y = y_ + block_off_y;
                        val y_norm = -(y+0.5f+offset_y)/globalHeight*2.0f + 1.0f;
                        for (x_ in 0..(localBlockWidth-1)) {
                            val x = x_ + block_off_x;
                            val x_norm = (x+0.5f+offset_x)/globalWidth*2.0f - 1.0f;
                            val ray = x_norm * globalWidth/globalHeight * right
                                    + forwards
                                    + y_norm * up;
                            state.d = ray * 800;
                            state.l = state.d.length();
                            state.d /= state.l;
                            localFrame(y*localWidth + x) = castRayAndRender(state) as RGB;
                        }
                    }
                }
                for (y_ in 0..(localBlockHeight-1)) {
                    val y = y_ + block_off_y;
                    IndexedMemoryChunk.asyncCopy(localFrame.raw(), y*localWidth, frameBuffer, offset_x + (offset_y+y)*globalWidth, localWidth);
                }
            }

        }

        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

