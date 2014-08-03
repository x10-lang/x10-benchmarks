package raytracer;

import x10.util.HashMap;
import x10.util.ArrayList;

public abstract class FrameBuffer {

    protected var raw:Rail[RGB];

    public def this(width:Int, height:Int) {
        raw = new Rail[RGB](width * height);
    }

    public abstract def update(write:()=>void):void;

    public def length() = raw.size;

    public operator this (i:Int) = raw(i);

    public def raw() = raw;

}

// vim: shiftwidth=4:tabstop=4:expandtab
