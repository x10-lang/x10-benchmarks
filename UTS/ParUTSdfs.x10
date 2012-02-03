import x10.util.Random;
import x10.compiler.Inline;
import x10.compiler.Uncounted;

final class ParUTSdfs {
    val queue:Queue;
    val thieves:FixedSizeStack[Int];
    val temp:FixedSizeStack[Int];
    val lifelines:Rail[Int];
    val lifelinesActivated:Rail[Boolean];
    
    val k:Int;
    val n:Int;
    val w:Int;
    val l:Int;
    
    val myRandom = new Random();
    
    var active:Boolean = false;
    @x10.compiler.Volatile transient var empty:Boolean;
    @x10.compiler.Volatile transient var waiting:Boolean;
    
    val counter:Counter;
    public def counters()=[counter as Counter];
    
    public def this (b:Int, d:Int, k:Int, n:Int, w:Int, l:Int, lifelines:Rail[Int]) {
        this.k = k;
        this.n = n;
        this.w = w;
        this.l = l;
        this.lifelines = lifelines;
        this.counter = new Counter(false);
        queue = new Queue(65536, b, d);
        thieves = new FixedSizeStack[Int](lifelines.size+2);
        temp = new FixedSizeStack[Int](Place.MAX_PLACES);
        lifelinesActivated = new Rail[Boolean](Place.MAX_PLACES);
        
        // 1st wave
        val i = Runtime.hereInt();
        if (2*i+1<Place.MAX_PLACES) thieves.push(2*i+1);
        if (2*i+2<Place.MAX_PLACES) thieves.push(2*i+2);
        if (i > 0) lifelinesActivated((i-1)/2) = true;
    }
    
    @Inline final def processAtMostN() {
        var i:Int=0;
        for (; (i<n) && (queue.size>0); ++i) {
            queue.expand();
        }
        queue.count += i;
        return queue.size > 0;
    }
    
    /** A trivial function to calculate minimum of 2 integers */
    @Inline def min(i:Int,j:Int) = i < j ? i : j;
    
    final def processStack(st:PlaceLocalHandle[ParUTSdfs]) {
        do {
            while (processAtMostN()) {
                Runtime.probe();
                distribute(st);
            }
            reject(st);
        } while (steal(st));
    }
    
    @Inline def distribute(st:PlaceLocalHandle[ParUTSdfs]) {
        var numThieves:Int;
        var t:Int;
        while (((numThieves = thieves.size() + temp.size()) > 0) && (t = queue.select()) >= 0) {
            val lootSize = queue.upper(t) - queue.lower(t);
            numThieves = min(numThieves+1, lootSize);
            val numToSteal = lootSize/numThieves;
            val victim = Runtime.hereInt();
            for (var i:Int=1; i < numThieves; ++i) {
                val loot = queue.grab(t, numToSteal);
                if (temp.size() > 0) {
                    val thief = temp.pop();
                    counter.nodesGiven += numToSteal;
                    ++counter.stealsSuffered;
                    if (thief >= 0) {
                        at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; }
                    } else {
                        at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
                    }
                } else {
                    val thief = thieves.pop();
                    counter.incTxNodes(numToSteal);
                    at (Place(thief)) async st().deal(st, loot, victim);
                }
            }
        }
        if (numThieves == 0) return;
        val lootSize = queue.size;
        numThieves = min(numThieves+1, lootSize);
        val numToSteal = lootSize/numThieves;
        val victim = Runtime.hereInt();
        for (var i:Int=1; i < numThieves; ++i) {
            val loot = queue.pop(numToSteal);
            if (temp.size() > 0) {
                val thief = temp.pop();
                counter.nodesGiven += numToSteal;
                ++counter.stealsSuffered;
                if (thief >= 0) {
                    at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; }
                } else {
                    at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
                }
            } else {
                val thief = thieves.pop();
                counter.incTxNodes(numToSteal);
                at (Place(thief)) async st().deal(st, loot, victim);
            }
        }
        reject();
    }
    
    @Inline def reject(st:PlaceLocalHandle[ParUTSdfs]) {
        while (temp.size() > 0) {
            val thief = temp.pop();
            if (thief >= 0) {
                thieves.push(thief);
                at (Place(thief)) @Uncounted async { st().waiting = false; }
            } else {
                at (Place(-thief-1)) @Uncounted async { st().waiting = false; }
            }
        }
    }
    
    def steal(st:PlaceLocalHandle[ParUTSdfs]) {
        val P = Place.MAX_PLACES;
        if (P == 1) return false;
        val p = Runtime.hereInt();
        empty = true;
        for (var i:Int=0; i < w && empty; ++i) {
            var q:Int = 0;
            while ((q = myRandom.nextInt(P)) == p);
            counter.incStealsAttempted();
            waiting = true;
            at (Place(q)) @Uncounted async st().request(st, p, false);
            while (waiting) Runtime.probe();
        }
        for (var i:Int=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                lifelinesActivated(lifeline) = true;
                waiting = true;
                at (Place(lifeline)) @Uncounted async st().request(st, p, true);
                while (waiting) Runtime.probe();
            }
        }
        return !empty;
    }
    
    def request(st:PlaceLocalHandle[ParUTSdfs], thief:Int, isLifeLine:Boolean) {
        ++counter.stealsReceived;
        if (queue.size == 0) {
            if (isLifeLine) thieves.push(thief);
            at (Place(thief)) @Uncounted async { st().waiting = false; }
        } else {
            if (isLifeLine) temp.push(thief); else temp.push(-thief-1);
        }
    }
    
    @Inline final def processLoot(loot:Queue.Fragment, lifeline:Boolean) {
        counter.incRx(lifeline, loot.hash.length());
        queue.push(loot);
    }
    
    def deal(st:PlaceLocalHandle[ParUTSdfs], loot:Queue.Fragment, source:Int) {
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
                counter.nodesCounter = queue.count;
            }
        } catch (v:Throwable) {
            Console.OUT.println("Exception at " + here);
            v.printStackTrace();
        }
    }
    
    def main(st:PlaceLocalHandle[ParUTSdfs], seed:Int) {
        finish {
            active = true;
            counter.startLive();
            queue.init(seed);
            processStack(st);
            counter.stopLive();
            active = false;
            counter.nodesCounter = queue.count;
        } 
    }
}
