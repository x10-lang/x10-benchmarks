package raytracer;

import x10.compiler.ByRef;

import x10.io.Console;

public class Vector3Test {

// use Vector3.x10
/*
    public static struct Vector3(x:Float, y:Float, z:Float) {

        public operator this + (v:Vector3) = Vector3(x+v.x, y+v.y, z+v.z);
        public operator this - (v:Vector3) = Vector3(x-v.x, y-v.y, z-v.z);
        public operator + this = this;
        public operator - this = Vector3(-x, -y, -z);
        public operator this * (v:Vector3) = Vector3(x*v.x, y*v.y, z*v.z);
        public operator this / (v:Vector3) = Vector3(x/v.x, y/v.y, z/v.z);
        public operator this * (v:Float) = Vector3(x*v, y*v, z*v);
        public operator (v:Float) * this = Vector3(x*v, y*v, z*v);
        public operator this / (v:Float) = Vector3(x/v, y/v, z/v);

        public def length2() = x*x + y*y + z*z;
        public def length() = Math.sqrtf(length2());
        public def dot(v:Vector3) = x*v.x + y*v.y + z*v.z;
        public def cross(v:Vector3) = Vector3(y*v.z - z*v.y,  z*v.x - x*v.z,  x*v.y - y*v.x);
        public def normalised() = this/length();

        public def toString() = "Vector3("+x+", "+y+", "+z+")";

        public def maxElement() = Math.max(x, Math.max(y, z));
        public def minElement() = Math.min(x, Math.min(y, z));

        public static def max(a:Vector3, b:Vector3) = Vector3(Math.max(a.x, b.x), Math.max(a.y, b.y), Math.max(a.z, b.z));
        public static def min(a:Vector3, b:Vector3) = Vector3(Math.min(a.x, b.x), Math.min(a.y, b.y), Math.min(a.z, b.z));
        public def max(o:Vector3) = Vector3(Math.max(x, o.x), Math.max(y, o.y), Math.max(z, o.z));
        public def min(o:Vector3) = Vector3(Math.min(x, o.x), Math.min(y, o.y), Math.min(z, o.z));
    }
*/

    public static def recursive(i:Int, @ByRef v:Vector3, @ByRef v2:Vector3, @ByRef v3:Vector3, @ByRef v4:Vector3):Float {
        if (i==0n) {
            //Console.OUT.println(v);
            return v.x;
        }
        val tmp = v2.dot(v3);
        val tmp2 = tmp * 5.0f;
        val tmp3 = tmp2 * v4;
        val v_ = v + v * tmp3;
        var r:Float = 0.0f;
        r += recursive(i-1n, v_, v2, v3, v4+Vector3( 1, 1, 1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3( 1, 1,-1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3( 1,-1, 1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3( 1,-1,-1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3(-1, 1, 1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3(-1, 1,-1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3(-1,-1, 1));
        r += recursive(i-1n, v_, v2, v3, v4+Vector3(-1,-1,-1));
        return r;
    }

    public static def recursive(i:Int, vx:Float,  vy:Float,  vz:Float, 
                                       v2x:Float, v2y:Float, v2z:Float,
                                       v3x:Float, v3y:Float, v3z:Float,
                                       v4x:Float, v4y:Float, v4z:Float):Float {
        if (i==0n) {
            //Console.OUT.println("Vector3("+vx+", "+vy+", "+vz+")");
            return vx;
        }
        val tmp = v2x*v3x + v2y*v3y + v2z*v3z;
        val tmp2 = tmp * 5.0f;
        val tmp3x = tmp2 * v4x;
        val tmp3y = tmp2 * v4y;
        val tmp3z = tmp2 * v4z;
        val vx_ = vx + vx * tmp3x;
        val vy_ = vy + vy * tmp3y;
        val vz_ = vz + vz * tmp3z;
        var r:Float = 0.0f;
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x+1,v4y+1,v4z+1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x+1,v4y+1,v4z-1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x+1,v4y-1,v4z+1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x+1,v4y-1,v4z-1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x-1,v4y+1,v4z+1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x-1,v4y+1,v4z-1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x-1,v4y-1,v4z+1);
        r += recursive(i-1n, vx_,vy_,vz_, v2x,v2y,v2z, v3x,v3y,v3z, v4x-1,v4y-1,v4z-1);
        return r;
    }

    public static def main(args:Rail[String]) {
        val depth = 10n;
        {
            var v:Vector3 = Vector3(9,9,9);
            var v2:Vector3 = Vector3(1,1,1);
            var v3:Vector3 = Vector3(1,2,1.5f);
            var v4:Vector3 = Vector3(5,5,5);
            val before = System.nanoTime();
            recursive(depth, v,v2,v3,v4);
            val after = System.nanoTime();
            Console.OUT.println("took "+(after-before)/1E9+" seconds");
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
            recursive(depth, vx,vy,vz, v2x,v2y,v2z, v3x,v3y,v3z, v4x,v4y,v4z);
            val after = System.nanoTime();
            Console.OUT.println("took "+(after-before)/1E9+" seconds");
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
