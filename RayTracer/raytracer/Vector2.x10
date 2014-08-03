package raytracer;

public struct Vector2(x:Float, y:Float) {

    public operator this + (v:Vector2) = Vector2(x+v.x, y+v.y);
    public operator this - (v:Vector2) = Vector2(x-v.x, y-v.y);
    public operator + this = this;
    public operator - this = Vector2(-x, -y);
    public operator this * (v:Vector2) = Vector2(x*v.x, y*v.y);
    public operator this / (v:Vector2) = Vector2(x/v.x, y/v.y);
    public operator this * (v:Float) = Vector2(x*v, y*v);
    public operator (v:Float) * this = Vector2(x*v, y*v);
    public operator this / (v:Float) = Vector2(x/v, y/v);

    public def length2() = x*x + y*y;
    public def length() = Math.sqrtf(length2());
    public def dot(v:Vector2) = x*v.x + y*v.y;
    public def cross(v:Vector2) = x*v.y - y*v.x;
    public def normalised() = this/length();

    public def toString() = "Vector2("+x+", "+y+")";

    public def maxElement() = Math.max(x, y);
    public def minElement() = Math.min(x, y);

    public static def max(a:Vector2, b:Vector2) = Vector2(Math.max(a.x, b.x), Math.max(a.y, b.y));
    public static def min(a:Vector2, b:Vector2) = Vector2(Math.min(a.x, b.x), Math.min(a.y, b.y));
    public def max(o:Vector2) = Vector2(Math.max(x, o.x), Math.max(y, o.y));
    public def min(o:Vector2) = Vector2(Math.min(x, o.x), Math.min(y, o.y));

    public static def lerp(v1:Vector2, v2:Vector2, alpha:Float) = (1-alpha)*v1 + alpha*v2;

    public operator this(i:Int) {
        switch (i) {
            case 0n: return x;
            default: return y;
        }
    }

    public def principalAxis() {
        if (x>y) return 0n;
        return 1n;
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab
