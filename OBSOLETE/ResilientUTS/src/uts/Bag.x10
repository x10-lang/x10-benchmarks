package uts;

class Bag {
  val hash:Rail[Byte];
  val depth:Rail[Int];
  val lower:Rail[Int];
  val upper:Rail[Int];
  var size:Int;

  def this(n:Int) {
    this.hash = new Rail[Byte](n * 20n + 4n); // slack for in-place SHA1 computation
    this.depth = new Rail[Int](n);
    this.lower = new Rail[Int](n);
    this.upper = new Rail[Int](n);
  }

  def split():Bag {
    var s : Int = 0n;
    for (var i:Int = 0n; i < size; ++i) {
      if ((upper(i) - lower(i)) >= 2n) {
        ++s;
      }
    }
    if (s == 0n) {
      return null;
    }
    val b:Bag = new Bag(s);
    for (var i:Int = 0n; i < size; ++i) {
      val p:Int = upper(i) - lower(i);
      if (p >= 2n) {
        Rail.copy(hash, i * 20, b.hash, b.size * 20, 20);
        b.depth(b.size) = depth(i);
        b.upper(b.size) = upper(i);
        upper(i) -= p / 2n;
        b.lower(b.size++) = upper(i);
      }
    }
    return b;
  }

  def merge(b:Bag):Bag {
	  var newSize:Int = depth.size as Int;
	  
	  // Not sure it needs to be a multiple of 2
	  while (size + b.size > newSize) {
		  newSize = newSize * 2n;
	  }

	  val newBag:Bag;
	  if(newSize == depth.size as Int) {
		  newBag = this;
	  } else {
		  newBag = new Bag(newSize);

		  Rail.copy(hash, 0, newBag.hash, 0, size * 20);
		  Rail.copy(depth, 0, newBag.depth, 0, size as Long);
		  Rail.copy(lower, 0, newBag.lower, 0, size as Long);
		  Rail.copy(upper, 0, newBag.upper, 0, size as Long);
		  newBag.size = size;
	  }

	  newBag.mergeUnsafe(b);
	  return newBag;
  }
  
  private def mergeUnsafe(b:Bag):void {
	  Rail.copy(b.hash, 0, hash, size * 20, b.size * 20);
	  Rail.copy(b.depth, 0, depth, size as Long, b.size as Long);
	  Rail.copy(b.lower, 0, lower, size as Long, b.size as Long);
	  Rail.copy(b.upper, 0, upper, size as Long, b.size as Long);
	  size += b.size;
  }
}
