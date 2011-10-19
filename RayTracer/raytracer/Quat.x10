package raytracer;

import x10.compiler.Inline;

public struct Quat (w:Float, x:Float,y:Float,z:Float) {

    public static ID:Quat = Quat(1,0,0,0);

    @Inline public static def angleAxis (a:Float, x:Float, y:Float, z:Float) {
        val c = Math.cos(a*0.5f) as Float;
        val s = Math.sin(a*0.5f) as Float;
        return Quat(c, x*s, y*s, z*s);
    }

    @Inline public operator this + (v:Quat) = Quat(w+v.w, x+v.x, y+v.y, z+v.z);
    @Inline public operator this - (v:Quat) = Quat(w-v.w, x-v.x, y-v.y, z-v.z);
    @Inline public operator + this = this;
    @Inline public operator - this = Quat(-w, -x, -y, -z);

    @Inline public operator this * (v:Vector3) {
        // nVidia SDK implementation
        val axis = Vector3(x, y, z);
        val uv = axis.cross(v);
        val uuv = axis.cross(uv);
        val uv2 = uv * (2.0f * w);
        val uuv2 = uuv * 2.0f;
        return v + uv2 + uuv2;
    }

    @Inline
    public operator this * (v:Quat) = Quat(w*v.w - x*v.x - y*v.y - z*v.z,
                                           w*v.x + x*v.w + y*v.z - z*v.y,
                                           w*v.y + y*v.w + z*v.x - x*v.z,
                                           w*v.z + z*v.w + x*v.y - y*v.x);

    @Inline public operator this * (v:Float) = Quat(w*v, x*v, y*v, z*v);
    @Inline public operator this / (v:Float) = Quat(w/v, x/v, y/v, z/v);

    @Inline public def axis() = Vector3(x,y,z);
    @Inline public def length2() = w*w + x*x + y*y + z*z;
    @Inline public def length() = Math.sqrtf(length2());
    @Inline public def normalised() = this/length();
    @Inline public def dot (v:Quat) = w*v.w + x*v.x + y*v.y + z*v.z;
    @Inline public def unitInverse () = Quat(w,-x,-y,-z);
    @Inline public def inverse () = normalised().unitInverse();

    public def toString () = "Quat("+w+", "+x+", "+y+", "+z+")";

}

