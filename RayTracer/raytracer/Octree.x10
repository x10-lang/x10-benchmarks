package raytracer;

import x10.util.ArrayList;
import x10.util.StringBuilder;


public final class Octree {

    val bounds : AABB;
    val depth : Int; // how many more levels of children are allowed

    var children : Array[Octree](1);
    var cargo : ArrayList[Primitive];

    public def this (depth:Int, bounds:AABB) {
        this.bounds = bounds;
        this.depth = depth;
    }

    public def insertLocally (o:Primitive) {
        if (cargo==null) cargo = new ArrayList[Primitive]();
        cargo.add(o);
    }

    public def insert (o:Primitive) {
        if (depth==0) {
            insertLocally(o);
            return;
        }
        for (i in 0..7) {
            if (o.getAABB().subspaceOf(calcChildAABB(i))) {
                ensureChildren();
                ensureChild(i);
                val child = children(i);
                child.insert(o);
                return;
            }
        }
        insertLocally(o);
    }

    public def calcChildAABB(i:Int) {
        // each axis is either 0 or 0.5
        val min = Vector3((i >> 0) & 1, (i >> 1) & 1, (i >> 2) & 1) * 0.5f;
        // each axis is either 0.5 or 1
        val max = min + Vector3(0.5f, 0.5f, 0.5f);
        return AABB(bounds.lerp(min), bounds.lerp(max));
    }

    public def ensureChildren () {
        if (children!=null) return;
        if (depth==0) return;
        children = new Array[Octree](8);
    }

    public def ensureChild (i:Int) {
        if (depth==0) return;
        if (children(i) != null) return;
        children(i) = new Octree(depth-1, calcChildAABB(i));
    }

    public def countCargo() : Int {
        var r:Int = cargo == null ? 0 : cargo.size();
        if (children != null) {
            for (i in 0..7) {
                if (children(i) != null) {
                    r += children(i).countCargo();
                }
            }
        }
        return r;
    }
    public def iterateCargo(cb:(Primitive)=>void) {
        if (cargo!=null) for (i in 0..(cargo.size()-1)) cb(cargo(i));
        if (children == null) return;
        for (i in 0..7) {
            if (children(i) != null) children(i).iterateCargo(cb);
        }
    }

    public def castRay(o:Vector3, d:Vector3, rt:RayTracer, res:RayResult, res2:ScreenResult) {

        // in the equation P = o + t.d, the following t0 and t1 are such that...
        val t0 = (bounds.min - o) / d;
        val t1 = (bounds.max - o) / d;
        // o.x + d.x * t0.x == bounds.min.x
        // o.x + d.x * t1.x == bounds.max.x
        // (similarly for y, z)

        //Console.OUT.println("Casting octree ray: o="+o+"  d="+d);

        // max ensures vector is positive
        castRay2(o, d, rt, res, res2, t0, t1);
    }

    // components of t0, t1 MUST be positive
    private def castRay2(o:Vector3, d:Vector3, rt:RayTracer, res:RayResult, res2:ScreenResult, t0:Vector3, t1:Vector3) {
        //Console.OUT.println("\033[1m"+depth+":  is octant:  "+bounds+"\033[0m");
        //Console.OUT.println("t0="+t0+"  t1="+t1);
        val t0_ = Vector3.min(t0,t1);
        val t1_ = Vector3.max(t0,t1);
        //Console.OUT.println("t0_="+t0_+"  t1_="+t1_);
        //val t0_Bar = t0_.max(Vector3(0,0,0));
        //val t1_Bar = t1_.max(Vector3(0,0,0));
        //Console.OUT.println("|t0_|="+t0_Bar+"  |t1_|="+t1_Bar);
        val t0_Bar_ = t0_.maxElement();
        val t1_Bar_ = t1_.minElement();
        //Console.OUT.println("in="+t0_Bar_+"  out="+t1_Bar_);

        if (Math.max(t0_Bar_,0.0f) >= Math.max(t1_Bar_,0.0f)) {
            // misses entire octant
            return;
        }

        // hits octant
        //Console.OUT.println("hits octant: "+bounds);

        // process cargo...
        if (false && cargo!=null) for (i in 0..(cargo.size()-1)) {
            rt.castRayPrimitive(cargo(i), o, d, res, res2);
        }

        //recurse to children...
        if (children==null) return; // leaf node

        // calculate midplanes (it's linear -- they are halfway between outer planes)
        val th = (t0+t1)*0.5f;

        val process_child = (i:Int, t0:Vector3, t1:Vector3) => {
            val child = children(i);
            if (child != null) child.castRay2(o,d,rt,res,res2,t0,t1);
        };

        process_child(0, Vector3(t0.x, t0.y, t0.z), Vector3(th.x, th.y, th.z));
        process_child(1, Vector3(th.x, t0.y, t0.z), Vector3(t1.x, th.y, th.z));
        process_child(2, Vector3(t0.x, th.y, t0.z), Vector3(th.x, t1.y, th.z));
        process_child(3, Vector3(th.x, th.y, t0.z), Vector3(t1.x, t1.y, th.z));
        process_child(4, Vector3(t0.x, t0.y, th.z), Vector3(th.x, th.y, t1.z));
        process_child(5, Vector3(th.x, t0.y, th.z), Vector3(t1.x, th.y, t1.z));
        process_child(6, Vector3(t0.x, th.y, th.z), Vector3(th.x, t1.y, t1.z));
        process_child(7, Vector3(th.x, th.y, th.z), Vector3(t1.x, t1.y, t1.z));
        
    }

    public def toString() = toString(0);
    private def indent(var depth:Int, spacer:String) {
        val sb = new StringBuilder();
        while (depth-- > 0) sb.add(spacer);
        return sb.toString();
    }
    private def toString(depth:Int) {
        var r : String = indent(depth, "    ") + bounds + (cargo==null?"":"{"+cargo.size()+"}");
        if (children==null) {
            return r;
        } else {
            for (i in 0..7) {
                if (children(i) != null)
                    r = r + "\n" + children(i).toString(depth+1);
            }
            return r;
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

