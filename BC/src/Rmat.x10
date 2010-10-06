import x10.util.Random;
import x10.util.HashMap;
import x10.util.ArrayList;
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

  private final def ones (numElements:Int):Rail[Int] =
                               Rail.make[Int] (numElements as Int, (Int)=>1);

  private final def rand (rng:Random, numElements:Int) =
                 Rail.make[Double] (numElements as Int, 
                                       (Int)=>rng.nextDouble());

  private final def greaterThan (lhs:Rail[Double], rhs:Double) =
    Rail.make[Int] (lhs.length(), (i:Int)=>(lhs(i) > rhs) ? 1 : 0);

  private final def greaterThan (lhs:Rail[Double], rhs:Rail[Double]) =
    Rail.make[Int] (lhs.length(), (i:Int)=>(lhs(i) > rhs(i)) ? 1 : 0);

  private final def multiply (lhs:Rail[Int], multiplier:Double, flip:Boolean) =
    Rail.make[Double] 
      (lhs.length(), (i:Int)=>(lhs(i) as Double)*
                              ((flip)?(multiplier-1):multiplier));

  private final def multiply (lhs:Rail[Int], multiplier:Int) =
    Rail.make[Int] (lhs.length(), (i:Int)=>lhs(i)*multiplier);

  private final def add (lhs:Rail[Double], rhs:Rail[Double]) = 
    Rail.make[Double] (lhs.length(), (i:Int)=>lhs(i)+rhs(i));

  private final def add (lhs:Rail[Int], rhs:Rail[Int]) =
    Rail.make[Int] (lhs.length(), (i:Int)=>lhs(i)+rhs(i));


  private final def printAdjacencyList 
                  (adjacencyList:HashMap[Int, HashMap[Int, Int]]) {

    for (sourceVertex in adjacencyList.keySet()) {
      val sourceAdjacencies = 
                (adjacencyList.get (sourceVertex)).value();

      for (destVertex in sourceAdjacencies.keySet()) {
        val edgeWeight = sourceAdjacencies.get (destVertex).value();
        Console.OUT.println ("(" + sourceVertex +
                              ", " + destVertex + ")" +
                              " => " + edgeWeight);
      }
    }
  }


  private final def makeAdjacencyList (row:Rail[Int],
                                       col:Rail[Int]) {
    val adjacencyList = new HashMap [Int, HashMap[Int, Int]]();
    val numElements = row.length(); 

    for (var i:Int=0; i<numElements; ++i) {
      val sourceVertex = row(i);
      val destVertex = col(i);

      if (!adjacencyList.containsKey (sourceVertex)) {
        adjacencyList.put (sourceVertex, new HashMap[Int, Int]());
      }

      val sourceAdjacencies = 
                (adjacencyList.get (sourceVertex)).value();

      if (sourceAdjacencies.containsKey (destVertex)) {
        sourceAdjacencies.put (destVertex, 
                               ((sourceAdjacencies.get (destVertex)).value())+1);
      } else {
        sourceAdjacencies.put (destVertex, 1);
      }
    }

    printAdjacencyList (adjacencyList);

    return adjacencyList;
  }

  public def generate () {
    // Initialize N, M, and rng
    val N = Math.pow (2.0, n) as Int;
    val M = 8*N;
    val rng = new Random(this.seed);

    // Create index arrays
    var ii:Rail[Int] = this.ones(M);
    var jj:Rail[Int] = this.ones(M);

    // Loop over each order of bit
    val ab = a+b;
    val cNorm = c / (c+d);
    val aNorm = a / (a+b);

    for (var ib:Int=0; ib<this.n; ++ib) {
      val iiBit = this.greaterThan (this.rand (rng, M), ab);
      val jjBitComparator = this.add (this.multiply (iiBit, cNorm, false),
                                      this.multiply (iiBit, aNorm, true));
      val jjBit = this.greaterThan (this.rand (rng, M), jjBitComparator);
      val exponent = Math.pow (2, ib) as Int;
      ii = this.add (ii, this.multiply (iiBit, exponent));
      jj = this.add (jj, this.multiply (jjBit, exponent));
    }

    Console.OUT.println (ii);
    Console.OUT.println (jj);
    
    return this.makeAdjacencyList (ii, jj);
  }
}
