
package raytracer.primitives;

import x10.compiler.Native;

import raytracer.*;

public class WaveyRectangle extends Rectangle {

    static val dir = Vector2(8,5).normalised();

    public def this (p1:Vector3, tc1:Vector2, p2:Vector3, tc2:Vector2, p3:Vector3, tc3:Vector2, p4:Vector3, tc4:Vector2, mat:Material) {
        super(p1,tc1,p2,tc2,p3,tc3,p4,tc4,mat);
    }

    @Native("c++", "::fabsf(#x)")
    private static def absf(x:Float) : Float = Math.abs(x) as Float;
    private static def waveFunc (x:Float) {
        val x2 = absf(x);
        val x3 = x2 % 2.0f;
        return x3>1 ? (1.5f-x3)*(x3-2.36602540378444f)*(x3+0.36602540378444f-1) : (x3-0.5f)*(x3-1.36602540378444f)*(x3+0.36602540378444f);
    }

    public def intersectRay (s:RayState) {
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
        s.texCoord = tc1 + a/w*tcw*tcx + b/h*tch*tcy;
        s.t = t;
        s.normal = n;
        s.mat = mat;

        val wave = waveFunc(0.5f * s.time + s.texCoord.dot(dir));
        val perturb = 0.20f * wave * dir;
        //s.normal = (s.normal + wave * Vector3(dir.x, dir.y, 0)).normalised();
        s.normal = Vector3(perturb.x, perturb.y, Math.sqrtf(1-perturb.x*perturb.x-perturb.y*perturb.y));

        // perturb normal
        //val x = 0.1f*(Math.cos(s.texCoord.x) as Float);
        //val y = 0.1f*(Math.sin(s.texCoord.y) as Float);
        //s.normal = Vector3(x,y,Math.sqrtf(1-x*x-y*y));
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

