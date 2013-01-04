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
	private static val NCHUNKS = 150;
	
	public static def main(args: Array[String](1){rail}) {
		val start = System.nanoTime();
		val n = args.size > 0 ? Int.parse(args(0)) : 12; 
		if ( n < 0 || n > 12 ) {         // 13 won't fit into int
			printResult( n, -1, -1 );
			return;
		}
		if ( n <= 1 ) {
			printResult( n, 0, 0 );
			return;
		}
		val Fact = new Array[int](n+1);
		Fact(0) = 1;
		for (var i:int=1; i<Fact.size; ++i ) {
			Fact(i) = Fact(i-1) * i;
		}
		
		val CHUNKSZ = (Fact(n) + NCHUNKS - 1) / NCHUNKS;
		val NTASKS = (Fact(n) + CHUNKSZ - 1) / CHUNKSZ;
		val maxFlips = new Array[int](NTASKS);
		val chkSums  = new Array[int](NTASKS);
		val taskId = new AtomicInteger(0);
		
		val nProcs = 2; // TODO 1) there is no way to detect number of procs, so guessing 2  
		finish {
			for ([i] in 1..nProcs) async {
				val p     = new Array[int](n);
				val pp    = new Array[int](n);
				val count = new Array[int](n);
				
				var task:int = 0;             
				while ((task = taskId.getAndIncrement() ) < NTASKS ) {
					runTask(n, task, CHUNKSZ, Fact, count, p, pp, maxFlips, chkSums);
				}
			}
		}
		
		var res:int = 0;// TODO: switch to collecting finish
		for (v in maxFlips) {  // TODO: switch to maxFlips.values() when it appears
			res = Math.max( res, maxFlips(v) );
		}
		var chk:int = 0;
		for (v in chkSums ) {  // TODO: would like chkSums.values()
			chk += chkSums(v);
		}
		
		printResult( n, res, chk );
		val end = System.nanoTime();
		Console.OUT.println("Program runtime: " + ( end-start));
	}
	
	static def runTask(n:int, task:int, CHUNKSZ: int, Fact:Array[int](1){rail}, count:Array[int](1){rail},
			p:Array[int](1){rail}, pp:Array[int](1){rail},maxFlips:Array[int](1){rail}, chkSums:Array[int](1){rail})
	{
		val idxMin = task*CHUNKSZ;
		val idxMax = Math.min( Fact(n), idxMin+CHUNKSZ );
		
		firstPermutation(idxMin,Fact,count,p,pp);
		
		var mf:int = 1;
		var chksum:int = 0;
		for (var i:int=idxMin;; ) {
			if (p(0) != 0) {
				val flips = countFlips(p,pp);
				mf = Math.max( mf, flips );
				chksum += i%2 ==0 ? flips : -flips;
			}
			
			if (++i == idxMax ) {
				break;
			}
			
			nextPermutation(count,p,pp);
		}
		maxFlips(task) = mf;
		chkSums(task)  = chksum;
	}
	
	static def firstPermutation(var idx:int, Fact:Array[int](1){rail}, count:Array[int](1){rail},
			p:Array[int](1){rail}, pp:Array[int](1){rail}) {
		
		for ([i] in p ) {
			p(i) = i;
		}
		
		for (var i:int=count.size-1; i>0; --i ) {
			val d = idx / Fact(i);
			count(i) = d;
			idx = idx % Fact(i);
			
			Array.copy(p,0,pp,0,i+1);
			
			for ([j] in 0..i) {  
				p(j) = j+d <= i ? pp(j+d) : pp(j+d-i-1);
			}
		}
	}
	
	static def countFlips(p:Array[int](1){rail},pp:Array[int](1){rail})
	{
		var flips:int = 1;
		var first:int = p(0);
		if (p(first) != 0) {
			Array.copy(p,pp);
			do {
				++flips;
				var lo:int = 0;
				var hi:int = 0;
				for ( lo = 1, hi = first - 1; lo < hi; ++lo, --hi ) {
					val t = pp(lo);
					pp(lo) = pp(hi);
					pp(hi) = t;
				}
				val t = pp(first);
				pp(first) = first;
				first = t;
			} while ( pp(first) != 0 );
		}
		return flips;
	}
	
	static def nextPermutation(count:Array[int](1){rail},
			p:Array[int](1){rail}, pp:Array[int](1){rail}) {
		var first:int = p(1);
		p(1) = p(0);
		p(0) = first;
		
		var i:int=1;
		while ( ++count(i) > i ) {
			count(i++) = 0;
			val nxt = p(0) = p(1);
			for ([j] in 1..(i-1)) {  
				p(j) = p(j+1);
			}
			p(i) = first;
			first = nxt;
		}
		return true;
	}
	
	static def printResult(n:int, res:int, chk:int )
	{
		// TODO: clean up when StringBuilder bug is fixed.
		Console.OUT.println( "" + chk+"\nPfannkuchen("+n+") = "+res );
	}
}

