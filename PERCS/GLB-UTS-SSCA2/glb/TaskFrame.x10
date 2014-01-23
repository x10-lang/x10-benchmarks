package glb;

/**
 * A TaskFrame[Z] (Z is the type of the result)
 * represents the user-defined data-structure maintained at each place by the
 * GLB implementation. It has an associated task bag. 
 */
public abstract class TaskFrame[Z] {
	
	/**
	 * Perform initialization. Called when the TaskFrame is first created.
	 * If the computation is supposed to be initiated with a root task, then
	 * the programmer should arrange matters so that the root task is added 
	 * to the task bag at a single place (usually place zero). If the computation
	 * can start with many tasks executing simultaneously, then initTask() may
	 * initialize non-empt task bags at more than one (perhaps all) places.
	 */
	abstract public def initTask():void; 


     /**
 	 * add on Nov 10, 2013 for initializing the task per place, specific to BC type of workload
     */
     public def initTask(placeID: Long, maxPlace:Long):void{}

	/**
	 * Run at most n tasks in the associated task bag. Return true
     * if more items are left in the associated task bag to process.
	 */
	 abstract public def runAtMostNTasks(n:Long):Boolean;
	 
	 /**
	  * Return the underlying task bag.
	  */
	 abstract public def getTaskBag():TaskBag;
	 
	 /**
	  * Return the result accumulated so far for all executed tasks.
	  */
	 abstract public def getResult():Z;
	 
	 /**
	  * Return the reducer of type Z associated with this job.
	  */
	 abstract public def getReducer():Reducible[Z];
	
	 
	 /**
	  * Auxiliary function that user can overwrite to print the statistics one cares about,
	  * e.g., computation time. This function will be called only after all the calculation
	  * and results reduction are done.
	  */
	 protected def printLog():void{}
	 
	 var st:PlaceLocalHandle[LocalJobRunner[Z]];
	 def setPLH(st:PlaceLocalHandle[LocalJobRunner[Z]]): void{
		 this.st = st;
	 }
	 
	 public def yield():void{
		 this.st().getYieldPoint()(this.st); // gee, this is not pretty
	 }
	 
	 public def reduce(){;} // on Jan 23, 2014, added for better use of x10 Team reduce functionality 
}
