import x10.util.Random;

/**
 * A class that emulates the recursive-matrix graph from the paper:
 * "R-MAT: A Recursive Model for Graph Mining" by Chakrabarti et al.
 * 
 * This code is based on the MATLAB sample code that was given along 
 * with the SSCA2 benchmarks.
 * 
 * The R-MAT generator takes in 6 parameters as input (via the constructor).
 * The values passed to these arguments ultimately decide the shape and the 
 * properties of the graph. For a more detailed description of the parameters
 * and their influence, please refer to Chakrabarti et al.
 */
public struct Rmat {
	private val seed:Long; // seed to the random number generator
	private val n:Int; // the log of the number of verties. I.e., N = 2^n
	private val N:Int; // the number of vertices.
	private val a:Double; // The next 4 parameters determine the shape of 
	private val b:Double; // the graph. A detailed description of the 
	private val c:Double; // parameters is out of scope here. Briefly,
	private val d:Double; // (a+b+c+d == 1) and typically a>=b, a>= c, a>=d.

	public def this (seed:Long,
			n:Int,
			a:Double,
			b:Double,
			c:Double,
			d:Double) {
		this.seed = seed;
		this.n = n;
		this.N = 1<<n;
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	/**
	 *  A function that mimics the MATLAB function rand (M,1). It generates a 
	 *  vector of M random numbers. Here, numElements is M!
	 */
	private def rand(rng:Random, numElements:Int) =
		new Rail[Double](numElements, (Int)=>rng.nextDouble());

	/**
	 * A function that mimics the use of > operator in MATLAB when the LHS is 
	 * a vector and the RHS either a scalar value or a vector. Basically, the 
	 * result of "V > a", where "V" is a vector and "a" is a scalar is an 
	 * integer-valued vector where there is a 1 if "V[i] > a" and 0 otherwise.
	 */
	private def greaterThan(lhs:Rail[Double], rhs:Double) =
		new Rail[Int](lhs.size, (i:Int)=>(lhs(i) > rhs) ? 1 : 0);

	/**
	 * The same function as above, only with a element-wise comparison in the RHS
	 * instead of a comparison with a scalar value. So, there is a 1 in the 
	 * resultant vector if "LHS[i] > RHS[i]", and 0 otherwise.
	 */
	private def greaterThan(lhs:Rail[Double], rhs:Rail[Double]) =
		new Rail[Int](lhs.size, (i:Int)=>(lhs(i) > rhs(i)) ? 1 : 0);

	/**
	 * Multiple a vector with a scalar. There is, however, one catch. When the 
	 * flip bit is turned on, the vector (LHS) is manipulated such that its either 
	 * always 0 or 1. If V[i] > 0 and flip==true, then LHS(i) == 0, and 1 otherwise.
	 * In other words, we flip V[i].
	 */
	private def multiply(lhs:Rail[Int], multiplier:Double, flip:Boolean) =
		new Rail[Double](lhs.size, (i:Int)=>multiplier*(flip ? ((lhs(i) > 0) ? 0 : 1) : lhs(i)));

	/**
	 * A straightforward vector-scalar multiplication
	 */
	private def multiply(lhs:Rail[Int], multiplier:Int) =
		new Rail[Int](lhs.size, (i:Int)=>lhs(i)*multiplier);

	/**
	 * A straightforward addition of two vectors.
	 */
	private def add(lhs:Rail[Double], rhs:Rail[Double]) = 
		new Rail[Double](lhs.size, (i:Int)=>lhs(i)+rhs(i));

	/**
	 * Same as above, but with a different type
	 */
	private def add(lhs:Rail[Int], rhs:Rail[Int]) =
		new Rail[Int](lhs.size, (i:Int)=>lhs(i)+rhs(i));

	/**
	 * This function mimics the behavior of the MATLAB function sparse(i,j,s).
	 */
	private def sparse(row:Rail[Int], col:Rail[Int]):Graph {
		val adjacencyGraph:Graph = new Graph(N);
		for (var i:Int=0; i<row.size; ++i) adjacencyGraph.addEdge(row(i), col(i));
		return adjacencyGraph;
	}

	public def generate() {
		// Initialize M, and rng
		val M = 8*N;
		val rng = new Random(seed);

		// Create index arrays
		var ii:Rail[Int] = new Rail[Int](M);
		var jj:Rail[Int] = new Rail[Int](M);

		// Loop over each order of bit
		val ab = a+b;
		val cNorm = c/(c+d);
		val aNorm = a/(a+b);

		for (var ib:Int=0; ib<n; ++ib) {
			val iiBit = greaterThan(rand(rng, M), ab);
			val jjBitComparator = add(multiply(iiBit, cNorm, false), multiply(iiBit, aNorm, true));
			val jjBit = greaterThan(rand(rng, M), jjBitComparator);
			val exponent = 1<<ib;
			ii = add(ii, multiply(iiBit, exponent));
			jj = add(jj, multiply(jjBit, exponent));
		}

		return sparse(ii, jj);
	}
}
