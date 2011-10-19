package raytracer;

public abstract class Primitive {
    public abstract def intersectRay (s:RayState) : Boolean;
    public abstract def getAABB() : AABB;
}
