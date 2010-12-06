/**
 * An abstract class  that provides all the functionality of a graph. This is
 * further specialized to provide either weighted or unweighted graphs.
 */
public abstract class AbstractCSRGraph {
  protected val N:Int; // number of vertices
  protected var M:Int; // number of edges
  protected val inDegreeMap:Rail[Int]; // in-degree for each vertex

  /** 
   * Two gigantic rails that we are using to hold all the edges --- we are 
   * moving to this representation to save some object creation overhead 
   */
  /** The edgelist of a vertex is stored as offsetMap[i] to offsetmap[i+1] */
  protected val offsetMap:Rail[Int];

  /** This just contains a series of edges that are indexed by offsetMap */
  protected var adjacencyMap:Rail[Int];

  /** Constructor */
  public def this(N:Int) {
    this.N = N;
    this.M = 0;
    this.inDegreeMap = Rail.make[Int] (this.N, (Int) => 0);
    this.offsetMap = Rail.make[Int] ((this.N)+1);
  }

  /** Compress the datastructures in the graph */
  abstract public def compressGraph (): Void;

  /** Get the adjacent node from index */
  public final def getAdjacentVertexFromIndex(wIndex:Int) = 
                                        this.adjacencyMap(wIndex);

  /** 
   * Give the position of the begining of my neighbors in the compressed
   * notation of the graph. This means that the compression must represent
   * the graph in the CSR format.
   */
  public final def begin (v:Int) = this.offsetMap(v);

  /**
   * Similar to above, but gives the location of one past the current 
   * vertex's neighbor list end. The iteration space is therefore
   * [begin, end).
   */
  public final def end (v:Int) = this.offsetMap(v+1);

  /** Check if an edge between the two vertices already exists */
  abstract public def existsEdge (u:Int, v:Int): Boolean;

  /** Print out the graph in string format */
  abstract public def toString (): String;

  /** Return the number of vertices in the graph */
  public final def numVertices () = this.N;

  /** Return the number of edges in the graph */
  public final def numEdges () = this.M;

  /** Add to the inDegree of a vertex */
  public final def incrementInDegree (v:Int) {
    this.inDegreeMap(v)+=1;
    this.M+=1;
  }

  /** Get a vertex's inDegree */
  public final def getInDegree (v:Int) = this.inDegreeMap(v);
}
