package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

import x10.io.File;

public class RayTracer {

    globalWidth:Int;
    globalHeight:Int;
    localWidth:Int;
    localHeight:Int;
    horzSplits:Int;
    vertSplits:Int;
    frameBuffer:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE};
    localFrame:Array[RGB](1){self!=null};
    localFrameRemoteRef:RemoteIndexedMemoryChunk[RGB];
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
        localFrameRemoteRef = RemoteIndexedMemoryChunk.wrap(localFrame.raw());

    }

    public static interface Material {
    }

    public static class RayResult {
        var t : Float;
        var pos : Vector3;
        var normal : Vector3;
        var texCoord : Pair[Float,Float];
        var mat : Material;
    }

    public static interface Primitive {
        public def intersectRay (ray_origin_w:Vector3, ray_dir:Vector3, res:RayResult) : Boolean;
    }

    public static final struct Sphere(worldPos:Vector3, radius:Float) implements Primitive {
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

            res.t = t;
            res.pos = ray_origin_w + t * ray_dir;
            val hit_pos_os = (res.pos - worldPos);
            res.normal = hit_pos_os / radius;

            return true;

        }
    }

    public static final struct SpeckledSphere(worldPos:Vector3, radius:Float) implements Primitive {
        // FIXME: code duplicated from Sphere, extends Sphere(worldPos, radius) gives a type error...
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

            res.t = t;
            res.pos = ray_origin_w + t * ray_dir;
            val hit_pos_os = (res.pos - worldPos);
            res.normal = hit_pos_os / radius;

            /* igor's stuff */
            val sc = 100*(Math.PI/(2*4.0f)) as Float;

            val F = (v:Vector3) => {
                val f = Math.sin(sc * v.x) as Float * Math.sin(sc * v.y) as Float * Math.sin(sc * v.z) as Float;
                return  (1.0f + f) / 2.0f;
            };

            val bump = F(hit_pos_os);

            val mu = 4.5f/Math.PI as Float;
            val dF = Vector3(
                F(hit_pos_os + Vector3(mu, 0, 0)),
                F(hit_pos_os + Vector3(0, mu, 0)),
                F(hit_pos_os + Vector3(0, 0,  mu))
            );

            res.normal -= dF - bump*Vector3(1,1,1);

            return true;

        }
    }

    public static final struct Triangle(p1:Vector3, p2:Vector3, p3:Vector3) implements Primitive {
        public def intersectRay (ray_origin_w:Vector3, ray_dir:Vector3, res:RayResult) : Boolean {
            // Stolen from http://www.lighthouse3d.com/tutorials/maths/ray-triangle-intersection/

            val e1 = p2 - p1;
            val e2 = p3 - p1;

            val h = ray_dir.cross(e2);
            val a = e1.dot(h);

            if (a > -0.00001 && a < 0.00001)
                return false;

            val f = 1/a;
            val s = ray_origin_w - p1;
            val u = f * s.dot(h);

            if (u < 0.0 || u > 1.0)
                return false;

            val q = s.cross(e1);
            val v = f * ray_dir.dot(q);

            if (v < 0.0 || u + v > 1.0)
                return false;

            // at this stage we can compute t to find out where
            // the intersection point is on the line
            val t = f * e2.dot(q);

            // line intersection but not ray intersection
            if (t < 0.00001) return false;

            res.t = t;
            res.normal = e1.cross(e2);
            res.pos = ray_origin_w + t * ray_dir;
            return true;
        }
    }

    val scene = [
        new Sphere(Vector3(0,3,0), 1) as Primitive,
        new Sphere(Vector3(-1,3,-1), 1) as Primitive,
        new SpeckledSphere(Vector3(2,3,0.5f), 1) as Primitive,
        new Triangle(Vector3(-5,3,0.5f), Vector3(-3,3.0f,0.6f), Vector3(-4,0,0.2f)) as Primitive
    ];
    val sun_dir = Vector3(0,0,1);

    public static def to_col(x:Vector3) {
        val scaled = x*0.5f + Vector3(0.5f,0.5f,0.5f);
        return RGB(scaled.x, scaled.y, scaled.z);
    }

    public final def castRay (origin:Vector3, dir:Vector3, res:RayResult) : RGB {
        var colour:RGB = RGB.DARK_BLUE;
        var z:Float = Float.MAX_VALUE;
        for (var i:Int=0 ; i<scene.size ; ++i) {
            val p = scene(i);
            if (p.intersectRay(origin, dir, res)) {
                if (res.t > z) continue;
                z = res.t;
                val the_dot = res.normal.dot(sun_dir);
                /* half lambert shading */
                val diffuse = (the_dot * 0.5f + 0.5f) * (the_dot * 0.5f + 0.5f);
                /* standard shading */
                //val diffuse = Math.max(0.0f, the_dot);
                val ambient = 0.15f;
                val l = diffuse + ambient;
                colour = RGB(l, l, l);
                //colour = to_col(res.normal);
            }
        }
        //return colour;
        if (z < Float.MAX_VALUE) return colour;
        return to_col(dir.normalised());
    }

    public def renderFrame () {
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
            val lw = localWidth;
            val lh = localHeight;
            val gw = globalWidth;
            val gh = globalHeight;
            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);
            for (var y_:Int=0 ; y_<lh ; y_+=1) {
                val y = y_;
                // y_norm: centre of pixel, normalised to -1 -> 1 range
                // note inversion of axis so -1,-1 is bottom left of screen
                val y_norm = -(y+0.5f+offset_y)/gh*2.0f + 1.0f;
                for (var x:Int=0 ; x<lw ; ++x) {
                    // linear projection
                    // x_norm: center of pixel, normalised to -1 -> 1 range
                    val x_norm = (x+0.5f+offset_x)/gw*2.0f - 1.0f;
                    // FOV of 90
                    val ray = x_norm * gw/gh * right
                            + forwards
                            + y_norm * up;
                    localFrame(y*lw + x) = castRay(pos, ray * 800, res);
                }
                val local_off = y*lw;
                val remote_off = offset_x + (offset_y+y)*gw;
                val lb = localFrameRemoteRef;
                val fb = frameBuffer;
                async at (Place.FIRST_PLACE) {
                    fb().receive(lb, local_off, remote_off, lw);
                }
                Runtime.probe();
            }
        }
        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

