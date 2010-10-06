public final struct Edge {
  private val destination:Long;
  private val weight:UInt;

  public def this(destination:Long,
                  weight:UInt) {
    this.destination = destination;
    this.weight = weight;
  }

  public def getDestination () = this.destination;

  public def getWeight () = this.weight;
}
