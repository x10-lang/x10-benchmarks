package raytracer;

// axis-aligned bounding box
public struct AABB(min:Vector3, max:Vector3) { 

    public def this(min:Vector3, max:Vector3) {
        property(min, max);
    }

    public def this(p:Vector3) {
        property(p, p);
    }

    public def dimensions() = max - min;

    public def midPoint() = 0.5f*(max+min);

    public def subspaceOf(other:AABB) = this.min.x>=other.min.x && this.min.y>=other.min.y && this.min.z>=other.min.z
                                     && this.max.x<=other.max.x && this.max.y<=other.max.y && this.max.z<=other.max.z;

    public def contains(p:Vector3) = this.min.x<=p.x && this.min.y<=p.y && this.min.z<=p.z && this.max.x>=p.x && this.max.y>=p.y && this.max.z>=p.z;

    public static def union(a:AABB, b:AABB) = AABB(Vector3.min(a.min,b.min), Vector3.max(a.max,b.max));

    public static def union(a:AABB, b:Vector3) = AABB(Vector3.min(a.min,b), Vector3.max(a.max,b));

    public def principalAxis() = dimensions().principalAxis();

    // p is in the range (0,0,0)->(1,1,1) and is used to index this space
    public def lerp(p:Vector3) = min + (max-min)*p;

    public def toString() = "[ "+min.x+"->"+max.x+", "+min.y+"->"+max.y+", "+min.z+"->"+max.z+" ]"
                          + "( "+(max.x-min.x)+" x "+(max.y-min.y)+" x "+(max.z-min.z)+" )";
}

// vim: shiftwidth=4:tabstop=4:expandtab
