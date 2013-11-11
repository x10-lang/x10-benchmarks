package glb;

/**
 * A bag (multiset) of tasks. This is implemented by a user of the 
 * GLB library.
 * 
 * <p> A simple implementation of this interface is provided by 
 * ArrayListTaskBag. It uses an ArrayList as the backing data structure
 * for the bag. 
 * 
 */
public interface TaskBag {
	
    /**
     * Merge tb into the current task bag (this), thus 
     * changing the state of this.
     */
	public def merge(tb: TaskBag):void; 
	
	/**
	 * Split the current task bag (this), returning a portion, and retaining
	 * the remainder (thus changing the state of this). Return null
	 * if the bag is too small to split.
	 */
	public def split():TaskBag;  
	
	/**
	 * Return the size of the bag.
	 */
	public def size():Long; 
	
	//public def breakEven(chunkNum:Int):Rail[TaskBag]; // TODO this might be a better interface
	
}
