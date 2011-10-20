package raytracer.materials;

import raytracer.*;

public class Reflective extends Material {
    public def render (rt:Engine, s:RayState) : RGB {
        return RGB.RED;
    }
}


