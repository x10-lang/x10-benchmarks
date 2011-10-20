package raytracer;

public abstract class Material {
    public abstract def render (rt:RayTracer, s:RayState) : RGB;
}
