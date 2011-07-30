package raytracer;

import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;

public abstract class FrameBuffer {

    protected var raw : IndexedMemoryChunk[RGB];

    public def this (width:Int, height:Int) {
        raw = IndexedMemoryChunk.allocateZeroed[RGB](width * height);
    }

    public abstract def update (write:()=>void) : void;

    public def length() = raw.length();

    public operator this (i:Int) = raw(i);

    public def receive (from:RemoteIndexedMemoryChunk[RGB], from_off:Int, to_off:Int, len:Int) {
        IndexedMemoryChunk.asyncCopy(from, from_off, raw, to_off, len);
    }
       
}


// vim: shiftwidth=4:tabstop=4:expandtab

