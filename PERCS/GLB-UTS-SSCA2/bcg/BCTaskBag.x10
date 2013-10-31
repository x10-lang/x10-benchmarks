package bcg;
import x10.compiler.Ifdef;
import x10.compiler.Inline;

import glb.TaskBag;

public class BCTaskBag implements TaskBag {
	
	/*backing data storage*/
	public var data:Rail[BCTaskItem];
	public var head:Int = 0n;
	public var tail:Int = 0n;	
	public var size:Int = 0N; // note size not necessarily the same as data.size, but it should be always the same as tail-head+1, except when tail==head==0==size
	
	/* split threshold, when resulting split bag is smaller than this, choose not not split, tunnable*/
	public var splitThreashold:Int = 10n;
	
	/**
	 * Constructor 
	 * @param splitThreshold split threshold
	 */
	public def this(splitThreashold:Int){
		this.splitThreashold = splitThreashold;
	}
	
	public def this(data:Rail[BCTaskItem], splitThreashold:Int){
		this(splitThreashold);
		this.data = data;
		this.size = data.size as Int;
		this.head = 0n;
		this.tail = (this.size -1n) as Int;
	}
	
	
	
	/**
	 * vertices number : 1<<n;
	 * interval is how many vertices we place into a taskitem
	 * set to be public for testing purpose only
	 */
	public def init(verticesNumber:Int, interval:Int){
		assert(verticesNumber % interval == 0n);
		this.size = verticesNumber / interval;
		this.data = new Rail[BCTaskItem](size, (i:Long)=>new BCTaskItem( (i*interval) as Int,(((i+1)*interval)-1n) as Int));
		this.head = 0n;
		this.tail = (this.size -1n) as Int;
	}
	
	/**
	 * return null if not worth spliting,
	 * otherwise return last half of data.
	 */
	@Inline public def split():BCTaskBag {
		if(this.size/2 < this.splitThreashold)return null;
		numElems:Long = this.size - this.size/2; // # of task items passed to the split bag
		val dstData = new Rail[BCTaskItem](numElems); // split bag data
		Rail.copy(this.data,this.tail-numElems+1n ,dstData, 0L, numElems);
		this.size = this.size /2n;
		this.tail = this.tail - numElems as Int;
	
		// at most will waste log(N)*Interval*sizeof(initial taskbag) memory,
		//probably not a big deal to not to delete the other half
		return new BCTaskBag(dstData, this.splitThreashold);
	}
	
	@Inline public def merge(var tb:TaskBag):void {
		if(this.size==0n){
			this.data = (tb as BCTaskBag).data;
			this.size = this.data.size as Int;
			this.head = 0n;
			this.tail = (this.size - 1n) as Int;
			
		}else{
			val mergeAfterSize:Int = this.size+(tb as BCTaskBag).data.size as Int;
			val tmpData = new Rail[BCTaskItem](mergeAfterSize);
			assert(this.size == this.tail-this.head +1n);
			Rail.copy(this.data, this.head as Long, tmpData, 0L, this.size as Long);// copy original data
			Rail.copy((tb as BCTaskBag).data, 0L, tmpData, this.size as Long, (tb as BCTaskBag).data.size);
			this.size = mergeAfterSize;
			this.tail = this.size - 1n;
			this.head = 0n;
			this.data = tmpData;
		}
		
	}
	
	
    @Inline public def size():Long =size;
	
	/**
	 * Below are helper methods
	 * set public for testing purpose only
	 */
	@Inline protected  def pop():BCTaskItem{
		result:BCTaskItem = this.data(head);
		this.head+=1n;
		this.size--;
		return result;
	}
}
