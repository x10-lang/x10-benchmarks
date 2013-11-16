package ssca2;
import core.TaskFrame;
import core.TaskBag;
import x10.compiler.Ifdef;
public class SSCA2TaskFrame extends TaskFrame[SSCA2TaskItem, SSCA2Result]{
	var tb:SSCA2TaskBag;
	val verticesNum:Int;
	val interval:Int;
	var ssca2_:SSCA2;
	var graph:Graph;
	var verbose:Int;
	var splitThreshold:Int;
	/**
	 * should be only called by the master task frame
	 */
	public def initTask():void {
		this.tb.init(this.verticesNum, this.interval);
	}
	
	// public def this(verticesNum:Int, interval:Int){
	// 	this.verticesNum = verticesNum;
	// 	this.interval = interval;
	// }
	
	// Constructor
	// public def this(graph:Graph, interval:Int, permute:Int, verbose:Int) {
	// 	this.verticesNum = graph.numVertices();
	// 	this.graph = graph;
	// 	this.verbose = verbose;
	// 	this.interval = interval;
	// 	this.ssca2_ = new SSCA2(this.graph, this.verbose);
	// 	if(permute > 0){
	// 		ssca2_.permuteVertices();
	// 	}
	// }

	public def this(rmat:Rmat, interval:Int, splitThreshold:Int, permute:Int, verbose:Int) {
		// init ssca2 the workhorse
		val graph = rmat.generate();
		graph.compress();
		this.verticesNum = graph.numVertices();
		this.graph = graph;
		this.verbose = verbose;
		this.interval = interval;
		this.splitThreshold = splitThreshold;
		this.ssca2_ = new SSCA2(this.graph, this.verbose);
		if(permute > 0){
			ssca2_.permuteVertices();
		}
		// init the taskbag
		this.tb = new SSCA2TaskBag(this.splitThreshold); // should just use a split threshold as a constructor, later on, more data will be either initialized or merged TODO
	}
	
	public def runAtMostNTask(var n:Long):Boolean {
		var tasksRun:Long = 0L;
		while((tb.size() > 0) && (tasksRun < n)){
			val vRange:SSCA2TaskItem = tb.pop();
			val vStartIdx:Int = vRange.startVertexIdx;
			val eStartIdx:Int = vRange.endVertexIdx;
			// Console.OUT.println("start idx:"+ vStartIdx);
			// Console.OUT.println("stop idx:" + eStartIdx);
			ssca2_.bfsShortestPaths(vStartIdx, eStartIdx+1n); // NOTE: the +1n in the end, that is [start, end) is the region that SSCA2 works on when calling bfsShortestPaths
			tasksRun++;
		}
		return (tasksRun==n);
	}
	
	public def getResult():SSCA2Result {
		
		return new SSCA2Result(this.ssca2_.betweennessMap);
	}
	
	public def getTaskBag():TaskBag[SSCA2TaskItem] {
		return this.tb;
	}
	
	/**
	 * added for debugging purpose
	 */
	public def printResult():void{
		this.ssca2_.printBetweennessMap();
	}
	
	// @override print log
	public def printLog():void{
		@Ifdef("LOG"){
			Console.OUT.println("Place " + Runtime.hereLong()+ " Alloc time: " + ssca2_.allocTime/(1E9));
			Console.OUT.println("Place " + Runtime.hereLong()+ " processing time: " + ssca2_.processingTime/(1E9));
		}
	}
	
	
}