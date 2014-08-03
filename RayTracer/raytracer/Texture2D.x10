package raytracer;

import x10.util.*;

import x10.io.Console;

// power of 2 width/height required
// max of 512 in either direction
public final class Texture2D {
    public static final class MipMap {
        val buffer:Rail[RGB];
        val width:Int;
        val height:Int;
        public def this(w_:Int, h_:Int) {
            // account for rectangular textures
            width = w_==0n ? 1n : w_;
            height = h_==0n ? 1n : h_;
            buffer = new Rail[RGB](width*height);
        }
        public def coordEncode(x:Int, y:Int) {
            return y * width + x;
            /*
            var r:Int = 0;
            for (i in 0..8) { // 0..512
                val inputMask = 1<<i;
                if ((x & inputMask) != 0) r |= 1<<(2*i+0);
                if ((y & inputMask) != 0) r |= 1<<(2*i+1);
            }
            return r;
            */
        }
        public def raw() = buffer;
        public def unsafeLookup(x:Int, y:Int) = buffer(coordEncode(x,y));
        public def wrappedLookup(x:Int, y:Int) = unsafeLookup(x&(width-1n), y&(height-1n));
        public def clampedLookup(x:Int, y:Int) = unsafeLookup(Math.min(Math.max(x,0n),width-1n), Math.min(Math.max(y,0n),height-1n));
        // filtered with linear interpolation
        public def wrappedLookup(uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = wrappedLookup(xi+0n,yi+0n) as Vector3;
            val c01 = wrappedLookup(xi+1n,yi+0n) as Vector3;
            val c10 = wrappedLookup(xi+0n,yi+1n) as Vector3;
            val c11 = wrappedLookup(xi+1n,yi+1n) as Vector3;
            val c0 = Vector3.lerp(c00, c01, xm);
            val c1 = Vector3.lerp(c10, c11, xm);
            return Vector3.lerp(c0, c1, ym);
        }
        public def clampedLookup(uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = clampedLookup(xi+0n,yi+0n) as Vector3;
            val c01 = clampedLookup(xi+1n,yi+0n) as Vector3;
            val c10 = clampedLookup(xi+0n,yi+1n) as Vector3;
            val c11 = clampedLookup(xi+1n,yi+1n) as Vector3;
            val c0 = Vector3.lerp(c00, c01, xm);
            val c1 = Vector3.lerp(c10, c11, xm);
            return Vector3.lerp(c0, c1, ym);
        }
        public def wrappedNearestLookup(uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = wrappedLookup(xi+0n,yi+0n) as Vector3;
            val c01 = wrappedLookup(xi+1n,yi+0n) as Vector3;
            val c10 = wrappedLookup(xi+0n,yi+1n) as Vector3;
            val c11 = wrappedLookup(xi+1n,yi+1n) as Vector3;
            val c0 = xm < 0.5 ? c00 : c01;
            val c1 = xm < 0.5 ? c10 : c11;
            return ym < 0.5 ? c0 : c1;
        }
        public def init(closure:(x:Int, y:Int)=>RGB) {
            for (y in 0n..(height-1n)) {
                for (x in 0n..(width-1n)) {
                    buffer(coordEncode(x,y)) = closure(x,y);
                }
            }
        }
        public def initFromLevelAbove(above:MipMap) {
            if (above.width == 1n) {
                for (y in 0n..(height-1n)) {
                    val c0 = above.buffer(above.coordEncode(0n, 2n*y+0n));
                    val c1 = above.buffer(above.coordEncode(0n, 2n*y+1n));
                    val box_filter = 0.5f*c0+0.5f*c1;
                    buffer(coordEncode(0n,y)) = box_filter;
                }
            } else if (above.height == 1n) {
                for (x in 0n..(width-1n)) {
                    val c0 = above.buffer(above.coordEncode(2n*x+0n,0n));
                    val c1 = above.buffer(above.coordEncode(2n*x+1n,0n));
                    val box_filter = 0.5f*c0+0.5f*c1;
                    buffer(coordEncode(x,0n)) = box_filter;
                }
            } else {
                for (y in 0n..(height-1n)) {
                    for (x in 0n..(width-1n)) {
                        val c0 = above.buffer(above.coordEncode(2n*x+0n,2n*y+0n));
                        val c1 = above.buffer(above.coordEncode(2n*x+1n,2n*y+0n));
                        val c2 = above.buffer(above.coordEncode(2n*x+0n,2n*y+1n));
                        val c3 = above.buffer(above.coordEncode(2n*x+1n,2n*y+1n));
                        val box_filter = 0.25f*c0+0.25f*c1+0.25f*c2+0.25f*c3;
                        buffer(coordEncode(x,y)) = box_filter;
                    }
                }
            }
        }
    }

    val mipmaps:Rail[MipMap];

    public def mipmap(i:Int) = mipmaps(i);

    private static def bitDepth(var x:Int) {
        var r:Int = 0n;
        while (x>1n) {
            x = x/2n;
            r++;
        }
        return r;
    }
    public def this(w:Int, h:Int) {
        val wdepth = bitDepth(w);
        val hdepth = bitDepth(h);
        val levels = Math.max(wdepth,hdepth);
        this.mipmaps = new Rail[MipMap](levels, (i:Long)=>new MipMap(w>>i, h>>i));
    }
    public def init (closure:(x:Int, y:Int)=>RGB) {
        mipmaps(0).init(closure);
        for (i in 1..(mipmaps.size-1)) {
            mipmaps(i).initFromLevelAbove(mipmaps(i-1));
        }
    }

    public def mipmapLevel(level:Int) = mipmaps(Math.max(0n, Math.min((mipmaps.size-1) as Int, level)));;

    public operator this (uv:Vector2, level:Int) = mipmapLevel(level).wrappedLookup(uv);
    public def clampedLookup(uv:Vector2, level:Int) = mipmapLevel(level).clampedLookup(uv);
    public def wrappedNearestLookup(uv:Vector2, level:Int) = mipmapLevel(level).wrappedNearestLookup(uv);

    public def width() = mipmaps(0).width;
    public def height() = mipmaps(0).height;
}

// vim: shiftwidth=4:tabstop=4:expandtab
