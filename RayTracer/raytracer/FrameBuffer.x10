package raytracer;

import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;
import x10.util.HashMap;
import x10.util.ArrayList;

public abstract class FrameBuffer {

    protected var raw : IndexedMemoryChunk[RGB];

    public def this (width:Int, height:Int) {
        raw = IndexedMemoryChunk.allocateZeroed[RGB](width * height);
    }

    public abstract def update (write:()=>void) : void;

    public def length() = raw.length();

    public operator this (i:Int) = raw(i);

    public def raw() = raw;

}


// vim: shiftwidth=4:tabstop=4:expandtab

