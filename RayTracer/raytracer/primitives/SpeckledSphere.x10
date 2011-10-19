package raytracer.primitives;

import raytracer.*;

public final class SpeckledSphere(worldPos:Vector3, radius:Float) extends Primitive {
    public def getAABB() = AABB(worldPos-radius*Vector3(1,1,1), worldPos+radius*Vector3(1,1,1));
    // FIXME: code duplicated from Sphere, extends Sphere(worldPos, radius) gives a type error...
    public def intersectRay (ray_origin_w:Vector3, ray_dir:Vector3, res:RayResult) : Boolean {
        // stolen from http://wiki.cgsociety.org/index.php/Ray_Sphere_Intersection#Example_Code
        val ray_origin_o = ray_origin_w - worldPos;
        //Compute A, B and C coefficients
        val a = ray_dir.length2();
        val b = 2 * ray_dir.dot(ray_origin_o);
        val c = ray_origin_o.length2() - radius * radius;

        val discriminant = b * b - 4 * a * c;
            
        // if dworldPos-radius*Vector3(1,1,1)iscriminant is negative there are no real roots, so return 
        // false as ray misses sphere
        if (discriminant < 0)
            return false;

        // compute q as described above
        val dist_sqrt = Math.sqrtf(discriminant);
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
