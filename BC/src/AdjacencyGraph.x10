import x10.util.HashMap;

public final struct AdjacencyGraph [VertexType] {
  private val N:Int;
  private val adjacencyList:HashMap[VertexType, 
                                    HashMap[VertexType, Int]];

  /**
   * Constructor: prepare all the data structures.
   */
  public def this (N:Int) { 
    this.N = N;
    this.adjacencyList = new HashMap[VertexType, 
                                     HashMap[VertexType, Int]] ();
    
    // Set up each distance map
    for (var i:Int=0; i<N; ++i) {
      this.adjacencyList.put (i as VertexType, 
                              new HashMap[VertexType, Int] ());
    }
  }

  /**
   * Return the neighbors of a particular vertex.
   */
  public def getNeighbors (v:VertexType) = this.adjacencyList.get(v).value();

  /**
   * Check if an edge exists between a pair of vertices.
   */
  public def existsEdge (v:VertexType, w:VertexType) = 
    this.getNeighbors(v).containsKey(w); 

  /**
   *  Return the weight of the edge (if there is an edge).
   */
  public def getEdgeWeight (v:VertexType, w:VertexType) =
    (this.existsEdge(v,w)) ? this.getNeighbors(v).get(w).value() : Int.MIN_VALUE;

  /**
   * Add an edge with a given weight. We do not check if the edge exists!
   * If an edge exists, its overwritten.
   */
  public def addEdge (v:VertexType, w:VertexType, d:Int) =
    this.getNeighbors(v).put (w, d);

  /**
   * Return the number of vertices in the graph.
   */
  public def numVertices () = this.N;

  public def toString () {
    var outString:String = "";

    for (v in this.adjacencyList.keySet()) {
      val neighbors = this.getNeighbors (v);

      for (w in neighbors.keySet()) {
        val d = this.getEdgeWeight (v, w);
        outString += "(" + v + ", " + w + ")" + " => " + d + "\n";
      }
    }

    return outString;
  }
}
