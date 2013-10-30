package uts;

import x10.compiler.Pragma;
import x10.compiler.Inline;
import x10.compiler.Ifdef;
import x10.compiler.Uncounted;

import x10.util.Random;
import x10.util.Option;
import x10.util.OptionsParser;

import glb.LifelineGenerator;
import glb.TaskBag;
import glb.GLBParameters;
import glb.GlobalLoadBalancer;

public class UTS{
	
	
	public static def main(args:Rail[String]) {
		val opts = new OptionsParser(args, new Rail[Option](), [
		                                                        Option("b", "", "Branching factor"),
		                                                        Option("r", "", "Seed (0 <= r < 2^31"),
		                                                        Option("d", "", "Tree depth"),
		                                                        Option("n", "", "Number of nodes to process before probing. Default 200."),
		                                                        Option("w", "", "Number of thieves to send out. Default 1."),
		                                                        Option("l", "", "Base of the lifeline"),
		                                                        Option("m", "", "Max potential victims"),
		                                                        Option("v", "", "Verbose level")]);

		val b = opts("-b", 4n);
		val r = opts("-r", 19n);
		val d = opts("-d", 13n);
		val n = opts("-n", 511n);
		val l = opts("-l", 32n);
		val m = opts("-m", 1024n);
		val verbose = opts("-v", 0n);
		val P=Place.MAX_PLACES;
		val w = opts("-w", GLBParameters.computeZ(P,l));
		val z=w;
		Console.OUT.println("places=" + P +
				"   b=" + b +
				        "   r=" + r +
				                "   d=" + d +
				                        "   w=" + w +
				                                "   n=" + n +
				                                        "   l=" + l + 
				                                                "   m=" + m + 
				                                                        "   z=" + z);
		val myuts_ = new GlobalLoadBalancer[Long](GLBParameters(n, w, l, z, m,verbose));
		var time:Long = System.nanoTime();
		result:Long = myuts_.run(()=>new UTSTaskFrame(b,r,d));
		time = System.nanoTime() - time;
		Console.OUT.println("Time spent: " + (time/1E9));
		Console.OUT.println("Result: "+ result);
		Console.OUT.println("Throughput: "+result/(time/1E3)+ " M nodes/s");
	
	}
	
	
}
