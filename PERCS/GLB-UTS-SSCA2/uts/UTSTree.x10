package uts; 
import x10.compiler.Inline;

/**
 * Data structure to represent the Geometric tree
 */
final class UTSTree {
	/*descriptor array*/
    var hash:Rail[SHA1Rand];
    /*unvisited children lower array*/
    var lower:Rail[Int]; // It always starts 0, but if merging happens it can become non-zero
    /*unvisited children upper array*/
    var upper:Rail[Int];
    /*number of the effective elements in hash/lower/upper, one hash/lower/upper 3-tuple represents a node
     note, this is however not the size of the tree.*/
    var size:Long; 

    /*denominator*/
    val den:Double;

    /*number of nodes have been visited*/
    var count:Long;

    /*branching factor*/
    val factor:Int; 
    
    /**
     * Constructor
     * @param factor, branching factor,expected value not the max value 
     */
    def this(factor:Int) { // 
        hash = new Rail[SHA1Rand](4096);
        lower = new Rail[Int](4096);
        upper = new Rail[Int](4096);
        den = Math.log(factor / (1.0 + factor)); // den:stands for denominator
        this.factor = factor;
    }

    /**
     * @param seed raondom seed
     * @param height distance from the bottom of the trees
     */
    @Inline def init(seed:Int, height:Int) {
        push(SHA1Rand(seed, height));
        ++count; // now we have a root node
    }

    /**
     * Grow a new node
     * @param h node descriptor
     */
    @Inline def push(h:SHA1Rand):void {
        val u = Math.floor(Math.log(1.0 - h() / 2147483648.0) / den) as Int;
        if(u > 0n) { 
            if(size >= hash.size){
            	grow();
            }
            hash(size) = h;
            lower(size) = 0n;
            upper(size++) = u;
        }
    }

    /**
     * Explore the tree in a depth-first manner
     */
    @Inline def expand() {
        val top = size - 1;
        val h = hash(top);
        val d = h.depth;
        val l = lower(top);
        val u = upper(top) - 1n;
        
        if(d > 1n) { // cutoff depth
            if(u == l) --size; else upper(top) = u; 
            push(SHA1Rand(h, u, d - 1n)); 
        } else {
            --size;
            count += u - l;
        }
    }

    /**
     * grow by doubling the tree size 
     */
    def grow():void {
        val capacity = size * 2;
        val h = new Rail[SHA1Rand](capacity);
        Rail.copy(hash, 0, h, 0, size);
        hash = h;
        val l = new Rail[Int](capacity);
        Rail.copy(lower, 0, l, 0, size);
        lower = l;
        val u = new Rail[Int](capacity);
        Rail.copy(upper, 0, u, 0, size);
        upper = u;
      
    }

    /**
     * Substring helper function
     */
    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    
    
}
