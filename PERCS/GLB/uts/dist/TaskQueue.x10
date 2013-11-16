package uts.dist;

import x10.compiler.*;

public final class TaskQueue extends uts.UTS {
    public def this(factor:Int) {
        super(factor);
    }

    @Inline public def process(n:Long) {
        var i:Long=0;
        for (; (i<n) && (size>0); ++i) {
            expand();
        }
        count += i;
        return size > 0;
    }

    @Inline public def split() {
        var s:Long = 0;
        for (var i:Long=0; i<size; ++i) {
            if ((upper(i) - lower(i)) >= 2) ++s;
        }
        if (s == 0) return null;
        val bag = new TaskBag(s);
        s = 0;
        for (var i:Long=0; i<size; ++i) {
            val p = upper(i) - lower(i);
            if (p >= 2n) {
                bag.hash(s) = hash(i);
                bag.upper(s) = upper(i);
                upper(i) -= p/2n;
                bag.lower(s++) = upper(i);
            }
        }
        return bag;
    }

    @Inline public def merge(bag:TaskBag) {
        val h = bag.size();
        val q = size;
        while (h + q > hash.size) grow();
        Rail.copy(bag.hash, 0, hash, q, h);
        Rail.copy(bag.lower, 0, lower, q, h);
        Rail.copy(bag.upper, 0, upper, q, h);
        size += h;
    }
}
