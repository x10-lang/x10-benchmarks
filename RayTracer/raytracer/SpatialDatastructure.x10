package raytracer;

public abstract class SpatialDatastructure {
    public abstract def insert(o:Primitive):void;
    public abstract def bake():void;
    public abstract def countCargo():Int;
    public abstract def iterateCargo(cb:(Primitive)=>void):void;
    public abstract def castRay(s:RayState):void;

    protected static def queryOctantHit(s:RayState, t0:Vector3, t1:Vector3) {
        //Console.OUT.println("\033[1m"+depth+":  is octant:  "+bounds+"\033[0m");
        //Console.OUT.println("t0="+t0+"  t1="+t1);
        val t0_ = Vector3.min(t0,t1);
        val t1_ = Vector3.max(t0,t1);
        //Console.OUT.println("t0_="+t0_+"  t1_="+t1_);
        val t0_Bar_ = t0_.maxElement();
        val t1_Bar_ = t1_.minElement();
        //Console.OUT.println("in="+t0_Bar_+"  out="+t1_Bar_);
        return Math.max(t0_Bar_,0.0f) <= Math.min(t1_Bar_, s.l);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
