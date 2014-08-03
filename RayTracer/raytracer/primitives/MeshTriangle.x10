package raytracer.primitives;

import raytracer.*;

public final class MeshTriangle extends Primitive {
    val v1:UShort, v2:UShort, v3:UShort;

    val p1:Vector3;
    val e1:Vector3, e2:Vector3;
    val m:Material;
    val texSquash:Float;

    public def this(v1:UShort, v2:UShort, v3:UShort, V1:MeshVertex, V2:MeshVertex, V3:MeshVertex, m:Material) {
        this.v1 = v1;
        this.v2 = v2;
        this.v3 = v3;
        this.p1 = V1.pos;
        this.e1 = V2.pos - V1.pos;
        this.e2 = V3.pos - V1.pos;
        this.m = m;
        val space_area = e1.cross(e2).length()*0.5f;
        val uv_e1 = V2.uv - V1.uv;
        val uv_e2 = V3.uv - V1.uv;
        val uv_area = uv_e1.cross(uv_e2)*0.5f;
        texSquash = uv_area / space_area;
    }   

    public def getAABB() = AABB(Vector3.min(p1,Vector3.min(p1+e1, p1+e2)), Vector3.max(p1,Vector3.max(p1+e1, p1+e2)));

    public def intersectRay(st:RayState) {
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
        st.mat = m;
        val V1 = st.vertexes(v1 as UInt as Int);
        val V2 = st.vertexes(v2 as UInt as Int);
        val V3 = st.vertexes(v3 as UInt as Int);
        st.normal = (1-E1_-E2_)*V1.normal + E1_*V2.normal + E2_*V3.normal;
        st.texCoord = (1-E1_-E2_)*V1.uv + E1_*V2.uv + E2_*V3.uv;

        st.texSquash = texSquash / (-st.d.dot(st.normal));
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
