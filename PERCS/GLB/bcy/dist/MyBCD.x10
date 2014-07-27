/**
 * re-write this application so that it "has" BC, not it "is" BC
 */
package bcy.dist;

import x10.compiler.*;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Random;
import x10.util.Team;

import bc.Rmat;
import bcy.BC;

public final class MyBCD{
	val startVertex:Int;
	val endVertex:Int;
	public var bc_:BC;
	
	public def this(rmat:Rmat, permute:Int) {
		this.bc_ = new BC(rmat, permute);
		val h = Runtime.hereInt();
		val max = Place.numPlaces();
		startVertex = (this.bc_.N as Long*h/max) as Int;
		endVertex = (this.bc_.N as Long*(h+1)/max) as Int;
	}
	
	def bfsShortestPaths() {
		for(var vertexIndex:Int=startVertex; vertexIndex<endVertex; ++vertexIndex) { 
			this.bc_.bfsShortestPath(vertexIndex, ()=>{;});
		}
		
	}
	
	def allreduce() {
		Team.WORLD.allreduce(this.bc_.betweennessMap, // Source buffer.
				0, // Offset into the source buffer.
				this.bc_.betweennessMap, // Destination buffer.
				0, // Offset into the destination buffer.
				this.bc_.N as long, // Number of elements.
				Team.ADD); // Operation to be performed.
	}
	
	public static def main(args:Rail[String]):void {
		val cmdLineParams = new OptionsParser(args, new Rail[Option](0L), [
		                                                                   Option("s", "", "Seed for the random number"),
		                                                                   Option("n", "", "Number of vertices = 2^n"),
		                                                                   Option("a", "", "Probability a"),
		                                                                   Option("b", "", "Probability b"),
		                                                                   Option("c", "", "Probability c"),
		                                                                   Option("d", "", "Probability d"),
		                                                                   Option("p", "", "Permutation"),
		                                                                   Option("v", "", "Verbose")]);
		
		val seed:Long = cmdLineParams("-s", 2);
		val n:Int = cmdLineParams("-n", 2n);
		val a:Double = cmdLineParams("-a", 0.55);
		val b:Double = cmdLineParams("-b", 0.1);
		val c:Double = cmdLineParams("-c", 0.1);
		val d:Double = cmdLineParams("-d", 0.25);
		val permute:Int = cmdLineParams("-p", 1n); // on by default
		val verbose:Int = cmdLineParams("-v", 0n); // off by default
		
		val max = Place.numPlaces();
		
		Console.OUT.println("Running BC with the following parameters:");
		Console.OUT.println("seed = " + seed);
		Console.OUT.println("N = " + (1<<n));
		Console.OUT.println("a = " + a);
		Console.OUT.println("b = " + b);
		Console.OUT.println("c = " + c);
		Console.OUT.println("d = " + d);
		Console.OUT.println("places = " + max);
		
		var time:Long = System.nanoTime();
		val plh = PlaceLocalHandle.makeFlat[BCD](Place.places(), ()=>new BCD(Rmat(seed, n, a, b, c, d), permute));
		val setupTime = (System.nanoTime()-time)/1e9;
		
		
		time = System.nanoTime();
		Place.places().broadcastFlat(()=>{
			plh().bfsShortestPaths();
		});
		val procTime = (System.nanoTime()-time)/1e9;
		time = System.nanoTime();
		Place.places().broadcastFlat(()=>{
			plh().allreduce();
		});
		val reduceTime = (System.nanoTime()-time)/1e9;
		if(verbose > 0) {
			Place.places().broadcastFlat(()=>{
				Console.OUT.println("[" + here.id + "]"
						+ " Time = " + plh().accTime
						+ " Count = " + plh().count);
			});
		}
		
		if(verbose > 2) plh().printBetweennessMap(6n);
		
		Console.OUT.println("Places: " + max + " N: " + plh().N + "  Setup: " + 
				setupTime + "s  Processing: " + procTime + "s" + " Reduce: " + reduceTime + "s");
	}
}
