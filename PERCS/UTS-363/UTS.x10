import x10.compiler.Inline;
import x10.compiler.Pragma;
import x10.compiler.Uncounted;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Random;

//@x10.compiler.NativeCPPInclude("google/profiler.h")

public final class UTS {
    val queue:Queue;
    val lifelineThieves:FixedSizeStack[Int];
    val thieves:FixedSizeStack[Int];
    val lifelines:Rail[Int];
    val lifelinesActivated:Rail[Boolean];
    
    val n:Int;
    val w:Int;
    val m:Int;
    
    val random = new Random();
    val victims:Rail[Int];
    val logger:Logger;
    
    @x10.compiler.Volatile transient var active:Boolean = false;
    @x10.compiler.Volatile transient var empty:Boolean;
    @x10.compiler.Volatile transient var waiting:Boolean;
    
    val P = Place.numPlaces();
    
    public def this(b:Int, d:Int, n:Int, w:Int, l:Int, z:Int, m:Int) {
        this.n = n;
        this.w = w;
        this.m = m;
        this.lifelines = new Rail[Int](z, -1);
        
        val h = Runtime.hereInt();
        
        victims = new Rail[Int](m);
        if (P>1) for (var i:Int=0; i<m; i++) {
            while ((victims(i) = random.nextInt(P)) == h);
        }
        
        // lifelines
        var x:Int = 1;
        var t:Int = 0;
        for (var j:Int=0; j<z; j++) {
            var v:Int = h;
            for (var k:Int=1; k<l; k++) {
                v = v - v%(x*l) + (v+x*l-x)%(x*l);
                if (v<P) {
                    lifelines(t++) = v;
                    break;
                }
            }
            x *= l;
        }
        
        /*
         * Console.OUT.print("" + i + " =>");
         * for (var j:Int=0; j<z; j++) Console.OUT.print(" " + lifelines(j));
         * Console.OUT.println();
         */
        
        queue = new Queue(4096, b, d);
        lifelineThieves = new FixedSizeStack[Int](lifelines.size+3);
        thieves = new FixedSizeStack[Int](P);
        lifelinesActivated = new Rail[Boolean](P);
        
        // 1st wave
        if (3*h+1 < P) lifelineThieves.push(3*h+1);
        if (3*h+2 < P) lifelineThieves.push(3*h+2);
        if (3*h+3 < P) lifelineThieves.push(3*h+3);
        if (h > 0) lifelinesActivated((h-1)/3) = true;
        
        logger = new Logger(true);
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
    
    final def processStack(st:PlaceLocalHandle[UTS]) {
        do {
            while (processAtMostN()) {
                Runtime.probe();
                distribute(st);
            }
            reject(st);
        } while (steal(st));
    }
    
    @Inline def give(st:PlaceLocalHandle[UTS], loot:Queue.Fragment) {
        val victim = Runtime.hereInt();
        logger.nodesGiven += loot.hash.length();
        if (thieves.size() > 0) {
            val thief = thieves.pop();
            if (thief >= 0) {
                ++logger.lifelineStealsSuffered;
                at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; }
            } else {
                ++logger.stealsSuffered;
                at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
            }
        } else {
            ++logger.lifelineStealsSuffered;
            val thief = lifelineThieves.pop();
            at (Place(thief)) async st().deal(st, loot, victim);
        }
    }
    
    @Inline def distribute(st:PlaceLocalHandle[UTS]) {
        var numThieves:Int;
        var t:Int;
        while (((numThieves = lifelineThieves.size() + thieves.size()) > 0) && (t = queue.select()) >= 0) {
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
    
    @Inline def reject(st:PlaceLocalHandle[UTS]) {
        while (thieves.size() > 0) {
            val thief = thieves.pop();
            if (thief >= 0) {
                lifelineThieves.push(thief);
                at (Place(thief)) @Uncounted async { st().waiting = false; }
            } else {
                at (Place(-thief-1)) @Uncounted async { st().waiting = false; }
            }
        }
    }
    
    def steal(st:PlaceLocalHandle[UTS]) {
        if (P == 1) return false;
        val p = Runtime.hereInt();
        empty = true;
        for (var i:Int=0; i < w && empty; ++i) {
            ++logger.stealsAttempted;
            waiting = true;
            logger.stopLive();
            at (Place(victims(random.nextInt(m)))) @Uncounted async st().request(st, p, false);
            while (waiting) Runtime.probe();
            logger.startLive();
        }
        for (var i:Int=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                ++logger.lifelineStealsAttempted;
                lifelinesActivated(lifeline) = true;
                waiting = true;
                logger.stopLive();
                at (Place(lifeline)) @Uncounted async st().request(st, p, true);
                while (waiting) Runtime.probe();
                logger.startLive();
            }
        }
        return !empty;
    }
    
    def request(st:PlaceLocalHandle[UTS], thief:Int, lifeline:Boolean) {
        try {
            if (lifeline) ++logger.lifelineStealsReceived; else ++logger.stealsReceived;
            if (queue.size == 0) {
                if (lifeline) lifelineThieves.push(thief);
                at (Place(thief)) @Uncounted async { st().waiting = false; }
            } else {
                if (lifeline) thieves.push(thief); else thieves.push(-thief-1);
            }
        } catch (v:CheckedThrowable) {
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
    
    def deal(st:PlaceLocalHandle[UTS], loot:Queue.Fragment, source:Int) {
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
        } catch (v:CheckedThrowable) {
            error(v);
        }
    }
    
    def main(st:PlaceLocalHandle[UTS], seed:Int) {
        @Pragma(Pragma.FINISH_DENSE) finish {
            try {
                active = true;
                logger.startLive();
                queue.init(seed);
                processStack(st);
                logger.stopLive();
                active = false;
                logger.nodesCount = queue.count;
            } catch (v:CheckedThrowable) {
                error(v);
            }
        } 
    }
    
    static def error(v:CheckedThrowable) {
        Runtime.println("Exception at " + here);
        v.printStackTrace();
    }
    
    public static def main(args:Array[String](1)) {
        val opts = new OptionsParser(args, null, [
                Option("b", "", "Branching factor"),
                Option("r", "", "Seed (0 <= r < 2^31"),
                Option("d", "", "Tree depth"),
                Option("n", "", "Number of nodes to process before probing. Default 200."),
                Option("w", "", "Number of thieves to send out. Default 1."),
                Option("l", "", "Base of the lifeline"),
                Option("m", "", "Max potential victims"),
                Option("v", "", "Verbose. Default 0 (no).")]);
        
        val b = opts("-b", 4);
        val r = opts("-r", 19);
        val d = opts("-d", 13);
        val n = opts("-n", 511);
        val l = opts("-l", 32);
        val m = opts("-m", 1024);
        val verbose = opts("-v", 0) != 0;
        
        val P = Place.numPlaces();
        
        var z0:Int = 1;
        var zz:Int = l;
        while (zz < P) {
            z0++;
            zz *= l;
        }
        val z = z0;

        val w = opts("-w", z);

        Console.OUT.println("places=" + P +
                "   b=" + b +
                "   r=" + r +
                "   d=" + d +
                "   w=" + w +
                "   n=" + n +
                "   l=" + l + 
                "   m=" + m + 
                "   z=" + z);
        
        val st = PlaceLocalHandle.makeFlat[UTS](Place.places(), ()=>new UTS(b, d, n, w, l, z, m));
        
        Console.OUT.println("Starting...");
        //@Native("c++", "ProfilerStart(\"UTS.prof\");") {}
        var time:Long = System.nanoTime();
        st().main(st, r);
        time = System.nanoTime() - time;
        //@Native("c++", "ProfilerStop();") {}
        Console.OUT.println("Finished.");
        
        val logs:Rail[Logger];
        if (P >= 1024) {
            logs = new Rail[Logger](P/32, (i:Int)=>at (Place(i*32)) {
                val h = Runtime.hereInt();
                val n = min(32, P-h);
                val logs = new Rail[Logger](n, (i:Int)=>at (Place(h+i)) st().logger.get(verbose));
                val log = new Logger(false);
                log.collect(logs);
                return log;
            });
        } else {
            logs = new Rail[Logger](P, (i:Int)=>at (Place(i)) st().logger);
        }
        val log = new Logger(false);
        log.collect(logs);
        log.stats(time);
    }
}

// vim: ts=2:sw=2:et
