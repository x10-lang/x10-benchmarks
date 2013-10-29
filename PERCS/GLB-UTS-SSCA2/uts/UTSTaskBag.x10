package uts;

import x10.compiler.Ifdef;

import glb.TaskBag;

public class UTSTaskBag implements TaskBag{
	public val queue:UTSTree;
	var branchFactor:Int; // not sure if this is really needed or not yet
	public def this(b:Int){
		this.branchFactor = b;
		this.queue = new UTSTree(b);
	}
	
	public def this(tree:UTSTree){queue = tree;}
	
	/**
	 * specific to this UTSTaskBag
	 */
	public def initTree(seed:Int, d:Int){queue.init(seed, d);}
	
	public def split():UTSTaskBag {
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
		
		return new UTSTaskBag(sentoutTree);
		
	}
	public def merge(var tbb:TaskBag):void {
		val tb:UTSTaskBag= tbb as UTSTaskBag; 
		val tbqueue:UTSTree = tb.queue;
		//val h = tbqueue.hash.size; // incoming taskbag size This was a BUG
		val h = tbqueue.size; // incoming taskbag size, originally it was tbqueue.hash.size
		val q = queue.size; // my own size
		while (h + q > queue.hash.size) queue.grow(); // if more than i can accept once, i grow
		Rail.copy(tbqueue.hash, 0, queue.hash, q, h); // src srcidx, dest, destidx, #
		Rail.copy(tbqueue.lower, 0, queue.lower, q, h);
		Rail.copy(tbqueue.upper, 0, queue.upper, q, h);
		queue.size += h;
		
	}
	public def size():Long=queue.size;
	
	/**
	 * another layer to call ustree.expand
	 */
	protected def expand():void{queue.expand();}
	
	/**
	 * another layer increment the queue.count, to do the actual work
	 */
	protected def incByI(i:Long):void{queue.count += i;}
	
	/**
	 * another layer to get the queue.count, so that collector can collect and compute
	 */
	protected def getCount():Long=queue.count;
	public def equals(_bag:UTSTaskBag):Boolean=queue.equals(_bag.queue);
	
}
