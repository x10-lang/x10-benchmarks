
import x10.util.Random;
import x10.lang.Math;
import x10.util.Stack;
import x10.util.List;
import x10.util.ArrayList;

/**
 * Hybrid UTS -- implemented with w workers in P places. The w workers 
 * use work-stealing to share the load generated by a single worker. 
 * Each place has a master async which starts with the initial load.
 * Other workers can steal asyncs generated by the worker executing this
 * async. 
 * 
 * TODO: Combine ParUTS with HUTS. HUTS is basically identical, except
 * for a few small changes. a finish async is used in processTree, and
 * an array of counters is kept at each place, one for each worker. Stats
 * are accumulated per worker.
 */
final class HUTS implements Counted {
    static type PLH= PlaceLocalHandle[HUTS];
    static type SHA1Rand = UTS.SHA1Rand;
    static type TreeNode = UTS.TreeNode;
    static type Constants = UTS.Constants;
    
    static val gatherTimes = false;
    
    final static class FixedSizeStack[T] {
        val data:Rail[T];
        var last:Int;
        val size:Int;
        def this(n:Int, t:T) {
            data = Rail.make[T](n, (i:Int) => t);
            last = -1;
            size= n;
        }
        def empty():Boolean= last < 0;
        def pop():T = data(last--);
        def push(t:T) {
            data(++last)=t;
        }
        def size():Int=last+1;
        
    }
    val thieves:FixedSizeStack[Int];
    
    val width:Int;
  
    val myLifelines:Rail[Int];
    
    // Which of the lifelines have I actually activated?
    val lifelinesActivated: Rail[Boolean];
    
    val treeType:Int; // 0=BINOMIAL, 1=GEOMETRIC
    val b0:Int; // root branching factor
    val q:Long, m:Int, k:Int, nu:Int; // For the binomial tree
    val a:Int, d:Int; // For the geometric tree
    
    val l:Int; 
    val z:Int;
    val logEvents:Boolean;
    val myRandom = new Random();
    val stacks = new Array[Stack[TreeNode]](Runtime.INIT_THREADS, (Int)=> new Stack[TreeNode]());
    public val counters:Array[Counter](1){rail};
    var active:Boolean=false;
    var noLoot:Boolean=true;
    public def counters()=counters;
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
        this.treeType = Constants.BINOMIAL;
        this.b0 = b0;
        this.q = q; 
        this.m = m; 
        this.k=k; 
        this.nu=nu; 
        this.l = l;
        this.myLifelines = lifelineNetwork;
        this.z = lifelineNetwork.length; // assume symmetric.
        this.width=w;
        this.logEvents=e;
        this.counters = new Array[Counter](Runtime.INIT_THREADS, (Int)=> new Counter(e));
        thieves = new FixedSizeStack[Int](z, 0);
        lifelinesActivated = Rail.make[Boolean](Place.MAX_PLACES, (Int)=>false);
        //	printLifelineNetwork();
        
        this.a = -1; 
        this.d = -1;
    }
    
    /** Initialize the state. Executed at all places when executing the 
     * PlaceLocalHandle.make command in main (of UTS). GEOMETRIC
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
        this.treeType = Constants.GEOMETRIC;
        this.b0 = b0;
        this.a = a; 
        this.d = d; 
        this.k=k; 
        this.nu=nu; 
        this.l = l;
        this.myLifelines = lifelineNetwork;
        this.z = lifelineNetwork.length; // assume symmetric.
        this.width=w;
        this.logEvents=e;
        this.counters = new Array[Counter](Runtime.INIT_THREADS, (Int)=> new Counter(e));
        this.
        thieves = new FixedSizeStack[Int](Place.MAX_PLACES, 0);
        lifelinesActivated = Rail.make[Boolean](Place.MAX_PLACES, (Int)=>false);
        printLifelineNetwork();
        
        this.q = -1; 
        this.m = -1;
    }
    
    def printLifelineNetwork () {
        Console.OUT.print (here.id + " =>");
        for (var i:Int=0; i<myLifelines.length(); ++i) 
            if (-1 != myLifelines(i)) 
                Console.OUT.print  (" " + myLifelines(i) +  " " +
                        new PAdicNumber(NetworkGenerator.findW(Place.MAX_PLACES, z), z, myLifelines(i)));
            else Console.OUT.print (" X");
        Console.OUT.println ();
    }
    
    def event(s:String) { 
        /*      event(false, s); */
    }
    
    /*
     * def event(verbose:Boolean, s:String) {
     * if (verbose)
     * Console.OUT.println("[Place(" + here.id+"), at " 
     * + System.nanoTime() + "] " + s);
     * }
     */
    
    /** Proess at most n nodes from instack in parallel (permitting stealing),
     * and then call probe. instack is guaranteed to have at least n elements.
     * 
     * Additionally, if the worker executing this is not the worker who
     * owns instack, then keep processing the worker's stack until it is empty.
     * 
     * This should be invoked by the worker who owns instack (=controlling worker),
     * under a finish.
     * 
     * On return the controlling worker will know that at least n of 
     * its tasks have been completed, (and possibly some others).
     * Also, all other workers will have empty stacks. The controlling
     * worker may have stolen some tasks from other workers during
     * this execution so may end up with more tasks than n less than
     * what it started with.
     */
    final def processSubtree (n:Int, var instack:Stack[TreeNode]) {
        while (true){
            for (var count:Int=0; count < n; count++) {
                val node = instack.pop();
                // Let other workers steal the contiuation.
                async  {
                    val Me = Runtime.workerId();
                    val stack = stacks(Me);
                    val counter = counters(Me);
                    ++counter.nodesCounter;
                    if (Constants.BINOMIAL==treeType) 
                        TreeExpander.binomial (q, m, node, stack);
                    else 
                        TreeExpander.geometric (a, b0, d, node, stack);
                }
            }
            // This continuation may be executed by a thief. This
            // thief could be the controlling worker.
            val Me = Runtime.workerId();
            // service incoming thefts and disbursement of loot from
            // this worker's stack.
            val time:Long =  gatherTimes ? System.nanoTime() : 0;
            Runtime.probe();
            if (gatherTimes) counters(Me).incTimeProbing (System.nanoTime() - time);
            
            val stack = stacks(Me);
            if (stack == instack)
                // This is the controlling worker, exit after processing 
                // at most n.
                break;
            // Non-controlling worker: continue processing worker stack
            // to completion.
            val nn = min(stack.size(), nu);
            instack=stack;
            if (nn <= 0)
                break;
        } 
    }
    
    final def processLoot(loot: Rail[TreeNode], lifeline:Boolean) {
        val Me = Runtime.workerId();
        val counter = counters(Me);
        val stack = stacks(Me);
        counter.incRx(lifeline, loot.length);
        val time = gatherTimes ? System.nanoTime() : 0;
        finish {
            for (r in loot) stack.push(r);
            processSubtree(loot.length(), stack);
          
        }
        if (gatherTimes) counters(Me).incTimeComputing (System.nanoTime() - time);  
    }
    
    /** A trivial function to calculate minimum of 2 integers */
    def min(i:int,j:int) = i < j ? i : j;
    
    /** Go through each element in the stack, process it (generate its
     * children, and add them to the stack) until there is nothing left
     * on the stack. 
     * 
     * <p> At this point, attempt to steal. 
     * 
     * <p> If nothing can be stolen, terminate for now. 
     * <p> Also, after processing a particular 
     * number of nodes, check if there are any outstanding messages to
     * handle and also, distribute a chunk of the local stack (work) to 
     * our lifeline buddy.
     */
    final def processStack(st:PLH) {
        val Me = Runtime.workerId();
        val counter = counters(Me);
        val stack = stacks(Me);
        while (true) {
            var n:Int = min(stack.size(), nu);
            while (n > 0) {
                // Process at most N nodes from the stack in parallel.
                finish {
                    val time = gatherTimes ? System.nanoTime() : 0;
                    processSubtree(n, stack);
                    if (gatherTimes) counters(Me).incTimeComputing (System.nanoTime() - time);  
                }
                // Only this async is responsible for distributing to thieves
                val numThieves = thieves.size();
                if (numThieves > 0) distribute(st, 1, numThieves);
                n = min(stack.size(), nu);
            }
            // only this async is responsible for remote steals.
            val loot = attemptSteal(st);
            if (null==loot) { 
                if (! noLoot) {
                    noLoot=true;
                    continue;
                }
                else {
                    break;
                }
            } else {
                processLoot(loot, false);
            }
        }
        event("Finished main loop.");
    }
    
    /** If our buddy/buddies have requested a lifeline, and we have ample supply 
     * of nodes, give him half (i.e, launch a remote async). We are not timing this 
     * section because it ultimately turns around and calls the distribute() function
     * below, which is timed.
     */
    def distribute(st:PLH, depth:Int) {
        val numThieves = thieves.size();
        if (numThieves > 0) distribute(st, 1, numThieves);
    }
    
    def distribute(st:PLH, depth:Int, var numThieves:Int) {
        val Me = Runtime.workerId();
        val counter = counters(Me);
        val stack = stacks(Me);
        val time = gatherTimes ? System.nanoTime() : 0;
        val lootSize= stack.size();
        if (lootSize > 2u) {
            numThieves = min(numThieves, lootSize-2);
            val numToSteal = lootSize/(numThieves+1);
            for (var i:Int=0; i < numThieves; ++i) {
                val thief = thieves.pop();
                val loot = stack.pop(numToSteal);
                counter.incTxNodes(numToSteal);
                // event("Distributing " + loot.length() + " to " + thief);
                val victim = here.id;
                // This is a remote distribution async governed by the
                // main finish
                async at(Place(thief)) 
                st().launch(st, false, loot, depth, victim);
            }
        }
        if (gatherTimes) counters(Me).incTimeDistributing (System.nanoTime()-time);
    }
    
    /** This is the code invoked locally by each node when there are no 
     * more nodes left on the stack. In other words, this function is 
     * the basis of all pull-based stealing. The push based stealing 
     * happens through the lifeline system. First, we attempt to get 
     * work from randomly chosen neighbors (for a certain number of 
     * tries). If we are not successful, we invoke our lifeline system.
     */
    def attemptSteal(st:PLH):Rail[TreeNode] {
        val Me = Runtime.workerId();
        val time = gatherTimes ? System.nanoTime() : 0;
        val P = Place.MAX_PLACES;
        if (P == 1) return null;
        val p = here.id;
        for (var i:Int=0; i < width && noLoot; i++) {
            var q_:Int = 0;
            while((q_ =  myRandom.nextInt(P)) == p) ;
            val q = q_;
            counters(Me).incStealsAttempted();
            // event("Stealing from " + q);
            // Potential communication attempt.
            // May receive incoming thefts or distributions.
            val loot = at (Place(q)) st().trySteal(p);
            if (loot != null) {
                //event("Steal succeeded with " + 
                //(loot == null ? 0 : loot.length()) + " items");
                if (gatherTimes) counters(Me).incTimeStealing(System.nanoTime() - time);
                return loot;
            }
        }
        if (! noLoot) {
            if (gatherTimes) counters(Me).incTimeStealing(System.nanoTime() - time);
            return null;
        }
        event("No loot; establishing lifeline(s).");
        
        // resigned to make a lifeline steal from one of our lifelines.
        var loot:Rail[TreeNode] = null;
        for (var i:Int=0; 
        (i<myLifelines.length()) && (noLoot) && (0<=myLifelines(i)); 
        ++i) {
            val lifeline:Int = myLifelines(i);
            if (!lifelinesActivated(lifeline) ) {
                lifelinesActivated(lifeline) = true;
                loot = at(Place(lifeline)) st().trySteal(p, true);
                // event("Lifeline steal result " + (loot==null ? 0 : loot.length()));
                if (null!=loot) {
                    lifelinesActivated(lifeline) = false;
                    break;
                }
            }
        }
        if (gatherTimes) counters(Me).incTimeStealing(System.nanoTime() - time);
        return loot;
    }
    
    /** Try to steal from the local stack --- invoked by either a 
     * theif at a remote place using asyncs (during attemptSteal) 
     * or by the owning place itself when it wants to give work to 
     * a fallen buddy.
     */
    def trySteal(p:Int):Rail[TreeNode]=trySteal(p, false);
    def trySteal(p:Int, isLifeLine:Boolean) : Rail[TreeNode] {
        val Me = Runtime.workerId();
        val counter = counters(Me);
        val stack = stacks(Me);
        counter.stealsReceived++;
        val length = stack.size();
        val numSteals = k==0u ? (length >=2u ? length/2u : 0u)
                : (k < length ? k : (k/2u < length ? k/2u : 0u));
        if (numSteals==0u) {
            if (isLifeLine)
                thieves.push(p);
            event("Returning null");
            return null;
        }
        val loot = stack.pop(numSteals);
        counter.nodesGiven += numSteals;
        counter.stealsSuffered++;
        return loot;
    }
    
    def launch(st:PLH, 
            init:Boolean, 
            loot:Rail[TreeNode], 
            depth:Int, 
            source:Int) {
        assert loot != null;
        val Me = Runtime.workerId();
        val counter =  counters(Me);
        try {
            lifelinesActivated(source) = false;
            if (active) {
                noLoot = false;
                processLoot(loot, true);
                assert (! init);
                /*
                 * // Now you can return, the outer activity will handle the data on the stack.
                 * if (depth > 0) distribute(st, depth+1);
                 */
                return;
            }
            active=true;
            counter.startLive();
            counter.updateDepth(depth);
            processLoot(loot, true);
            if (depth > 0) 
                distribute(st, depth+1);
            processStack(st);
            counter.stopLive();
            active=false;
        } catch (v:Throwable) {
            Console.OUT.println("Exception at " + here);
            v.printStackTrace();
        } catch (v:Error) {
            Console.OUT.println("Exception at " + here);
            v.printStackTrace();
        }
    }
    
    /** Called only for the root node. Processes all the children of 
     * the root node and then proceeds to divide these children up 
     * evenly amongst all the places. This is the bootstrap mechanism
     * for distributed UTS.
     */
    def main (st:PLH, 
            rootNode:TreeNode) {
        val P=Place.MAX_PLACES;
        val T = Runtime.INIT_THREADS;
        event("Start main finish");
        val counter = counters(0);
        val stack=stacks(0);
        counter.startLive();
        // The main finish!
        finish {
            event("Launch main");
            if (Constants.BINOMIAL==treeType) { 
                TreeExpander.processBinomialRoot (b0, rootNode, stack);
            } else {
                TreeExpander.geometric (a, b0, d, rootNode, stack);
            }
            ++counter.nodesCounter; // root node is never pushed on the stack.
            
            val lootSize = stack.size()/P;
            for (var pi:Int=1 ; pi<P ; ++pi) {
                val time = gatherTimes ? System.nanoTime() : 0;
                val loot = stack.pop(lootSize);
                if (gatherTimes) counters(0).incTimePreppingSteal (System.nanoTime() - time);
                val pi_ = pi;
                // Launch the initial async executing tasks at the remote place.
                // Governed by the main finish.
                async at(Place(pi_))
                    st().launch(st, true, loot, 0, 0);
                counter.incTxNodes(lootSize);
            }
            active=true;
            processStack(st);
            active=false;
            event("Finish main");
            counter.stopLive();
        } 
        event("End main finish");
    }
}

