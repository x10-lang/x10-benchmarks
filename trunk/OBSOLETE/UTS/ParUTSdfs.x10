import x10.compiler.Inline;
import x10.compiler.Uncounted;
import x10.util.Random;

final class ParUTSdfs {
    val queue:Queue;
    val thieves:FixedSizeStack[Int];
    val temp:FixedSizeStack[Int];
    val lifelines:Rail[Int];
    val lifelinesActivated:Rail[Boolean];
    
    val n:Int;
    val w:Int;
    val l:Int;
    
    val random = new Random();
    val logger = new Logger();
    
    var active:Boolean = false;
    @x10.compiler.Volatile transient var empty:Boolean;
    @x10.compiler.Volatile transient var waiting:Boolean;
    
    public def this(b:Int, d:Int, n:Int, w:Int, l:Int, lifelines:Rail[Int]) {
        this.n = n;
        this.w = w;
        this.l = l;
        this.lifelines = lifelines;
        queue = new Queue(65536, b, d);
        thieves = new FixedSizeStack[Int](lifelines.size+2);
        temp = new FixedSizeStack[Int](Place.MAX_PLACES);
        lifelinesActivated = new Rail[Boolean](Place.MAX_PLACES);
        
        // 1st wave
        val i = Runtime.hereInt();
        if (2*i+1 < Place.MAX_PLACES) thieves.push(2*i+1);
        if (2*i+2 < Place.MAX_PLACES) thieves.push(2*i+2);
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
    
    @Inline static def min(i:Int,j:Int) = i < j ? i : j;
    
    final def processStack(st:PlaceLocalHandle[ParUTSdfs]) {
        do {
            while (processAtMostN()) {
                Runtime.probe();
                distribute(st);
            }
            reject(st);
        } while (steal(st));
    }
    
    @Inline def give(st:PlaceLocalHandle[ParUTSdfs], loot:Queue.Fragment) {
        val victim = Runtime.hereInt();
        logger.nodesGiven += loot.hash.length();
        if (temp.size() > 0) {
            val thief = temp.pop();
            if (thief >= 0) {
                ++logger.lifelineStealsSuffered;
                at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; }
            } else {
                ++logger.stealsSuffered;
                at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
            }
        } else {
            ++logger.lifelineStealsSuffered;
            val thief = thieves.pop();
            at (Place(thief)) async st().deal(st, loot, victim);
        }
    }
    
    @Inline def distribute(st:PlaceLocalHandle[ParUTSdfs]) {
        var numThieves:Int;
        var t:Int;
        while (((numThieves = thieves.size() + temp.size()) > 0) && (t = queue.select()) >= 0) {
            val lootSize = queue.upper(t) - queue.lower(t);
            numThieves = min(numThieves+1, lootSize);
            val numToSteal = lootSize/numThieves;
            for (var i:Int=1; i < numThieves; ++i) {
                give(st, queue.grab(t, numToSteal));
            }
        }
        if (numThieves == 0) return;
        val lootSize = queue.size;
        numThieves = min(numThieves+1, lootSize);
        val numToSteal = lootSize/numThieves;
        for (var i:Int=1; i < numThieves; ++i) {
            give(st, queue.pop(numToSteal));
        }
        reject(st);
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
            while ((q = random.nextInt(P)) == p);
            ++logger.stealsAttempted;
            waiting = true;
            at (Place(q)) @Uncounted async st().request(st, p, false);
            while (waiting) Runtime.probe();
        }
        for (var i:Int=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                ++logger.lifelineStealsAttempted;
                lifelinesActivated(lifeline) = true;
                waiting = true;
                at (Place(lifeline)) @Uncounted async st().request(st, p, true);
                while (waiting) Runtime.probe();
            }
        }
        return !empty;
    }
    
    def request(st:PlaceLocalHandle[ParUTSdfs], thief:Int, lifeline:Boolean) {
        try {
            if (lifeline) ++logger.lifelineStealsReceived; else ++logger.stealsReceived;
            if (queue.size == 0) {
                if (lifeline) thieves.push(thief);
                at (Place(thief)) @Uncounted async { st().waiting = false; }
            } else {
                if (lifeline) temp.push(thief); else temp.push(-thief-1);
            }
        } catch (v:Throwable) {
            error(v);
        }
    }
    
    @Inline final def processLoot(loot:Queue.Fragment, lifeline:Boolean) {
        val n = loot.hash.length();
        if (lifeline) {
            ++logger.lifelineStealsPerpetrated;
            logger.lifelineNodesReceived += n;
        } else {
            ++logger.stealsPerpetrated;
            logger.nodesReceived += n;
        }
        queue.push(loot);
    }
    
    def deal(st:PlaceLocalHandle[ParUTSdfs], loot:Queue.Fragment, source:Int) {
        try {
            val lifeline = source >= 0;
            if (lifeline) lifelinesActivated(source) = false;
            if (active) {
                empty = false;
                processLoot(loot, lifeline);
            } else {
                active = true;
                logger.startLive();
                processLoot(loot, lifeline);
                //distribute(st);
                processStack(st);
                logger.stopLive();
                active = false;
                logger.nodesCount = queue.count;
            }
        } catch (v:Throwable) {
            error(v);
        }
    }
    
    def main(st:PlaceLocalHandle[ParUTSdfs], seed:Int) {
        finish {
            try {
                active = true;
                logger.startLive();
                queue.init(seed);
                processStack(st);
                logger.stopLive();
                active = false;
                logger.nodesCount = queue.count;
            } catch (v:Throwable) {
                error(v);
            }
        } 
    }
    
    static def error(v:Throwable) {
        Runtime.println("Exception at " + here);
        v.printStackTrace();
    }
}
