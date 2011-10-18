package raytracer;

// axis-aligned bounding box
public struct AABB (min:Vector3, max:Vector3) { 

    public def subspaceOf(other:AABB) = this.min.x>=other.min.x && this.min.y>=other.min.y && this.min.z>=other.min.z
                                     && this.max.x<=other.max.x && this.max.y<=other.max.y && this.max.z<=other.max.z;

    // p is in the range (0,0,0)->(1,1,1) and is used to index this space

    public def lerp(p:Vector3) = min + (max-min)*p;

    public def toString () = "[ "+min.x+"->"+max.x+", "+min.y+"->"+max.y+", "+min.z+"->"+max.z+" ]"
                           + "( "+(max.x-min.x)+" x "+(max.y-min.y)+" x "+(max.z-min.z)+" )";

}
