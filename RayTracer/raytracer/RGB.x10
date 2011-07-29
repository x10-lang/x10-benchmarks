package raytracer;

public struct RGB(r:UByte,g:UByte,b:UByte) {
    public def this (r:UByte, g:UByte, b:UByte) {
        property(r,g,b);
    }
    public def this (r:Int, g:Int, b:Int) {
        property(Math.min(Math.max(r, 0),255) as UByte,
                 Math.min(Math.max(g, 0),255) as UByte,
                 Math.min(Math.max(b, 0),255) as UByte);
    }
    public def this (r:Float, g:Float, b:Float) {
        property(Math.min(Math.max(r * 255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(g * 255, 0.0f),255.0f) as UByte,
                 Math.min(Math.max(b * 255, 0.0f),255.0f) as UByte);
    }
    static WHITE = RGB(255,255,255);
    static BLACK = RGB(0,0,0);
    static RED   = RGB(255,0,0);
    static DARK_RED   = RGB(127,0,0);
    static GREEN = RGB(0,255,0);
    static DARK_GREEN = RGB(0,127,0);
    static BLUE  = RGB(0,0,255);
    static DARK_BLUE  = RGB(0,0,127);
}

