package raytracer.primitives;

import raytracer.*;

public final class Sphere(worldPos:Vector3, radius:Float, m:Material) extends Primitive {
    public def getAABB() = AABB(worldPos-radius*Vector3(1,1,1), worldPos+radius*Vector3(1,1,1));
    public def intersectRay (s:RayState) {
        // stolen from http://wiki.cgsociety.org/index.php/Ray_Sphere_Intersection#Example_Code
        val ray_origin_o = s.o - worldPos;
        //Compute A, B and C coefficients
        val a = s.d.length2();
        val b = 2 * s.d.dot(ray_origin_o);
        val c = ray_origin_o.length2() - radius * radius;

        val discriminant = b * b - 4 * a * c;
            
        // if discriminant is negative there are no real roots, so return 
        // false as ray misses sphere
        if (discriminant < 0) return;

        // compute q as described above
        val dist_sqrt = Math.sqrtf(discriminant);
        val q = b < 0
              ? (-b - dist_sqrt)/2.0f
              : (-b + dist_sqrt)/2.0f;

        // compute t0 and t1
        val t0_ = q / a;
        val t1_ = c / q;

        val t0 = Math.min(t0_, t1_);
        //val t1 = Math.max(t0_, t1_);

        /*
        // if t1 is less than zero, the object is in the ray's negative direction (behind the camera)
        // and consequently the ray misses the sphere
        if (t1 < 0) return;

        // if t0 is less than zero, the intersection point is at t1
        val t = t0 < 0 ? t1 : t0;
        */
        val t = t0;
        if (t < 0) return;
        if (t >= s.t) return;

        s.t = t;
        val hit_pos_ws = s.o + t*s.d;
        val hit_pos_os = (hit_pos_ws - worldPos);
        s.normal = hit_pos_os / radius;
        s.mat = m;
    }
}

