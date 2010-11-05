import x10.util.HashMap;

/*
 * A class that represents an AdjacencyList. Note that this is a simple class 
 * and hardcodes vertices to be numbered from 0 through N-1.
 */
public final class AdjacencyGraph  {
  private val N:Int; // number of vertices
  private var M:Int; // number of edges
  private val adjacencyList:Rail[HashMap[Int, ULong]];
  private val inDegreeMap:Rail[Int];

  /** 
    * Two gigantic rails that we are using to hold all the edges --- we are 
    * moving to this representation to save some object creation overhead 
    */
  /** The edgelist of a vertex is stored as offsetMap[i] to offsetmap[i+1] */
  private val offsetMap:Rail[Int];

  /** This just contains a series of edges that are indexed by offsetMap */
  public var adjacencyMap:Rail[AdjacencyNode];

  /**
   * Constructor: prepare all the data structures.
   */
  public def this (N:Int) { 
    this.N = N;
    this.M = 0;
    this.adjacencyList = 
     Rail.make[HashMap[Int, ULong]] (N, (Int)=> new HashMap[Int, ULong]());
    this.inDegreeMap = Rail.make[Int] (N, (Int) => 0);
    this.offsetMap = Rail.make[Int](N+1);
  }

  /**
   * Create the compressed representation. To be called only after all the 
   * edges have been added to the vertex list. All we are doing here is 
   * iterating over all the edges over all the vertices and populating the 
   * offsetMap and the adjacencyMap.
   */
  public def compressGraph () { 
    // Create as many elements as edges.
    this.adjacencyMap = Rail.make[AdjacencyNode](this.M);

    // Start copying over from the first vertex onwards.
    var currentOffset:Int = 0;
    for ([v] in 0..this.N-1) {
      // Put in the starting offset for this vertex.
      this.offsetMap(v) = currentOffset;
      
      // Iterate over all the edges.
      for (w in this.getNeighbors(v).keySet()) {
        this.adjacencyMap(currentOffset) = 
            AdjacencyNode (w, this.getEdgeWeight(v,w));
        ++currentOffset;
      }
    }

    // assert that we have included every edge.
    assert (currentOffset==this.M);

    // set the offset of the sentinel
    this.offsetMap(N) = currentOffset;
  }

  /**
   * Get the starting index for my neighbors.
   */
  public def begin(v:Int) {
    assert (v<this.N);
    return this.offsetMap(v);
  }

  /**
   * Get the last index for my neighbors.
   */
  public def end (v:Int) { 
    assert (v<this.N);
    return this.offsetMap(v+1);
  }

  /**
   * Get the adjacency node for a given index.
   */
  public def getAdjancencyNode (index:Int) {
    assert (index<this.M);
    return this.adjacencyMap(index);
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
   * Return the number of vertices in the graph.
   */
  public def numEdges () = this.M;

  /**
   * Add to the inDegree of a vertex.
   */
  public def incrementInDegree (v:Int) { 
    ++this.inDegreeMap(v); 
    ++this.M; 
  }

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
