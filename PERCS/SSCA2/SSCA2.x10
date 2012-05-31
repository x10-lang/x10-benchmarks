import x10.compiler.Pragma;
import x10.util.Random;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.concurrent.Lock;

public final class SSCA2(N:Int) {
    val graph:Graph;
    val verbose:Int;
    val verticesToWorkOn = new Rail[Int](N, (i:Int)=>i);
    val betweennessMap = new Rail[Double](N);

    // Constructor
    public def this(graph:Graph, verbose:Int) {
        property(graph.numVertices());
        this.graph = graph;
        this.verbose = verbose;
    }

    static def make(rmat:Rmat, permute:Int, verbose:Int) {
        val graph = rmat.generate();
        graph.compress();
        val s = new SSCA2(graph, verbose);
        if (permute > 0) s.permuteVertices();
        return s;
    }

    /**
     * Helper function that processes a set of vertices --- i.e, calculates 
     * the single souce shortest path for all destinations and updates the 
     * betweenness for all the vertices based on this calculation.
     */
    public def bfsShortestPaths(val startVertex:Int, val endVertex:Int) {
        var allocTime:Long = System.nanoTime();
        // These are the per-vertex data structures.
        val vertexStack = new FixedRailStack[Int](N);
        val predecessorMap = new Rail[FixedRailStack[Int]](N, (i:Int)=>new FixedRailStack[Int](graph.getInDegree(i)));
        val distanceMap = new Rail[Long](N, Long.MAX_VALUE);
        val sigmaMap = new Rail[Long](N);
        val regularQueue = new FixedRailQueue[Int](N);
        val deltaMap = new Rail[Double](N);
        val processedVerticesStack = new FixedRailStack[Int](N);
        var count:Int = 0;

        allocTime = System.nanoTime() - allocTime;

        var processingTime:Long = 0;
        var resetTime:Long = 0;

        // Iterate over each of the vertices in my portion.
        for(var vertexIndex:Int=startVertex; vertexIndex<endVertex; ++vertexIndex) { 
            val s:Int = this.verticesToWorkOn(vertexIndex);

            // Reset the values of those vertices that were touched in the previous
            // iteration. This might save some computation.

            // 1. Clear the vertexStack and the priorityQueue --- O(1) operation.
            val resetCounter:Long = System.nanoTime();
            vertexStack.clear();
            regularQueue.clear();

            // 2. Pop off the processedVerticesStack and reset their values.
            while(!(processedVerticesStack.isEmpty())) {
                val processedVertex = processedVerticesStack.pop();
                predecessorMap(processedVertex).clear();
                distanceMap(processedVertex) = Long.MAX_VALUE;
                sigmaMap(processedVertex) = 0L;
                deltaMap(processedVertex) = 0.0;
            }

            resetTime += System.nanoTime() - resetCounter;

            val processingCounter:Long = System.nanoTime();

            // Put the values for source vertex
            distanceMap(s) = 0L;
            sigmaMap(s) = 1L;
            regularQueue.push(s);

            // Loop until there are no elements left in the priority queue
            while(!regularQueue.isEmpty()) {
                count++;
                // Pop the node with the least distance
                val v = regularQueue.pop();
                vertexStack.push(v);
                processedVerticesStack.push(v);

                // Get the start and the end points for the edge list for "v"
                val edgeStart:Int = graph.begin(v);
                val edgeEnd:Int = graph.end(v);

                // Iterate over all its neighbors
                for(var wIndex:Int=edgeStart; wIndex<edgeEnd; ++wIndex) {
                    // Get the target of the current edge.
                    val w:Int = graph.getAdjacentVertexFromIndex(wIndex);
                    val distanceThroughV:Long = distanceMap(v) + 1L;
 
                    // In BFS, the minimum distance will only be found once --- the 
                    // first time that a node is discovered. So, add it to the queue.
                    if(distanceMap(w) == Long.MAX_VALUE) {
                        regularQueue.push(w);
                        distanceMap(w) = distanceThroughV;
                    }

                    // If the distance through "v" for "w" from "s" was the same as its 
                    // current distance, we found another shortest path. So, add 
                    // "v" to predecessorMap of "w" and update other maps.
                    if(distanceThroughV == distanceMap(w)) {
                        sigmaMap(w) = sigmaMap(w) + sigmaMap(v);// XTENLANG-2027
                        predecessorMap(w).push(v);
                    }
                }
            } // while priorityQueue not empty

            // Return vertices in order of non-increasing distances from "s"
            while(!vertexStack.isEmpty()) {
                val w = vertexStack.pop();
                while(!(predecessorMap(w).isEmpty())) {
                    val v = predecessorMap(w).pop();
                    deltaMap(v) += (sigmaMap(v) as Double/sigmaMap(w) as Double)*(1.0 + deltaMap(w));
                }

                // Accumulate updates locally 
                if(w != s) betweennessMap(w) += deltaMap(w); 

            } // vertexStack not empty
            processingTime += System.nanoTime() - processingCounter;
        } // All vertices from(startVertex, endVertex)

        if(verbose > 0) {
            Console.OUT.println("[" + here.id + "]"
                + " Alloc = " + allocTime/1e9
                + " Reset = " + resetTime/1e9
                + " Proc = " + processingTime/1e9
                + " Count = " + count);
        }
    }

    /**
     * A function to shuffle the vertices randomly to give better work dist.
     */
    private def permuteVertices() {
        val prng = new Random(1);

        for(var i:Int=0; i<N; i++) {
            val indexToPick = prng.nextInt(N-i);
            val v = verticesToWorkOn(i);
            verticesToWorkOn(i) = this.verticesToWorkOn(i+indexToPick);
            verticesToWorkOn(i+indexToPick) = v;
        }
    }

    /**
     * Place local version of crunchNumbers.
     */
    private def crunchNumbersLocally(first:Int, last:Int) {
        bfsShortestPaths(first, last);

        // Merge the results in this place with the results in other places.
        val globalMergeTime:Long = -System.nanoTime();

        Team.WORLD.allreduce(here.id, // My ID.
            betweennessMap, // Source buffer.
            0, // Offset into the source buffer.
            betweennessMap, // Destination buffer.
            0, // Offset into the destination buffer.
            N, // Number of elements.
            Team.ADD); // Operation to be performed.

        if(verbose > 1) {
            Console.OUT.println("[" + here.id +  "]"
                + " Global merge time = " +((globalMergeTime+System.nanoTime())/1e9));
        }
    }

    /**
     * Dump the betweenness map.
     */
    private def printBetweennessMap() {
        for(var i:Int=0; i<N; ++i) {
            if(betweennessMap(i) != 0.0) {
                Console.OUT.println("(" + i + ") -> " + betweennessMap(i));
            }
        }
    }

    /**
     * Calls betweeness, prints out the statistics and what not.
     */
    private static def crunchNumbers(rmat:Rmat, permute:Int, verbose:Int) {
        var time:Long = System.nanoTime();

        val plh = PlaceLocalHandle.makeFlat[SSCA2](Dist.makeUnique(), ()=>SSCA2.make(rmat, permute, verbose));

        val distTime = (System.nanoTime()-time)/1e9;
        time = System.nanoTime();

        val myGraph = plh().graph;
        val N = myGraph.numVertices();
        val M = myGraph.numEdges();
        Console.OUT.println("Graph details: N=" + N + ", M=" + M);

        val max = Place.MAX_PLACES;

        // Loop over all the places and crunch the numbers.
        @Pragma(Pragma.FINISH_SPMD) finish {
            for(var i:Int=0; i<max; ++i) {
                val ii = i;
                at(Place(ii)) async {
                    plh().crunchNumbersLocally((N as Long*ii/max) as Int, (N as Long*(ii+1)/max) as Int);
                }
            }
        }

        time = System.nanoTime() - time;
        val procTime = time/1E9;
        val totalTime = distTime + procTime;
        val procPct = procTime*100.0/totalTime;

        if(verbose > 2) plh().printBetweennessMap();

        Console.OUT.println("Places: " + max + "  N: " + N + "  Setup: " + distTime + "s  Processing: " + procTime + "s  Total: " + totalTime + "s  (proc: " + procPct  +  "%).");
    }

    /**
     * Reads in all the options and calculate betweenness.
     */
    public static def main(args:Rail[String]):void {
        val cmdLineParams = new OptionsParser(args, null, [
            Option("s", "", "Seed for the random number"),
            Option("n", "", "Number of vertices = 2^n"),
            Option("a", "", "Probability a"),
            Option("b", "", "Probability b"),
            Option("c", "", "Probability c"),
            Option("d", "", "Probability d"),
            Option("p", "", "Permutation"),
            Option("v", "", "Verbose")]);

        val seed:Long = cmdLineParams("-s", 2);
        val n:Int = cmdLineParams("-n", 2);
        val a:Double = cmdLineParams("-a", 0.55);
        val b:Double = cmdLineParams("-b", 0.1);
        val c:Double = cmdLineParams("-c", 0.1);
        val d:Double = cmdLineParams("-d", 0.25);
        val permute:Int = cmdLineParams("-p", 1); // on by default
        val verbose:Int = cmdLineParams("-v", 0); // off by default

        Console.OUT.println("Running SSCA2 with the following parameters:");
        Console.OUT.println("seed = " + seed);
        Console.OUT.println("N = " + (1<<n));
        Console.OUT.println("a = " + a);
        Console.OUT.println("b = " + b);
        Console.OUT.println("c = " + c);
        Console.OUT.println("d = " + d);
        Console.OUT.println("places = " + Place.MAX_PLACES);

        crunchNumbers(Rmat(seed, n, a, b, c, d), permute, verbose);
    }
}
