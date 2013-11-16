package glb;

public interface TaskQueue {
    public def process(n:Long):Boolean;

    public def split():TaskBag;

    public def merge(TaskBag):void;

    public def count():Long;
}
