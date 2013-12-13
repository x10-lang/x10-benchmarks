package bcg;
import x10.util.Random;

/**
 * The workhorse of Betweenness Centrality
 */
public final class BC(N:Int) {
	val graph:Graph;
	
	
	val verticesToWorkOn = new Rail[Int](N, (i:Long)=>i as Int);
	val betweennessMap = new Rail[Double](N);
	var allocTime:Long = 0L;
	var processingTime:Long = 0L;
	
	
	
	// These are the per-vertex data structures.
	var predecessorMap:Rail[Int]; 
	var predecessorCount:Rail[Int];
	var distanceMap:Rail[Long];
	var sigmaMap:Rail[Long];
	var regularQueue:FixedRailQueue[Int];
	var deltaMap:Rail[Double];
	var count:Int = 0n;
	
	
	/**
	 * Constructor
	 * @param graph random graph to work on, inside the constructor, various helper data structured
	 * will be allocated.
	 */
	public def this(graph:Graph) {
		property(graph.numVertices());
		this.graph = graph;
		
		allocTime  -= System.nanoTime();
		predecessorMap = new Rail[Int](graph.numEdges());
		predecessorCount = new Rail[Int](N);
		distanceMap = new Rail[Long](N, Long.MAX_VALUE);
		sigmaMap = new Rail[Long](N);
		regularQueue = new FixedRailQueue[Int](N);
		deltaMap = new Rail[Double](N);
		count:Int = 0n;
		allocTime += System.nanoTime();
	}
	
	
	
	/**
	 * Helper function that processes a set of vertices --- i.e, calculates 
	 * the single souce shortest path for all destinations and updates the 
	 * betweenness for all the vertices based on this calculation.
	 */
	public def bfsShortestPaths(val startVertex:Int, val endVertex:Int,yield:()=>void) {
		
		
		//var processingTime:Long = 0;
		var resetTime:Long = 0;
		
		// Iterate over each of the vertices in my portion.
		for(var vertexIndex:Int=startVertex; vertexIndex<endVertex; ++vertexIndex) { 
			val s:Int = verticesToWorkOn(vertexIndex);
			
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
						predecessorMap(graph.rev(w)+predecessorCount(w)++) = v;
					}
				}
			} // while priorityQueue not empty
			
			regularQueue.rewind();
			yield(); // added on 12/13/2013
			// Return vertices in order of non-increasing distances from "s"
			while(!regularQueue.isEmpty()) {
				val w = regularQueue.top();
				val rev = graph.rev(w);
				while(predecessorCount(w) > 0) {
					val v = predecessorMap(rev+--predecessorCount(w));
					deltaMap(v) += (sigmaMap(v) as Double/sigmaMap(w) as Double)*(1.0 + deltaMap(w));
				}
				
				// Accumulate updates locally 
				if(w != s) betweennessMap(w) += deltaMap(w); 
				distanceMap(w) = Long.MAX_VALUE;
				sigmaMap(w) = 0L;
				deltaMap(w) = 0.0;
				
			} // vertexStack not empty
			processingTime += (System.nanoTime() - processingCounter);
			
		} // All vertices from(startVertex, endVertex)
		
		
	}
	
	/**
	 * A function to shuffle the vertices randomly to give better work distribution
	 */
	protected def permuteVertices() {
		val prng = new Random(1);
		
		for(var i:Int=0n; i<N; i++) {
			val indexToPick = prng.nextInt(N-i);
			val v = verticesToWorkOn(i);
			verticesToWorkOn(i) = verticesToWorkOn(i+indexToPick);
			verticesToWorkOn(i+indexToPick) = v;
		}
	}
	
	/**
	 * Print the betweenness map.
	 */
	protected def printBetweennessMap() {
		for(var i:Int=0n; i<N; ++i) {
			if(betweennessMap(i) != 0.0) {
				Console.OUT.println("(" + i + ") -> " + sub(""+betweennessMap(i), 0n, 6n));
			}
		}
	}
	
	/**
	 * Get the subsrting of a given string
	 * @param str parent string
	 * @param start start idx 
	 * @param end end idx
	 * @return sub string of str with [start, end(or end of str))
	 */
	private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));
	
	
	
}
