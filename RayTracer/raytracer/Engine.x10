package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

import x10.compiler.Inline;

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
    

    var orientation:Quat = Quat(1,0,0,0);
    var pos:Vector3 = Vector3(0,0,0);

    val vertexes : Array[MeshVertex](1);
    val skybox : Array[Texture2D](1);

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

        octree = new LooseOctree(opts("-d",10), AABB(Vector3(-10,-10,-10),Vector3(10,10,10)), 20.0f);
        mipmapBias = opts("-b",0);

        this.vertexes = vertexes;
        this.skybox = skybox;

        for (p in prims.values()) {
            octree.insert(p);
        }

        octree.bake();

        if (dumpOctree) Console.OUT.println(octree);

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


    val octree : LooseOctree;

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

    public def renderFrame (frameBuffer:RemoteIndexedMemoryChunk[RGB], time:Float) {
        val horz_split = here.id % horzSplits;
        val vert_split = here.id / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);


        //val before = Runtime.getX10RTStats();
        //val render_before = System.nanoTime();
        finish {
            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);

            for (by in 0..(vertBlocks-1)) async {
                val block_off_y = by * localBlockHeight;
                finish for (bx in 0..(horzBlocks-1)) async {
                    val block_off_x = bx * localBlockWidth;
                    val state = new RayState(vertexes, time, 4);
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

            /*
            for (y in 0..(localHeight-1)) {
                // y_norm: centre of pixel, normalised to -1 -> 1 range
                // note inversion of axis so -1,-1 is bottom left of screen
                val y_norm = -(y+0.5f+offset_y)/globalHeight*2.0f + 1.0f;

                for (x in 0..(localWidth-1)) {
                    // linear projection
                    // x_norm: center of pixel, normalised to -1 -> 1 range
                    val x_norm = (x+0.5f+offset_x)/globalWidth*2.0f - 1.0f;
                    // FOV of 90
                    val ray = x_norm * globalWidth/globalHeight * right
                            + forwards
                            + y_norm * up;
                    state.d = ray * 800;
                    state.l = state.d.length();
                    state.d /= state.l;
                    localFrame(y*localWidth + x) = castRayAndRender(state);
                }
                IndexedMemoryChunk.asyncCopy(localFrame.raw(), y*localWidth, frameBuffer, offset_x + (offset_y+y)*globalWidth, localWidth);
            }
            */
        }
        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

