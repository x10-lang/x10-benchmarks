package raytracer.materials;

import raytracer.*;

public class DebugMaterial extends Material {

    public def render(rt:Engine, s:RayState) = s.colour;
}

// vim: shiftwidth=4:tabstop=4:expandtab
