package uts;

import x10.compiler.*;

public class UTSTaskFrame extends glb.TaskFrame[Long]{ 
	
	var last:Long;
	var tb:UTSTaskBag{self!=null}; 
	var seed:int; 
	var depth:int; 
	var branchfactor:int; 
	var result:Long = 0L;
	public def getResult():Long=result;
	public def getTaskBag():UTSTaskBag=tb;
	public def getReducer()=Reducible.SumReducer[Long]();
	public def this(branchfactor:Int, seed:Int, depth:Int){
		this.branchfactor = branchfactor;
		this.seed = seed;
		this.depth = depth;
		this.tb = new UTSTaskBag(branchfactor);
	}
	
	@Inline public def runAtMostNTasks(tb:UTSTaskBag, n:Long):Boolean{
		var i:Long=0;
		for (; (i<n) && (tb.size()>0); ++i) {
			tb.expand();
		}
		tb.incByI(i);
		result = tb.getCount();// WA 10/20
		return tb.size() > 0;
	}
	@Inline public def runAtMostNTasks(n:Long):Boolean=runAtMostNTasks(this.tb as UTSTaskBag, n);
	public def initTask(): void{
		this.tb.initTree(this.seed, this.depth); 
	}
	
}
