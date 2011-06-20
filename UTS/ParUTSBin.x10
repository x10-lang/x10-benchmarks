import x10.util.Box;
import x10.util.Random;
import x10.lang.Math;
import x10.util.Stack;
import x10.util.List;
import x10.util.IndexedMemoryChunk;
import x10.compiler.Inline;

final class ParUTSBin {
	@Inline public static def processBinomialRoot (b0:Int, 
			node:SHA1Rand, 
			deque:GrowableIndexedMemoryChunk[SHA1Rand]) {
		for (var i:Int=0; i<b0; ++i) deque.add(SHA1Rand (node, i));
	}
	
    @Inline static def pop(stack:GrowableIndexedMemoryChunk[SHA1Rand]):SHA1Rand {
        val e = stack(stack.length() - 1);
        stack.removeLast();
        return e;
    }

    @Inline static def pop(stack:GrowableIndexedMemoryChunk[SHA1Rand], k:Int):Box[IndexedMemoryChunk[SHA1Rand]] {
        return new Box(stack.moveSectionToIndexedMemoryChunk(k));
    }

    static type PLH = PlaceLocalHandle[ParUTSBin];
    static type SHA1Rand = UTS.SHA1Rand;
    
    final static class FixedSizeStack[T] {
        val data:IndexedMemoryChunk[T];
        var size:Int;
        def this(n:Int) {
            data = IndexedMemoryChunk.allocateUninitialized[T](n);
            size = 0;
        }
        @Inline def pop():T = data(--size);
        @Inline def push(t:T) { data(size++) = t; }
    }
    
    val thieves:FixedSizeStack[Int];
    
    val width:Int;
    val stack = new GrowableIndexedMemoryChunk[SHA1Rand](65536);
    val lifelines:Rail[Int];
    
    // Which of the lifelines have I actually activated?
    val lifelinesActivated: IndexedMemoryChunk[Boolean];
    
    val b0:Int; // root branching factor
    val q:Long;
    val m:Int;
    val k:Int;
    val nu:Int; // For the binomial tree
    
    val l:Int; 
    val z:Int;
    val myRandom = new Random();
    public val counter:Counter;
    var active:Boolean=false;
    @x10.compiler.Volatile transient var empty:Boolean;
    @x10.compiler.Volatile transient var ack:Int=0;
    public def counters()=[counter as Counter];
    
    var st:PLH;
    
    /** Initialize the state. Executed at all places when executing the 
     * PlaceLocalHandle.make command in main (of UTS). BINOMIAL
     */
    public def this (b0:Int, 
            q:Long, 
            m:Int, 
            k:Int, 
            nu:Int, 
            w:Int, 
            e:Boolean, 
            l:Int,
            lifelineNetwork:Rail[Int]) {
        this.b0 = b0;
        this.q = q; 
        this.m = m; 
        this.k = k; 
        this.nu = nu; 
        this.l = l;
        this.lifelines = lifelineNetwork;
        this.z = lifelineNetwork.size;
        this.width = w;
        this.counter = new Counter(false);
        thieves = new FixedSizeStack[Int](z);
        lifelinesActivated = IndexedMemoryChunk.allocateZeroed[Boolean](Place.MAX_PLACES);
    }
    
    @Inline final def processLoot(l:Box[IndexedMemoryChunk[SHA1Rand]], lifeline:Boolean) {
    	val loot = l();
        counter.incRx(lifeline, loot.length());
        for (var i:Int=0; i<loot.length(); ++i) {
        	val node = loot(i);
        	if (node() < q) for (var ii:Int=0; ii<m; ++ii) stack.add(SHA1Rand (node, ii));
        }
        counter.nodesCounter += loot.length();
    }
    
    @Inline final def processAtMostN(n:Int) {
    	val stack = this.stack;
    	val m = this.m;
    	val q = this.q;
    	for (var i:Int=0; i<n; ++i) {
        	val node = pop(stack);
        	if (node() < q) for (var ii:Int=0; ii<m; ++ii) stack.add(SHA1Rand (node, ii));
        }
        counter.nodesCounter += n;
    }
    
    /** A trivial function to calculate minimum of 2 integers */
    @Inline def min(i:int,j:int) = i < j ? i : j;
    
    /** Go through each element in the stack, process it (generate its
     * children, and add them to the stack) until there is nothing left
     * on the stack. At this point, attempt to steal. If nothing can be 
     * stolen, terminate for now. Also, after processing a particular 
     * number of nodes, check if there are any outstanding messages to
     * handle and also, distribute a chunk of the local stack (work) to 
     * our lifeline buddy.
     */
    final def processStack() {
        while (true) {
            var n:Int = min(stack.length(), nu);
            while (n > 0) {
                processAtMostN(n);
                Runtime.probe();
                distribute();
                n = min(stack.length(), nu);
            }
            if (attemptSteal()) return;
        }
    }
    
    /** If our buddy/buddies have requested a lifeline, and we have ample supply 
     * of nodes, give him half (i.e, launch a remote async). We are not timing this 
     * section because it ultimately turns around and calls the distribute() function
     * below, which is timed.
     */
    @Inline def distribute() {
        var numThieves:Int = thieves.size;
        if (numThieves == 0) return;
        val lootSize = stack.length();
        if (lootSize >= 2) {
            numThieves = min(numThieves+1, lootSize);
            val numToSteal = lootSize/numThieves;
            val victim = Runtime.hereInt();
            val st_ = st;
            for (var i:Int=1; i < numThieves; ++i) {
                val thief = thieves.pop();
                val loot = pop(stack, numToSteal);
                counter.incTxNodes(numToSteal);
                async at(Place(thief)) st_().relaunch(loot, victim);
            }
        }
    }
    
    /** This is the code invoked locally by each node when there are no 
     * more nodes left on the stack. In other words, this function is 
     * the basis of all pull-based stealing. The push based stealing 
     * happens through the lifeline system. First, we attempt to get 
     * work from randomly chosen neighbors (for a certain number of 
     * tries). If we are not successful, we invoke our lifeline system.
     */
    def attemptSteal() {
        val P = Place.MAX_PLACES;
        if (P == 1) return true;
        val p = Runtime.hereInt();
        val st_ = st;
        empty = true;
        for (var i:Int=0; i < width && empty; ++i) {
            var q_:Int = 0;
            while ((q_ = myRandom.nextInt(P)) == p);
            val q = q_;
            counter.incStealsAttempted();
            val a = ++ack;
            async at(Place(q)) st_().trySteal(p, false, a);
            while (a == ack && empty) Runtime.probe();
        }
        for (var i:Int=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline:Int = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                lifelinesActivated(lifeline) = true;
                val a = ++ack;
                async at(Place(lifeline)) st_().trySteal(p, true, a);
                while (a == ack && empty) Runtime.probe();
            }
        }
        return empty;
    }
    
    /** Try to steal from the local stack --- invoked by either a 
     * theif at a remote place using asyncs (during attemptSteal) 
     * or by the owning place itself when it wants to give work to 
     * a fallen buddy.
     */
    def trySteal(p:Int, isLifeLine:Boolean, a:Int) {
        ++counter.stealsReceived;
        val st_ = st;
        val length = stack.length();
        val numSteals = k==0 ? (length >= 2 ? length/2 : 0) : (k < length ? k : (k/2 < length ? k/2 : 0));
        if (numSteals==0) {
            if (isLifeLine) thieves.push(p);
            async at (Place(p)) { if (st_().ack == a) st_().ack++; }
        } else {
            val loot = pop(stack, numSteals);
            counter.nodesGiven += numSteals;
            ++counter.stealsSuffered;
            val victim = isLifeLine ? Runtime.hereInt() : -1;
            async at (Place(p)) { st_().relaunch(loot, victim); }
        }
    }
    
    def launch(loot:Box[IndexedMemoryChunk[SHA1Rand]]) {
        try {
            active = true;
            counter.startLive();
            processLoot(loot, true);
            processStack();
            counter.stopLive();
            active = false;
        } catch (v:Throwable) {
            Console.OUT.println("Exception at " + here);
            v.printStackTrace();
        }
    }
    
    def relaunch(loot:Box[IndexedMemoryChunk[SHA1Rand]], source:Int) {
        val isLifeLine = source >= 0;
        try {
            if (isLifeLine) lifelinesActivated(source) = false;
            if (active) {
                empty = false;
                processLoot(loot, isLifeLine);
            } else {
                active = true;
                counter.startLive();
                processLoot(loot, isLifeLine);
                distribute();
                processStack();
                counter.stopLive();
                active = false;
            }
        } catch (v:Throwable) {
            Console.OUT.println("Exception at " + here);
            v.printStackTrace();
        }
    }
    
    /** Called only for the root node. Processes all the children of 
     * the root node and then proceeds to divide these children up 
     * evenly amongst all the places. This is the bootstrap mechanism
     * for distributed UTS.
     */
    def main (st:PLH, rootNode:SHA1Rand) {
        this.st = st;
        val P = Place.MAX_PLACES;
        finish {
            active = true;
            counter.startLive();
            processBinomialRoot(b0, rootNode, stack);
            ++counter.nodesCounter; // root node is never pushed on the stack.
            
            val lootSize = stack.length()/P;
            for (var pi:Int=1 ; pi<P ; ++pi) {
                val loot = pop(stack, lootSize);
                val pi_ = pi;
                async at(Place(pi_)) {
                    st().st = st;
                    st().launch(loot);
                }
                counter.incTxNodes(lootSize);
            }
            processStack();
            counter.stopLive();
            active = false;
        } 
    }
}

