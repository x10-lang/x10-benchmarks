package myuts;
import core.TaskFrame;
import core.TaskBag;
import x10.compiler.Inline;
import x10.compiler.Ifdef;
public class UTSTaskFrame extends TaskFrame[UTSTreeNode, Long]{ // should this taskframe class be stateful or stateless?
	
	var last:Long;// debug
	var tb:TaskBag[UTSTreeNode]{self!=null}; // general to all TaskFrame
	
	
	var seed:int; // specific for UTSTaskFrame
	var depth:int; // specific for UTSTaskFrame
	var branchfactor:int; // specific for UTSTaskFrame
	/**
	 * Run this task in the given task frame. 
	 * Implementations of this method will use 
	 * the stack to create additional tasks, if necessary.
	 * For historical reason, I put it here, probably not needed
	 */
	public def runTask(t:UTSTreeNode, tb:TaskBag[UTSTreeNode]):void{}
	
	var result:Long = 0L;
	
	public def this(branchfactor:Int, seed:Int, depth:Int){
		this.branchfactor = branchfactor;
		this.seed = seed;
		this.depth = depth;
		this.tb = new UTSTaskBag[UTSTreeNode](branchfactor);
	}
	
	/**
	 * theoretically the only method need be implemented in this class
	 * @override
	 */
	@Inline public def runAtMostNTask(tb:UTSTaskBag[UTSTreeNode], n:Long):Boolean{
		
		var i:Long=0;
		
		for (; (i<n) && (tb.size()>0); ++i) {
			
			tb.expand();
			// @Ifdef("LOG") {
			// 	Console.OUT.println(Runtime.hereLong()+" expanded now queue nodecnt:" + (this.tb as UTSTaskBag[UTSTreeNode]).getCount());
			// }
		}
		@Ifdef("LOG") {
			Console.OUT.println("Place " + Runtime.hereLong()+ " runed " + i + " tasks.");
			if (((this.tb as UTSTaskBag[UTSTreeNode]).getCount() ^ last) > (1 << 25n)) Runtime.println(Runtime.hereLong() + " COUNTED " + ((this.tb as UTSTaskBag[UTSTreeNode]).getCount()));
			last = ((this.tb as UTSTaskBag[UTSTreeNode]).getCount());
		}
		tb.incByI(i);
		result = tb.getCount();// WA 10/20
		
		return tb.size() > 0;
	}
	
	@Inline public def runAtMostNTask(n:Long):Boolean{
		
		return this.runAtMostNTask(this.tb as UTSTaskBag[UTSTreeNode], n);
	}
	
	public def getResult():Long{
		return this.result;
	}
	
	// public def setTB(tb:TaskBag[UTSTreeNode]{self!=null}):void{
	// 	this.tb = tb;
	// }
	// 
	// protected def setSeed(seed:Int):void{
	// 	this.seed = seed;
	// }
	// protected def setDepth(d:Int):void{
	// 	this.depth = d;
	// }
	
	public def initTask(): void{
		(tb as UTSTaskBag[UTSTreeNode]).initTree(this.seed, this.depth); // probably foolish style ?
	}
	public def getTaskBag():TaskBag[UTSTreeNode] {
		// TODO: auto-generated method stub
		return this.tb;
	}
	
	
}