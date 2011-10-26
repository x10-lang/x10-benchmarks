package raytracer;

import x10.util.*;

import x10.io.Console;

import x10.compiler.Inline;

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
        @Inline public def coordEncode (x:Int, y:Int) {
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
        public def raw () = buffer;
        public def unsafeLookup (x:Int, y:Int) = buffer(coordEncode(x,y));
        public def wrappedLookup (x:Int, y:Int) = unsafeLookup(x&(width-1), y&(height-1));
        public def clampedLookup (x:Int, y:Int) = unsafeLookup(Math.min(Math.max(x,0),width-1), Math.min(Math.max(y,0),height-1));
        // filtered with linear interpolation
        public def wrappedLookup (uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = wrappedLookup(xi+0,yi+0) as Vector3;
            val c01 = wrappedLookup(xi+1,yi+0) as Vector3;
            val c10 = wrappedLookup(xi+0,yi+1) as Vector3;
            val c11 = wrappedLookup(xi+1,yi+1) as Vector3;
            val c0 = Vector3.lerp(c00, c01, xm);
            val c1 = Vector3.lerp(c10, c11, xm);
            return Vector3.lerp(c0, c1, ym);
        }
        public def clampedLookup (uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = clampedLookup(xi+0,yi+0) as Vector3;
            val c01 = clampedLookup(xi+1,yi+0) as Vector3;
            val c10 = clampedLookup(xi+0,yi+1) as Vector3;
            val c11 = clampedLookup(xi+1,yi+1) as Vector3;
            val c0 = Vector3.lerp(c00, c01, xm);
            val c1 = Vector3.lerp(c10, c11, xm);
            return Vector3.lerp(c0, c1, ym);
        }
        public def wrappedNearestLookup (uv:Vector2) {
            val xs = uv.x * width - 0.5f; // scaled and with the mid-pixel offset
            val ys = uv.y * height - 0.5f;
            val xi = xs as Int;
            val yi = ys as Int;
            val xm = xs - xi; // fractional part
            val ym = ys - yi;
            val c00 = wrappedLookup(xi+0,yi+0) as Vector3;
            val c01 = wrappedLookup(xi+1,yi+0) as Vector3;
            val c10 = wrappedLookup(xi+0,yi+1) as Vector3;
            val c11 = wrappedLookup(xi+1,yi+1) as Vector3;
            val c0 = xm < 0.5 ? c00 : c01;
            val c1 = xm < 0.5 ? c10 : c11;
            return ym < 0.5 ? c0 : c1;
        }
        public def init (closure:(x:Int, y:Int)=>RGB) {
            for (y in 0..(height-1)) {
                for (x in 0..(width-1)) {
                    buffer(coordEncode(x,y)) = closure(x,y);
                }
            }
        }
        public def initFromLevelAbove(above:MipMap) {
            if (above.width == 1) {
                for (y in 0..(height-1)) {
                    val c0 = above.buffer(above.coordEncode(0, 2*y+0));
                    val c1 = above.buffer(above.coordEncode(0, 2*y+1));
                    val box_filter = 0.5f*c0+0.5f*c1;
                    buffer(coordEncode(0,y)) = box_filter;
                }
            } else if (above.height == 1) {
                for (x in 0..(width-1)) {
                    val c0 = above.buffer(above.coordEncode(2*x+0,0));
                    val c1 = above.buffer(above.coordEncode(2*x+1,0));
                    val box_filter = 0.5f*c0+0.5f*c1;
                    buffer(coordEncode(x,0)) = box_filter;
                }
            } else {
                for (y in 0..(height-1)) {
                    for (x in 0..(width-1)) {
                        val c0 = above.buffer(above.coordEncode(2*x+0,2*y+0));
                        val c1 = above.buffer(above.coordEncode(2*x+1,2*y+0));
                        val c2 = above.buffer(above.coordEncode(2*x+0,2*y+1));
                        val c3 = above.buffer(above.coordEncode(2*x+1,2*y+1));
                        val box_filter = 0.25f*c0+0.25f*c1+0.25f*c2+0.25f*c3;
                        buffer(coordEncode(x,y)) = box_filter;
                    }
                }
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
    public def this (w:Int, h:Int) {
        val wdepth = bitDepth(w);
        val hdepth = bitDepth(h);
        val levels = Math.max(wdepth,hdepth);
        this.mipmaps = new Array[MipMap](levels, (i:Int)=>new MipMap(w>>i, h>>i));
    }
    public def init (closure:(x:Int, y:Int)=>RGB) {
        mipmaps(0).init(closure);
        for (i in 1..(mipmaps.size-1)) {
            mipmaps(i).initFromLevelAbove(mipmaps(i-1));
        }
    }

    public def mipmapLevel(level:Int) = mipmaps(Math.max(0, Math.min(mipmaps.size-1, level)));;

    public operator this (uv:Vector2, level:Int) = mipmapLevel(level).wrappedLookup(uv);
    public def clampedLookup (uv:Vector2, level:Int) = mipmapLevel(level).clampedLookup(uv);
    public def wrappedNearestLookup (uv:Vector2, level:Int) = mipmapLevel(level).wrappedNearestLookup(uv);

    public def width () = mipmap(0).width;
    public def height () = mipmap(0).height;
}

// vim: shiftwidth=4:tabstop=4:expandtab

