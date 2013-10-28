package myuts; 
import x10.compiler.*;
// Questions:Q1(l5) Q2(l7)  Q3(l13,44,45,74, what was unbounded?) Q4(SHA1RANd.x10) Q5(not a real question)(l19)
final class Queue {
    var hash:Rail[SHA1Rand];
    var lower:Rail[Int]; // Wei: Question: shouldn't lower elements values are always 0 ? only in seq code
    var upper:Rail[Int];
    var size:Long; // Wei: Q: seems not initialized, is it true default value is always 0 ?

    val den:Double;

    var count:Long;

    
    def this(factor:Int) { // Wei: factor is the branching factor, expected value not the max value 
    	                   // Does this imply if we are really unlucky, the tree can be really large, but
    	                   // since we have bounded depth it terminates
        hash = new Rail[SHA1Rand](4096);
        lower = new Rail[Int](4096);
        upper = new Rail[Int](4096);
        den = Math.log(factor / (1.0 + factor)); // den:stands for denominator
       
    }

    @Inline def init(seed:Int, height:Int) {
        push(SHA1Rand(seed, height));
        ++count; // now we have a root node
    }

    @Inline def push(h:SHA1Rand):void {
        val u = Math.floor(Math.log(1.0 - h() / 2147483648.0) / den) as Int;
        if(u > 0n) { 
            if(size >= hash.size) grow();
            hash(size) = h;
            lower(size) = 0n;
            upper(size++) = u;
        }
    }

    @Inline def expand() {
        val top = size - 1;
        val h = hash(top);
        val d = h.depth;
        val l = lower(top);
        val u = upper(top) - 1n; // note this -1n thing here, upper is exclusive
        
        if(d > 1n) { // cutoff depth, the guard ?
            if(u == l) --size; else upper(top) = u; // Q: grow the next child , what if u==l==0, probably it is the last child to grow ?
            push(SHA1Rand(h, u, d - 1n)); // will call grow, parent id, child idx used as the generator, and depth
        } else {
            --size;
            count += u - l;
        }
    }

    /**
     * double the size
     */
    def grow():void {
        val capacity = size * 2;
        val h = new Rail[SHA1Rand](capacity);
        Rail.copy(hash, 0, h, 0, size);
        hash = h;
        val l = new Rail[Int](capacity);
        Rail.copy(lower, 0, l, 0, size);//Wei: copy syntax: src, srcIdx, dest, destIdx, # to copy
        lower = l;
        val u = new Rail[Int](capacity);
        Rail.copy(upper, 0, u, 0, size);
        upper = u;
    }

    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    public static def main(Rail[String]) {
        val queue = new Queue(4n); // branching factor
        var time:Long = System.nanoTime();
        queue.init(19n, 13n); // seed, depth, Q:given these two parameters, even in distributed manner, the tree is deterministic? with branching factor
        while (queue.size > 0) {
            queue.expand();
            ++queue.count;
        }
        time = System.nanoTime() - time;
        Console.OUT.println("Performance = " + queue.count + "/" +
                sub("" + time/1e9, 0n, 6n) + " = " +
                sub("" + (queue.count/(time/1e3)), 0n, 6n) + "M nodes/s");
    }
}
