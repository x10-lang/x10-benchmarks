import x10.util.HashMap;

/*
 * A class that represents an AdjacencyList. Note that this is a simple class 
 * and hardcodes vertices to be numbered from 0 through N-1.
 */
public final struct AdjacencyGraph  {
  private val N:Int;
  private val adjacencyList:Rail[HashMap[Int, ULong]];
  private val inDegreeMap:Rail[Int];

  /**
   * Constructor: prepare all the data structures.
   */
  public def this (N:Int) { 
    this.N = N;
    this.adjacencyList = 
     Rail.make[HashMap[Int, ULong]] (N, (Int)=> new HashMap[Int, ULong]());
    this.inDegreeMap = Rail.make[Int] (N, (Int) => 0);
  }

  /**
   * Return the neighbors of a particular vertex.
   */
  public def getNeighbors (v:Int) = this.adjacencyList(v);

  /**
   * Check if an edge exists between a pair of vertices.
   */
  public def existsEdge (v:Int, w:Int) = this.getNeighbors(v).containsKey(w); 

  /**
   *  Return the weight of the edge (if there is an edge).
   */
  public def getEdgeWeight (v:Int, w:Int) =
    (this.existsEdge(v,w)) ? 
      this.getNeighbors(v).getOrElse(w, 0 as ULong) : ULong.MAX_VALUE;

  /**
   * Add an edge with a given weight. We do not check if the edge exists!
   * If an edge exists, its overwritten.
   */
  public def addEdge (v:Int, w:Int, d:ULong) = this.getNeighbors(v).put (w, d);

  /**
   * Return the number of vertices in the graph.
   */
  public def numVertices () = this.N;

  /**
   * Add to the inDegree of a vertex.
   */
  public def incrementInDegree (v:Int) { ++this.inDegreeMap(v); }

  /**
   * Get a vertex's inDegree.
   */
  public def getInDegree (v:Int) { return this.inDegreeMap(v); }

  public def toString () {
    var outString:String = "";

    for ([v] in 0..N-1) {
      val neighbors = this.getNeighbors (v);

      for (w in neighbors.keySet()) {
        val d = this.getEdgeWeight (v, w);
        outString += "(" + v + ", " + w + ")" + " => " + d + "\n";
      }
    }

    return outString;
  }
}
