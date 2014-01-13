package glb;

public class Context[Queue]{Queue<:TaskQueue[Queue]}{
	/**
	 * Merged in on Jan 8, 2014 to support yield point
	 */
	var st:PlaceLocalHandle[Worker[Queue]]{Queue<:TaskQueue[Queue]};
	
	public def this(st:PlaceLocalHandle[Worker[Queue]]){Queue<:TaskQueue[Queue]}{
		this.st = st;
	}
	
	public def yield():void{
		this.st().getYieldPoint()(this.st); 
	}
	
}