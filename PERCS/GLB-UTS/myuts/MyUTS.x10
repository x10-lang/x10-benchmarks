package myuts;
import core.GlobalJobRunner;
import x10.compiler.Pragma;
import x10.compiler.Inline;
import x10.util.Random;
import core.LifelineGenerator;
import x10.compiler.Ifdef;
import x10.compiler.Uncounted;

import x10.util.Option;
import x10.util.OptionsParser;
import core.TaskBag;
import core.LocalJobRunner;
public class MyUTS extends GlobalJobRunner[UTSTreeNode, Long]{
	
	private var resultReducer:Reducible[Long];
	public def getResultReducer():x10.lang.Reducible[x10.lang.Long] {
		// TODO: auto-generated method stub
		return this.resultReducer;
	}
	
	public def setResultReducer(var r:x10.lang.Reducible[x10.lang.Long]):void {
		this.resultReducer = r;
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
		
		val myuts: MyUTS = new MyUTS();
		// uncomment it to get it work
		myuts.setResultReducer(new UTSResultReducible());
		var time:Long = System.nanoTime();
		result:Long = myuts.main(()=>new LocalJobRunner[UTSTreeNode, Long](new UTSTaskFrame(b,r,d), n, w, l, z, m));
		time = System.nanoTime() - time;
		Console.OUT.println("Time spent: " + (time/1E9));
		Console.OUT.println("Result: "+ result);
		Console.OUT.println("Throughput: "+result/(time/1E3)+ " M nodes/s");
		// end of uncomment it to get it work
		
		//myuts.dryRun(()=>new LocalJobRunner[UTSTreeNode, Long](new UTSTaskFrame(b,r,d), n, w, l, z, m));
	
		
	}
	
	
}