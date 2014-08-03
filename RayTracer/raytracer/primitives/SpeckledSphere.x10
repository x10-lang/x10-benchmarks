package raytracer.primitives;

import raytracer.*;

public final class SpeckledSphere(worldPos:Vector3, radius:Float, m:Material) extends Primitive {

    public def getAABB() = AABB(worldPos-radius*Vector3(1,1,1), worldPos+radius*Vector3(1,1,1));

    public def intersectRay(s:RayState) {
        if (Sphere.intersectRay(worldPos, radius, m, s)) {
            val hit_pos_ws = s.o + s.t*s.d;
            val hit_pos_os = (hit_pos_ws - worldPos);

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

            s.normal -= dF - bump*Vector3(1,1,1);
            s.normal = s.normal.normalised();
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
