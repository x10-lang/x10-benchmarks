package glb;

public interface TaskQueue[Queue]{
	public abstract def process(n:Long, context:Context[Queue]){Queue<:TaskQueue[Queue]}:Boolean;
	
	public abstract def split():TaskBag;
	
	public abstract def merge(TaskBag):void;
	
	public abstract def count():Long;
	
	public abstract def getResult():GLBResult;
	
	/**
	 * Auxiliary function that user can overwrite to print the statistics one cares about,
	 * e.g., computation time. This function will be called only after all the calculation
	 * and results reduction are done.
	 */
	public abstract def printLog():void;
	
}
