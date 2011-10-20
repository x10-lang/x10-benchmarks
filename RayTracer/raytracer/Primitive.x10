package raytracer;

public abstract class Primitive {
    public abstract def intersectRay (s:RayState) : void;
    public abstract def getAABB() : AABB;
}
