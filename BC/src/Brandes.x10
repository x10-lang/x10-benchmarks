import x10.util.Random;
import x10.util.HashMap;
import x10.util.HashSet;
import x10.util.Stack;
import x10.util.Set;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;
import x10.io.File;
import x10.io.Printer;
import x10.lang.Cell;

public final class Brandes(N:Int) {
	static val M=1000*1000;
	val graph:AdjacencyGraph[Int];
	val betweennessMap= Rail.make (N, (Int)=> new LockedDouble(0.0));
	def this(g:AdjacencyGraph[Int]) {
		property(g.numVertices());
		this.graph=g;
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
		 */
		public  def dijkstraShortestPaths (s:Int) {	
			var taskTime:Long = -System.nanoTime();
			var vertexTime:Long = 0L;
			val vertexStack = new Stack[Int] ();
			val predecessorMap = Rail.make(N, (Int)=> new HashSet[Int]());
			val distanceMap = Rail.make[ULong](N, -1);
			val sigmaMap = Rail.make(N, 0 as ULong);
			val priorityQueueComparator = makeNonIncreasingComparator(distanceMap);
			val priorityQueue = new NaivePriorityQueue[Int] (priorityQueueComparator, N);
			val myBetweennessMap= Rail.make[Double] (N, 0.0D);
			// Put the values for source vertex
			distanceMap(s)=0;
			sigmaMap(s)=1;
			priorityQueue.push (s);
			var pCount:Long=0;
			// Loop until there are no elements left in the priority queue
			while (!priorityQueue.isEmpty()) {
				var start:Long = -System.nanoTime();
				val v = priorityQueue.pop();
				start += System.nanoTime();
				pCount += start;
				
				val timer1 = System.nanoTime();
				vertexStack.push (v);
				vertexTime += (System.nanoTime()-timer1)/M;
				
				for (w in graph.getNeighbors(v).keySet()) {
					val dw = distanceMap(w);
					if (dw < 0) { // this is the first time....
						start = -System.nanoTime();
						priorityQueue.push (w);
						start += System.nanoTime();
						pCount += start;
						distanceMap(w)=ULong.MAX_VALUE;
					}
					val distanceThroughV = distanceMap(v) + graph.getEdgeWeight (v, w);
        
					// Update the distance if its a new low
					if (distanceThroughV < distanceMap(w)) {
						distanceMap(w) = distanceThroughV;
						sigmaMap(w) += sigmaMap(v);
						predecessorMap(w).add(v);
					}
				}
			} // while priorityQueue not empty
			val vertexStackSizeMax = vertexStack.size();
			pCount = pCount/M;
		
			
			
			val deltaMap = Rail.make[Double](N, 0.0D);
			// Return vertices in order of non-increasing distances from "s"
			while (!vertexStack.isEmpty()) {
				val w = vertexStack.pop ();
				for (v in predecessorMap(w)) 
					deltaMap(v) += (sigmaMap(v) as Double/sigmaMap(w) as Double)*(1 + deltaMap(w));
				// Accumulate updates locally 
				if (w != s) {
					myBetweennessMap(w) += deltaMap(w);  
				}
			} // vertexStack not empty
			
			// update global shared state once, atomically.
			for (var i:Int=0; i < N; i++) {
				val result = myBetweennessMap(i);
				if (result != 0.0D)
					betweennessMap(i).adjust(result);
			}
			taskTime += System.nanoTime();
			taskTime = taskTime/(1000*1000);
			Console.OUT.println("VertexStack s=" + s+ " size=" 
					+ vertexStackSizeMax + " time = " + taskTime + " ms " 
					+ (taskTime>0? "(" + safeSubstring("" + (pCount*1.0/taskTime)*100, 0, 3)
							+ "% priorityQ)."  : "")
							+ "vertexTime=" + vertexTime + "ms.");
		}
		public static def safeSubstring(str:String, start:Int, end:Int) 
		= str.substring(start, Math.min(end, str.length()));
		/**
		 * Sequential version to calculate the betweenness centrality. The algorithm
		 * is found in Brandes' 2004 work.
		 */
		public  def brandesBetweenness (P:Int) {	
			/*val chunk = N/P;
			finish 
			for ([i] in 0..P-1) async {
				val start = chunk*i;
				val end = i == P-1 ? N-1 : start +chunk - 1;
				for ([s] in start..end) 
				 dijkstraShortestPaths (s, i);
				Console.OUT.println("Async " + i + " done at "+ System.nanoTime()/(1000*1000));
			}*/
			finish 
			for ([s] in 0..N-1) 
				async {
				
				dijkstraShortestPaths(s);
				
			}
		}
		
		/**
		 * Calls betweeness, prints out the statistics and what not.
		 */
		private def crunchNumbers (printer:Printer) {
			var time:Long = System.nanoTime();
			brandesBetweenness (Runtime.INIT_THREADS);
			time = System.nanoTime() - time;
			printer.println ("Betweenness calculation took " + time/1E9 + " seconds.");
			
			/*for (vertex in betweennessMap.keySet()) {
			 * printer.println ("" + vertex + " = " + 
			 * betweennessMap.getOrElse(vertex,null));
			 * }*/
			var sum:Int=0;
			for ([i] in 0..N-1) sum += betweennessMap(i).count();
			printer.println("Number of updates =" + sum);
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
				
				/* Set the printer appropriate to where the user wants output */
				val printer = (0 == outFileName.compareTo("STDOUT")) ? 
						Console.OUT : (new File(outFileName)).printer();
				val P = Runtime.INIT_THREADS;
				printer.println ("Running SSCA2 with the following parameters:");
				
				if (0 == fileName.compareTo("NOFILE")) {
					printer.println ("seed = " + seed);
					printer.println ("N = " + Math.pow(2, n) as Int);
					printer.println ("a = " + a);
					printer.println ("b = " + b);
					printer.println ("c = " + c);
					printer.println ("d = " + d);
					printer.println ("" + P + " workers.");
					val recursiveMatrixGenerator = Rmat (seed, n, a, b, c, d);
					val graph = recursiveMatrixGenerator.generate ();
					val brandes = new Brandes(graph);
					//printer.println (graph);
					
					brandes.crunchNumbers (printer);
				} else {
					printer.println ("f = " + fileName);
					printer.println ("t = " + fileType);
					printer.println ("i = " + startIndex);
					printer.println ("" + P + " workers.");
					
					val graph = NetReader.readNetFile (fileName, startIndex);
					val brandes = new Brandes(graph);
					//printer.println (graph);
					
					brandes.crunchNumbers (printer);
				}
				
			} catch (e:Throwable) {
				e.printStackTrace(Console.ERR);
			}
		}
}
