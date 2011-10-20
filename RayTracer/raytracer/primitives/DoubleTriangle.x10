package raytracer.primitives;

import raytracer.*;

public final class DoubleTriangle extends Primitive {
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
        // Stolen from http://www.lighthouse3d.com/tutorials/maths/ray-triangle-intersection/
        // appears to be from http://www.cs.virginia.edu/~gfx/Courses/2003/ImageSynthesis/papers/Acceleration/Fast%20MinimumStorage%20RayTriangle%20Intersection.pdf
        val h = st.d.cross(e2);
        val a = e1.dot(h);

        if (a > -0.00001 && a < 0.00001)
            return;

        val f = 1/a;
        val s = st.o - p1;
        val u = f * s.dot(h);

        if (u < 0.0 || u > 1.0)
            return;

        val q = s.cross(e1);
        val v = f * st.d.dot(q);

        if (v < 0.0 || u + v > 1.0)
            return;

        // at this stage we can compute t to find out where
        // the intersection point is on the line
        val t = f * e2.dot(q);

        // line intersection but not ray intersection
        if (t < 0) return;
        if (t >= st.t) return;

        st.t = t;
        st.normal = n;
        st.mat = m;
    }
}


