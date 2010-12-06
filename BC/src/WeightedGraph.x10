import x10.util.HashMap;

/*
 * A class that represents an AdjacencyList. Note that this is a simple class 
 * and hardcodes vertices to be numbered from 0 through N-1.
 */
public final class WeightedGraph extends AbstractWeightedCSRGraph {
  private val adjacencyList:Rail[HashMap[Int, Long]];
  private var edgeWeightMap:Rail[Long];

  /**
   * Constructor: prepare all the data structures.
   */
  public def this (N:Int) { 
    super(N);
    this.adjacencyList = 
     Rail.make[HashMap[Int, Long]] (N, (Int)=> new HashMap[Int, Long]());
  }

  /**
   * @Override
   * Create the compressed representation. To be called only after all the 
   * edges have been added to the vertex list. All we are doing here is 
   * iterating over all the edges over all the vertices and populating the 
   * offsetMap and the adjacencyMap.
   */
  public def compressGraph () { 
    // Create as many elements as edges.
    this.adjacencyMap = Rail.make[Int](this.M);
    this.edgeWeightMap = Rail.make[Long](this.M);

    // Start copying over from the first vertex onwards.
    var currentOffset:Int = 0;
    for ([v] in 0..this.N-1) {
      // Put in the starting offset for this vertex.
      this.offsetMap(v) = currentOffset;
      
      // Iterate over all the edges.
      for (w in this.adjacencyList(v).keySet()) {
        this.adjacencyMap(currentOffset) = w;
        this.edgeWeightMap(currentOffset) = this.getEdgeWeight(v,w);
        ++currentOffset;
      }
    }

    // assert that we have included every edge.
    assert (currentOffset==this.M);

    // set the offset of the sentinel
    this.offsetMap(N) = currentOffset;
  }

  /**
   * @Override
   * Check if an edge exists between a pair of vertices.
   */
  public def existsEdge (v:Int, w:Int) = this.adjacencyList(v).containsKey(w); 

  /**
   * @Override
   * Return the weight of the edge (if there is an edge). This function is 
   * called both during construction and after construction of the graph.
   */
  public def getEdgeWeight (v:Int, w:Int) =
    (this.existsEdge(v,w)) ? 
      this.adjacencyList(v).getOrElse(w, 0 as Long) : Long.MAX_VALUE;

  /**
   * @Override
   * This function can only be called after compression.
   * TODO: Add a check for compression.
   */
  public def getEdgeWeightFromIndex(wIndex:Int): Long {
    return this.edgeWeightMap(wIndex);
  }

  /**
   * @Override
   * Add an edge with a given weight. We do not check if the edge exists!
   * If an edge exists, its overwritten.
   */
  public def addEdge (v:Int, w:Int, d:Long): Void {
    this.adjacencyList(v).put (w, d);
  }

  /**
   * @Override
   * Print out the graph as a string
   */
  public def toString (): String {
    var outString:String = "";

    for ([v] in 0..N-1) {
      val neighbors = this.adjacencyList (v);

      for (w in neighbors.keySet()) {
        val d = this.getEdgeWeight (v, w);
        outString += "(" + v + ", " + w + ")" + " => " + d + "\n";
      }
    }

    return outString;
  }
}
