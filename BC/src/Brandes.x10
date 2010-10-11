import x10.util.Random;
import x10.util.HashMap;
import x10.util.HashSet;
import x10.util.Stack;
import x10.util.Set;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;

public final class Brandes {
  public static type VertexType = Int;
  public static type adjacencyType = 
    HashMap [Brandes.VertexType, HashMap[Brandes.VertexType, Int]];
  private val makeNonIncreasingComparator = 
    (distanceMap:HashMap[Int, Int]) => { return (x:Int, y:Int) => {
        val dx = distanceMap.get(x).value();
        val dy = distanceMap.get(y).value();
        return (dx==dy) ? 0 : (dx<dy) ? +1 : -1;
      };
    };

  private def printHello() = Console.OUT.println ("Hello from Brandes");

  /**
   * Returns the weight of an edge
   */
  private def getEdgeWeight (graph:adjacencyType,
                             source:Brandes.VertexType,
                             sink:Brandes.VertexType) : Int {
    return ((graph.get (source)).value()).get (sink).value();
  }

  /**
   * Returns the neighbors for a given vertex
   */
  private def getNeighbors(graph:adjacencyType, 
                           vertex:Brandes.VertexType):Set [Brandes.VertexType]{
    return ((graph.get (vertex)).value()).keySet();
  }

  /**
   * Sequential version to calculate the betweenness centrality. The algorithm
   * is found in Brandes' 2004 work.
   */
  private def sequentialBrandes (graph:adjacencyType, n:Int) : 
                                     HashMap[Brandes.VertexType, Double] {

    val betweennessMap = new HashMap[Brandes.VertexType, Double] ();
    for (vertex in graph.keySet()) betweennessMap.put (vertex, 0.0);



    // Remember that the vertices are numbered from (0, N], where N=(2^n).
    // So, to iterate over all the vertices, we can iterate over (0, N].
    val N = Math.pow (2, n) as Brandes.VertexType;
    for (var s:Int=0; s<N; ++s) {
      val vertexStack = new Stack[Brandes.VertexType] ();
      val predecessorMap = 
             new HashMap[Brandes.VertexType, HashSet[Brandes.VertexType]]();
      val distanceMap = new HashMap [Brandes.VertexType, Int] ();
      val priorityQueueComparator = makeNonIncreasingComparator(distanceMap);
      val sigmaMap = new HashMap [Brandes.VertexType, Int] ();
      val priorityQueue = 
        new NaivePriorityQueue [Brandes.VertexType] (priorityQueueComparator);

      // Zero initialize all the maps
      for (vertex in graph.keySet()) {
        predecessorMap.put (vertex, new HashSet [Brandes.VertexType]());
        distanceMap.put (vertex, Int.MAX_VALUE);
        sigmaMap.put (vertex, 0);
      }

      // Put the values for source vertex
      distanceMap.put (s, 0);
      sigmaMap.put (s, 1);
      priorityQueue.push (s);

      // Loop until there are no elements left in the priority queue
      while (!priorityQueue.isEmpty()) {
        val v = priorityQueue.pop();
        vertexStack.push (v);

        for (w in this.getNeighbors(graph, v)) {
          val distanceThroughV = ((distanceMap.get (v)).value() + 
                                  this.getEdgeWeight (graph, v, w));

          // Update the distance if its a new low
          if (distanceThroughV < (distanceMap.get (w)).value()) {
            distanceMap.put (w, distanceThroughV);
            priorityQueue.push (w);
            sigmaMap.put (w, (sigmaMap.get(w)).value() + 1);
            predecessorMap.get (w).value().add(v);
          }
        }

        val deltaMap = new HashMap [Brandes.VertexType, Double] ();
        for (vertex in graph.keySet()) deltaMap.put (vertex, 0.0);

        // Return vertices in order of non-increasing distances from "s"
        while (!vertexStack.isEmpty()) {
          val w = vertexStack.pop ();
          for (predecessor in (predecessorMap.get (w)).value()) {
            val deltaUpdate = deltaMap.get (predecessor).value () +
                      ((sigmaMap.get (predecessor).value() as Double / 
                        sigmaMap.get (w).value() as Double) * 
                          (1 + deltaMap.get (w).value()));
            deltaMap.put (predecessor, deltaUpdate);
          }

          if (w != s) {
            betweennessMap.put (w, betweennessMap.get (w).value() + 
                                   deltaMap.get (w).value());
          }
        } // vertexStack not empty
      } // while priorityQueue not empty
    }
    return betweennessMap;
  }

  public static def main (args:Array[String](1)):void {
    try {
      val cmdLineParams = new OptionsParser 
                      (args, null,
                       [Option("s", "", "Seed for the random number"),
                        Option("n", "", "Number of vertices = 2^n"),
                        Option("a", "", "Probability a"),
                        Option("b", "", "Probability b"),
                        Option("c", "", "Probability c"),
                        Option("d", "", "Probability d")]);
      val seed:Long = cmdLineParams ("-s", 2);
      val n:Int = cmdLineParams ("-n", 2);
      val a:Double = cmdLineParams ("-a", 0.55);
      val b:Double = cmdLineParams ("-b", 0.1);
      val c:Double = cmdLineParams ("-c", 0.1);
      val d:Double = cmdLineParams ("-d", 0.25);

      Console.OUT.println ("Running SSCA2 with the following parameters:");
      Console.OUT.println ("seed = " + seed);
      Console.OUT.println ("N = " + Math.pow(2, n) as Int);
      Console.OUT.println ("a = " + a);
      Console.OUT.println ("b = " + b);
      Console.OUT.println ("c = " + c);
      Console.OUT.println ("d = " + d);


      val numPlaces = Place.MAX_PLACES;
      val brandesHandle = PlaceLocalHandle.make[Brandes]
                           (Dist.makeUnique(), ()=>new Brandes());

      val recursiveMatrixGenerator = new Rmat (seed, n, a, b, c, d);
      val adjacencyList = recursiveMatrixGenerator.generate ();

      recursiveMatrixGenerator.printAdjacencyList (adjacencyList);

      val betweennessMap = 
                brandesHandle().sequentialBrandes (adjacencyList, n);

      for (vertex in betweennessMap.keySet()) {
        Console.OUT.println ("" + vertex + " = " + 
                             betweennessMap.get (vertex).value());
      }

      finish {
        for (var place:Int=0; place<numPlaces; ++place) {
          val thisPlace = place;
          async at (Place(thisPlace)) brandesHandle().printHello();
        }
      }
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
