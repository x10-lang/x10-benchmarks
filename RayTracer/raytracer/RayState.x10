package raytracer;

import x10.compiler.Inline;
import x10.util.Pair;

public final class RayState {
    public val parent : RayTracer;
    public def this (parent:RayTracer) { this.parent = parent; }

    public var o:Vector3; // ray origin
    public var d:Vector3; // ray dir

    public var screenT : Float; // depth value (effectively)
    public var screenColour : RGB;

    public var t : Float; // depth value (effectively)
    public var normal : Vector3;
    public var texCoord : Pair[Float,Float];
    public var mat : Material;

    @Inline public def castRayPrimitive (p:Primitive) {
        if (p.intersectRay(this)) { 
            if (t > screenT) return; 
            screenT = t;
            val the_dot = normal.dot(parent.sunDir); 
            // half lambert shading 
            val diffuse = (the_dot * 0.5f + 0.5f) * (the_dot * 0.5f + 0.5f); 
            // standard shading 
            //val diffuse = Math.max(0.0f, the_dot); 
            val ambient = 0.15f; 
            val l = diffuse + ambient; 
            val lb = (l * 255) as UByte;
            screenColour = RGB(lb, lb, lb); 
            //res2.colour = to_col(res.normal); 
        }
    }

}
