final class Fragment {
    val hash:Rail[SHA1Rand];
    val lower:Rail[Int];
    val upper:Rail[Int];
 
    def this(size:Long) {
        hash = new Rail[SHA1Rand](size);
        lower = new Rail[Int](size);
        upper = new Rail[Int](size);
    }

    static def make(queue:Queue) {
        var s:Long = 0;
        for (var i:Long=0; i<queue.size; ++i) {
            if ((queue.upper(i) - queue.lower(i)) >= 2) ++s;
        }
        if (s == 0) return null;
        val fragment = new Fragment(s);
        s = 0;
        for (var i:Long=0; i<queue.size; ++i) {
            val p = queue.upper(i) - queue.lower(i);
            if (p >= 2n) {
                fragment.hash(s) = queue.hash(i);
                fragment.upper(s) = queue.upper(i);
                queue.upper(i) -= p/2n;
                fragment.lower(s++) = queue.upper(i);
            }
        }
        return fragment;
    }

    def push(queue:Queue) {
        val h = hash.size;
        val q = queue.size;
        while (h + q > queue.hash.size) queue.grow();
        Rail.copy(hash, 0, queue.hash, q, h);
        Rail.copy(lower, 0, queue.lower, q, h);
        Rail.copy(upper, 0, queue.upper, q, h);
        queue.size += h;
    }
}
