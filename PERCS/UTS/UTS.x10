import x10.compiler.Ifdef;
import x10.compiler.Inline;
import x10.compiler.Pragma;
import x10.compiler.Uncounted;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Random;
import x10.xrx.Runtime;

public final class UTS {
    val queue:Queue;
    val lifelineThieves:FixedSizeStack[Long];
    val thieves:FixedSizeStack[Long];
    val lifelines:Rail[Long];
    val lifelinesActivated:Rail[Boolean];
    
    val n:Int;
    val w:Int;
    val m:Int;
    
    // debug
    var last:Long;
    var phase:Long;
    var probes:Long;
    
    val random = new Random();
    val victims:Rail[Long];
    val logger:Logger;
    
    @x10.compiler.Volatile transient var active:Boolean = false;
    @x10.compiler.Volatile transient var empty:Boolean = true;
    @x10.compiler.Volatile transient var waiting:Boolean = false;
    
    @Inline def probe(n:Long) {
        @Ifdef("LOG") { if (++probes%(1<<25n) == 0) Runtime.println(Runtime.hereLong() + " PROBING " + n + " (" + (probes>>25n) + ")"); }
        Runtime.probe();
    }
    
    val P = Place.numPlaces();
    
    public def this(b:Int, d:Int, n:Int, w:Int, l:Int, z:Int, m:Int) {
        this.n = n;
        this.w = w;
        this.m = m;
        this.lifelines = new Rail[Long](z, -1);
        
        val h = Runtime.hereLong();
        
        victims = new Rail[Long](m);
        if (P>1) for (var i:Long=0; i<m; i++) {
            while ((victims(i) = random.nextLong(P)) == h);
        }
        
        // lifelines
        var x:Long = 1;
        var t:Long = 0;
        for (var j:Long=0; j<z; j++) {
            var v:Long = h;
            for (var k:Long=1; k<l; k++) {
                v = v - v%(x*l) + (v+x*l-x)%(x*l);
                if (v<P) {
                    lifelines(t++) = v;
                    break;
                }
            }
            x *= l;
        }
        
        queue = new Queue(b);
        lifelineThieves = new FixedSizeStack[Long](lifelines.size+3);
        thieves = new FixedSizeStack[Long](P);
        lifelinesActivated = new Rail[Boolean](P);
        
        // 1st wave
        if (3*h+1 < P) lifelineThieves.push(3*h+1);
        if (3*h+2 < P) lifelineThieves.push(3*h+2);
        if (3*h+3 < P) lifelineThieves.push(3*h+3);
        if (h > 0) lifelinesActivated((h-1)/3) = true;
        
        logger = new Logger(true);
    }
    
    @Inline final def processAtMostN() {
        var i:Long=0;
        for (; (i<n) && (queue.size>0); ++i) {
            queue.expand();
        }
        @Ifdef("LOG") {
            if ((queue.count ^ last) > (1 << 25n)) Runtime.println(Runtime.hereLong() + " COUNTED " + queue.count);
            last = queue.count;
        }
        queue.count += i;
        return queue.size > 0;
    }
    
    @Inline static def min(i:Long, j:Long) = i < j ? i : j;
    
    final def processStack(st:PlaceLocalHandle[UTS]) {
        do {
            while (processAtMostN()) {
                probe(9999999);
                distribute(st);
                reject(st);
            }
            reject(st);
        } while (steal(st));
        @Ifdef("LOG") {
            if (queue.size > 0) Runtime.println(Runtime.hereLong() + " ERROR queue.size>0");
            if (thieves.size() > 0) Runtime.println(Runtime.hereLong() + " ERROR thieves.size>0");
        }
    }
    
    @Inline def give(st:PlaceLocalHandle[UTS], loot:Fragment) {
        val victim = Runtime.hereLong();
        logger.nodesGiven += loot.hash.size;
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
        var loot:Fragment;
        while (((thieves.size() > 0) || (lifelineThieves.size() > 0)) && (loot = Fragment.make(queue)) != null) {
            give(st, loot);
        }
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
        val p = Runtime.hereLong();
        empty = true;
        for (var i:Long=0; i < w && empty; ++i) {
            ++logger.stealsAttempted;
            waiting = true;
            logger.stopLive();
            val v = victims(random.nextInt(m));
            at (Place(v)) @Uncounted async st().request(st, p, false);
            while (waiting) probe(v);
            logger.startLive();
        }
        for (var i:Long=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
            val lifeline = lifelines(i);
            if (!lifelinesActivated(lifeline)) {
                ++logger.lifelineStealsAttempted;
                lifelinesActivated(lifeline) = true;
                waiting = true;
                logger.stopLive();
                at (Place(lifeline)) @Uncounted async st().request(st, p, true);
                while (waiting) probe(-lifeline);
                logger.startLive();
            }
        }
        return !empty;
    }
    
    def request(st:PlaceLocalHandle[UTS], thief:Long, lifeline:Boolean) {
        try {
            if (lifeline) ++logger.lifelineStealsReceived; else ++logger.stealsReceived;
            if (empty || waiting) {
                if (lifeline) lifelineThieves.push(thief);
                at (Place(thief)) @Uncounted async { st().waiting = false; }
            } else {
                if (lifeline) thieves.push(thief); else thieves.push(-thief-1);
            }
        } catch (v:CheckedThrowable) {
            error(v);
        }
    }
    
    @Inline final def processLoot(loot:Fragment, lifeline:Boolean) {
        val n = loot.hash.size;
        if (lifeline) {
            ++logger.lifelineStealsPerpetrated;
            logger.lifelineNodesReceived += n;
        } else {
            ++logger.stealsPerpetrated;
            logger.nodesReceived += n;
        }
        loot.push(queue);
    }
    
    def deal(st:PlaceLocalHandle[UTS], loot:Fragment, source:Long) {
        try {
            val lifeline = source >= 0;
            if (lifeline) lifelinesActivated(source) = false;
            empty = false;
            if (active) {
                processLoot(loot, lifeline);
            } else {
                @Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
                active = true;
                logger.startLive();
                processLoot(loot, lifeline);
                //distribute(st);
                processStack(st);
                logger.stopLive();
                active = false;
                @Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
                logger.nodesCount = queue.count;
            }
        } catch (v:CheckedThrowable) {
            error(v);
        }
    }
    
    def main(st:PlaceLocalHandle[UTS], seed:Int, d:Int) {
        @Pragma(Pragma.FINISH_DENSE) finish {
            try {
                @Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
                empty = false;
                active = true;
                logger.startLive();
                queue.init(seed, d);
                processStack(st);
                logger.stopLive();
                active = false;
                @Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
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
    
    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, new Rail[Option](), [
                                                                Option("b", "", "Branching factor"),
                                                                Option("r", "", "Seed (0 <= r < 2^31"),
                                                                Option("d", "", "Tree depth"),
                                                                Option("n", "", "Number of nodes to process before probing. Default 200."),
                                                                Option("w", "", "Number of thieves to send out. Default 1."),
                                                                Option("l", "", "Base of the lifeline"),
                                                                Option("m", "", "Max potential victims"),
                                                                Option("v", "", "Verbose. Default 0 (no).")]);

        val b = opts("-b", 4n);
        val r = opts("-r", 19n);
        val d = opts("-d", 13n);
        val n = opts("-n", 511n);
        val l = opts("-l", 32n);
        val m = opts("-m", 1024n);
        val verbose = opts("-v", 0) != 0;

        val P = Place.numPlaces();

        var z0:Int = 1n;
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
        var time:Long = System.nanoTime();
        st().main(st, r, d);
        time = System.nanoTime() - time;
        Console.OUT.println("Finished.");
        
        val logs:Rail[Logger];
        if (P >= 1024) {
            logs = new Rail[Logger](P/32, (i:Long)=>at (Place(i*32)) {
                val h = Runtime.hereLong();
                val n = min(32, P-h);
                val logs = new Rail[Logger](n, (i:Long)=>at (Place(h+i)) st().logger.get(verbose));
                val log = new Logger(false);
                log.collect(logs);
                return log;
            });
        } else {
            logs = new Rail[Logger](P, (i:Long)=>at (Place(i)) st().logger.get(verbose));
        }
        val log = new Logger(false);
        log.collect(logs);
        log.stats(time);
    }
}
