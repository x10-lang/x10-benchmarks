import x10.util.Random;
import x10.util.HashMap;
import x10.util.ArrayList;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;
import x10.io.File;
import x10.io.Printer;
import x10.lang.Cell;
import x10.util.concurrent.atomic.AtomicLong;

public final class Brandes(N:Int) {
  static val M=1000*1000;
  static type AtomicType=LockedDouble;

  val graph:AdjacencyGraph[Int];
  val debug:Boolean;
  val betweennessMap=Rail.make[AtomicType] (N, (Int)=> new AtomicType(0.0));

  // Constructor
  def this(g:AdjacencyGraph[Int], debug:Boolean) {
    property(g.numVertices());
    this.graph=g;
    this.debug=debug;
  }

  // A comparator which orders the vertices by their distances.
  private static val makeNonIncreasingComparator = 
    (distanceMap:Rail[ULong]) =>  (x:Int, y:Int) => {
      val dx = distanceMap(x);
      val dy = distanceMap(y);
      return (dx==dy) ? 0 : (dx<dy) ? +1 : -1;
    };
    
  /**
   * Helper function that processes one single vertex --- i.e, calculates the 
   * single souce shortest path for all destinations and updates the 
   * betweenness for all the vertices based on this calculation.
   *
   * Note that the vertex numbers are [startVertex, endVertex], not 
   * [startVertex, endVertex) as we are used to!
   */
  public def dijkstraShortestPaths (val startVertex:Int,
                                    val endVertex:Int) { 
    // Per-thread structure --- initialize once.
    val myBetweennessMap = Rail.make[Double] (N, 0.0 as Double);

    // These are the per-vertex data structures.
    val vertexStack = new FixedRailStack[Int] (N);
    val predecessorMap= Rail.make[FixedRailStack[Int]](N, (i:Int)=> 
                        new FixedRailStack[Int](graph.getInDegree(i)));
    val distanceMap = Rail.make[ULong](N);
    val sigmaMap = Rail.make(N, 0 as ULong);
    val binaryHeapComparator = makeNonIncreasingComparator(distanceMap);
    val priorityQueue = new FixedBinaryHeap (binaryHeapComparator, N);
    val deltaMap = Rail.make[Double](N);

    Console.OUT.println ("Starting processing from : " + startVertex);

    // Iterate over each of the vertices in my portion.
    for ([s] in startVertex..endVertex) { 

      // Reset all the per-vertex structures without freeing the memory!
      vertexStack.clear();
      for ([i] in 0..N-1) predecessorMap(i).clear();
      for ([i] in 0..N-1) distanceMap(i) = ULong.MAX_VALUE;
      for ([i] in 0..N-1) sigmaMap(i) = 0 as ULong;
      for ([i] in 0..N-1) deltaMap(i) = 0.0 as Double;
      priorityQueue.clear();

      // Put the values for source vertex
      distanceMap(s)=0 as ULong;
      sigmaMap(s)=1 as ULong;
      priorityQueue.push (s);
     
      // Loop until there are no elements left in the priority queue
      while (!priorityQueue.isEmpty()) {
        // Pop the node with the least distance
        val v = priorityQueue.pop();
        vertexStack.push (v);
        
        // Iterate over all its neighbors
        for (w in graph.getNeighbors(v).keySet()) {
          val distanceThroughV = distanceMap(v) + graph.getEdgeWeight (v, w);

          // Update the distance and push it in the priorityQueue
          // if a new low distance has been found.
          if (distanceThroughV < distanceMap(w)) {
            // Check if this is the first time "w" was found.
            val firstTimeRelaxation = 
              (distanceMap(w)==ULong.MAX_VALUE)? true:false;

            // Update the distance map
            distanceMap(w) = distanceThroughV;

            // If this is the first time for "w", add it to the queue.
            if (firstTimeRelaxation) {
              priorityQueue.push (w); 
            } else { // Decrease the key and remove the previous predecessors
              priorityQueue.decreaseKey (w);
              while (!predecessorMap(w).isEmpty()) predecessorMap(w).pop();
            }
          }

          // If v relaxed the distance to w, we can update the sigmaMap and add
          // v to the predecessorMap of w.
          if (distanceThroughV == distanceMap(w)) {
            sigmaMap(w) = sigmaMap(w) + sigmaMap(v);// XTENLANG-2027
            predecessorMap(w).push(v);
          }
        }
      } // while priorityQueue not empty
      
      // Return vertices in order of non-increasing distances from "s"
      while (!vertexStack.isEmpty()) {
        val w = vertexStack.pop ();
        while (!(predecessorMap(w).isEmpty())) {
          val v = predecessorMap(w).pop();
          deltaMap(v) += (sigmaMap(v) as Double/sigmaMap(w) as Double)*
                         (1 + deltaMap(w));
        }
     
        // Accumulate updates locally 
        if (w != s) myBetweennessMap(w) += deltaMap(w); 
      } // vertexStack not empty
    } // All vertices from (startVertex, endVertex)

    // update global shared state once, atomically.
    for (var i:Int=0; i < N; i++) {
      val result = myBetweennessMap(i);
      if (result != 0.0D) betweennessMap(i).adjust(result);
    }
  }

  /**
   * Calls betweeness, prints out the statistics and what not.
   */
  private def crunchNumbers (printer:Printer, debug:Boolean) {
    var time:Long = System.nanoTime();

    // Divide the iteration space equally amongst the P processes and 
    // hand out the chunks to each worker.
    val NThreads = Runtime.INIT_THREADS;
		val chunkSize = N/NThreads;
		finish  {
			for ([i] in 0..NThreads-1) async {
				val startVertex = chunkSize*i;
				val endVertex = (i==NThreads-1) ? N-1 : (startVertex+chunkSize-1);
				dijkstraShortestPaths (startVertex, endVertex);
			}
    }

    time = System.nanoTime() - time;
    printer.println ("Betweenness calculation took " + time/1E9 + " seconds.");

    if (debug) {
      for ([i] in 0..N-1) {
        if (betweennessMap(i).get() != 0.0) 
          printer.println ("(" + i + ") ->" + betweennessMap(i));
      }
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
           Option("debug", "", "Debug"),
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
      val debug:Boolean = 0==cmdLineParams ("-debug", 1); // off by default
      
      val numPlaces = Place.MAX_PLACES;
      
      /* Set the printer appropriate to where the user wants output */
      val printer = (0 == outFileName.compareTo("STDOUT")) ? 
          Console.OUT : (new File(outFileName)).printer();

      printer.println ("Running SSCA2 with the following parameters:");
      
      if (0 == fileName.compareTo("NOFILE")) {
        printer.println ("seed = " + seed);
        printer.println ("N = " + Math.pow(2, n) as Int);
        printer.println ("a = " + a);
        printer.println ("b = " + b);
        printer.println ("c = " + c);
        printer.println ("d = " + d);
        printer.println ("" + Runtime.INIT_THREADS + " workers.");
        val recursiveMatrixGenerator = Rmat (seed, n, a, b, c, d);
        val graph = recursiveMatrixGenerator.generate ();
        val brandes = new Brandes(graph, debug);
        
        brandes.crunchNumbers (printer, debug);
      } else {
        printer.println ("f = " + fileName);
        printer.println ("t = " + fileType);
        printer.println ("i = " + startIndex);
        printer.println ("" + Runtime.INIT_THREADS + " workers.");
        
        val graph = NetReader.readNetFile (fileName, startIndex);
        val brandes = new Brandes(graph, debug);
        
        brandes.crunchNumbers (printer, debug);
      }
      
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
