/**
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * 
 * Adapted from Java version by Oleg Mazurov
 * 
 * v1: A direct, straightforward port from Java, with no tuning, extra constraints, or non-essential X10 idioms.
 * 
 */

import x10.io.Console;
import x10.util.concurrent.AtomicInteger;

public class fannkuchredux {
    private static val NCHUNKS = 150n;
    
    public static def main(args:Rail[String]) {
        val start = System.nanoTime();
        val n = args.size > 0 ? Int.parse(args(0)) : 12n; 
        if ( n < 0n || n > 12n ) {         // 13 won't fit into int
            printResult(n, -1n, -1n);
            return;
        }
        if ( n <= 1n ) {
            printResult(n, 0n, 0n);
            return;
        }
        val Fact = new Rail[int](n+1);
        Fact(0) = 1n;
        for (var i:int=1n; i<Fact.size; ++i ) {
            Fact(i) = Fact(i-1) * i;
        }
        
        val CHUNKSZ = (Fact(n) + NCHUNKS - 1n) / NCHUNKS;
        val NTASKS = (Fact(n) + CHUNKSZ - 1n) / CHUNKSZ;
        val maxFlips = new Rail[int](NTASKS);
        val chkSums  = new Rail[int](NTASKS);
        val taskId = new AtomicInteger(0n);
        
        val nProcs = 2; // TODO 1) there is no way to detect number of procs, so guessing 2  
        finish {
            for (1..nProcs) async {
                val p     = new Rail[int](n);
                val pp    = new Rail[int](n);
                val count = new Rail[int](n);
                
                var task:int = 0n;             
                while ((task = taskId.getAndIncrement() ) < NTASKS ) {
                    runTask(n, task, CHUNKSZ, Fact, count, p, pp, maxFlips, chkSums);
                }
            }
        }
        
        var res:int = 0n;// TODO: switch to collecting finish
        for (v in maxFlips) {
            res = Math.max(res, v);
        }
        var chk:int = 0n;
        for (v in chkSums ) {
            chk += v;
        }
        
        printResult(n, res, chk);
        val end = System.nanoTime();
        Console.OUT.println("Program runtime: " + ( end-start));
    }
    
    static def runTask(n:int, task:int, CHUNKSZ: int, Fact:Rail[int], count:Rail[int],
                       p:Rail[int], pp:Rail[int], maxFlips:Rail[int], chkSums:Rail[int]) {
        val idxMin = task*CHUNKSZ;
        val idxMax = Math.min( Fact(n), idxMin+CHUNKSZ );
        
        firstPermutation(idxMin,Fact,count,p,pp);
        
        var mf:int = 1n;
        var chksum:int = 0n;
        for (var i:int=idxMin;; ) {
            if (p(0) != 0n) {
                val flips = countFlips(p,pp);
                mf = Math.max( mf, flips );
                chksum += i%2n ==0n ? flips : -flips;
            }
            
            if (++i == idxMax ) {
                break;
            }
            
            nextPermutation(count,p,pp);
        }
        maxFlips(task) = mf;
        chkSums(task)  = chksum;
    }
    
    static def firstPermutation(var idx:int, Fact:Rail[int], count:Rail[int],
                                p:Rail[int], pp:Rail[int]) {
        for (i in p.range() ) {
            p(i) = i as int;
        }
        
        for (var i:int=(count.size-1) as int; i>0n; --i ) {
            val d = idx / Fact(i);
            count(i) = d;
            idx = idx % Fact(i);
            
            Rail.copy(p,0,pp,0,i+1);
            
            for (j in 0n..i) {  
                p(j) = j+d <= i ? pp(j+d) : pp(j+d-i-1n);
            }
        }
    }
    
    static def countFlips(p:Rail[int], pp:Rail[int]) {
        var flips:int = 1n;
        var first:int = p(0);
        if (p(first) != 0n) {
            Rail.copy(p, pp);
            do {
                ++flips;
                var lo:int = 0n;
                var hi:int = 0n;
                for ( lo = 1n, hi = first - 1n; lo < hi; ++lo, --hi ) {
                    val t = pp(lo);
                    pp(lo) = pp(hi);
                    pp(hi) = t;
                }
                val t = pp(first);
                pp(first) = first;
                first = t;
            } while ( pp(first) != 0n);
        }
        return flips;
    }
    
    static def nextPermutation(count:Rail[int], p:Rail[int], pp:Rail[int]) {
        var first:int = p(1);
        p(1) = p(0);
        p(0) = first;
        
        var i:int=1n;
        while ( ++count(i) > i ) {
            count(i++) = 0n;
            val nxt = p(0) = p(1);
            for (j in 1..(i-1)) {  
                p(j) = p(j+1);
            }
            p(i) = first;
            first = nxt;
        }
        return true;
    }
    
    static def printResult(n:int, res:int, chk:int ) {
        // TODO: clean up when StringBuilder bug is fixed.
        Console.OUT.println( "" + chk+"\nPfannkuchen("+n+") = "+res );
    }
}
