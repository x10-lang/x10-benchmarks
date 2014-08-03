package raytracer;

public struct RGB(r:UByte, g:UByte, b:UByte) {

    public def this(r:UByte, g:UByte, b:UByte) {
        property(r,g,b);
    }

    public def this(r:Int, g:Int, b:Int) {
        property(Math.min(Math.max(r, 0n),255n) as UByte,
                 Math.min(Math.max(g, 0n),255n) as UByte,
                 Math.min(Math.max(b, 0n),255n) as UByte);
    }

    public def this(r:Float, g:Float, b:Float) {
        property(Math.min(Math.max(r*255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(g*255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(b*255, 0.0f),255.0f) as UByte);
    }

    public operator this + (v:RGB) = RGB(r+v.r, g+v.g, b+v.b);
    public operator this - (v:RGB) = RGB(r-v.r, g-v.g, b-v.b);
    public operator this * (v:RGB) = RGB((r*(v.r as UShort))/256, (g*(v.g as UShort))/256, (b*(v.b as UShort))/256);
    public operator this * (v:Float) = ((this as Vector3) * v) as RGB;
    public operator (v:Float) * this = (v * (this as Vector3)) as RGB;
    public operator this / (v:Float) = ((this as Vector3) / v) as RGB;

    public static WHITE = RGB(255n,255n,255n);
    public static GREY = RGB(127n,127n,127n);
    public static BLACK = RGB(0n,0n,0n);
    public static YELLOW   = RGB(255n,255n,0n);
    public static DARK_YELLOW   = RGB(127n,127n,0n);
    public static ORANGE   = RGB(255n,127n,0n);
    public static DARK_ORANGE   = RGB(127n,63n,0n);
    public static RED   = RGB(255n,0n,0n);
    public static DARK_RED   = RGB(127n,0n,0n);
    public static GREEN = RGB(0n,255n,0n);
    public static DARK_GREEN = RGB(0n,127n,0n);
    public static BLUE  = RGB(0n,0n,255n);
    public static DARK_BLUE  = RGB(0n,0n,127n);
    public static CYAN  = RGB(0n,255n,255n);
    public static DARK_CYAN  = RGB(0n,127n,127n);

    public static operator (v:Vector3) as RGB = RGB(v.x, v.y, v.z);

    public static def lerp(v1:RGB, v2:RGB, alpha:Float) = (1-alpha)*v1 + alpha*v2;
}

// vim: shiftwidth=4:tabstop=4:expandtab
