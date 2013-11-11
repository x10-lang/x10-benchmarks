package uts;

public class UTSTaskBag implements glb.TaskBag{
	public val tree:UTSTree;
	var branchFactor:Int; 
	
	/**
	 * Constructor
	 * @param b braching factor
	 */
	public def this(b:Int){
		this.branchFactor = b;
		this.tree = new UTSTree(b);
	}
	
	/**
	 * Constructor
	 * @param tree tree that holds data
	 */
	public def this(tree:UTSTree){this.tree = tree;}
	
	/**
	 * specific to this UTSTaskBag
	 */
	protected def initBag(seed:Int, d:Int){tree.init(seed, d);}
	
	/**
	 * Split a task bag
	 * @return null when each node has only one child to traverse
	 *         Otherwise, split each node to half and return
	 */
	public def split():UTSTaskBag {
		var s:Long = 0;
		for (i in 0..(tree.size-1)) {
			if ((tree.upper(i) - tree.lower(i)) >= 2) ++s;
		}
		if (s == 0) return null;
		val fragment = new Fragment(s);
		s = 0;
		for (i in 0..(tree.size-1)) {
			val p = tree.upper(i) - tree.lower(i);
			if (p >= 2n) {
				fragment.hash(s) = tree.hash(i);
				fragment.upper(s) = tree.upper(i);
				tree.upper(i) -= p/2n; // my own tree is split
				fragment.lower(s++) = tree.upper(i);
			}
		}
		
		// we now create a new empty tree and use this fragment to grow the queue
		val sentoutTree:UTSTree = new UTSTree(tree.factor);
		fragment.push(sentoutTree);
		return new UTSTaskBag(sentoutTree);
	}
	
	/**
	 * @Override merge two taskbags(aka trees) together
	 */
	public def merge(tbb:glb.TaskBag):void {
		val tb:UTSTaskBag= tbb as UTSTaskBag; 
		val tbqueue:UTSTree = tb.tree;
		val h = tbqueue.size; 
		val q = tree.size; 
		while (h + q > tree.hash.size) tree.grow(); // if more than i can accept once, i grow
		Rail.copy(tbqueue.hash, 0, tree.hash, q, h);
		Rail.copy(tbqueue.lower, 0, tree.lower, q, h);
		Rail.copy(tbqueue.upper, 0, tree.upper, q, h);
		tree.size += h;
		
	}
	
	/**
	 * @override
	 */
	public def size():Long=tree.size;
	
	/**
	 * another layer to call ustree.expand
	 */
	protected def expand():void{tree.expand();}
	
	/**
	 * another layer increment the tree.count, to do the actual counting nodes
	 */
	protected def incByI(i:Long):void{tree.count += i;}
	
	/**
	 * another layer to get the tree.count, so that collector can collect and compute
	 */
	protected def getCount():Long=tree.count;
	
	/**
	 * This is not a naturally balanced workload, so shouldnt really need to implement anything
	 * on Nov 8, 2013
	 */
	public def breakEven(chunkNum:Int):Rail[glb.TaskBag]{
	    return null;
	}
	
	/**
	 * Helper class used to merge two trees together
	 */
	final class Fragment {
		val hash:Rail[SHA1Rand];
		val lower:Rail[Int];
		val upper:Rail[Int];
		
		def this(size:Long) {
			hash = new Rail[SHA1Rand](size);
			lower = new Rail[Int](size);
			upper = new Rail[Int](size);
		}
		
		
		def push(queue:UTSTree){ 
			val h = hash.size; // fragment's size
			val q = queue.size; // queue's size 
			while (h + q > queue.hash.size) queue.grow();
			Rail.copy(hash, 0, queue.hash, q, h); 
			Rail.copy(lower, 0, queue.lower, q, h);
			Rail.copy(upper, 0, queue.upper, q, h);
			queue.size += h;
			
		}
	}
	
	
	
	
	
	
	
	
}
