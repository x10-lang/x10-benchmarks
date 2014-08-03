package raytracer;

import x10.util.ArrayList;
import x10.util.StringBuilder;

import raytracer.primitives.MeshTriangle;

public final class Octree extends SpatialDatastructure {


    val bounds:AABB;
    val depth:Int; // how many more levels of children are allowed

    var children:Rail[Octree];
    var cargo:ArrayList[Primitive];
    var meshTriangleCargo:ArrayList[MeshTriangle];

    var bakedChildren:Rail[Octree] = new Rail[Octree](0);
    var bakedCargo:Rail[Primitive] = new Rail[Primitive](0);
    var bakedMeshTriangleCargo:Rail[MeshTriangle] = new Rail[MeshTriangle](0);


    public def this(depth:Int, bounds:AABB) {
        this.bounds = bounds;
        this.depth = depth;
    }

    public def insert(o:Primitive) {
        if (depth==0n) {
            insertLocally(o);
            return;
        }
        for (i in 0n..7n) {
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

    public def makeChild(i:Int)  = new Octree(depth-1n, calcChildAABB(i));

    public def castRay(s:RayState) {
        // in the equation P = o + t.d, the following t0 and t1 are such that...
        val t0 = (bounds.min - s.o) / s.d;
        val t1 = (bounds.max - s.o) / s.d;
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

        // calculate midplanes (it's linear -- they are halfway between outer planes)
        val th = (t0+t1)*0.5f;

        val process_child = (i:Int, t0:Vector3, t1:Vector3) => {
            val child = bakedChildren(i);
            if (child!=null && queryOctantHit(s,t0,t1)) child.octantHit(s, t0.x,t0.y,t0.z, t1.x,t1.y,t1.z);
        };

        process_child(0n, Vector3(t0.x, t0.y, t0.z), Vector3(th.x, th.y, th.z));
        process_child(1n, Vector3(th.x, t0.y, t0.z), Vector3(t1.x, th.y, th.z));
        process_child(2n, Vector3(t0.x, th.y, t0.z), Vector3(th.x, t1.y, th.z));
        process_child(3n, Vector3(th.x, th.y, t0.z), Vector3(t1.x, t1.y, th.z));
        process_child(4n, Vector3(t0.x, t0.y, th.z), Vector3(th.x, th.y, t1.z));
        process_child(5n, Vector3(th.x, t0.y, th.z), Vector3(t1.x, th.y, t1.z));
        process_child(6n, Vector3(t0.x, th.y, th.z), Vector3(th.x, t1.y, t1.z));
        process_child(7n, Vector3(th.x, th.y, th.z), Vector3(t1.x, t1.y, t1.z));
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

    public def ensureChildren() {
        if (children!=null) return;
        if (depth==0n) return;
        children = new Rail[Octree](8);
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
        var r : String = indent(depth, "    ") + bounds + (num_cargo==0?"":"{"+num_cargo+"}");
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
