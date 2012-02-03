import x10.compiler.Inline;
import x10.util.IndexedMemoryChunk;

final class Queue {
    var hash:IndexedMemoryChunk[SHA1Rand];
    var depth:IndexedMemoryChunk[Int];
    var lower:IndexedMemoryChunk[Int];
    var upper:IndexedMemoryChunk[Int];

    var size:Int;
    var count:Long;

    val factor:Int;
    val height:Int;
    val den:Double;

    def this(var capacity:Int, factor:Int, height:Int) {
        if (capacity < 8) capacity = 8;
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

    @Inline def init(seed:Int) {
        val h = SHA1Rand(seed);
        push(h, 1, 0, children(h));
        ++count;
    }

    @Inline def children(h:SHA1Rand) = Math.floor(Math.log(1.0 - h() / 2147483648.0) / den) as Int;

    @Inline def score(i:Int) = Math.pow(factor, height - depth(i)) * (upper(i) - lower(i));

    @Inline def push(h:SHA1Rand, d:Int, l:Int, u:Int):void {
        if (size >= hash.length()) grow();
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
        val h = hash(top);
        val d = depth(top);
        val l = lower(top);
        val u = upper(top) - 1;
        
        if (d < height) {
            if (u == l) --size; else upper(top) = u;
            val hh = SHA1Rand(h, u);
            val uu = children(hh);
            if (uu > 0) push(hh, d + 1, 0, uu);
        } else {
            --size;
            count += u - l;
        }
    }

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
        IndexedMemoryChunk.copy(lower, size, fragment.lower, 0, n);
        IndexedMemoryChunk.copy(upper, size, fragment.upper, 0, n);
        return fragment;
    }

    def grab(i:Int, n:Int) {
        val fragment = new Fragment(1);
        fragment.hash(0) = hash(i);
        fragment.depth(0) = depth(i);
        fragment.upper(0) = upper(i);
        upper(i) -= n;
        fragment.lower(0) = upper(i);
        return fragment;
    }

    def push(fragment:Fragment) {
        val n = fragment.hash.length();
        while (size + n > hash.length()) grow();
        IndexedMemoryChunk.copy(fragment.hash, 0, hash, size, n);
        IndexedMemoryChunk.copy(fragment.depth, 0, depth, size, n);
        IndexedMemoryChunk.copy(fragment.lower, 0, lower, size, n);
        IndexedMemoryChunk.copy(fragment.upper, 0, upper, size, n);
        size += n;
    }

    private def grow():void {
        val capacity = size * 2;
        val h = IndexedMemoryChunk.allocateUninitialized[SHA1Rand](capacity);
        IndexedMemoryChunk.copy(hash, 0, h, 0, size);
        hash.deallocate();
        hash = h;
        val d = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        IndexedMemoryChunk.copy(depth, 0, d, 0, size);
        depth.deallocate();
        depth = d;
        val l = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        IndexedMemoryChunk.copy(lower, 0, l, 0, size);
        lower.deallocate();
        lower = l;
        val u = IndexedMemoryChunk.allocateUninitialized[Int](capacity);
        IndexedMemoryChunk.copy(upper, 0, u, 0, size);
        upper.deallocate();
        upper = u;
    }

    @Inline def select() {
        var max:Double = 0.0;
        var mem:Int = -1;
        for (var i:Int=0; i<size; i++) {
            if (upper(i) <= lower(i) + 1) continue;
            val s = score(i);
            if (s > max) {
                max = s;
                mem = i;
            }
        }
        return mem;
    }

    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    public static def main(Array[String]) {
        val queue = new Queue(256, 4, 13);
        var time:Long = System.nanoTime();
        queue.init(29);
        while (queue.size > 0) {
            queue.expand();
            queue.count++;
        }
        time = System.nanoTime() - time;
        Console.OUT.println("Performance = " + queue.count + "/" +
                sub("" + time/1e9, 0, 6) + " = " +
                sub("" + (queue.count/(time/1e3)), 0, 6) + "M nodes/s");
    }
}
