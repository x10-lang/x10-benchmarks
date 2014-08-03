package raytracer;

import x10.util.ArrayList;
import x10.util.StringBuilder;

import raytracer.primitives.MeshTriangle;

public final class LooseOctree extends SpatialDatastructure {

    val size:Float;
    val bounds:AABB;
    val depth:Int; // how many more levels of children are allowed

    var children:Rail[LooseOctree];
    var cargo:ArrayList[Primitive];
    var meshTriangleCargo:ArrayList[MeshTriangle];

    var bakedChildren:Rail[LooseOctree] = new Rail[LooseOctree](0);
    var bakedCargo:Rail[Primitive] = new Rail[Primitive](0);
    var bakedMeshTriangleCargo:Rail[MeshTriangle] = new Rail[MeshTriangle](0);

    public def this(depth:Int, bounds:AABB, size:Float) {
        this.bounds = bounds;
        this.depth = depth;
        this.size = size;
    }

    public def insert(o:Primitive) {
        val obb = o.getAABB();
        if (depth==0n || obb.dimensions().maxElement() > 0.5f * size) {
            // if we recursed to this level, then that means sz <= 2*size (the size of the level above)
            insertLocally(o);
            return;
        }
        for (i in 0n..7n) {
            if (calcChildAABB(i).contains(obb.midPoint())) {
                ensureChildren();
                ensureChild(i);
                children(i).insert(o);
                //return;
            }
        }
    }

    public def makeChild(i:Int) = new LooseOctree(depth-1n, calcChildAABB(i), size*0.5f);

    public def castRay(s:RayState) {
        // in the equation P = o + t.d, the following t0 and t1 are such that...
        val loose_bounds = AABB(bounds.midPoint()-bounds.dimensions(), bounds.midPoint()+bounds.dimensions());
        val t0 = (loose_bounds.min - s.o) / s.d;
        val t1 = (loose_bounds.max - s.o) / s.d;
        // o.x + d.x * t0.x == bounds.min.x
        // o.x + d.x * t1.x == bounds.max.x
        // (similarly for y, z)

        //Console.OUT.println("Casting octree ray: o="+o+"  d="+d);
        octantHit(s, t0.x,t0.y,t0.z, t1.x,t1.y,t1.z);
    }

    private def octantHit(s:RayState, t0x:Float, t0y:Float, t0z:Float, t1x:Float, t1y:Float, t1z:Float) {
        val t0 = Vector3(t0x,t0y,t0z);
        val t1 = Vector3(t1x,t1y,t1z);

        // process cargo...
        for (i in 0..(bakedMeshTriangleCargo.size-1)) {
            s.primTests++;
            bakedMeshTriangleCargo(i).intersectRay(s);
        }
        for (i in 0..(bakedCargo.size-1)) {
            s.primTests++;
            bakedCargo(i).intersectRay(s);
        }

        //recurse to children...
        if (bakedChildren.size==0) return; // leaf node

        // calculate midplanes -- for a loose octree we have to consider the overlap of the child nodes
        // each node overlaps by half of its size in all directions, thereby actually occupying twice the space in each dimension
        val T0 = Vector3.lerp(t0,t1,0.125f);
        val Th = Vector3.lerp(t0,t1,0.375f);
        val TH = Vector3.lerp(t0,t1,0.625f);
        val T1 = Vector3.lerp(t0,t1,0.875f);

        val process_child = (i:Int, t0:Vector3, t1:Vector3) => {
            val child = bakedChildren(i);
            if (child!=null && queryOctantHit(s,t0,t1)) child.octantHit(s, t0.x,t0.y,t0.z, t1.x,t1.y,t1.z);
        };

        process_child(0n, Vector3(T0.x, T0.y, T0.z), Vector3(TH.x, TH.y, TH.z));
        process_child(1n, Vector3(Th.x, T0.y, T0.z), Vector3(T1.x, TH.y, TH.z));
        process_child(2n, Vector3(T0.x, Th.y, T0.z), Vector3(TH.x, T1.y, TH.z));
        process_child(3n, Vector3(Th.x, Th.y, T0.z), Vector3(T1.x, T1.y, TH.z));
        process_child(4n, Vector3(T0.x, T0.y, Th.z), Vector3(TH.x, TH.y, T1.z));
        process_child(5n, Vector3(Th.x, T0.y, Th.z), Vector3(T1.x, TH.y, T1.z));
        process_child(6n, Vector3(T0.x, Th.y, Th.z), Vector3(TH.x, T1.y, T1.z));
        process_child(7n, Vector3(Th.x, Th.y, Th.z), Vector3(T1.x, T1.y, T1.z));
    }

    public def insertLocally(o:Primitive) {
        if (o instanceof MeshTriangle) {
            val mt = o as MeshTriangle;
            if (meshTriangleCargo==null) meshTriangleCargo = new ArrayList[MeshTriangle]();
            meshTriangleCargo.add(mt);
        } else {
            if (cargo==null) cargo = new ArrayList[Primitive]();
            cargo.add(o);
        }
    }

    public def bake() {
        if (children!=null) bakedChildren = children;
        if (cargo!=null) bakedCargo = cargo.toRail(); // does a copy
        if (meshTriangleCargo!=null) bakedMeshTriangleCargo = meshTriangleCargo.toRail(); // does a copy
        for (i in 0..(bakedChildren.size-1)) {
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
        if (depth==0n) return;
        children = new Rail[LooseOctree](8);
    }

    public def ensureChild(i:Int) {
        if (depth==0n) return;
        if (children(i) != null) return;
        children(i) = makeChild(i);
    }

    public def countCargo():Int {
        var r:Int = (bakedCargo.size + bakedMeshTriangleCargo.size) as Int;
        for (i in 0..(bakedChildren.size-1)) {
            if (bakedChildren(i) != null) {
                r += bakedChildren(i).countCargo();
            }
        }
        return r;
    }

    public def iterateCargo(cb:(Primitive)=>void) {
        for (i in 0..(bakedCargo.size-1)) cb(bakedCargo(i));
        for (i in 0..(bakedMeshTriangleCargo.size-1)) cb(bakedMeshTriangleCargo(i));
        for (i in 0..(bakedChildren.size-1)) {
            if (bakedChildren(i) != null) bakedChildren(i).iterateCargo(cb);
        }
    }

    public def toString() = toString(0n);

    private def indent(var depth:Int, spacer:String) {
        val sb = new StringBuilder();
        while (depth-- > 0) sb.add(spacer);
        return sb.toString();
    }

    private def toString(depth:Int) {
        val num_cargo = bakedCargo.size + bakedMeshTriangleCargo.size;
        var r:String = indent(depth, "    ") + bounds + (num_cargo==0?"":"{"+num_cargo+"}");
        if (bakedChildren.size==0) {
            return r;
        } else {
            for (i in 0..7) {
                if (bakedChildren(i) != null)
                    r = r + "\n" + bakedChildren(i).toString(depth+1n);
            }
            return r;
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
