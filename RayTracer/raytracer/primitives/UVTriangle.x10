package raytracer.primitives;

import x10.util.Pair;

import raytracer.*;

public final class UVTriangle extends Primitive {
    val p1:Vector3;
    val e1:Vector3, e2:Vector3;
    val n:Vector3;
    val m:Material;
    val u:Vector3, v:Vector3; // unusual grouping because we don't have Vector2
    val stretch:Float;
    public def this (p1:Vector3, p2:Vector3, p3:Vector3, u:Vector3, v:Vector3, m:Material) {
        this.p1 = p1;
        this.e1 = p2 - p1;
        this.e2 = p3 - p1;
        this.u = u;
        this.v = v;
        this.m = m;
        this.n = e1.cross(e2).normalised();
        val space_area = e1.cross(e2).length()*0.5f;
        val uv1 = Vector3(u.x, v.x, 0);
        val uv2 = Vector3(u.y, v.y, 0);
        val uv3 = Vector3(u.z, v.z, 0);
        val uv_e1 = uv2 - uv1;
        val uv_e2 = uv3 - uv1;
        val uv_area = uv_e1.cross(uv_e2).length()*0.5f;
        stretch = uv_area / space_area;
    }
    public def getAABB() = AABB(Vector3.min(p1,Vector3.min(p1+e1, p1+e2)), Vector3.max(p1,Vector3.max(p1+e1, p1+e2)));
    public def intersectRay (st:RayState) {
        // from http://www.cs.virginia.edu/~gfx/Courses/2003/ImageSynthesis/papers/Acceleration/Fast%20MinimumStorage%20RayTriangle%20Intersection.pdf
        val h = st.d.cross(e2);
        val a = e1.dot(h);

        if (a < 0.00001) return;

        val s = st.o - p1;
        val E1 = s.dot(h);

        if (E1 < 0.0 || E1 > a) return;

        val q = s.cross(e1);
        val E2 = st.d.dot(q);

        if (E2 < 0.0 || E1 + E2 > a) return;

        val t = e2.dot(q);

        val f = 1/a;

        val t_ = t * f;
        val E1_ = E1 * f;
        val E2_ = E2 * f;

        if (t_ < 0.00001) return;
        if (t_ >= st.t) return;

        st.t = t_;
        st.normal = n;
        st.mat = m;
        val tex_coord_u = (1-E1_-E2_)*u.x + E1_*u.y + E2_*u.z;
        val tex_coord_v = (1-E1_-E2_)*v.x + E1_*v.y + E2_*v.z;
        st.texCoord = Pair[Float,Float](tex_coord_u, tex_coord_v);

        //st.obliqueness = stretch / (-st.d.dot(n));
    }
}

