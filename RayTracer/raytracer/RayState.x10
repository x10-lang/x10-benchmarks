package raytracer;

import x10.compiler.Inline;
import x10.util.Pair;

public final class RayState {
    public val parent : RayTracer;
    public def this (parent:RayTracer) { this.parent = parent; }

    public var o:Vector3; // ray origin
    public var d:Vector3; // ray dir

    public var t : Float; // depth value (effectively)
    public var normal : Vector3;
    public var texCoord : Pair[Float,Float];
    public var colour : RGB;
    public var mat : Material;

}
