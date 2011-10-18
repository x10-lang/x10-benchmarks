package raytracer;

import x10.util.Random;

public class OctreeTest {

    public static class TestObject(aabb:AABB) implements Octree.Storable {
        public def getAABB() = aabb;
    }

    public static def main (args : Array[String]) {
        val octree = new Octree(12, AABB(Vector3(-1000,-1000,-1000),Vector3(1000,1000,1000)));
        val rand = new Random();
        for (i in 0..999) {
            val sz = rand.nextFloat()*30;
            val pos = Vector3(rand.nextFloat()*2-1,rand.nextFloat()*2-1,rand.nextFloat()*2-1) * 1000;
            octree.insert(new TestObject(AABB(pos-sz*Vector3(1,1,1), pos+sz*Vector3(1,1,1))));
        }
        Console.OUT.println(octree);
        Console.OUT.println(octree.countCargoRecursive());
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

