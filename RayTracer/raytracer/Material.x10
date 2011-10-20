package raytracer;

public abstract class Material {
    public abstract def render (rt:Engine, s:RayState) : RGB;
}
