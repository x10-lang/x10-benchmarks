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

  private static val makeNonIncreasingComparator = 
    (distanceMap:HashMap[Int, Int]) => { return (x:Int, y:Int) => {
        val dx = distanceMap.get(x).value();
        val dy = distanceMap.get(y).value();
        return (dx==dy) ? 0 : (dx<dy) ? +1 : -1;
      };
    };

  /**
   * Sequential version to calculate the betweenness centrality. The algorithm
   * is found in Brandes' 2004 work.
   */
  public static def sequentialBrandes(graph:AdjacencyGraph [Brandes.VertexType]){

    // Remember that the vertices are numbered from (0, N], where N=(2^n).
    val N = graph.numVertices ();
    val betweennessMap = new HashMap[Brandes.VertexType, Double] ();
    for (var vertex:Int=0; vertex<N; ++vertex) betweennessMap.put (vertex, 0.0);

    // So, to iterate over all the vertices, we can iterate over (0, N].
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
      for (var vertex:Int=0; vertex<N; ++vertex) { 
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

        for (w in graph.getNeighbors(v).keySet()) {
          val distanceThroughV = (distanceMap.get (v)).value() + 
                                  graph.getEdgeWeight (v, w);

          // Update the distance if its a new low
          if (distanceThroughV < distanceMap.get (w).value()) {
            distanceMap.put (w, distanceThroughV);
            priorityQueue.push (w);
            sigmaMap.put (w, sigmaMap.get(w).value() + sigmaMap.get(v).value());
            predecessorMap.get (w).value().add(v);
          }
        }
      } // while priorityQueue not empty

      val deltaMap = new HashMap [Brandes.VertexType, Double] ();
      for (var vertex:Int=0; vertex<N; ++vertex) deltaMap.put (vertex, 0.0);

      // Return vertices in order of non-increasing distances from "s"
      while (!vertexStack.isEmpty()) {
        val w = vertexStack.pop ();
        for (v in (predecessorMap.get (w)).value()) {
          val deltaUpdate = deltaMap.get (v).value () +
                            ((sigmaMap.get (v).value() as Double / 
                              sigmaMap.get (w).value() as Double) * 
                            (1 + deltaMap.get (w).value()));
          deltaMap.put (v, deltaUpdate);
        }

        if (w != s) {
          betweennessMap.put (w, betweennessMap.get (w).value() + 
                                 deltaMap.get (w).value());
        }
      } // vertexStack not empty
    } // vertexStack not empty

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

      val recursiveMatrixGenerator = Rmat (seed, n, a, b, c, d);
      val graph = recursiveMatrixGenerator.generate ();

      Console.OUT.println (graph);

      val betweennessMap = Brandes.sequentialBrandes (graph);

      for (vertex in betweennessMap.keySet()) {
        Console.OUT.println ("" + vertex + " = " + 
                             betweennessMap.get (vertex).value());
      }
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
