package raytracer;

import x10.util.ArrayList;
import x10.util.StringBuilder;


public class Octree {

    public static interface Storable {
        public def getAABB() : AABB;
    }

    val bounds : AABB;
    val depth : Int; // how many more levels of children are allowed

    var children : Array[Octree](1);
    var cargo : ArrayList[Storable];

    public def this (depth:Int, bounds:AABB) {
        this.bounds = bounds;
        this.depth = depth;
    }

    public def insertLocally (o:Storable) {
        if (cargo==null) cargo = new ArrayList[Storable]();
        cargo.add(o);
    }

    public def insert (o:Storable) {
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

    public def countCargoRecursive() : Int {
        var r:Int = cargo == null ? 0 : cargo.size();
        if (children != null) {
            for (i in 0..7) {
                if (children(i) != null) {
                    r += children(i).countCargoRecursive();
                }
            }
        }
        return r;
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

