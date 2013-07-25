import x10.compiler.*;

final class Queue {
    var hash:Rail[SHA1Rand];
    var lower:Rail[Int];
    var upper:Rail[Int];
    var size:Long;

    val den:Double;

    var count:Long;

    def this(factor:Int) {
        hash = new Rail[SHA1Rand](4096);
        lower = new Rail[Int](4096);
        upper = new Rail[Int](4096);
        den = Math.log(factor / (1.0 + factor));
    }

    @Inline def init(seed:Int, height:Int) {
        push(SHA1Rand(seed, height));
        ++count;
    }

    @Inline def push(h:SHA1Rand):void {
        val u = Math.floor(Math.log(1.0 - h() / 2147483648.0) / den) as Int;
        if(u > 0) {
            if(size >= hash.size) grow();
            hash(size) = h;
            lower(size) = 0;
            upper(size++) = u;
        }
    }

    @Inline def expand() {
        val top = size - 1;
        val h = hash(top);
        val d = h.depth;
        val l = lower(top);
        val u = upper(top) - 1;
        
        if(d > 1) {
            if(u == l) --size; else upper(top) = u;
            push(SHA1Rand(h, u, d - 1));
        } else {
            --size;
            count += u - l;
        }
    }

    def grow():void {
        val capacity = size * 2;
        val h = new Rail[SHA1Rand](capacity);
        Rail.copy(hash, 0L, h, 0L, size);
        hash = h;
        val l = new Rail[Int](capacity);
        Rail.copy(lower, 0L, l, 0L, size);
        lower = l;
        val u = new Rail[Int](capacity);
        Rail.copy(upper, 0L, u, 0L, size);
        upper = u;
    }

    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    public static def main(Rail[String]) {
        val queue = new Queue(4); // branching factor
        var time:Long = System.nanoTime();
        queue.init(19, 13); // seed, depth
        while (queue.size > 0L) {
            queue.expand();
            ++queue.count;
        }
        time = System.nanoTime() - time;
        Console.OUT.println("Performance = " + queue.count + "/" +
                sub("" + time/1e9, 0, 6) + " = " +
                sub("" + (queue.count/(time/1e3)), 0, 6) + "M nodes/s");
    }
}
