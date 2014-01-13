package glb;

public interface TaskQueue[Queue]{
	public abstract def process(n:Long, context:Context[Queue]){Queue<:TaskQueue[Queue]}:Boolean;
	
	public abstract def split():TaskBag;
	
	public abstract def merge(TaskBag):void;
	
	public abstract def count():Long;
	
	
	
}
