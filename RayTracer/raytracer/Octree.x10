package raytracer;

import x10.util.ArrayList;
import x10.util.StringBuilder;
import x10.util.IndexedMemoryChunk;

import x10.compiler.Inline;

import raytracer.primitives.MeshTriangle;

public final class Octree {

    val bounds : AABB;
    val depth : Int; // how many more levels of children are allowed

    var children : Array[Octree](1);
    var cargo : ArrayList[Primitive];
    var meshTriangleCargo : ArrayList[MeshTriangle];

    var bakedChildren : IndexedMemoryChunk[Octree] = IndexedMemoryChunk.allocateUninitialized[Octree](0);
    var bakedCargo : IndexedMemoryChunk[Primitive] = IndexedMemoryChunk.allocateUninitialized[Primitive](0);
    var bakedMeshTriangleCargo : IndexedMemoryChunk[MeshTriangle] = IndexedMemoryChunk.allocateUninitialized[MeshTriangle](0);

    public def this (depth:Int, bounds:AABB, Float) {
        this.bounds = bounds;
        this.depth = depth;
    }

    public def this (depth:Int, bounds:AABB) {
        this.bounds = bounds;
        this.depth = depth;
    }

    public def insertLocally (o:Primitive) {
        if (o instanceof MeshTriangle) {
            val mt = o as MeshTriangle;
            if (meshTriangleCargo==null) meshTriangleCargo = new ArrayList[MeshTriangle]();
            meshTriangleCargo.add(mt);
        } else {
            if (cargo==null) cargo = new ArrayList[Primitive]();
            cargo.add(o);
        }
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

    public def bake () {
        if (children!=null) bakedChildren = children.raw();
        if (cargo!=null) bakedCargo = cargo.toIndexedMemoryChunk(); // does a copy
        if (meshTriangleCargo!=null) bakedMeshTriangleCargo = meshTriangleCargo.toIndexedMemoryChunk(); // does a copy
        for (i in 0..(bakedChildren.length()-1)) {
            if (bakedChildren(i) != null) bakedChildren(i).bake();
        }
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
        var r:Int = bakedCargo.length() + bakedMeshTriangleCargo.length();
        for (i in 0..(bakedChildren.length()-1)) {
            if (bakedChildren(i) != null) {
                r += bakedChildren(i).countCargo();
            }
        }
        return r;
    }
    public def iterateCargo(cb:(Primitive)=>void) {
        for (i in 0..(bakedCargo.length()-1)) cb(bakedCargo(i));
        for (i in 0..(bakedMeshTriangleCargo.length()-1)) cb(bakedMeshTriangleCargo(i));
        for (i in 0..(bakedChildren.length()-1)) {
            if (bakedChildren(i) != null) bakedChildren(i).iterateCargo(cb);
        }
    }

    @Inline private static def queryOctantHit (s:RayState, t0:Vector3, t1:Vector3) {
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

    public def castRay (s:RayState) {
        // in the equation P = o + t.d, the following t0 and t1 are such that...
        val t0 = (bounds.min - s.o) / s.d;
        val t1 = (bounds.max - s.o) / s.d;
        // o.x + d.x * t0.x == bounds.min.x
        // o.x + d.x * t1.x == bounds.max.x
        // (similarly for y, z)

        //Console.OUT.println("Casting octree ray: o="+o+"  d="+d);
        octantHit(s, t0.x,t0.y,t0.z, t1.x,t1.y,t1.z);
    }

    private def octantHit (s:RayState, t0x:Float,t0y:Float,t0z:Float, t1x:Float,t1y:Float,t1z:Float) {
        val t0 = Vector3(t0x,t0y,t0z);
        val t1 = Vector3(t1x,t1y,t1z);

        // process cargo...
        for (i in 0..(bakedMeshTriangleCargo.length()-1)) {
            bakedMeshTriangleCargo(i).intersectRay(s);
        }
        for (i in 0..(bakedCargo.length()-1)) {
            bakedCargo(i).intersectRay(s);
        }

        //recurse to children...
        if (bakedChildren.length()==0) return; // leaf node

        // calculate midplanes (it's linear -- they are halfway between outer planes)
        val th = (t0+t1)*0.5f;

        val process_child = (i:Int, t0:Vector3, t1:Vector3) => {
            val child = bakedChildren(i);
            if (child!=null && queryOctantHit(s,t0,t1)) child.octantHit(s, t0.x,t0.y,t0.z, t1.x,t1.y,t1.z);
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
        val num_cargo = bakedCargo.length() + bakedMeshTriangleCargo.length();
        var r : String = indent(depth, "    ") + bounds + (num_cargo==0?"":"{"+num_cargo+"}");
        if (bakedChildren.length()==0) {
            return r;
        } else {
            for (i in 0..7) {
                if (bakedChildren(i) != null)
                    r = r + "\n" + bakedChildren(i).toString(depth+1);
            }
            return r;
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

