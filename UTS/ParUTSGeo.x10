import x10.util.Random;
import x10.compiler.Inline;
import x10.compiler.Uncounted;

final class ParUTSGeo {
    val thieves:FixedSizeStack[Int];
    
    private static val NORMALIZER = 2147483648.0; // does not depend on input parameters

    val width:Int;
    val stack = new MyStack[SHA1RandX](65536);
    val lifelines:Rail[Int];
    
    // Which of the lifelines have I actually activated?
    val lifelinesActivated:Rail[Boolean];
    
    val b0:Int; // root branching factor
    val a:Int;
    val d:Int;
    val k:Int;
    val nu:Int; // For the binomial tree
    
    val l:Int; 
    val z:Int;
    val den:double;
    val myRandom = new Random();
    public val counter:Counter;
    var active:Boolean=false;
    @x10.compiler.Volatile transient var empty:Boolean;
    @x10.compiler.Volatile transient var waiting:Boolean;
    public def counters()=[counter as Counter];
    
    /** Initialize the state. Executed at all places when executing the 
     * PlaceLocalHandle.make command in main (of UTS). BINOMIAL
     */
    public def this (b0:Int, 
            a:Int, 
            d:Int, 
            k:Int, 
            nu:Int, 
            w:Int, 
            e:Boolean, 
            l:Int,
            lifelineNetwork:Rail[Int]) {
        this.b0 = b0;
        this.a = a; 
        this.d = d; 
        this.k = k; 
        this.nu = nu; 
        this.l = l;
        this.lifelines = lifelineNetwork;
        this.z = lifelineNetwork.size;
        this.width = w;
        this.counter = new Counter(false);
        thieves = new FixedSizeStack[Int](z);
        lifelinesActivated = new Rail[Boolean](Place.MAX_PLACES);
        this.den = Math.log(b0/(1.0+b0));
    }

    @Inline final def push(node:SHA1RandX) {
        val depth = node.depth();
        if (depth >= d) return;
        val numChildren = Math.floor(Math.log(1.0 - node() / NORMALIZER) / den) as int;
        /* Push all the children onto the Deque (stack) */
        if (depth < d) {
            for (var i:Int=0; i<numChildren; ++i) 
                stack.push(SHA1RandX (node, i));
        } else {
            counter.nodesCounter += numChildren;
        }
    }
    
    @Inline final def processLoot(loot:Rail[SHA1RandX], lifeline:Boolean) {
        counter.incRx(lifeline, loot.size);
        for (var i:Int=0; i<loot.size; ++i) {
            push(loot(i));
        }
        counter.nodesCounter += loot.size;
    }
    
    @Inline final def processAtMostN() {
        var i:Int=0;
        for (; (i<nu) && (stack.size()>0); ++i) {
            push(stack.pop());
        }
        counter.nodesCounter += i;
        return stack.size() > 0;
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
    final def processStack(st:PlaceLocalHandle[ParUTSGeo]) {
        do {
            while (processAtMostN()) {
                Runtime.probe();
                distribute(st);
            }
        } while (steal(st));
    }
    
    /** If our buddy/buddies have requested a lifeline, and we have ample supply 
     * of nodes, give him half (i.e, launch a remote async). We are not timing this 
     * section because it ultimately turns around and calls the distribute() function
     * below, which is timed.
     */
    @Inline def distribute(st:PlaceLocalHandle[ParUTSGeo]) {
        var numThieves:Int = thieves.size();
        if (numThieves == 0) return;
        val lootSize = stack.size();
        if (lootSize >= 2) {
            numThieves = min(numThieves+1, lootSize);
            val numToSteal = lootSize/numThieves;
            val victim = Runtime.hereInt();
            for (var i:Int=1; i < numThieves; ++i) {
                val thief = thieves.pop();
                val loot = stack.pop(numToSteal);
                counter.incTxNodes(numToSteal);
                at(Place(thief)) async st().deal(st, loot, victim);
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
    def steal(st:PlaceLocalHandle[ParUTSGeo]) {
        val P = Place.MAX_PLACES;
        if (P == 1) return false;
        val p = Runtime.hereInt();
        empty = true;
        for (var i:Int=0; i < width && empty; ++i) {
            var q_:Int = 0;
            while ((q_ = myRandom.nextInt(P)) == p);
            val q = q_;
            counter.incStealsAttempted();
            waiting = true;
            at(Place(q)) @Uncounted async st().request(st, p, false);
            while (waiting) Runtime.probe();
        }
        for (var i:Int=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline:Int = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                lifelinesActivated(lifeline) = true;
                waiting = true;
                at(Place(lifeline)) @Uncounted async st().request(st, p, true);
                while (waiting) Runtime.probe();
            }
        }
        return !empty;
    }
    
    /** Try to steal from the local stack --- invoked by either a 
     * theif at a remote place using asyncs (during attemptSteal) 
     * or by the owning place itself when it wants to give work to 
     * a fallen buddy.
     */
    def request(st:PlaceLocalHandle[ParUTSGeo], thief:Int, isLifeLine:Boolean) {
        ++counter.stealsReceived;
        val length = stack.size();
        val numSteals = k==0 ? (length >= 2 ? length/2 : 0) : (k < length ? k : (k/2 < length ? k/2 : 0));
        if (numSteals==0) {
            if (isLifeLine) thieves.push(thief);
            at (Place(thief)) @Uncounted async { st().waiting = false; }
        } else {
            val loot = stack.pop(numSteals);
            counter.nodesGiven += numSteals;
            ++counter.stealsSuffered;
            val victim = isLifeLine ? Runtime.hereInt() : -1;
            at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; }
        }
    }
    
    def deal(st:PlaceLocalHandle[ParUTSGeo], loot:Rail[SHA1RandX], source:Int) {
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
                //distribute(st);
                processStack(st);
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
    def main(st:PlaceLocalHandle[ParUTSGeo], rootNode:SHA1RandX) {
        val P = Place.MAX_PLACES;
        finish {
            active = true;
            counter.startLive();
            push(rootNode);
            ++counter.nodesCounter;
            val lootSize = stack.size()/P;
            for (var pi:Int=1 ; pi<P ; ++pi) {
                val loot = stack.pop(lootSize);
                val pi_ = pi;
                at(Place(pi_)) async {
                    st().deal(st, loot, 0);
                }
                counter.incTxNodes(lootSize);
            }
            processStack(st);
            counter.stopLive();
            active = false;
        } 
    }
}

