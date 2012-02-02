import x10.compiler.*;
import x10.util.OptionsParser;
import x10.util.Option;

//@x10.compiler.NativeCPPInclude("google/profiler.h")

public class UTSGeo {

    private static val NORMALIZER = 2147483648.0; // does not depend on input parameters

    public static def main (args : Array[String](1)) {
        try {
            val opts = new OptionsParser(args, null, [
                    Option("b", "", "Branching factor"),
                    Option("r", "", "Root seed (0 <= r < 2^31"),
                    Option("d", "", "GEO: Tree depth"),
                    Option("k", "", "Number of items to steal; default 0. If 0, steal half. "),
                    Option("n", "", "Number of nodes to process before probing."),
                    Option("w", "", "Number of thieves to send out, less 1. (Default 0, so 1 thief will be sent out."),
                    Option("l", "", "Lifeline method: 0 for linear, 1 for hypercube, 2 for sparse chunked, 3 for sparse embedding -- in which case also enter dimension"),
                    Option("z", "", "Dimension of the sparse hypercube"),
                    Option("v", "", "Verbose, default 0 (no).")
                ]);

            val b0 = opts ("-b", 4);
            val r = opts ("-r", 0);

            // Geometric options
            val d:Int = opts ("-d", 6);

            val k = opts ("-k", 0);
            val n = opts("-n", 200);
            val w = opts("-w", 0);

            // Figure out what kind of connectivity is needed.
            val l = opts ("-l", 3);
            val z = opts ("-z", 1);

            val verbose = opts("-v", 0)==1;

            val P = Place.MAX_PLACES;

            Console.OUT.println("--------");
            Console.OUT.println("Places=" + P);
            Console.OUT.println("b0=" + b0 +
                    "   r=" + r +
                    "   d=" + d +
                    "   k=" + k +
                    "   n=" + n +
                    "   w=" + w +
                    "   l=" + l + 
                    "   z=" + z +
                    (l==3 ? " base=" + (z==0 ? 0 : NetworkGenerator.findW(Place.MAX_PLACES, z)) : "")
                );

            // Generate the lifelines
            val lifelines:Rail[Rail[Int]] =
                (0==l) ? NetworkGenerator.generateRing(P):
                (1==l) ? NetworkGenerator.generateHyperCube(P):
                (2==l) ? NetworkGenerator.generateChunkedGraph (P, z):
                NetworkGenerator.generateSparseEmbedding (P, z);

            val st = PlaceLocalHandle.make[ParUTSGeo](Dist.makeUnique(), ()=>new ParUTSGeo(b0, 3, d, k, n, w, e, l, lifelines(here.id)));

            Console.OUT.println("Starting...");
            //@Native("c++", "ProfilerStart(\"UTS.prof\");") {}
            var time:Long = -System.nanoTime();
            st().main(st, SHA1RandX(r));
            //@Native("c++", "ProfilerStop();") {}
            time += System.nanoTime();
            Console.OUT.println("Finished.");
            val cl = (i:Int) => { val pi = Place(i); return at(pi) st().counters(); };
            val allCounters = new Rail[Array[Counter](1){rail}](P,cl);
            st().counter.stats(allCounters, time, verbose, false);

            Console.OUT.println("--------");
        } catch (e:Throwable) {
            e.printStackTrace();
        }
    }
}

// vim: ts=2:sw=2:et
