package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

import x10.compiler.Inline;

public class Engine {

    globalWidth:Int;
    globalHeight:Int;
    localBlockWidth:Int;
    localBlockHeight:Int;
    localWidth:Int;
    localHeight:Int;
    horzSplits:Int;
    vertSplits:Int;
    horzBlocks:Int;
    vertBlocks:Int;
    localFrame:Array[RGB](1){self!=null};
    verbose:Boolean;
    quiet:Boolean;
    dumpOctree:Boolean;

    var orientation:Quat = Quat(1,0,0,0);
    var pos:Vector3 = Vector3(0,0,0);

    public def this (opts:OptionsParser, global_width:Int, global_height:Int, prims:Array[Primitive](1)) {

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

        if (dumpOctree) Console.OUT.println(scene);

        for (p in prims.values()) {
            scene.insert(p);
        }
    }

    val sunDir = Vector3(0,0,1);
    val ambLight = 0.15f;
    val diffLightCol = Vector3(1,1,1);

    public final def lightingEquation(diff_surf_col:Vector3, amb_surf_col:Vector3, normal:Vector3, pos:Vector3) {
            val the_dot = normal.dot(sunDir); 

            // half lambert shading 
            val diff_exp = (the_dot * 0.5f + 0.5f) * (the_dot * 0.5f + 0.5f); 
            // standard shading 
            //val diff_exp = Math.max(0.0f, the_dot); 

            val amb_comp  =            ambLight     * amb_surf_col;
            val diff_comp = diff_exp * diffLightCol * diff_surf_col;
            //val spec_comp = spec_exp * specLightCol * scol;

            // sum up all the various components
            return (amb_comp + diff_comp) as RGB;
    }


    val scene = new Octree(12, AABB(Vector3(-100,-100,-100),Vector3(100,100,100)));

    public static def to_col(x:Vector3) {
        val scaled = x*0.5f + Vector3(0.5f,0.5f,0.5f);
        return RGB(scaled.x, scaled.y, scaled.z);
    }

    public final def castRay (s:RayState) {
        s.t = Float.MAX_VALUE;
        //scene.iterateCargo((p:Primitive) => { p.intersectRay(s); });
        scene.castRay(s);
        if (s.t == Float.MAX_VALUE) {
            val dn = s.d.normalised();
            //return RGB.BLACK;
            //return to_col(dn);
            if (dn.x > 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) return to_col(Vector3( 1,0,0));
            else if (dn.x < 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) return to_col(Vector3(-1,0,0));
            else if (dn.y > 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) return to_col(Vector3(0, 1,0));
            else if (dn.y < 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) return to_col(Vector3(0,-1,0));
            else if (dn.z > 0 && Math.abs(dn.x/dn.z) < 1 && Math.abs(dn.y/dn.z) < 1) return to_col(Vector3(0,0, 1));
            else                                                                     return to_col(Vector3(0,0,-1));
        } else {
            return s.mat.render(this,s);
        }
    }

    public def renderFrame (frameBuffer:RemoteIndexedMemoryChunk[RGB]) {
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
                    val state = new RayState(this);
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
                            localFrame(y*localWidth + x) = castRay(state);
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
                    localFrame(y*localWidth + x) = castRay(state);
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

