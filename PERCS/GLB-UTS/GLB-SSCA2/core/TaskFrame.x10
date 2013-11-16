package core;

/**
 * this is the same as the GLB impl in PPOPP11
 */
public abstract class TaskFrame[T, Z] {
	
	
	private var tb:TaskBag[T];
	/**
	 * Run this task in the given task frame. 
	 * Implementations of this method will use 
	 * the stack to create additional tasks, if necessary.
	 * For historical reason, I put it here, probably not needed
	 */
	// public def runTask(t:T, tb:TaskBag[T]):void{}
	
	
	 /**
	  * theoretically the only method need be implemented in this class
	  */
	// abstract public def runAtMostNTask(tb:TaskBag[T], n:Long):Boolean;
	 
	 abstract public def runAtMostNTask(n:Long):Boolean;
	 
	 abstract public def getResult():Z;
	 
	 abstract public def initTask():void; // init the task, only the first task frame should do this (aka root task)
	 
	 abstract public def getTaskBag():TaskBag[T];
	 
	 public def printLog():void{
		 //do nothing, override it to print out the logs that you want
	 }
}