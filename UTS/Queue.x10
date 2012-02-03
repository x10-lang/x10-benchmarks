import x10.compiler.Inline;
import x10.util.IndexedMemoryChunk;

final class Queue {
    var hash:IndexedMemoryChunk[SHA1Rand];
    var depth:IndexedMemoryChunk[Int];
    var lower:IndexedMemoryChunk[Int];
    var upper:IndexedMemoryChunk[Int];

    var size:Int;
    var count:Long;

    val b:Int;
    val height:Int;
    val den:Double;

    def this(capacity:Int, factor:Int, height:Int) {
        hash = IndexedMemoryChunk.allocateUninitialized[SHA1Rand](capacity);
        depth = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        lower = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        upper = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        size = 0;
        count = 0L;
        this.factor = factor;
        this.height = height;
        den = Math.log(factor / (1.0 + factor));
    }

    @Inline def init(seed:Int, den:Double) {
        val h = SHA1Rand(seed);
        push(h, 0, 0, children(h));
    }

    @Inline def children(h:SHA1Rand) = Math.floor(Math.log(1.0 - hh() / 2147483648.0) / den) as Int;

    @Inline def score(i:Int) = Math.exp(factor, height - depth(i)) * (upper(i) - lower(i));

    @Inline def push(h:SHA1Rand, d:Int, l:Int, u:Int):void {
//        if (size+1 > capacity()) grow(size+1);
        hash(size) = h;
        depth(size) = d;
        lower(size) = l;
        upper(size++) = u;
    }

    @Inline def pop():Int {
        return --size;
    }

    @Inline def expand() {
        val top = size - 1;
        val d = depth(top);
        val l = lower(top);
        val u = --upper(top);
        
        val h = hash(top);
        if (depth < height) {
            if (u == l) --size;
            val hh = SHA1Rand(h, u);
            val uu = children(hh);
            if (uu > 0) push(hh, d + 1, 0, uu);
        } else {
            count += upper - lower;
        }
    }

//    @Inline def capacity():Int = imc.length();

    static class Fragment {
        val hash:IndexedMemoryChunk[SHA1Rand];
        val depth:IndexedMemoryChunk[Int];
        val lower:IndexedMemoryChunk[Int];
        val upper:IndexedMemoryChunk[Int];

        def this (size:Int) {
            hash = IndexedMemoryChunk.allocateUninitialized[SHA1Rand](size);
            depth = IndexedMemoryChunk.allocateUninitialized[Int](size);
            lower = IndexedMemoryChunk.allocateUninitialized[Int](size);
            upper = IndexedMemoryChunk.allocateUninitialized[Int](size);
        }
    }

    def pop(n:Int) {
        val fragment = new Fragment(n);
        size -= n;
        IndexedMemoryChunk.copy(hash, size, fragment.hash, 0, n);
        IndexedMemoryChunk.copy(depth, size, fragment.depth, 0, n);
        IndexedMemoryChunk.copy(lower, size, fragment.lower 0, n);
        IndexedMemoryChunk.copy(upper, size, fragment.upper, 0, n);
        return fragment;
    }

    def push(fragment:Fragment) {
        val n = fragment.hash.size();
        IndexedMemoryChunk.copy(fragment.hash, size, hash, 0, n);
        IndexedMemoryChunk.copy(fragment.depth, size, depth, 0, n);
        IndexedMemoryChunk.copy(fragment.lower, size, lower 0, n);
        IndexedMemoryChunk.copy(fragment.upper, size, upper, 0, n);
        size += n;
    }
    
    /*
    private def grow(var newCapacity:Int):void {
        var oldCapacity:int = capacity();
        if (newCapacity < oldCapacity*2) {
            newCapacity = oldCapacity*2;
        }
        if (newCapacity < 8) {
            newCapacity = 8;
        }
        val tmp = IndexedMemoryChunk.allocateUninitialized[Int](newCapacity);
        IndexedMemoryChunk.copy(imc, 0, tmp, 0, size);
        imc.deallocate();
        imc = tmp;
    }
    */
}
