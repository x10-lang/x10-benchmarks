package raytracer;

import x10.compiler.Inline;

public struct RGB(r:UByte,g:UByte,b:UByte) {
    @Inline public def this (r:UByte, g:UByte, b:UByte) {
        property(r,g,b);
    }
    @Inline public def this (r:Int, g:Int, b:Int) {
        property(Math.min(Math.max(r, 0),255) as UByte,
                 Math.min(Math.max(g, 0),255) as UByte,
                 Math.min(Math.max(b, 0),255) as UByte);
    }
    @Inline public def this (r:Float, g:Float, b:Float) {
        property(Math.min(Math.max(r * 255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(g * 255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(b * 255, 0.0f),255.0f) as UByte);
    }

    @Inline public operator this + (v:RGB) = RGB(r+v.r, g+v.g, b+v.b);
    @Inline public operator this - (v:RGB) = RGB(r-v.r, g-v.g, b-v.b);
    @Inline public operator this * (v:RGB) = RGB((r*(v.r as UShort))/256, (g*(v.g as UShort))/256, (b*(v.b as UShort))/256);
    @Inline public operator this * (v:Float) = ((this as Vector3) * v) as RGB;
    @Inline public operator (v:Float) * this = (v * (this as Vector3)) as RGB;
    @Inline public operator this / (v:Float) = ((this as Vector3) / v) as RGB;

    public static WHITE = RGB(255,255,255);
    public static GREY = RGB(127,127,127);
    public static BLACK = RGB(0,0,0);
    public static YELLOW   = RGB(255,255,0);
    public static DARK_YELLOW   = RGB(127,127,0);
    public static ORANGE   = RGB(255,127,0);
    public static DARK_ORANGE   = RGB(127,63,0);
    public static RED   = RGB(255,0,0);
    public static DARK_RED   = RGB(127,0,0);
    public static GREEN = RGB(0,255,0);
    public static DARK_GREEN = RGB(0,127,0);
    public static BLUE  = RGB(0,0,255);
    public static DARK_BLUE  = RGB(0,0,127);
    public static CYAN  = RGB(0,255,255);
    public static DARK_CYAN  = RGB(0,127,127);

    @Inline public static operator (v:Vector3) as RGB = RGB(v.x, v.y, v.z);

    @Inline public static def lerp (v1:RGB, v2:RGB, alpha:Float) = (1-alpha)*v1 + alpha*v2;
}

