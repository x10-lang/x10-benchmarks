package test;

import x10.util.OptionsParser;
import x10.util.Option;
import ssca2.Rmat;
import ssca2.SSCA2TaskFrame;
import ssca2.SSCA2TaskItem;
import ssca2.SSCA2Result;
import ssca2.SSCA2TaskBag;
import core.TaskFrame;
import core.TaskBag;
public class TestSSCA2 {
	
	////////// beginning of unit tests
	
	public static def testTBInit(){
		val tb:SSCA2TaskBag = new SSCA2TaskBag(32n); // 32n is just the split threshold
		tb.init(1024n, 16n);
		assert(tb.size == 64n);
		assert(tb.head == 0n);
		assert(tb.tail == 63n);
		assert(tb.data(0).startVertexIdx == 0n);
		assert(tb.data(0).endVertexIdx == 15n);
		assert(tb.data(1).startVertexIdx == 16n);
		assert(tb.data(1).endVertexIdx == 31n);
		assert(tb.data(63).startVertexIdx == 1008n);
		assert(tb.data(63).endVertexIdx == 1023n);
		Console.OUT.println("testTBInit passed");
	}
	
	/**
	 * list of task bag/split to test
	 * (1) init a task bag of 1024 elements and split it into half
	 */
	public static def testTBSplit(){
		val tb:SSCA2TaskBag = new SSCA2TaskBag(32n); // 32n is just the split threshold
		tb.init(1024n, 16n);
		splitBag:SSCA2TaskBag = (tb as TaskBag[SSCA2TaskItem]).split() as SSCA2TaskBag;
		assert(splitBag != null);
		assert(splitBag.size == 32n);
		assert(splitBag.head == 0n);
		assert(splitBag.tail == 31n);
		assert(tb.size == 32n);
		assert(tb.tail == 31n);
		assert(tb.head == 0n);
		
		Console.OUT.println("testTBSplit passed");
	}
	
	public static def testTBPopAndSplit(){
		val tb:SSCA2TaskBag = new SSCA2TaskBag(16n); // 16n is just the split threshold
		tb.init(1024n, 16n);
		tb.pop();
		assert(tb.size == 63n);
		assert(tb.head == 1n);
		assert(tb.tail == 63n);
		splitBag:SSCA2TaskBag = (tb as TaskBag[SSCA2TaskItem]).split() as SSCA2TaskBag;
		assert(splitBag != null);
		assert(splitBag.size == 32n);
		assert(tb.size == 31n);
		//assert(tb.tail == 30n);
		Console.OUT.println("testTBPopAndSplit passed");
	}
	
	public static def testMerge(){
		val tb:SSCA2TaskBag = new SSCA2TaskBag(16n); // 16n is just the split threshold
		tb.init(1024n, 16n);
		//tb.pop();
		var splitBag:SSCA2TaskBag = (tb as TaskBag[SSCA2TaskItem]).split() as SSCA2TaskBag;
		tb.merge(splitBag);
		assert(tb.size == 64n);
		assert(tb.head == 0n);
		assert(tb.tail == 63n);
		assert(tb.data(0).startVertexIdx == 0n);
		assert(tb.data(0).endVertexIdx == 15n);
		assert(tb.data(1).startVertexIdx == 16n);
		assert(tb.data(1).endVertexIdx == 31n);
		assert(tb.data(63).startVertexIdx == 1008n);
		assert(tb.data(63).endVertexIdx == 1023n);
		
		tb.pop();
		splitBag = (tb as TaskBag[SSCA2TaskItem]).split() as SSCA2TaskBag;
		assert(splitBag !=null);
		tb.merge(splitBag);
		assert(tb.size == 63n);
		assert(tb.head == 0n);
		assert(tb.tail == 62n);
		Console.OUT.println("testMerge passed");
	}
	
	public static def unitTests(){
		testTBInit();
		testTBSplit();
		testTBPopAndSplit();
		testMerge();
	}

	
	//////////// end of unit tests
	public static def testTaskBag(args:Rail[String]){
		val mytask:SSCA2TaskFrame = parseCMDLine(args);
		val n:Int = 5n;
		mytask.initTask();
	
		while(mytask.runAtMostNTask(n)){
			val splitBag:SSCA2TaskBag = mytask.getTaskBag().split() as SSCA2TaskBag;
			if(splitBag !=null){
				//Console.OUT.println("worth splitting...");
				mytask.getTaskBag().merge(splitBag);
			}
		}
		result:SSCA2Result = mytask.getResult();
		(mytask as SSCA2TaskFrame).printResult();
	}
	
	public static def testTaskFrame(args:Rail[String]){
		val mytask:SSCA2TaskFrame = parseCMDLine(args);
		mytask.initTask();
		val n:Int = 5n;
		while(mytask.runAtMostNTask(n));
		result:SSCA2Result = mytask.getResult();
		(mytask as SSCA2TaskFrame).printResult();
	}
	
	public static def parseCMDLine(args:Rail[String]):SSCA2TaskFrame{
		val cmdLineParams = new OptionsParser(args, new Rail[Option](0L), [
		                                                                   Option("s", "", "Seed for the random number"),
		                                                                   Option("n", "", "Number of vertices = 2^n"),
		                                                                   Option("a", "", "Probability a"),
		                                                                   Option("b", "", "Probability b"),
		                                                                   Option("c", "", "Probability c"),
		                                                                   Option("d", "", "Probability d"),
		                                                                   Option("p", "", "Permutation"),
		                                                                   Option("i", "", "interval"),
		                                                                   Option("t", "", "threshold of split"),
		                                                                   Option("v", "", "Verbose")]);

		val seed:Long = cmdLineParams("-s", 2);
		val n:Int = cmdLineParams("-n", 2n);
		val a:Double = cmdLineParams("-a", 0.55);
		val b:Double = cmdLineParams("-b", 0.1);
		val c:Double = cmdLineParams("-c", 0.1);
		val d:Double = cmdLineParams("-d", 0.25);
		val i:Int = cmdLineParams("-i", 16n); // on by default
		val t:Int = cmdLineParams("-t", 1n); // on by default
		val permute:Int = cmdLineParams("-p", 1n); // on by default
		val verbose:Int = cmdLineParams("-v", 0n); // off by default

		Console.OUT.println("Running SSCA2 with the following parameters:");
		Console.OUT.println("seed = " + seed);
		Console.OUT.println("N = " + (1<<n));
		Console.OUT.println("a = " + a);
		Console.OUT.println("b = " + b);
		Console.OUT.println("c = " + c);
		Console.OUT.println("d = " + d);
		Console.OUT.println("places = " + Place.numPlaces());

		val mytask:TaskFrame[SSCA2TaskItem, SSCA2Result] = new SSCA2TaskFrame(Rmat(seed, n, a, b, c, d),i ,t, permute, verbose);
		return mytask as SSCA2TaskFrame;
	}
	
	/**
	 * Reads in all the options and calculate betweenness.
	 */
	public static def main(args:Rail[String]):void {
		
		//unitTests();
		testTaskBag(args);
	}
}