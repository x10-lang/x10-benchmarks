public final class Edge {
  private val destination:Long;
  private val weight:UInt;

  public def this(destination:Long,
                  weight:UInt) {
    this.destination = destination;
    this.weight = weight;
  }

  public def getDestination () : Long = this.destination;

  public def getWeight () : UInt = this.weight;
}
