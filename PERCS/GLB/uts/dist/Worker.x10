package uts.dist;

import x10.compiler.*;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Random;

import util.*;

final class Worker {
    val queue:TaskQueue;
    val lifelineThieves:FixedSizeStack[Long];
    val thieves:FixedSizeStack[Long];
    val lifelines:Rail[Long];
    val lifelinesActivated:Rail[Boolean];
    
    val n:Int;
    val w:Int;
    val m:Int;
    
    val random = new Random(Runtime.hereInt());
    val victims:Rail[Long];
    val logger:Logger;
    
    @x10.compiler.Volatile transient var active:Boolean = false;
    @x10.compiler.Volatile transient var empty:Boolean = true;
    @x10.compiler.Volatile transient var waiting:Boolean = false;
    
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
        
        queue = new TaskQueue(b);
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
    
    final def processStack(st:PlaceLocalHandle[Worker]) {
        do {
            while (queue.process(n)) {
                Runtime.probe();
                distribute(st);
                reject(st);
            }
            reject(st);
        } while (steal(st));
    }
    
    @Inline def give(st:PlaceLocalHandle[Worker], loot:TaskBag) {
        val victim = Runtime.hereLong();
        logger.nodesGiven += loot.size();
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
    
    @Inline def distribute(st:PlaceLocalHandle[Worker]) {
        var loot:TaskBag;
        while (((thieves.size() > 0) || (lifelineThieves.size() > 0)) && (loot = queue.split()) != null) {
            give(st, loot);
        }
    }
    
    @Inline def reject(st:PlaceLocalHandle[Worker]) {
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
    
    def steal(st:PlaceLocalHandle[Worker]) {
        if (P == 1) return false;
        val p = Runtime.hereLong();
        empty = true;
        for (var i:Long=0; i < w && empty; ++i) {
            ++logger.stealsAttempted;
            waiting = true;
            logger.stopLive();
            val v = victims(random.nextInt(m));
            at (Place(v)) @Uncounted async st().request(st, p, false);
            while (waiting) Runtime.probe();
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
                while (waiting) Runtime.probe();
                logger.startLive();
            }
        }
        return !empty;
    }
    
    def request(st:PlaceLocalHandle[Worker], thief:Long, lifeline:Boolean) {
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
    
    @Inline final def processLoot(loot:TaskBag, lifeline:Boolean) {
        val n = loot.size();
        if (lifeline) {
            ++logger.lifelineStealsPerpetrated;
            logger.lifelineNodesReceived += n;
        } else {
            ++logger.stealsPerpetrated;
            logger.nodesReceived += n;
        }
        queue.merge(loot);
    }
    
    def deal(st:PlaceLocalHandle[Worker], loot:TaskBag, source:Long) {
        try {
            val lifeline = source >= 0;
            if (lifeline) lifelinesActivated(source) = false;
            empty = false;
            if (active) {
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
    
    def main(st:PlaceLocalHandle[Worker], seed:Int, d:Int) {
        @Pragma(Pragma.FINISH_DENSE) finish {
            try {
                empty = false;
                active = true;
                logger.startLive();
                queue.init(seed, d);
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
    
    @Inline static def min(i:Long, j:Long) = i < j ? i : j;
    
    static def stats(st:PlaceLocalHandle[Worker], verbose:Boolean) {
        val P = Place.numPlaces();
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
        log.stats();
        return log.nodesCount;
    }
}
