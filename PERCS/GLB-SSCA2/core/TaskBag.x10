package core;

public interface TaskBag[T] {
	
	public def merge(tb: TaskBag[T]):void; // merge a taskbag with itself it is a shame that i cant specify
	                                       // {self!=null} here
	public def split():TaskBag[T]; // split a task bag, the contract is if it returns null it means it 
	                              // is not  worth splitting
	
	public def size():Long; // return the size of the task bag
	
}