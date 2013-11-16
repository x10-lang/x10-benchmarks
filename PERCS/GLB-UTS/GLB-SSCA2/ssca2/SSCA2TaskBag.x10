package ssca2;
import core.TaskBag;
import x10.compiler.Ifdef;
import x10.compiler.Inline;
public class SSCA2TaskBag implements TaskBag[SSCA2TaskItem]{
	
	public var data:Rail[SSCA2TaskItem];
	public var head:Int = 0n;
	public var tail:Int = 0n;
	
	public var size:Int = 0N; // note size not necessarily the same as data.size, but it should be always the same as tail-head+1, except when tail==head==0==size
	
	public var splitThreashold:Int = 10n;// subject to change
	
	public def this(splitThreashold:Int){
		this.splitThreashold = splitThreashold;
	}
	
	public def this(data:Rail[SSCA2TaskItem], splitThreashold:Int){
		this(splitThreashold);
		this.data = data;
		this.size = data.size as Int;
		this.head = 0n;
		this.tail = (this.size -1n) as Int;
	}
	
	// public def this(size:Int, splitThreashold:Int){
	// 	this(splitThreashold);
	// 	this.size = size; // just a place holder, don't d
	// 	// this.data = new Rail[SSCA2TaskItem](size);
	// 	// this.head = 0n;
	// 	// this.tail = (this.size -1n) as Int;
	// }
	
	/**
	 * vertices number : 1<<n;
	 * interval is how many vertices we place into a taskitem
	 * set to be public for testing purpose only
	 */
	public def init(verticesNumber:Int, interval:Int){
		assert(verticesNumber % interval == 0n);
		this.size = verticesNumber / interval;
		this.data = new Rail[SSCA2TaskItem](size, (i:Long)=>new SSCA2TaskItem( (i*interval) as Int,(((i+1)*interval)-1n) as Int));
		this.head = 0n;
		this.tail = (this.size -1n) as Int;
	}
	
	/**
	 * return null if not worth spliting,
	 * otherwise return last half of data.
	 */
	@Inline public def split():TaskBag[SSCA2TaskItem] {
		if(this.size/2 < this.splitThreashold){
			return null;
		}
		numElems:Long = this.size - this.size/2; // # of task items passed to the split bag
		dstData:Rail[SSCA2TaskItem] = new Rail[SSCA2TaskItem](numElems); // split bag data
		Rail.copy(this.data,this.tail-numElems+1n ,dstData, 0L, numElems);
		this.size = this.size /2n;
		this.tail = this.tail - numElems as Int;
		// @Ifdef("LOG"){
		// 	Console.OUT.println("size:"+this.size+" head:"+this.head+" tail:"+this.tail);
		// 	assert(this.size == this.tail-this.head +1n);
		// }
		// at most will waste log(N)*Interval*sizeof(initial taskbag) memory, probably not a big deal to not to delete the other half
		return new SSCA2TaskBag(dstData, this.splitThreashold);
	}
	
	@Inline public def merge(var tb:TaskBag[SSCA2TaskItem]):void {
		if(this.size==0n){
			this.data = (tb as SSCA2TaskBag).data;
			this.size = this.data.size as Int;
			this.head = 0n;
			this.tail = (this.size - 1n) as Int;
			
		}else{
			val mergeAfterSize:Int = this.size+(tb as SSCA2TaskBag).data.size as Int;
			val tmpData = new Rail[SSCA2TaskItem](mergeAfterSize);
			assert(this.size == this.tail-this.head +1n);
			Rail.copy(this.data, this.head as Long, tmpData, 0L, this.size as Long);// copy original data
			Rail.copy((tb as SSCA2TaskBag).data, 0L, tmpData, this.size as Long, (tb as SSCA2TaskBag).data.size);
			this.size = mergeAfterSize;
			this.tail = this.size - 1n;
			this.head = 0n;
			this.data = tmpData;
		}
		// TODO: auto-generated method stub
	}
	
	
	@Inline public def size():Long {
		// TODO: auto-generated method stub
		return this.size;
	}
	
	/**
	 * Below are helper methods
	 * set public for testing purpose only
	 */
	@Inline public  def pop():SSCA2TaskItem{
		//assert(this.size > 0);
		result:SSCA2TaskItem = this.data(head);
		this.head+=1n;
		this.size--;
		// @Ifdef("LOG"){
		// 	Console.OUT.println("head: "+head + " tail: " + tail + " sise: " + size);
		// }
		//assert(this.size == this.tail-this.head +1n);
		return result;
	}
	
	
	
}