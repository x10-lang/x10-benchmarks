package raytracer;


import x10.io.Console;

public class Vector3Test {
    public static def accum(v:Vector3, tmp3:Vector3) = v + v * tmp3;

    public static def main (args : Array[String]) {
        {
            var v : Vector3 = Vector3(9,9,9);
            var v2 : Vector3 = Vector3(1,1,1);
            var v3 : Vector3 = Vector3(1,2,1.5f);
            var v4 : Vector3 = Vector3(5,5,5);
            val before = System.nanoTime();
            for (i in 1..2000000000) {
                val tmp = v2.dot(v3);
                val tmp2 = tmp * 5.0f;
                val tmp3 = tmp2 * v4;
                v = accum(v,tmp3);
            }
            val after = System.nanoTime();
            Console.OUT.println(v+" took "+(after-before)/1E9+" seconds");
        }
        {
            var vx:Float = 9.0f;
            var vy:Float = 9.0f;
            var vz:Float = 9.0f;
            var v2x:Float = 1.0f;
            var v2y:Float = 1.0f;
            var v2z:Float = 1.0f;
            var v3x:Float = 1.0f;
            var v3y:Float = 2.0f;
            var v3z:Float = 1.5f;
            var v4x:Float = 5.0f;
            var v4y:Float = 5.0f;
            var v4z:Float = 5.0f;
            val before = System.nanoTime();
            for (i in 1..2000000000) {
                val tmp = v2x*v3x + v2y*v3y + v2z*v3z;
                val tmp2 = tmp * 5.0f;
                val tmp3x = tmp2 * v4x;
                val tmp3y = tmp2 * v4y;
                val tmp3z = tmp2 * v4z;
                vx = vx + vx * tmp3x;
                vy = vy + vy * tmp3y;
                vz = vz + vz * tmp3z;
            }
            val after = System.nanoTime();
            Console.OUT.println("Vector3("+vx+", "+vy+", "+vz+") took "+(after-before)/1E9+" seconds");
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

