package raytracer;

import x10.compiler.Inline;


public struct Vector2(x:Float,y:Float) {

    @Inline public operator this + (v:Vector2) = Vector2(x+v.x, y+v.y);
    @Inline public operator this - (v:Vector2) = Vector2(x-v.x, y-v.y);
    @Inline public operator + this = this;
    @Inline public operator - this = Vector2(-x, -y);
    @Inline public operator this * (v:Vector2) = Vector2(x*v.x, y*v.y);
    @Inline public operator this / (v:Vector2) = Vector2(x/v.x, y/v.y);
    @Inline public operator this * (v:Float) = Vector2(x*v, y*v);
    @Inline public operator (v:Float) * this = Vector2(x*v, y*v);
    @Inline public operator this / (v:Float) = Vector2(x/v, y/v);

    @Inline public def length2() = x*x + y*y;
    @Inline public def length() = Math.sqrtf(length2());
    @Inline public def dot (v:Vector2) = x*v.x + y*v.y;
    @Inline public def cross (v:Vector2) = x*v.y - y*v.x;
    @Inline public def normalised() = this/length();

    public def toString () = "Vector2("+x+", "+y+")";

    @Inline public def maxElement () = Math.max(x, y);
    @Inline public def minElement () = Math.min(x, y);

    @Inline public static def max (a:Vector2, b:Vector2) = Vector2(Math.max(a.x, b.x), Math.max(a.y, b.y));
    @Inline public static def min (a:Vector2, b:Vector2) = Vector2(Math.min(a.x, b.x), Math.min(a.y, b.y));
    @Inline public def max (o:Vector2) = Vector2(Math.max(x, o.x), Math.max(y, o.y));
    @Inline public def min (o:Vector2) = Vector2(Math.min(x, o.x), Math.min(y, o.y));

    @Inline public static def lerp (v1:Vector2, v2:Vector2, alpha:Float) = (1-alpha)*v1 + alpha*v2;

}

