package raytracer.primitives;

import raytracer.*;

public final class Triangle extends Primitive {
    val p1:Vector3;
    val e1:Vector3, e2:Vector3;
    val m:Material;
    val n:Vector3;
    public def this (p1:Vector3, p2:Vector3, p3:Vector3, m:Material) {
        this.p1 = p1;
        this.e1 = p2 - p1;
        this.e2 = p3 - p1;
        this.m = m;
        this.n = e1.cross(e2).normalised();
    }
    public def getAABB() = AABB(Vector3.min(p1,Vector3.min(p1+e1, p1+e2)), Vector3.max(p1,Vector3.max(p1+e1, p1+e2)));
    public def intersectRay (st:RayState) {
        // from http://www.cs.virginia.edu/~gfx/Courses/2003/ImageSynthesis/papers/Acceleration/Fast%20MinimumStorage%20RayTriangle%20Intersection.pdf
        val h = st.d.cross(e2);
        val a = e1.dot(h);

        if (a < 0.00001) return;

        val s = st.o - p1;
        val u = s.dot(h);

        if (u < 0.0 || u > a) return;

        val q = s.cross(e1);
        val v = st.d.dot(q);

        if (v < 0.0 || u + v > a) return;

        val t = e2.dot(q);

        val f = 1/a;

        val t_ = t * f;
        //val u_ = u * f;
        //val v_ = v * f;
        
        if (t_ < 0.00001) return;
        if (t_ >= st.t) return;

        st.t = t_;
        st.normal = n;
        st.mat = m;
    }
}

