package raytracer;

import x10.util.Random;

public class OctreeTest {

    public static class TestObject(aabb:AABB) extends Octree.Storable {
        public def getAABB() = aabb;
        public def toString() = aabb.toString();
    }

    public static def main (args : Array[String]) {
        val scene = new Octree[TestObject](12, AABB(Vector3(-1000,-1000,-1000),Vector3(1000,1000,1000)));
        val add_cube = (pos:Vector3, sz:Float) => { scene.insert(new TestObject(AABB(pos-sz*Vector3(1,1,1), pos+sz*Vector3(1,1,1)))); };
        /*
        val rand = new Random();
        for (i in 0..999) {
            val sz = rand.nextFloat()*30;
            val pos = Vector3(rand.nextFloat()*2-1,rand.nextFloat()*2-1,rand.nextFloat()*2-1) * 1000;
            add_cube(pos, sz);
        }
        */
        add_cube(Vector3(-500,-500,-500), 400);
        add_cube(Vector3( 500,-500,-500), 400);
        add_cube(Vector3(-500, 500,-500), 400);
        add_cube(Vector3( 500, 500,-500), 400);
        add_cube(Vector3(-500,-500, 500), 400);
        add_cube(Vector3( 500,-500, 500), 400);
        add_cube(Vector3(-500, 500, 500), 400);
        add_cube(Vector3( 500, 500, 500), 400);
        scene.bake();

        Console.OUT.println(scene);
        Console.OUT.println(scene.countCargo());
        Console.OUT.println();

        //val test = (o:Vector3, d:Vector3) => {
        //    Console.OUT.println(o+"->"+d+" intersection...");
        //    scene.castRay(o, d, (p:TestObject) => {
        //        Console.OUT.println(p);
        //    });
        //    Console.OUT.println();
        //};

        //test(Vector3(-0.01f,0.01f,0.01f), Vector3(-0.9f,0.95f,0.98f));
        //test(Vector3(0.01f,0.01f,0.01f), Vector3(0.9f,0.95f,0.98f));
        //test(Vector3(-0.01f,-0.01f,0.01f), Vector3(-0.9f,-0.95f,0.98f));
        //test(Vector3(0.01f,-0.01f,0.01f), Vector3(0.9f,-0.95f,0.98f));
        
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

