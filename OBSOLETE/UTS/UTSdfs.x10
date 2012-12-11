import x10.util.OptionsParser;
import x10.util.Option;

//@x10.compiler.NativeCPPInclude("google/profiler.h")

public class UTSdfs {
    public static def main(args:Array[String](1)) {
        val opts = new OptionsParser(args, null, [
                Option("b", "", "Branching factor"),
                Option("r", "", "Seed (0 <= r < 2^31"),
                Option("d", "", "Tree depth"),
                Option("n", "", "Number of nodes to process before probing. Default 200."),
                Option("w", "", "Number of thieves to send out. Default 1."),
                Option("l", "", "Lifeline method: 0 for linear, 1 for hypercube, 2 for sparse chunked, 3 for sparse embedding -- in which case also enter dimension"),
                Option("z", "", "Dimension of the sparse hypercube"),
                Option("v", "", "Verbose. Default 0 (no).")]);
        
        val b = opts("-b", 4);
        val r = opts("-r", 0);
        val d = opts("-d", 6);
        val n = opts("-n", 200);
        val w = opts("-w", 1);
        val l = opts("-l", 3);
        val z = opts("-z", 1);
        val verbose = opts("-v", 0) != 0;
        
        val P = Place.MAX_PLACES;
        
        Console.OUT.println("places=" + P +
                "   b=" + b +
                "   r=" + r +
                "   d=" + d +
                "   w=" + w +
                "   n=" + n +
                "   l=" + l + 
                "   z=" + z +
                (l==3 ? "   base=" + (z==0 ? 0 : NetworkGenerator.findW(P, z)) : ""));
        
        // Generate the lifelines
        val lifelines:Rail[Rail[Int]] =
            (0==l) ? NetworkGenerator.generateRing(P):
            (1==l) ? NetworkGenerator.generateHyperCube(P):
            (2==l) ? NetworkGenerator.generateChunkedGraph(P, z):
                     NetworkGenerator.generateSparseEmbedding(P, z);
        
        val st = PlaceLocalHandle.make[ParUTSdfs,Rail[Int]](Dist.makeUnique(),
                (p:Place)=>lifelines(p.id),
                (lifelines:Rail[Int])=>new ParUTSdfs(b, d, n, w, l, lifelines));
        
        Console.OUT.println("Starting...");
        //@Native("c++", "ProfilerStart(\"UTS.prof\");") {}
        var time:Long = System.nanoTime();
        st().main(st, r);
        time = System.nanoTime() - time;
        //@Native("c++", "ProfilerStop();") {}
        Console.OUT.println("Finished.");
        
        val logs = new Rail[Logger](P, (i:Int)=>at (Place(i)) st().logger);
        new Logger().stats(logs, time, verbose);
    }
}

// vim: ts=2:sw=2:et
