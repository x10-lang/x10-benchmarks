package uts;

class Checkpoint {

	val bag:Bag;
	val count:long;

	def this(c:long) {
		this.bag = null;
		this.count = c;
	}

	def this(b:Bag, c:long) {
		if (b.size as Long == b.depth.size) {
			bag = b;
		} else {
			bag = new Bag(b.size);
			Rail.copy(b.hash, 0, bag.hash, 0, b.size * 20);
			Rail.copy(b.depth, 0, bag.depth, 0, b.size as Long);
			Rail.copy(b.lower, 0, bag.lower, 0, b.size as Long);
			Rail.copy(b.upper, 0, bag.upper, 0, b.size as Long);
			bag.size = b.size;
		}
		count = c;
	}
}