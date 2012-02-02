import x10.compiler.*;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;
import x10.util.Random;
import x10.util.Stack;

//@x10.compiler.NativeCPPInclude("google/profiler.h")

public class UTSdfs {
    public static def main (args:Array[String](1)) {
        try {
            val opts = new OptionsParser(args, null, [
                    Option("b", "", "Branching factor"),
                    Option("r", "", "Seed (0 <= r < 2^31"),
                    Option("d", "", "Tree depth"),
                    Option("k", "", "Number of items to steal; default 0. If 0, steal half. "),
                    Option("n", "", "Number of nodes to process before probing."),
                    Option("w", "", "Number of thieves to send out, less 1. (Default 0, so 1 thief will be sent out."),
                    Option("l", "", "Lifeline method: 0 for linear, 1 for hypercube, 2 for sparse chunked, 3 for sparse embedding -- in which case also enter dimension"),
                    Option("z", "", "Dimension of the sparse hypercube"),
                    Option("v", "", "Verbose, default 0 (no).")
                ]);
            
            val b = opts("-b", 4);
            val r = opts("-r", 0);
            val d = opts("-d", 6);
            val n = opts("-n", 200);
            val k = opts("-k", 0);
            val w = opts("-w", 0);
            val l = opts("-l", 3);
            val z = opts("-z", 1);
            val verbose = opts("-v", 0) != 0;
            
            Console.OUT.println("--------");
            Console.OUT.println("Places="+Place.MAX_PLACES);
            Console.OUT.println("b=" + b +
                    "   r=" + r +
                    "   k=" + k +
                    "   w=" + w +
                    "   n=" + n +
                    "   d=" + d +
                    "   l=" + l + 
                    "   z=" + z +
                    (l==3 ? " base=" + (z==0 ? 0 : NetworkGenerator.findW(Place.MAX_PLACES, z)) : "")
                );
            
            val P = Place.MAX_PLACES;
            
            // Generate the lifelines
            val lifelines:Rail[Rail[Int]] =
                (0==l) ? NetworkGenerator.generateRing(P):
                (1==l) ? NetworkGenerator.generateHyperCube(P):
                (2==l) ? NetworkGenerator.generateChunkedGraph (P, z):
                         NetworkGenerator.generateSparseEmbedding (P, z);
            
            val size = lifelines(0).size > 2 ? lifelines(0).size : 2;
            val thieves = new Rail[FixedSizeStack[Int]](P, new FixedSizeStack[Int](size));
            
            for (var i:Int=1; i<P; ++i) {
                thieves((i-1)/2).push(i);
            }
            val st = PlaceLocalHandle.make[ParUTSdfs](Dist.makeUnique(), ()=>new ParUTSdfs(b, d, k, n, w, l, lifelines(Runtime.hereInt()), thieves(Runtime.hereInt())));
            
            Console.OUT.println("Starting...");
            //@Native("c++", "ProfilerStart(\"UTS.prof\");") {}
            var time:Long = System.nanoTime();
            st().main(st, r);
            time = System.nanoTime() - time;
            //@Native("c++", "ProfilerStop();") {}
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
