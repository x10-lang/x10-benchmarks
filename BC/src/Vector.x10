public struct Vector[T](size:Int) implements (Int)=> T {
	public static type Vector[T](l:Int)= Vector[T]{self.size==l};
	val rail:Rail[T]; 
	def this(r:Rail[T]) {
		property(r.length);
		this.rail=r;
	}
	public def apply(i:Int):T=rail(i);
	public static def make[T](n:Int, init:(Int)=>T) {
		return Vector(Rail.make(n,init));
	}
	public static def make[T](n:Int, init:T) {
		return Vector(Rail.make(n,init));
	}
	public static operator (left:Vector[Int]) * (right:Vector[Int](left.size))
	:Vector[Int](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)*right(i)));
	public static operator (left:Vector[Int]) * (right:Int)
	:Vector[Int](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)*right));
	public static operator (left:Vector[Int]) + (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)+right(i)));
	public static operator (left:Vector[Int]) - (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)-right(i)));
	public static operator (left:Vector[Int]) > (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) > right(i) ? 1 :0));
	public static operator (left:Vector[Int]) > (right:Int) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) > right ? 1 :0));
	public static operator (left:Vector[Int]) >= (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) >= right(i) ? 1 :0));
	public static operator (left:Vector[Int]) < (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make[Int](left.size, (i:Int)=> left(i) < right(i) ? 1 :0));
	public static operator (left:Vector[Int]) <= (right:Vector[Int](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) <= right(i) ? 1 :0));
	
	public static operator (left:Vector[Double]) * (right:Vector[Double](left.size))
	:Vector[Double](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)*right(i)));
	public static operator (left:Vector[Double]) * (right:Double)
	:Vector[Double](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)*right));
	public static operator (left:Vector[Double]) + (right:Vector[Double](left.size)) 
	:Vector[Double](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)+right(i)));
	public static operator (left:Vector[Double]) - (right:Vector[Double](left.size)) 
	:Vector[Double](left.size) =
		Vector(Rail.make(left.size, (i:Int)=> left(i)-right(i)));
	public static operator (left:Vector[Double]) > (right:Vector[Double](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) > right(i) ? 1 :0));
	public static operator (left:Vector[Double]) > (right:Double) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) > right ? 1 :0));
	public static operator (left:Vector[Double]) >= (right:Vector[Double](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) >= right(i) ? 1 :0));
	public static operator (left:Vector[Double]) < (right:Vector[Double](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) < right(i) ? 1 :0));
	public static operator (left:Vector[Double]) <= (right:Vector[Double](left.size)) 
	:Vector[Int](left.size) = 
		Vector(Rail.make(left.size, (i:Int)=> left(i) <= right(i) ? 1 :0));
}