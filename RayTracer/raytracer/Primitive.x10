package raytracer;

public abstract class Primitive {
    public abstract def intersectRay (ray_origin_w:Vector3, ray_dir:Vector3, res:RayResult) : Boolean;
    public abstract def getAABB() : AABB;
}
