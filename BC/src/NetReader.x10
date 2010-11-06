import x10.io.File;
import x10.io.Reader;
import x10.io.ReaderIterator;

/* A class to read the NET format by Pajek */
public  struct NetReader {
  /* The function that reads in stuff from a file and populates it */
  public static def readNetFile (fileName:String,
                                 startIndex:Int) : 
                                AdjacencyGraph {

    val inputFile:File = new File(fileName);
    val inputFileReader:Reader = inputFile.openRead();
    val inputFileIterator:ReaderIterator[String] = inputFileReader.lines();

    /* Find out the number of vertices --- this is needed to initialize */
    val firstLine:String = inputFileIterator.next().toLowerCase();
    val N:Int = (0 > firstLine.lastIndexOf ("*vertices")) ? 
                      -1: /* error --- first line has to be "*Vertices" */
                      Int.parse(firstLine.split (" ")(1));

    if (0 > N) throw new Exception ("Incorrect File Format");

    val adjacencyGraph = new AdjacencyGraph(N);

    /* Iterate over the lines and construct the graph */
    var foundEdges:Boolean = false;
    while (inputFileIterator.hasNext()) {
      val thisLine:String = inputFileIterator.next().toLowerCase().trim();

      if (0 <= thisLine.lastIndexOf("*edgeslist") || 
          0 <= thisLine.lastIndexOf("*arcslist")) {
        throw new Exception ("We do not support EdgesList or ArcsList");
      } else if (0 <= thisLine.lastIndexOf("*edges") || 
                 0 <= thisLine.lastIndexOf("*arcs")) {
        foundEdges = true;
        continue; 
      }

      /* Process the edges or edgelist remaining */
      if (foundEdges) {
        val tokens:Rail[String] = thisLine.split(" ");

        if (3 != tokens.length() && 2 != tokens.length()) 
          throw new Exception ("Format not \"src dest weight\"");

        val source= Int.parse (tokens(0)) - startIndex;
        val destination = Int.parse (tokens(1)) - startIndex;
        val weight:ULong = (2==tokens.length()) ? 1 as ULong: 
                                                  ULong.parse (tokens(2));

        adjacencyGraph.addEdge (source, destination, weight);
        adjacencyGraph.incrementInDegree (destination);
      }
    }
    return adjacencyGraph;
  }
}
