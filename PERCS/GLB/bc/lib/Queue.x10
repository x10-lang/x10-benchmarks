package bc.lib;

import x10.compiler.*;
import x10.util.Team;

import bc.Graph;
import bc.Rmat;

public final class Queue extends bc.BC implements glb.TaskQueue {
    public var lower:Rail[Int];
    public var upper:Rail[Int];
    protected var size:Long;

    public def this(rmat:Rmat, permute:Int) {
        super(rmat, permute);
        lower = new Rail[Int](4096);
        upper = new Rail[Int](4096);
        val h = Runtime.hereInt();
        val max = Place.MAX_PLACES;
        lower(0) = (N as Long*h/max) as Int;
        upper(0) = (N as Long*(h+1)/max) as Int;
        size = 1;
    }

    public final def grow():void {
        val capacity = size * 2;
        val l = new Rail[Int](capacity);
        Rail.copy(lower, 0, l, 0, size);
        lower = l;
        val u = new Rail[Int](capacity);
        Rail.copy(upper, 0, u, 0, size);
        upper = u;
    }

    @Inline public def process(n:Long) {
        val top = size - 1;
        val l = lower(top);
        val u = upper(top) - 1n;
        
        if(u == l) --size; else upper(top) = u;
        bfsShortestPath(u);
        return size > 0;
    }

    @Inline public def split() {
        var s:Long = 0;
        for (var i:Long=0; i<size; ++i) {
            if ((upper(i) - lower(i)) >= 2) ++s;
        }
        if (s == 0) return null;
        val bag = new Bag(s);
        s = 0;
        for (var i:Long=0; i<size; ++i) {
            val p = upper(i) - lower(i);
            if (p >= 2n) {
                bag.upper(s) = upper(i);
                upper(i) -= p/2n;
                bag.lower(s++) = upper(i);
            }
        }
        return bag;
    }

    @Inline public def merge(bag:Bag) {
        val h = bag.size();
        val q = size;
        while (h + q > upper.size) grow();
        Rail.copy(bag.lower, 0, lower, q, h);
        Rail.copy(bag.upper, 0, upper, q, h);
        size += h;
    }

    @Inline public def merge(bag:glb.TaskBag) {
        merge(bag as Bag);
    }

    @Inline public def count() = count;

    def allreduce() {
        Team.WORLD.allreduce(betweennessMap, // Source buffer.
                0, // Offset into the source buffer.
                betweennessMap, // Destination buffer.
                0, // Offset into the destination buffer.
                N as long, // Number of elements.
                Team.ADD); // Operation to be performed.
    }
}
