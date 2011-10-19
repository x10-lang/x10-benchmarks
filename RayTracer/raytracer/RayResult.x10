package raytracer;

import x10.util.Pair;

public class RayResult {
    public var t : Float; // depth value (effectively)
    public var pos : Vector3;
    public var normal : Vector3;
    public var texCoord : Pair[Float,Float];
    public var mat : Material;
}
