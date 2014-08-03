package raytracer.primitives;

import raytracer.*;

public class Rectangle extends Primitive {

    p1:Vector3; //position of one of the vertexes, such that x and y go along the edges of the quad
    x:Vector3, y:Vector3, n:Vector3; // basis - width direction, height direction, normal (all should be at right angles to each other)
    w:Float, h:Float; // dimensions
    d:Float; // plane equation
    mat:Material;

    tc1:Vector2; // texture coord
    uvx:Vector2;
    uvy:Vector2;

    texSquash:Float;

    // order of points:
    // p1----p4
    // |      |
    // p2----p3
    public def this(p1:Vector3, tc1:Vector2, p2:Vector3, tc2:Vector2, p3:Vector3, tc3:Vector2, p4:Vector3, tc4:Vector2, mat:Material) {
        this.p1 = p1;
        val e_x = p4 - p1;
        val e_y = p2 - p1;
        this.tc1 = tc1;
        val e_tcx = tc4 - tc1;
        val e_tcy = tc2 - tc1;
        this.w = e_x.length();
        this.h = e_y.length();
        this.uvx = e_tcx/w;
        this.uvy = e_tcy/h;
        this.x = e_x / w;
        this.y = e_y / h;
        this.n = y.cross(x);
        this.d = p1.dot(n);
        this.mat = mat;
        this.texSquash = e_tcx.length() * e_tcy.length() / (w*h);
    }

    public def getAABB() {
        val p2 = p1 + h*y;
        val p3 = p2 + w*x;
        val p4 = p1 + w*x;
        return AABB(Vector3.min(Vector3.min(Vector3.min(p1, p2), p3), p4), Vector3.max(Vector3.max(Vector3.max(p1, p2), p3), p4));
    }

    public def intersectRay(s:RayState) {
        val facing = n.dot(s.d);
        if (facing > 0) return; // quad is facing away from the camera
        val t = (d - n.dot(s.o)) / facing; // solve the plane equation
        if (t < 0) return;
        if (t >= s.t) return;
        val ipos = s.o + t*s.d; // intersection point, on the plane
        val ipos2 = ipos - p1;
        val a = ipos2.dot(x);
        if (a<0 || a>w) return;
        val b = ipos2.dot(y);
        if (b<0 || b>h) return;

        // use a and b to get tex coords
        s.texCoord = tc1 + a*uvx + b*uvy;
        s.t = t;
        s.normal = n;
        s.mat = mat;
        s.texSquash = texSquash / (-facing);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
