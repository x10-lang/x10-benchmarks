package myuts;
import core.TaskBag;
import x10.compiler.Ifdef;
public class UTSTaskBag[UTSTreeNode] implements TaskBag[UTSTreeNode]{
	public val queue:UTSTree;
	
	var branchFactor:Int; // not sure if this is really needed or not yet
	
	public def this(b:Int){
		this.branchFactor = b;
		this.queue = new UTSTree(b);
	}
	
	public def this(tree:UTSTree){
		this.queue = tree;
	}
	
	/**
	 * specific to this UTSTaskBag
	 */
	public def initTree(seed:Int, d:Int){
		this.queue.init(seed, d);
	}
	
	
	public def split():TaskBag[UTSTreeNode] {
		
		var s:Long = 0;
		for (var i:Long=0; i<queue.size; ++i) {
			if ((queue.upper(i) - queue.lower(i)) >= 2) ++s;
		}
		if (s == 0) return null;
		val fragment = new Fragment(s);
		s = 0;
		for (var i:Long=0; i<queue.size; ++i) {
			val p = queue.upper(i) - queue.lower(i);
			if (p >= 2n) {
				fragment.hash(s) = queue.hash(i);
				fragment.upper(s) = queue.upper(i);
				queue.upper(i) -= p/2n; // my own tree is split
				fragment.lower(s++) = queue.upper(i);
			}
		}
		
		// we now create a new empty tree and use this fragment to grow the queue
		val sentoutTree:UTSTree = new UTSTree(queue.factor);
		fragment.pushWA(sentoutTree);
		
		return new UTSTaskBag[UTSTreeNode](sentoutTree);
		
	}
	
	// original code
	// public def merge(var tbb:TaskBag[UTSTreeNode]):void {
	// 	    val tb:UTSTaskBag[UTSTreeNode] = tbb as UTSTaskBag[UTSTreeNode]; // Question: Wei is there a better way to do this?
	//         val tbqueue:UTSTree = tb.queue;
	// 		val h = tbqueue.hash.size; // incoming taskbag size
	// 		val q = queue.size; // my own size
	// 		while (h + q > queue.hash.size) queue.grow(); // if more than i can accept once, i grow
	// 		Rail.copy(tbqueue.hash, 0, queue.hash, q, h); // src srcidx, dest, destidx, #
	// 		Rail.copy(tbqueue.lower, 0, queue.lower, q, h);
	// 		Rail.copy(tbqueue.upper, 0, queue.upper, q, h);
	// 		queue.size += h;
	// 	
	// }
	
	public def merge(var tbb:TaskBag[UTSTreeNode]):void {
		val tb:UTSTaskBag[UTSTreeNode] = tbb as UTSTaskBag[UTSTreeNode]; // Question: Wei is there a better way to do this?
		val tbqueue:UTSTree = tb.queue;
		val h = tbqueue.size; // incoming taskbag size BUG, originally it was tbqueue.hash.size
		val q = queue.size; // my own size
		while (h + q > queue.hash.size) queue.grow(); // if more than i can accept once, i grow
		Rail.copy(tbqueue.hash, 0, queue.hash, q, h); // src srcidx, dest, destidx, #
		Rail.copy(tbqueue.lower, 0, queue.lower, q, h);
		Rail.copy(tbqueue.upper, 0, queue.upper, q, h);
		queue.size += h;
		
	}
	
	
	
	
	public def size():Long{
		return this.queue.size;
	}
	
	/**
	 * another layer to call ustree.expand
	 */
	protected def expand():void{
		this.queue.expand();
	}
	
	/**
	 * another layer increment the queue.count, to do the actual work
	 */
	protected def incByI(i:Long):void{
		this.queue.count += i;
	}
	
	/**
	 * another layer to get the queue.count, so that collector can collect and compute
	 */
	protected def getCount():Long{
		return this.queue.count;
	}
	
	
}