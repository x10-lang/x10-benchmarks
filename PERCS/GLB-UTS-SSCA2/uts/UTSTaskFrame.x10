package uts;

import x10.compiler.Inline;

public class UTSTaskFrame extends glb.TaskFrame[Long]{ 
	
	//var last:Long;
	private var tb:UTSTaskBag{self!=null}; 
	private var seed:int; 
	private var depth:int; 
	private var branchfactor:int; 
	private var result:Long = 0L;
	
	/**
	 * Constructor
	 * @param branch factor
	 * @param seed random number generator
	 * @param depth depth of the tree
	 */
	public def this(branchfactor:Int, seed:Int, depth:Int){
		this.branchfactor = branchfactor;
		this.seed = seed;
		this.depth = depth;
		this.tb = new UTSTaskBag(branchfactor);
	}
	
	/**
	 * @Override
	 */
	public def initTask(): void{
		this.tb.initBag(this.seed, this.depth); 
	}
	/**
	 * @Override
	 */
	@Inline public def runAtMostNTasks(n:Long):Boolean=runAtMostNTasks(this.tb as UTSTaskBag, n);

	@Inline private def runAtMostNTasks(tb:UTSTaskBag, n:Long):Boolean{
		var i:Long=0;
		for (; (i<n) && (tb.size()>0); ++i) {
			tb.expand();
		}
		tb.incByI(i); // has traversed i number of nodes
		result = tb.getCount();// update result
		return tb.size() > 0;
	}
	
	/**
	 * @Override
	 */
	public def getResult():Long=result;
	public def getTaskBag():UTSTaskBag=tb;
	public def getReducer()=Reducible.SumReducer[Long]();
	
	
}
