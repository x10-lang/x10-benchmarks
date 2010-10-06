import x10.util.Random;
import x10.util.HashMap;
import x10.util.GrowableRail;
import x10.lang.Math;

public final class Rmat {
  private val seed:Long;
  private val n:Int;
  private val a:Double;
  private val b:Double;
  private val c:Double;
  private val d:Double;
  
  public def this (seed:Long,
                   n:Int,
                   a:Double,
                   b:Double,
                   c:Double,
                   d:Double) {
    this.seed = seed;
    this.n = n;
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }

  private final def ones (numElements:Int):ValRail[Int] =
                               ValRail.make[Int] (numElements, (Int)=>1);

  private final def rand (rng:Random, numElements:Int) =
                 ValRail.make[Double] (numElements, (Int)=>rng.nextDouble());

  private final def makeRail (lhs:ValRail[Double], rhs:Double) =
    ValRail.make[Int] (lhs.length(), (i:Int)=>(lhs(i) > rhs) ? 1 : 0);

  private final def makeRail (lhs:ValRail[Double], 
                              rhs:ValRail[Double]) =
    ValRail.make[Int] (lhs.length(), (i:Int)=>(lhs(i) > rhs(i)) ? 1 : 0);

  private final def multiply (lhs:ValRail[Int], 
                              multiplier:Double, 
                              flip:Boolean) =
    ValRail.make[Double] 
      (lhs.length(), (i:Int)=>(lhs(i) as Double)*
                              ((flip)?(multiplier-1):multiplier));

  private final def multiply (lhs:ValRail[Int], 
                              multiplier:Int) =
    ValRail.make[Int] (lhs.length(), (i:Int)=>lhs(i)*multiplier);

  private final def add (lhs:ValRail[Double], 
                         rhs:ValRail[Double]): ValRail[Double] = 
    ValRail.make[Double] (lhs.length(), (i:Int)=>lhs(i)+rhs(i));

  private final def add (lhs:ValRail[Int], 
                         rhs:ValRail[Int]): ValRail[Int] = 
    ValRail.make[Int] (lhs.length(), (i:Int)=>lhs(i)+rhs(i));

  public def generate () : HashMap[Long, GrowableRail[Edge]] {
    // Initialize N, M, and rng
    val N = Math.pow (2.0, n) as Int;
    val M = 8*N;
    val rng = new Random(this.seed);

    // Create index arrays
    var ii:ValRail[Int] = this.ones(M);
    var jj:ValRail[Int] = this.ones(M);

    // Loop over each order of bit
    val ab = a+b;
    val cNorm = c / (c+d);
    val aNorm = a / (a+b);

    for (var ib:Int=0; ib<this.n; ++ib) {
      val iiBit = this.makeRail (this.rand (rng, M), ab);
      val jjBitComparator = this.add (this.multiply (iiBit, cNorm, false),
                                      this.multiply (iiBit, aNorm, true));
      val jjBit = this.makeRail (this.rand (rng, M), jjBitComparator);
      val exponent = Math.pow (2, ib) as Int;
      ii = this.add (ii, this.multiply (iiBit, exponent));
      jj = this.add (jj, this.multiply (jjBit, exponent));
    }
    
    throw new NullPointerException();
  }
}
