/** A struct that encapsulates the target vertex and the edge weight */
public struct AdjacencyNode {
  private val targetVertex:Int;
  private val edgeWeight:ULong;

  /** constructor --- the only way to initialize */
  public def this (targetVertex:Int, edgeWeight:Long) {
    this.targetVertex = targetVertex;
    this.edgeWeight = edgeWeight as ULong;
  }

  /** constructor --- the only way to initialize */
  public def this (targetVertex:Int, edgeWeight:ULong) {
    this.targetVertex = targetVertex;
    this.edgeWeight = edgeWeight;
  }

  /** getters for both the edgeWeight and targetVertex */
  public def getTargetVertex () = this.targetVertex;
  public def getEdgeWeight () = this.edgeWeight;
}
