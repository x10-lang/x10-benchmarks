package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;

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
    public localFrame:Rail[RGB]{self!=null};
    public verbose:Boolean;
    public quiet:Boolean;
    public dumpOctree:Boolean;
    public mipmapBias:Int;
    

    val octree:SpatialDatastructure;

    val vertexes:Rail[MeshVertex];
    val skybox:Rail[Texture2D];

    static val heightFieldDimX = 128n;
    static val heightFieldDimY = 256n;
    val heightFieldHost:Rail[Float];

    val gpu:Place;

    val gpuHeightField:GlobalRail[Float]{home==gpu};
    val gpuVelocityField:GlobalRail[Float]{home==gpu};

    static val RADIUS = 1n;
    static val BLOCK_DIMX = 16n;
    static val BLOCK_DIMY = BLOCK_DIMX;
    static val THREADS = BLOCK_DIMX*BLOCK_DIMY;
    static val BLOCKS_X = heightFieldDimX/BLOCK_DIMX;
    static val BLOCKS_Y = heightFieldDimY/BLOCK_DIMY;
    static val S_DATA_STRIDE = BLOCK_DIMX+2n*RADIUS;
    static val S_DATA_SIZE = (BLOCK_DIMY+2n*RADIUS)*S_DATA_STRIDE;

    var lastTime:Float;

    private static def lerp(v1:Float, v2:Float, a:Float) = (1-a)*v1 + a*v2;

    private final def heightFieldHeight(x:Int, y:Int) = heightFieldHost(y*heightFieldDimX + x);

    public final def heightFieldPerturb(xm:Int, ym:Int) {
        val x = Math.max(0n, xm-1n);
        val X = Math.min(heightFieldDimX, xm+1n);
        val y = Math.max(0n, ym-1n);
        val Y = Math.min(heightFieldDimY, ym+1n);

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
        val n00 = heightFieldPerturb(x0+0n,y0+0n);
        val n01 = heightFieldPerturb(x0+1n,y0+0n);
        val n10 = heightFieldPerturb(x0+0n,y0+1n);
        val n11 = heightFieldPerturb(x0+1n,y0+1n);
        val n0 = Vector3.lerp(n00, n01, coord_fract.x);
        val n1 = Vector3.lerp(n10, n11, coord_fract.x);
        val n = Vector3.lerp(n0, n1, coord_fract.y);
        return n.normalised();
        //return Vector3(n00.x, n00.y, Math.sqrtf(1 - n00.x*n00.x - n00.y*n00.y));
        //return Vector3(n.x, n.y, Math.sqrtf(1 - n.x*n.x - n.y*n.y));
    }

    public def this(opts:OptionsParser, global_width:Int, global_height:Int, prims:Rail[Primitive], vertexes:Rail[MeshVertex], skybox:Rail[Texture2D]) {

        verbose = opts("-v");
        quiet = opts("-q");

        dumpOctree = opts("-o");

        globalWidth = global_width;
        globalHeight = global_height;

        var horz_splits:Int = 1n;
        switch (Place.numPlaces() as Int) {
            case 1n: horz_splits = 1n; break;
            case 2n: horz_splits = 2n; break;
            case 3n: horz_splits = 3n; break;
            case 4n: horz_splits = 2n; break;
            case 6n: horz_splits = 3n; break;
            case 8n: horz_splits = 4n; break;
            case 9n: horz_splits = 3n; break;
            case 10n: horz_splits = 5n; break;
            default:
        }
        horzSplits = opts("-w",horz_splits);
        vertSplits = opts("-h",Place.numPlaces() as Int / horz_splits);
        if (horzSplits * vertSplits != Place.numPlaces() as Int) {
            throw new Error("Number of places not appropriate for given horizontal / vertical splits");
        }
        horzBlocks = opts("-x",4n);
        vertBlocks = opts("-y",4n);

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
            Console.OUT.println();
        }

        localFrame = new Rail[RGB](localWidth * localHeight);

        octree = opts("-l") ? new LooseOctree(opts("-d",10n), AABB(Vector3(-10,-10,-10),Vector3(10,10,10)), 20.0f)
               : opts("-O") ? new      Octree(opts("-d",10n), AABB(Vector3(-10,-10,-10),Vector3(10,10,10)))
                            : new   SimpleBVH();

        mipmapBias = opts("-b",0n);

        this.vertexes = vertexes;
        this.skybox = skybox;

        for (p in prims) {
            octree.insert(p);
        }

        octree.bake();

        if (dumpOctree) Console.OUT.println(octree);

        Console.OUT.println("Primitives: "+octree.countCargo());
        Console.OUT.println();

        heightFieldHost = new Rail[Float](heightFieldDimX * heightFieldDimY);

        gpu = PlaceTopology.getTopology().numChildren(here)==0 ? here : PlaceTopology.getTopology().getChild(here,0);

        gpuHeightField = CUDAUtilities.makeGlobalRail[Float](gpu, heightFieldDimX*heightFieldDimY, heightFieldHost);
        gpuVelocityField = CUDAUtilities.makeGlobalRail[Float](gpu, heightFieldDimX*heightFieldDimY, 0.0f);
    }

    public static struct DirectionalLight(dir:Vector3, diff:Vector3, spec:Vector3) { }

    val sun = DirectionalLight(Vector3(0.4f,0.6f,1.0f).normalised(), Vector3(0.5f,0.5f,0.5f), Vector3(2,2,2));

    val ambLight = 0.5f;

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

    public final def castRay(s:RayState) {
        s.t = s.l;
        // use line below to bypass octree optimisation
        //octree.iterateCargo((p:Primitive) => { p.intersectRay(s); });
        octree.castRay(s);
    }

    public final def skyboxRender(d:Vector3):Vector3 {
        // <front> <back> <left> <right> <up> <down>
        if (d.y > 0 && Math.abs(d.x/d.y) <= 1 && Math.abs(d.z/d.y) <= 1) return skybox(0).clampedLookup(Vector2(d.x/d.y+1.0f,-d.z/d.y+1.0f)*0.5f,mipmapBias); 
        if (d.y < 0 && Math.abs(d.x/d.y) <= 1 && Math.abs(d.z/d.y) <= 1) return skybox(1).clampedLookup(Vector2(d.x/d.y+1.0f,  d.z/d.y+1.0f)*0.5f,mipmapBias);
        if (d.x < 0 && Math.abs(d.y/d.x) <= 1 && Math.abs(d.z/d.x) <= 1) return skybox(2).clampedLookup(Vector2(-d.y/d.x+1.0f,  d.z/d.x+1.0f)*0.5f,mipmapBias);
        if (d.x > 0 && Math.abs(d.y/d.x) <= 1 && Math.abs(d.z/d.x) <= 1) return skybox(3).clampedLookup(Vector2(-d.y/d.x+1.0f,-d.z/d.x+1.0f)*0.5f,mipmapBias);
        if (d.z > 0 && Math.abs(d.x/d.z) <= 1 && Math.abs(d.y/d.z) <= 1) return skybox(4).clampedLookup(Vector2(d.x/d.z+1.0f,  d.y/d.z+1.0f)*0.5f,mipmapBias);
        return skybox(5).clampedLookup(Vector2(-d.x/d.z+1.0f,  d.y/d.z+1.0f)*0.5f,mipmapBias);
    }

    public final def castRayAndRender(s:RayState) {
        castRay(s);
        if (s.t >= s.l) {
            return skybox==null ? RGB.DARK_BLUE as Vector3 : skyboxRender(s.d);
        } else {
            return s.mat.render(this,s) ;
        }
    }

    public def renderFrame(frameBuffer:GlobalRail[RGB], denting_water:Boolean, pos:Vector3, orientation:Quat, time:Float) {

        val horz_split = here.id as Int % horzSplits;
        val vert_split = here.id as Int / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);

        val counter = new Cell[Int](0n);

        finish {

            if (gpu != here) async {
                // update heightfield front buffer
                val heightField = gpuHeightField;
                val vel = gpuVelocityField;
                val dimx = heightFieldDimX;
                val dimy = heightFieldDimY;
		val RADIUS_ = RADIUS;
		val BLOCK_DIMX_ = BLOCK_DIMX;
		val BLOCK_DIMY_ = BLOCK_DIMY;
		val THREADS_ = THREADS;
                val BLOCKS_X_ = BLOCKS_X;
		val S_DATA_STRIDE_ = S_DATA_STRIDE;
		val S_DATA_SIZE_ = S_DATA_SIZE;
                val interval = 0.2f;
                val iters = ((time - lastTime) / interval) as Int;
                lastTime += iters * interval;
                val hit_pos_x:Int;
                val hit_pos_y:Int;
                if (denting_water) {
                    val dir = orientation * Vector3(0,1,0);
                    val t = - pos.z / dir.z;
                    val hit_pos = pos + t*dir;
                    val hit_pos2 = (Vector2(hit_pos.x/7.0f, hit_pos.y/13.0f) + Vector2(0.5f,0.5f));
                    hit_pos_x = (hit_pos2.x * heightFieldDimX) as Int;
                    hit_pos_y = (hit_pos2.y * heightFieldDimY) as Int;
                } else {
                    hit_pos_x = -1n;
                    hit_pos_y = -1n;
                }
                for (i in 1n .. iters) {
                    val g = gpu;
                    finish async at (g) @CUDA @CUDADirectParams {
                        finish for (block in 0n..(BLOCKS_X_*BLOCKS_Y-1n)) async {
                            val s_data_h = new Rail[Float](S_DATA_SIZE_, 0.0f);
                            clocked finish for (thread in 0n..(THREADS_-1n)) clocked async {
                                val blockidx = block%BLOCKS_X_;
                                val blockidy = block/BLOCKS_X_;
                                val threadidx = thread%BLOCK_DIMX_;
                                val threadidy = thread/BLOCK_DIMX_;

                                // populate s_data_h
                                for (sy in 0n..(BLOCK_DIMY_ + 2n*RADIUS_ - 1n)) {
                                    val gy = sy - RADIUS_ + blockidy*BLOCK_DIMY_;
                                    for (var sx:Int=thread as Int; sx<BLOCK_DIMX_+2n*RADIUS_ ; sx+=THREADS_) {
                                        val gx = sx - RADIUS_ + blockidx*BLOCK_DIMX_;
                                        if (gx==hit_pos_x && gy==hit_pos_y) {
                                            s_data_h(sy*S_DATA_STRIDE_ + sx) = -1.0f;
                                        } else if (gx>=0 && gx< dimx && gy>=0 && gy<dimy) {
                                            s_data_h(sy*S_DATA_STRIDE_ + sx) = heightField(gy*dimx + gx);
                                        } else {
                                            s_data_h(sy*S_DATA_STRIDE_ + sx) = 0.0f;
                                        }
                                    }
                                }

                                Clock.advanceAll();

                                val gtx = (blockidx*BLOCK_DIMX_+threadidx);
                                val gty = (blockidy*BLOCK_DIMY_+threadidy);

                                val curr_h = s_data_h((threadidy+RADIUS_)*S_DATA_STRIDE_ + threadidx+RADIUS_);

                                val curr_v:Float = vel(gty*dimx + gtx);
                                var disp:Float = 0.0f;
                                disp += s_data_h((threadidy+RADIUS_-1)*S_DATA_STRIDE_ + threadidx+RADIUS_+0);
                                disp += s_data_h((threadidy+RADIUS_+0)*S_DATA_STRIDE_ + threadidx+RADIUS_-1);
                                disp += s_data_h((threadidy+RADIUS_+0)*S_DATA_STRIDE_ + threadidx+RADIUS_+1);
                                disp += s_data_h((threadidy+RADIUS_+1)*S_DATA_STRIDE_ + threadidx+RADIUS_+0);
                                disp = 0.25f*disp - curr_h;
                                val accel = 5.0f * disp - 0.05f * curr_v;
                                val new_v = curr_v + interval*accel;

                                vel(gty*dimx + gtx) = new_v;
                                heightField(gty*dimx + gtx) = curr_h + interval*new_v;
                            }
                        }
                    }
                }
                Rail.asyncCopy(gpuHeightField, 0, heightFieldHost, 0, heightFieldHost.size);
            }

            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);

            for (by in 0n..(vertBlocks-1n)) async {
                val block_off_y = by * localBlockHeight;
                finish for (bx in 0n..(horzBlocks-1n)) async {
                    val block_off_x = bx * localBlockWidth;
                    val state = new RayState(this, time, 4n);
                    state.o = pos;
                    for (y_ in 0n..(localBlockHeight-1n)) {
                        val y = y_ + block_off_y;
                        val y_norm = -(y+0.5f+offset_y)/globalHeight*2.0f + 1.0f;
                        for (x_ in 0n..(localBlockWidth-1n)) {
                            val x = x_ + block_off_x;
                            val x_norm = (x+0.5f+offset_x)/globalWidth*2.0f - 1.0f;
                            val ray = x_norm * globalWidth/globalHeight * right + forwards + y_norm * up;
                            state.d = ray * 800;
                            state.l = state.d.length();
                            state.d /= state.l;
                            state.hasShadow = true;
                            localFrame(y*localWidth + x) = castRayAndRender(state) as RGB;
                        }
                    }
                    atomic { counter() = counter() + state.primTests; }
                }
                for (y_ in 0n..(localBlockHeight-1n)) {
                    val y = y_ + block_off_y;
                    Rail.asyncCopy(localFrame, (y*localWidth) as Long, frameBuffer, (offset_x + (offset_y+y)*globalWidth) as Long, localWidth as Long);
                }
            }

        }
        Console.OUT.println("prim tests: "+counter());

        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
