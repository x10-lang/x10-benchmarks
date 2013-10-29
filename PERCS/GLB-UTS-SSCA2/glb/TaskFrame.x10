package glb;

/**
 * A TaskFrame[Z] (Z is the type of the result)
 * represents the user-defined data-structure maintained at each place by the
 * GLB implementation. It has an associated task bag.
 */
public abstract class TaskFrame[Z] {

	/**
	 * Run at most n tasks in the associated task bag. Return true
     * if in fact n items were processed.
	 */
	 abstract public def runAtMostNTasks(n:Long):Boolean;
	 
	 /**
	  * Return the reducer of type Z associated with this job.
	  */
	 abstract public def getReducer():Reducible[Z];
	 /**
	  * Return the result accumulated so far for all executed tasks.
	  */
	 abstract public def getResult():Z;
	 
	 /**
	  * Perform initialization. Called when the TaskFrame is first created.
	  * If the computation is supposed to be initiated with a root task, then
	  * the programmer should arrange matters so that the root task is added 
	  * to the task bag at a single place (usually place zero). If the computation
	  * can start with many tasks executing simultaneously, then initTask() may
	  * initialize non-empt task bags at more than one (perhaps all) places.
	  */
	 abstract public def initTask():void; // init the task, only the first task frame should do this (aka root task)
	 
	 /**
	  * Return the underlying task bag.
	  */
	 abstract public def getTaskBag():TaskBag;
	 
	 public def printLog():void{
		 //do nothing, override it to print out the logs that you want
	 }
}
