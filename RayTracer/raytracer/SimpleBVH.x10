package raytracer;

import x10.util.*;

import x10.compiler.NonEscaping;

public class SimpleBVH extends SpatialDatastructure {

    private static struct Node {
        val parent : SimpleBVH;
        val bounds : AABB;
        val left : Int;
        val right : Int;
        val cargo : Primitive;

        def this (parent:SimpleBVH, o:Primitive) {
            this.parent = parent;
            this.bounds = o.getAABB();
            this.left = 0;
            this.right = 0;
            this.cargo = o;
        }

        def this (parent:SimpleBVH, left:Int, right:Int) {
            this.parent = parent;
            this.left = left;
            this.right = right;
            this.bounds = AABB.union(left().bounds, right().bounds);
            this.cargo = null;
        }

        @NonEscaping def left() = parent.nodes(left);
        @NonEscaping def right() = parent.nodes(right);

        public def castRay (s:RayState) : void {
            // in the equation P = o + t.d, the following t0 and t1 are such that...
            val t0 = (bounds.min - s.o) / s.d;
            val t1 = (bounds.max - s.o) / s.d;
            // o.x + d.x * t0.x == bounds.min.x
            // o.x + d.x * t1.x == bounds.max.x
            // (similarly for y, z)

            val t0_ = Vector3.min(t0,t1);
            val t1_ = Vector3.max(t0,t1);
            val t0_Bar_ = t0_.maxElement();
            val t1_Bar_ = t1_.minElement();
            if (Math.max(t0_Bar_,0.0f) <= Math.min(t1_Bar_, s.l)) {
                if (cargo!=null) {
                    s.primTests++;
                    cargo.intersectRay(s);
                } else {
                    left().castRay(s);
                    right().castRay(s);
                }
            }
        }
    }

    val nodes = new ArrayList[Node](); // internal nodes and leaves
    val leaves = new ArrayList[Node]();
    def swapLeaves(a:Int, b:Int) {
        val tmp = leaves(b);
        leaves(b) = leaves(a);
        leaves(a) = tmp;
    }

    var root:Int;

    public def insert (o:Primitive) : void {
        leaves.add(Node(this, o));
    }

    public def bake(from:Int, to:Int) : Int {
        val count = to - from + 1;
        if (count==1) {
            val ni = nodes.size();
            nodes.add(leaves(from));
            return ni;
        }

        // find bounding box of all leaf primitives midpoints
        // (this is better than using the leaf bounding boxes)
        var aabb:AABB = AABB(leaves(from).bounds.midPoint());
        for (i in (from+1)..to) aabb = AABB.union(aabb, leaves(i).bounds.midPoint());

        // calculate dividing plane
        val principal = aabb.principalAxis();
        var sumMP : Float = 0.0f;
        for (i in from..to) sumMP += leaves(i).bounds.midPoint()(principal);
        val averageMP = sumMP / count;

        // organise leaves array into 2 parts, where 'middle' is the beginning of the second part
        var middle : Int = from;
        for (i in from..to) {
            val mp = leaves(i).bounds.midPoint()(principal);
            // if smaller, swap with the guy at the middle (who is bigger)
            if (mp <= averageMP) {
                swapLeaves(i, middle); 
                middle++;
            }
        }
        if (middle > to) middle = to;
        if (middle == from) middle = from+1;

        // recurse
        val left = bake(from, middle-1);
        val right = bake(middle, to);
        val n = Node(this, left, right);

        val ni = nodes.size();
        nodes.add(n);
        return ni;
    }

    public def bake() : void {
        // build bvh
        if (leaves.size()>0) root = bake(0, leaves.size() - 1);
        Console.OUT.println("root = "+root);
    }

    public def countCargo() = leaves.size();

    public def iterateCargo(cb:(Primitive)=>void) {
        for (l in leaves) cb(l.cargo);
    }

    public def castRay (s:RayState) : void {
        if (leaves.size()>0) nodes(root).castRay(s);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
