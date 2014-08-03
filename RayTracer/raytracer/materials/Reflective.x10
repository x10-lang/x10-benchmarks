package raytracer.materials;

import raytracer.*;

public class Reflective(sub:Material, reflectMask:Vector3) extends Material {

    public def localRender(rt:Engine, s:RayState) {
        val s2 = s.child;
        if (s2 == null) return RGB.DARK_BLUE as Vector3;
        s2.o = s.o + s.t*s.d;
        s2.d = Vector3.reflect(s.d, s.normal);
        s2.l = 25;
        s2.hasShadow = true;
        return rt.castRayAndRender(s2);
    }

    public def render(rt:Engine, s:RayState) {
        return sub.render(rt,s) + reflectMask*localRender(rt,s);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
