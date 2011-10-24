package raytracer;

import x10.compiler.Inline;

public final class RayState {
    public val vertexes:Array[MeshVertex](1);

    public val child : RayState;

    public def this (vertexes:Array[MeshVertex](1), time:Float, depth:Int) {
        this.time = time;
        this.vertexes = vertexes;
        child = depth==0 ? null : new RayState(vertexes, time, depth-1);
    }

    public var o:Vector3; // ray origin
    public var d:Vector3; // ray dir (normalised)
    public var l:Float; // ray length

    public var t : Float; // depth value (effectively)
    public var normal : Vector3;
    public var texCoord : Vector2;
    public var colour : RGB;
    public var mat : Material;
    public var texSquash : Float;

    public var time:Float;

}
