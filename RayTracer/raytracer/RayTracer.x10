package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;

import x10.io.File;

public class RayTracer {

    globalWidth:Int;
    globalHeight:Int;
    localWidth:Int;
    localHeight:Int;
    horzSplits:Int;
    vertSplits:Int;
    remoteFrame:RemoteArray[RGB]{rank==1, home==Place.FIRST_PLACE};
    localFrame:Array[RGB](1){self!=null};
    verbose:Boolean;
    quiet:Boolean;

    public def this (opts:OptionsParser, global_width:Int, global_height:Int,
                     remote_frame:RemoteArray[RGB]{rank==1, home==Place.FIRST_PLACE}) {

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

        remoteFrame = remote_frame;
        localFrame = new Array[RGB](localWidth * localHeight);

    }

    public static interface Material {
    }

    public static class RayResult {
        var pos : Vector3;
        var normal : Vector3;
        var texCoord : Pair[Float,Float];
        var mat : Material;
    }

    //public static interface Primitive {
    //    public def intersectRay (ray_origin:Vector3, ray_dir:Vector3, res:RayResult) : Boolean;
    //}

    public static final class Sphere(worldPos:Vector3, radius:Float) /*implements Primitive*/ {
        public def intersectRay (ray_origin_w:Vector3, ray_dir:Vector3, res:RayResult) : Boolean {
            // stolen from http://wiki.cgsociety.org/index.php/Ray_Sphere_Intersection#Example_Code
            val ray_origin_o = ray_origin_w - worldPos;
            //Compute A, B and C coefficients
            val a = ray_dir.length2();
            val b = 2 * ray_dir.dot(ray_origin_o);
            val c = ray_origin_o.length2() - radius * radius;

            val disc = b * b - 4 * a * c;
                
            // if discriminant is negative there are no real roots, so return 
            // false as ray misses sphere
            if (disc < 0)
                return false;

            // compute q as described above
            val dist_sqrt = Math.sqrtf(disc);
            val q = b < 0
                  ? (-b - dist_sqrt)/2.0f
                  : (-b + dist_sqrt)/2.0f;

            // compute t0 and t1
            val t0_ = q / a;
            val t1_ = c / q;

            val t0 = Math.min(t0_, t1_);
            val t1 = Math.max(t0_, t1_);

            // if t1 is less than zero, the object is in the ray's negative direction
            // and consequently the ray misses the sphere
            if (t1 < 0)
                return false;

            // if t0 is less than zero, the intersection point is at t1
            val t = t0 < 0 ? t1 : t0;

            res.pos = ray_origin_w + t * ray_dir;
            res.normal = (res.pos - worldPos) / radius;

            return true;

        }
    }

    val scene = [
        new Sphere(Vector3(0,3,0), 1),
        new Sphere(Vector3(-1,3,-1), 1),
        new Sphere(Vector3(2,3,0.5f), 1)
     ];
    val sun_dir = Vector3(0,0,1);

    public final def castRay (origin:Vector3, dir:Vector3, res:RayResult) : RGB {
        for (var i:Int=0 ; i<scene.size ; ++i) {
            val p = scene(i);
            if (p.intersectRay(origin, dir, res)) {
                val diffuse = Math.max(0.0f,res.normal.dot(sun_dir));
                val ambient = 0.25f;
                val l = diffuse + ambient;
                return RGB(l, l, l);
            }
        }
        return RGB.DARK_BLUE;
    }

    public def renderFrame () {
        val horz_split = here.id % horzSplits;
        val vert_split = here.id / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);


        val before = Runtime.getX10RTStats();
        finish {
            for (var y_thread_:Int=0 ; y_thread_<4 ; ++y_thread_) {
                val y_thread=y_thread_;
                async {
                    val res = new RayResult();
                    val rf = remoteFrame;
                    val source = new RemoteArray[RGB](localFrame);
                    val lw = localWidth;
                    val lh = localHeight;
                    val gw = globalWidth;
                    val gh = globalHeight;
                    val ray_top_right = Vector3(gw/gh,1,1);
                    for (var y_:Int=y_thread ; y_<lh ; y_+=4) {
                        val y = y_;
                        val y_norm = -(y+0.5f+offset_y)/gh*2.0f + 1.0f;
                        for (var x:Int=0 ; x<lw ; ++x) {
                            // linear projection
                            val x_norm = (x+0.5f+offset_x)/gw*2.0f - 1.0f;
                            val ray = Vector3(x_norm,1,y_norm) * ray_top_right;
                            localFrame(y*lw + x) = castRay(Vector3(0,0,0), ray, res);
                        }
                        async at (Place.FIRST_PLACE) {
                            Array.asyncCopy(source, y*lw, rf(), offset_x + (offset_y+y)*gw, lw);
                        }
                    }
                }
            }
        }
        Console.OUT.println(Runtime.getX10RTStats() - before);
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

