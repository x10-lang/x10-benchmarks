package raytracer;

import x10.util.*;

import x10.io.Console;

// power of 2 width/height required
// max of 512 in either direction
public final class Texture2D {
    public static final class MipMap {
        val buffer:IndexedMemoryChunk[RGB];
        val width:Int;
        val height:Int;
        public def this (w_:Int, h_:Int) {
            // account for rectangular textures
            width = w_==0 ? 1 : w_;
            height = h_==0 ? 1 : h_;
            buffer = IndexedMemoryChunk.allocateUninitialized[RGB](width*height);
        }
        public static def mortonEncode (x:Int, y:Int) {
            var r:Int = 0;
            for (i in 0..8) { // 0..512
                val inputMask = 1<<i;
                if ((x & inputMask) != 0) r |= 1<<(2*i+0);
                if ((y & inputMask) != 0) r |= 1<<(2*i+1);
            }
            return r;
        }
        public def raw () = buffer;
        public def unsafeLookup (x:Int, y:Int) = buffer(mortonEncode(x,height-y));
        public def wrappedLookup (x:Int, y:Int) = unsafeLookup(x&(width-1), y&(height-1));
        // filtered with linear interpolation
        public operator this (x:Float, y:Float) {
            val xs = x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // mantissa
            val ym = ys - yi;
            val c00 = wrappedLookup(xi+0,yi+0) as Vector3;
            val c01 = wrappedLookup(xi+1,yi+0) as Vector3;
            val c10 = wrappedLookup(xi+0,yi+1) as Vector3;
            val c11 = wrappedLookup(xi+1,yi+1) as Vector3;
            val c0 = Vector3.lerp(c00, c01, xm);
            val c1 = Vector3.lerp(c10, c11, xm);
            return Vector3.lerp(c0, c1, ym);
        }
        public def init (closure:(x:Int, y:Int)=>RGB) {
            for (y in 0..(height-1)) {
                for (x in 0..(width-1)) {
                    buffer(mortonEncode(x,y)) = closure(x,y);
                }
            }
        }
        public def initFromLevelAbove(above:MipMap) {
            for (i in 0..(buffer.length()-1)) {
                val c0 = above.buffer(4*i+0);
                val c1 = above.buffer(4*i+1);
                val c2 = above.buffer(4*i+2);
                val c3 = above.buffer(4*i+3);
                val box_filter = RGB((c0.r as UInt + c1.r + c2.r + c3.r)/4,
                                     (c0.g as UInt + c1.g + c2.g + c3.g)/4,
                                     (c0.b as UInt + c1.b + c2.b + c3.b)/4);
                buffer(i) = box_filter;
            }
        }
    }

    val mipmaps : Array[MipMap](1);

    public def mipmap(i:Int) = mipmaps(i);

    private static def bitDepth (var x:Int) {
        var r:Int = 0;
        while (x>1) {
            x = x/2;
            r++;
        }
        return r;
    }
    public def this (w_:Int, h_:Int) {
        val wdepth = bitDepth(w_);
        val hdepth = bitDepth(h_);
        val levels = Math.max(wdepth,hdepth);
        val w = 1 << levels;
        val h = 1 << levels;
        this.mipmaps = new Array[MipMap](levels, (i:Int)=>new MipMap(w>>i, h>>i));
    }
    public def init (closure:(x:Int, y:Int)=>RGB) {
        mipmaps(0).init(closure);
        for (i in 1..(mipmaps.size-1)) {
            mipmaps(i).initFromLevelAbove(mipmaps(i-1));
        }
    }
    public operator this (x:Float, y:Float, level:Int) = mipmaps(level)(x,y);
}

// vim: shiftwidth=4:tabstop=4:expandtab

