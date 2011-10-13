package raytracer;


public struct Vector3(x:Float,y:Float,z:Float) {

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
    public def dot (v:Vector3) = x*v.x + y*v.y + z*v.z;
    public def cross (v:Vector3) = Vector3(y*v.z - z*v.y,  z*v.x - x*v.z,  x*v.y - y*v.x);
    public def normalised() = this/length();

    public def toString () = "Vector3("+x+", "+y+", "+z+")";
}

