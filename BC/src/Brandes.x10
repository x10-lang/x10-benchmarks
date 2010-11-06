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
import x10.util.Team;

public final class Brandes(N:Int) {
  static type AtomicType=LockedDouble;
  static val Meg = (1000*1000); // not Whitman, she is history

  val graph:AdjacencyGraph;
  val debug:Int;
  val verticesToWorkOn=Rail.make[Int] (N, (i:Int)=>i);
  val betweennessMap=Rail.make[AtomicType] (N, (Int)=> new AtomicType(0.0));

  // Constructor
  def this(g:AdjacencyGraph, debug:Int) {
    property(g.numVertices());
    this.graph=g;
    this.debug=debug;
  }
def graph()=graph;
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
                                    val endVertex:Int,
                                    debug:Int) { 
    var allocTime:Long= System.nanoTime();
	  // Per-thread structure --- initialize once.
    val myBetweennessMap = Rail.make[Double] (N, 0.0 as Double);

    // These are the per-vertex data structures.
    val vertexStack = new FixedRailStack[Int] (N);
    val predecessorMap= Rail.make[FixedRailStack[Int]](N, (i:Int)=> 
                        new FixedRailStack[Int](graph.getInDegree(i)));
    val distanceMap = Rail.make[ULong](N, ULong.MAX_VALUE);
    val sigmaMap = Rail.make(N, 0 as ULong);
    val binaryHeapComparator = makeNonIncreasingComparator(distanceMap);
    val priorityQueue = new FixedBinaryHeap (binaryHeapComparator, N);
    val deltaMap = Rail.make[Double](N, 0.0 as Double);
    val processedVerticesStack = new FixedRailStack[Int](N);

    allocTime = (System.nanoTime() - allocTime);
    
    if (debug > 0) {
      Console.OUT.println ("" + here.id + ":" +  
                           Runtime.workerId() + " started processing");
    }
   
    var processingTime:Long = 0;
    var resetTime:Long = 0;
    // Iterate over each of the vertices in my portion.
    for ([vertexIndex] in startVertex..endVertex) { 
      val s:Int = this.verticesToWorkOn(vertexIndex);

      // Reset the values of those vertices that were touched in the previous
      // iteration. This might save some computation.

      // 1. Clear the vertexStack and the priorityQueue --- O(1) operation.
    
      val resetCounter:Long = System.nanoTime();
      vertexStack.clear();
      priorityQueue.clear();

      // 2. Pop off the processedVerticesStack and reset their values.
      while (!(processedVerticesStack.isEmpty())) {
        val processedVertex = processedVerticesStack.pop();
        predecessorMap(processedVertex).clear();
        distanceMap(processedVertex) = ULong.MAX_VALUE;
        sigmaMap(processedVertex) = 0 as ULong;
        deltaMap(processedVertex) = 0.0 as Double;
      }

      resetTime += (System.nanoTime() - resetCounter);
    	  
      val processingCounter:Long = System.nanoTime();
      // Put the values for source vertex
      distanceMap(s)=0 as ULong;
      sigmaMap(s)=1 as ULong;
      priorityQueue.push (s);
     
     
      // Loop until there are no elements left in the priority queue
      while (!priorityQueue.isEmpty()) {
        // Pop the node with the least distance
        val v = priorityQueue.pop();
        vertexStack.push (v);
        processedVerticesStack.push (v);

        // Get the start and the end points for the edge list for "v"
        val edgeStart:Int = graph.begin(v);
        val edgeEnd:Int = graph.end(v);
        
        // Iterate over all its neighbors
        //for (w in graph.getNeighbors(v).keySet()) {
          //val distanceThroughV = distanceMap(v) + graph.getEdgeWeight (v, w);
        for (var wIndex:Int=edgeStart; wIndex<edgeEnd; ++wIndex) {
          // Get the target of the current edge and its weight.
          val adjacencyNode:AdjacencyNode = graph.getAdjacencyNode(wIndex);
          val w:Int = adjacencyNode.getTargetVertex();
          val distanceThroughV = distanceMap(v) + adjacencyNode.getEdgeWeight();

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
      processingTime  += (System.nanoTime() - processingCounter);
    } // All vertices from (startVertex, endVertex)

    // update global shared state once, atomically.
    var localMergeTime:Long = System.nanoTime();
    for (var i:Int=0; i < N; i++) {
      val result = myBetweennessMap(i);
      if (result != 0.0D) betweennessMap(i).adjust(result);
    } 
    localMergeTime = (System.nanoTime() - localMergeTime);
    
    if (debug > 0) {
      Console.OUT.println ("[" + here.id + ":" + Runtime.workerId() + "] "
    		  + " Alloc= " + allocTime/1e9
    		  + " Reset= " + resetTime/1e9
    		  + " Proc= " + processingTime/1e9
    		  + " Merge= " + localMergeTime/1e9
    		);
    }
  }

  /**
   * A function to shuffle the vertices randomly to give better work dist.
   */
  private def permuteVertices () {
    val prng = new Random();
    val maxIndex = N-1;
    val unshuffledVertices:Rail[Int] = Rail.make[Int] (N, (i:Int)=>i);
    for ([i] in 0..maxIndex) {
      val indexToPick = prng.nextInt (maxIndex-i);
      this.verticesToWorkOn(i) = unshuffledVertices(i+indexToPick);
      unshuffledVertices(i+indexToPick) = unshuffledVertices(i);
    }
  }

  /**
   * Merge the betweenness map. Don't quite know if everyone receives the 
   * results. Only the root needs the results and there is no clear way to 
   * specify this in the Team interface.
   */
  private def mergeBetweennessMap () {
    // Copy the local betweennessMap into a Double array.
    val unlockedBetweennessMap = Rail.make[Double]
          (this.N, (i:Int) => this.betweennessMap(i).get());

    // Merge the results globally
    Team.WORLD.allreduce (here.id, // My ID.
                          unlockedBetweennessMap, // Source buffer.
                          0, // Offset into the source buffer.
                          //mergedunlockedBetweennessMap, // Destination buffer.
                          unlockedBetweennessMap, // Destination buffer.
                          0, // Offset into the destination buffer.
                          this.N, // Number of elements.
                          Team.ADD); // Operation to be performed.
    
    // Copy the results back into the locked double. This has been done 
    // purely for elegance. You don't need to copy this back. Also, we 
    // can replace the LockedDouble with two arrays. One holding the Doubles
    // and another holding the locks to each Double. This way, we already 
    // have a Double values array ready to be globally reduced.
    for ([i] in 0..this.N-1) {
      this.betweennessMap(i).set(unlockedBetweennessMap(i));
    }
  }

  /**
   * Place local version of crunchNumbers.
   */
  private def crunchNumbersLocally (printer:Printer,
                                    permute:Boolean,
                                    chunk:Int,
                                    vertexBeginIndex:Int,
                                    vertexEndIndex:Int,
                                    debug:Int) {
    // Permutate the vertices if asked for
    if (permute) permuteVertices ();
   
    // Evaluate after splitting up the tasks based on the scheduling policy
    // A "-1" indicates that the user wants to split evenly acc all threads.
    val myTotalWorkLoad = (vertexEndIndex-vertexBeginIndex);
		val numChunks = (-1==chunk) ? Runtime.INIT_THREADS: chunk;
    val chunkSize = myTotalWorkLoad/numChunks;

		finish  {
			for ([i] in 0..numChunks-1) async {
				val startVertex = vertexBeginIndex + chunkSize*i;
				val endVertex = (i==numChunks-1) ? vertexEndIndex-1: 
                                           (startVertex+chunkSize-1);
				dijkstraShortestPaths (startVertex, endVertex, debug);
			}
    }

    // Merge the results back with each place.
    val globalMergeTime:Long = -System.nanoTime();
    mergeBetweennessMap ();
    if (debug > 0) {
      Console.OUT.println ("[" + here.id +  "] " 
    		  + " Global merge time= " + ((globalMergeTime+System.nanoTime())/1e9));
    }
  }

  /**
   * Dump the betweenness map.
   */
  private def printBetweennessMap (printer:Printer) {
    for ([i] in 0..graph.numVertices()-1) {
      if (betweennessMap(i).get() != 0.0 as Double) 
        printer.println ("(" + i + ") ->" + betweennessMap(i));
    }
  }

  /**
   * A simple one dimensional partition of nodes.
   */
  private static def getLinearPartition (totalWork:Int,
                                         numChunks:Int) {
    val workPartition:Rail[Int] = Rail.make[Int] (numChunks+1);
    val chunkSize = totalWork/numChunks;

    // The first (numChunks-1) are equal
    for ([partition] in 0..numChunks-1) {
      workPartition(partition) = chunkSize*partition;
    }

    // The last person gets whatever is remaining
    workPartition(numChunks) = totalWork;

    return workPartition;
  }

  /**
   * Calls betweeness, prints out the statistics and what not.
   */
  private static def crunchNumbers (graphMaker:GraphMaker,
                                    printer:Printer, 
                                    permute:Boolean,
                                    chunk:Int,
                                    debug:Int) {

    // Determine the number of places.
    val numPlaces = Place.MAX_PLACES;

  
    var time:Long = System.nanoTime();
    // Create a place local handle at each place.
    val brandesHandles = PlaceLocalHandle.make[Brandes] 
                                               (Dist.makeUnique(), ()=> {
                                            	   val graph = graphMaker.make();
                                            	   graph.compressGraph();
                                            	   new Brandes (graph, debug)
                                               });
    val myGraph = brandesHandles().graph();
    val N= myGraph.numVertices();
    val M= myGraph.numEdges();
    printer.println ("Graph details: N=" + N + ", M=" + M);
    // Get a rail of partitions
    val workPartition = getLinearPartition (N, numPlaces);
    
    val distTime = (System.nanoTime()-time)/1e9;
    time = System.nanoTime();
    // Loop over all the places and crunch the numbers.
    finish {
      for ([place] in 0..numPlaces-1) {
    	  val start = workPartition(place);
    	  val end = workPartition(place+1);
        async at(Place(place)) {
          brandesHandles().crunchNumbersLocally (printer, 
                                                 permute, 
                                                 chunk, 
                                                 start, 
                                                 end, 
                                                 debug);
        }
      }
    }

    time = System.nanoTime() - time;
    printer.println ("Betweenness calculation took distTime=" + distTime 
    		+ " procTime=" + time/1E9 + " seconds.");

    if (debug>1) {
      brandesHandles().printBetweennessMap(printer);
    }
  }
  static interface GraphMaker {
	  def make():AdjacencyGraph;
  }
  static struct RmatGraphMaker(seed:Long, n:Int, a:Double, b:Double, c:Double, d:Double) 
  implements GraphMaker{
	  public def make() {
		  val recursiveMatrixGenerator = Rmat (seed, n, a, b, c, d);
	        val graph = recursiveMatrixGenerator.generate ();
	        return graph;
	  }
  }
  static struct NetMaker(fileName:String, startIndex:Int) 
  implements GraphMaker{
	  public def make() {
		  val graph = NetReader.readNetFile (fileName, startIndex);
	        return graph;
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
           Option("chunk", "", "Chunk size, defaults to 100"),
           Option("permute", "", "true, false"),
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
      val debug:Int = cmdLineParams ("-debug", 0); // off by default
      val permute:Boolean = 0==cmdLineParams ("-permute", 1); // off by default
      val chunk:Int = cmdLineParams ("-chunk", -1); 
      
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
        printer.println ("Permuting: " + permute);
        printer.println ("Chunk size: " + chunk);
        printer.println ("" + Place.MAX_PLACES + " places and " + 
                Runtime.INIT_THREADS + " workers/place");
        
        crunchNumbers (RmatGraphMaker(seed,n,a,b,c,d), printer, permute, chunk, debug);
      } else {
        printer.println ("f = " + fileName);
        printer.println ("t = " + fileType);
        printer.println ("i = " + startIndex);
        printer.println ("" + Runtime.INIT_THREADS + " workers.");
        printer.println ("Permuting: " + permute);
        printer.println ("Chunk size: " + chunk);
        printer.println ("" + Place.MAX_PLACES + " places and " + 
                         Runtime.INIT_THREADS + " workers per-place");
        
        crunchNumbers (NetMaker(fileName, startIndex), printer, permute, chunk, debug);
      }
      
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
