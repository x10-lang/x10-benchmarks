package uts.dist;

import x10.compiler.*;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Random;

public final class UTSD {
    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, new Rail[Option](), [
                                                                Option("b", "", "Branching factor"),
                                                                Option("r", "", "Seed (0 <= r < 2^31"),
                                                                Option("d", "", "Tree depth"),
                                                                Option("n", "", "Number of nodes to process before probing. Default 200."),
                                                                Option("w", "", "Number of thieves to send out. Default 1."),
                                                                Option("l", "", "Base of the lifeline"),
                                                                Option("m", "", "Max potential victims"),
                                                                Option("v", "", "Verbose. Default 0 (no).")]);

        val b = opts("-b", 4n);
        val r = opts("-r", 19n);
        val d = opts("-d", 13n);
        val n = opts("-n", 511n);
        val l = opts("-l", 32n);
        val m = opts("-m", 1024n);
        val verbose = opts("-v", 0) != 0;

        val P = Place.numPlaces();

        var z0:Int = 1n;
        var zz:Int = l;
        while (zz < P) {
            z0++;
            zz *= l;
        }
        val z = z0;

        val w = opts("-w", z);

        Console.OUT.println("places=" + P +
                "   b=" + b +
                        "   r=" + r +
                                "   d=" + d +
                                        "   w=" + w +
                                                "   n=" + n +
                                                        "   l=" + l + 
                                                                "   m=" + m + 
                                                                        "   z=" + z);

        val st = PlaceLocalHandle.makeFlat[Worker](Place.places(), ()=>new Worker(b, d, n, w, l, z, m));

        Console.OUT.println("Starting...");
        var time:Long = System.nanoTime();
        st().main(st, r, d);
        time = System.nanoTime() - time;
        Console.OUT.println("Finished.");

        val count = Worker.stats(st, verbose);

        TaskQueue.print(time, count);
    }
}
