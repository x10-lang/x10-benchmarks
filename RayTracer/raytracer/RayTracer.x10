package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

import x10.io.File;

import raytracer.primitives.Triangle;
import raytracer.primitives.Sphere;
import raytracer.primitives.SpeckledSphere;

import x10.compiler.Inline;

public class RayTracer {

    globalWidth:Int;
    globalHeight:Int;
    localWidth:Int;
    localHeight:Int;
    horzSplits:Int;
    vertSplits:Int;
    frameBuffer:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE};
    localFrame:Array[RGB](1){self!=null};
    verbose:Boolean;
    quiet:Boolean;

    var orientation:Quat = Quat(1,0,0,0);
    var pos:Vector3 = Vector3(0,0,0);

    public def this (opts:OptionsParser, global_width:Int, global_height:Int,
                     frameBuffer:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE}) {

        verbose = opts("-v");
        quiet = opts("-q");

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

        localWidth = global_width / horzSplits;
        localHeight = global_height / vertSplits;

        if (!quiet) {
            Console.OUT.println("horzSplits: "+horzSplits);
            Console.OUT.println("vertSplits: "+vertSplits);
            Console.OUT.println("localWidth: "+localWidth);
            Console.OUT.println("localHeight: "+localHeight);
        }

        this.frameBuffer = frameBuffer;
        localFrame = new Array[RGB](localWidth * localHeight);
    }

    val scene = new Octree(4, AABB(Vector3(-100,-100,-100),Vector3(100,100,100)));
    public def init() {
        //scene.insert(new Sphere(Vector3(0,3,0), 1));
        //scene.insert(new Sphere(Vector3(-1,3,-1), 1));
        //scene.insert(new Sphere(Vector3( 2,3,-1), 1));
        //scene.insert(new Sphere(Vector3( 2,4,-2), 2));
        //scene.insert(new Sphere(Vector3( 3,-2,-4), 1.5f));
        //scene.insert(new SpeckledSphere(Vector3(2,3,0.5f), 1));
        //scene.insert(new Triangle(Vector3(-5,3,0.5f), Vector3(-3,3.0f,0.6f), Vector3(-4,0,0.2f)));
        for (z in -5..4) {
            for (y in -5..4) {
                for (x in -5..4) {
                    val pos = 5 * Vector3(x,y,z);
                    scene.insert(new Triangle(pos+Vector3(-1,0,-0.33f),
                                 pos+Vector3( 1,0,-0.33f),
                                 pos+Vector3(0,0,0.66f)));
                }
            }
        }
        //Console.OUT.println(scene);
        return this;
    }

    val sun_dir = Vector3(0,0,1);

    public static def to_col(x:Vector3) {
        val scaled = x*0.5f + Vector3(0.5f,0.5f,0.5f);
        return RGB(scaled.x, scaled.y, scaled.z);
    }

    public final def castRay (origin:Vector3, dir:Vector3, res:RayResult, res2:ScreenResult) {
        res2.colour = RGB.DARK_BLUE;
        res2.t = Float.MAX_VALUE;
        //scene.iterateCargo((p:Primitive) => {
        scene.castRay(origin, dir, this, res, res2);
        //return colour;
        if (res2.t < Float.MAX_VALUE) return;
        //res2.colour = to_col(dir.normalised());
        val dn = dir.normalised();
        if (dn.x > 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) res2.colour = to_col(Vector3( 1,0,0));
        if (dn.x < 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) res2.colour = to_col(Vector3(-1,0,0));
        if (dn.y > 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) res2.colour = to_col(Vector3(0, 1,0));
        if (dn.y < 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) res2.colour = to_col(Vector3(0,-1,0));
        if (dn.z > 0 && Math.abs(dn.x/dn.z) < 1 && Math.abs(dn.y/dn.z) < 1) res2.colour = to_col(Vector3(0,0, 1));
        if (dn.z < 0 && Math.abs(dn.x/dn.z) < 1 && Math.abs(dn.y/dn.z) < 1) res2.colour = to_col(Vector3(0,0,-1));
    }

    @Inline public def castRayPrimitive (p:Primitive, o:Vector3, d:Vector3, res:RayResult, res2:ScreenResult) {
        if (p.intersectRay(o, d, res)) { 
            if (res.t > res2.t) return; 
            res2.t = res.t; 
            val the_dot = res.normal.dot(sun_dir); 
            // half lambert shading 
            val diffuse = (the_dot * 0.5f + 0.5f) * (the_dot * 0.5f + 0.5f); 
            // standard shading 
            //val diffuse = Math.max(0.0f, the_dot); 
            val ambient = 0.15f; 
            val l = diffuse + ambient; 
            val lb = (l * 255) as UByte;
            res2.colour = RGB(lb, lb, lb); 
            //res2.colour = to_col(res.normal); 
        }
    }

    public def renderFrame (raw:RemoteIndexedMemoryChunk[RGB]) {
        val horz_split = here.id % horzSplits;
        val vert_split = here.id / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);


        //val before = Runtime.getX10RTStats();
        //val render_before = System.nanoTime();
        finish {
            val res = new RayResult();
            val res2 = new ScreenResult();

            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);

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
                    castRay(pos, ray * 800, res, res2);
                    localFrame(y*localWidth + x) = res2.colour;
                }
                IndexedMemoryChunk.asyncCopy(localFrame.raw(), y*localWidth, raw, offset_x + (offset_y+y)*globalWidth, localWidth);
            }
        }
        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

