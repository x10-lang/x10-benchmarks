package raytracer.materials;

import raytracer.*;

public class SolidColour(amb:Vector3, diff:Vector3, spec:Vector3, gloss:Float) extends Material {

    public def render(rt:Engine, s:RayState) {
        return rt.lightingEquation(s.child, amb, diff, spec, gloss, s.normal, s.o + s.t*s.d, -s.d);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
