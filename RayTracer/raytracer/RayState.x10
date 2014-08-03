package raytracer;

public final class RayState {

    public var primTests:Int;

    public var hasShadow:Boolean;

    public val vertexes:Rail[MeshVertex];
    public val engine:Engine;

    public val child:RayState;

    public def this(engine:Engine, time:Float, depth:Int) {
        this.time = time;
        this.engine = engine;
        this.vertexes = engine.vertexes;
        child = depth==0n ? null : new RayState(engine, time, depth-1n);
    }

    public var o:Vector3; // ray origin
    public var d:Vector3; // ray dir (normalised)
    public var l:Float; // ray length

    public var t:Float; // depth value (effectively)
    public var normal:Vector3;
    public var texCoord:Vector2;
    public var colour:Vector3;
    public var mat:Material;
    public var texSquash:Float;

    public var time:Float;

}

// vim: shiftwidth=4:tabstop=4:expandtab
