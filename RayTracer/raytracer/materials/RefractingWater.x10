package raytracer.materials;

import raytracer.*;

public class RefractingWater(sub:Material, fresnel:Float, refractiveIndex:Float, refractMask:Vector3, reflectMask:Vector3) extends Material {

    public def reflectRender(rt:Engine, s:RayState, hit_point:Vector3) {
        val s2 = s.child;
        if (s2 == null) return RGB.DARK_BLUE as Vector3;
        s2.o = hit_point;
        s2.d = Vector3.reflect(s.d, s.normal);
        s2.l = 25;
        s2.hasShadow = false;
        return rt.castRayAndRender(s2);
    }

    public def refractRender(rt:Engine, s:RayState, hit_point:Vector3) {
        val s2 = s.child;
        if (s2 == null) return RGB.DARK_BLUE as Vector3;
        s2.o = hit_point;
        s2.d = Vector3.refract(s.d, s.normal, refractiveIndex);
        s2.o += 0.000001f * s2.d; // skip it over the plane, avoids it recursively hitting itself
        s2.l = 25;
        s2.hasShadow = false;
        return rt.castRayAndRender(s2);
    }

    public def render(rt:Engine, s:RayState) {
        val hit_point = s.o + s.t*s.d;
        val perp = Math.powf(1 + s.normal.dot(s.d), fresnel);
        return sub.render(rt,s) + Vector3.lerp(refractMask*refractRender(rt,s,hit_point), reflectMask*reflectRender(rt,s,hit_point), perp);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
