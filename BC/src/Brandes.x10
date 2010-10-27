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
  public static type Precision = Float;

  private static val makeNonIncreasingComparator = 
    (distanceMap:HashMap[Int, Int]) => { return (x:Int, y:Int) => {
        val dx = distanceMap.get(x).value();
        val dy = distanceMap.get(y).value();
        return (dx==dy) ? 0 : (dx<dy) ? +1 : -1;
      };
    };

  /**
   * A function wrapper to update the betweenness map ... this can happen in 
   * parallel, so we cover it with an atomic.
   */
  private static def updateBetweenness
               (betweennessMap:HashMap[Brandes.VertexType, Brandes.Precision],
                vertex:Brandes.VertexType,
                newVal:Brandes.Precision) {
    atomic betweennessMap.put (vertex, newVal);
  }

  /**
   * Helper function that processes one single vertex --- i.e, calculates the 
   * single souce shortest path for all destinations and updates the 
   * betweenness for all the vertices based on this calculation.
   */
  public static def dijkstraShortestPaths 
              (graph:AdjacencyGraph [Brandes.VertexType],
               betweennessMap:HashMap[Brandes.VertexType, Brandes.Precision],
               s:Brandes.VertexType) {
    val N = graph.numVertices ();
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

    val deltaMap = new HashMap [Brandes.VertexType, Brandes.Precision] ();
    for (var vertex:Int=0; vertex<N; ++vertex) 
      deltaMap.put (vertex, 0.0 as Brandes.Precision);

    // Return vertices in order of non-increasing distances from "s"
    while (!vertexStack.isEmpty()) {
      val w = vertexStack.pop ();
      for (v in (predecessorMap.get (w)).value()) {
        val deltaUpdate = deltaMap.get (v).value () +
                          ((sigmaMap.get (v).value() as Brandes.Precision / 
                            sigmaMap.get (w).value() as Brandes.Precision) * 
                          (1 + deltaMap.get (w).value()));
        deltaMap.put (v, deltaUpdate);
      }

      if (w != s) updateBetweenness (betweennessMap, w,
             (betweennessMap.get (w).value() + deltaMap.get (w).value()));
    } // vertexStack not empty
  }

  /**
   * Sequential version to calculate the betweenness centrality. The algorithm
   * is found in Brandes' 2004 work.
   */
  public static def brandesBetweenness
                             (graph:AdjacencyGraph [Brandes.VertexType]) {

    // Remember that the vertices are numbered from (0, N], where N=(2^n).
    val N = graph.numVertices ();
    val betweennessMap = new HashMap[Brandes.VertexType, Brandes.Precision] ();
    for (var vertex:Int=0; vertex<N; ++vertex) 
      betweennessMap.put (vertex, 0.0 as Brandes.Precision);

    // So, to iterate over all the vertices, we can iterate over (0, N].
    finish {
      for (var s:Int=0; s<N; ++s) {
        val thisVertex = s;
        async dijkstraShortestPaths (graph, betweennessMap, thisVertex);
      }
    }

    return betweennessMap;
  }

  /**
   * Calls betweeness, prints out the statistics and what not.
   */
  private static def crunchNumbers 
             (graph:AdjacencyGraph [Brandes.VertexType]) {
     var time:Long = System.nanoTime();
     val betweennessMap = Brandes.brandesBetweenness (graph);
     time = System.nanoTime() - time;
     Console.OUT.println ("Betweenness calculation took " + 
                          time/1E9 + " seconds");

     for (vertex in betweennessMap.keySet()) {
       Console.OUT.println ("" + vertex + " = " + 
                            betweennessMap.get (vertex).value());
     }
  }

  /**
   * The big cahuna --- read in all the options and calculate betweenness.
   */
  public static def main (args:Array[String](1)):void {
    try {
      val cmdLineParams = new OptionsParser 
                      (args, null,
                       [Option("s", "", "Seed for the random number"),
                        Option("n", "", "Number of vertices = 2^n"),
                        Option("a", "", "Probability a"),
                        Option("b", "", "Probability b"),
                        Option("c", "", "Probability c"),
                        Option("d", "", "Probability d"),
                        Option("f", "", "Graph file name"),
                        Option("t", "", "File type: 0: NWB, 1:NET"),
                        Option("i", "", "Starting index of vertices"),
                        Option("o", "", "Output file name")]);

      val seed:Long = cmdLineParams ("-s", 2);
      val n:Int = cmdLineParams ("-n", 2);
      val a:Double = cmdLineParams ("-a", 0.55);
      val b:Double = cmdLineParams ("-b", 0.1);
      val c:Double = cmdLineParams ("-c", 0.1);
      val d:Double = cmdLineParams ("-d", 0.25);
      val fileName:String = cmdLineParams ("-f", "NOFILE");
      val fileType:Int = cmdLineParams ("-t", 0);
      val startIndex:Int = cmdLineParams ("-i", 0);
      val outFileName:String = cmdLineParams ("-o", "STDOUT");

      val numPlaces = Place.MAX_PLACES;

      Console.OUT.println ("Running SSCA2 with the following parameters:");
      if (0 == fileName.compareTo("NOFILE")) {
        Console.OUT.println ("seed = " + seed);
        Console.OUT.println ("N = " + Math.pow(2, n) as Int);
        Console.OUT.println ("a = " + a);
        Console.OUT.println ("b = " + b);
        Console.OUT.println ("c = " + c);
        Console.OUT.println ("d = " + d);

        val recursiveMatrixGenerator = Rmat (seed, n, a, b, c, d);
        val graph = recursiveMatrixGenerator.generate ();
        Console.OUT.println (graph);

        crunchNumbers (graph);
      } else {
        Console.OUT.println ("f = " + fileName);
        Console.OUT.println ("t = " + fileType);
        Console.OUT.println ("i = " + startIndex);

        val graph = NetReader.readNetFile (fileName, startIndex);
        Console.OUT.println (graph);

        crunchNumbers (graph);
      }
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
