package raytracer;

public abstract class Material {
    public abstract def render(rt:Engine, s:RayState):Vector3;
}

// vim: shiftwidth=4:tabstop=4:expandtab
