package bcg;

import x10.compiler.Ifdef;

import glb.TaskFrame;
import glb.TaskBag;



public class BCTaskFrame extends TaskFrame[BCResult]{
	var tb:BCTaskBag;
	val verticesNum:Int;
	val interval:Int;
	var bc_:BC;
	var graph:Graph;
	var verbose:Int;
	var splitThreshold:Int;
	/**
	 * should be only called by the master task frame
	 */
	public def initTask():void {
		this.tb.init(this.verticesNum, this.interval);
	}
	
	public def this(rmat:Rmat, interval:Int, splitThreshold:Int, permute:Int, verbose:Int) {
		// init bc the workhorse
		val graph = rmat.generate();
		graph.compress();
		this.verticesNum = graph.numVertices();
		this.graph = graph;
		this.verbose = verbose;
		this.interval = interval;
		this.splitThreshold = splitThreshold;
		this.bc_ = new BC(this.graph, this.verbose);
		if (permute > 0) bc_.permuteVertices();
		// init the taskbag
		this.tb = new BCTaskBag(this.splitThreshold); // should just use a split threshold as a constructor, later on, more data will be either initialized or merged TODO
	}
	
	public def runAtMostNTasks(var n:Long):Boolean {
		var tasksRun:Long = 0L;
		while((tb.size() > 0) && (tasksRun < n)){
			val vRange = tb.pop();
			val vStartIdx = vRange.startVertexIdx;
			val eStartIdx = vRange.endVertexIdx;
			// Console.OUT.println("start idx:"+ vStartIdx);
			// Console.OUT.println("stop idx:" + eStartIdx);
			bc_.bfsShortestPaths(vStartIdx, eStartIdx+1n); // NOTE: the +1n in the end, that is [start, end) is the region that SSCA2 works on when calling bfsShortestPaths
			tasksRun++;
		}
		return (tasksRun==n);
	}
	
	public def getResult()=new BCResult(this.bc_.betweennessMap);
	public def getTaskBag()=tb;
	public def getReducer()=new BCResultReducible(bc_.N);
	/**
	 * added for debugging purpose
	 */
	public def printResult():void{this.bc_.printBetweennessMap();}
	
	// @override print log
	public def printLog():void{
	    //		@Ifdef("LOG"){
	    //			Console.OUT.println("Place " + Runtime.hereLong()+ " Alloc time: " + ssca2.allocTime/(1E9));
	    //			Console.OUT.println("Place " + Runtime.hereLong()+ " processing time: " + ssca2.processingTime/(1E9));
	    //		}
	}
	
	
}
