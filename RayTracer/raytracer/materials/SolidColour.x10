package raytracer.materials;

import raytracer.*;

public class SolidColour(col:RGB) extends Material {
    public def render (rt:Engine, s:RayState) : RGB = rt.lightingEquation(col as Vector3, col as Vector3, s.normal, s.o + s.t*s.d);
}

