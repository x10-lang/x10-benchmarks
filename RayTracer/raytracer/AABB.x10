package raytracer;

import x10.compiler.Inline;

// axis-aligned bounding box
public struct AABB (min:Vector3, max:Vector3) { 

    public def dimensions () = max - min;

    public def midPoint () = 0.5f*(max+min);

    public def subspaceOf (other:AABB) = this.min.x>=other.min.x && this.min.y>=other.min.y && this.min.z>=other.min.z
                                     && this.max.x<=other.max.x && this.max.y<=other.max.y && this.max.z<=other.max.z;

    public def contains (p:Vector3) = this.min.x<=p.x && this.min.y<=p.y && this.min.z<=p.z && this.max.x>=p.x && this.max.y>=p.y && this.max.z>=p.z;

    // p is in the range (0,0,0)->(1,1,1) and is used to index this space

    public def lerp (p:Vector3) = min + (max-min)*p;

    public def toString () = "[ "+min.x+"->"+max.x+", "+min.y+"->"+max.y+", "+min.z+"->"+max.z+" ]"
                           + "( "+(max.x-min.x)+" x "+(max.y-min.y)+" x "+(max.z-min.z)+" )";

}
