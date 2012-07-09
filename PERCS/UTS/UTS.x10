import x10.util.OptionsParser;
import x10.util.Option;

//@x10.compiler.NativeCPPInclude("google/profiler.h")

public class UTS {
    public static def main(args:Array[String](1)) {
        val opts = new OptionsParser(args, null, [
                Option("b", "", "Branching factor"),
                Option("r", "", "Seed (0 <= r < 2^31"),
                Option("d", "", "Tree depth"),
                Option("n", "", "Number of nodes to process before probing. Default 200."),
                Option("w", "", "Number of thieves to send out. Default 1."),
                Option("l", "", "Base of the lifeline"),
                Option("z", "", "Depth of the lifeline"),
                Option("v", "", "Verbose. Default 0 (no).")]);
        
        val b = opts("-b", 4);
        val r = opts("-r", 0);
        val d = opts("-d", 6);
        val n = opts("-n", 200);
        val w = opts("-w", 1);
        val l = opts("-l", 32);
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
                "   z=" + z);
        
        val st = PlaceLocalHandle.makeFlat[ParUTS](PlaceGroup.WORLD, ()=>new ParUTS(b, d, n, w, l, z));
        
        Console.OUT.println("Starting...");
        //@Native("c++", "ProfilerStart(\"UTS.prof\");") {}
        var time:Long = System.nanoTime();
        st().main(st, r);
        time = System.nanoTime() - time;
        //@Native("c++", "ProfilerStop();") {}
        Console.OUT.println("Finished.");
        
        val logs:Rail[Logger];
        if (Place.MAX_PLACES >= 1024) {
            logs = new Rail[Logger](Place.MAX_PLACES/32, (i:Int)=>at (Place(i*32)) {
                val h = Runtime.hereInt();
                val n = Math.min(32, Place.MAX_PLACES-h);
                val logs = new Rail[Logger](n, (i:Int)=>at (Place(h+i)) st().logger);
                val log = new Logger();
                log.collect(logs);
                return log;
            });
        } else {
            logs = new Rail[Logger](P, (i:Int)=>at (Place(i)) st().logger);
        }
        val log = new Logger();
        log.collect(logs);
        log.stats(time, verbose);
    }
}

// vim: ts=2:sw=2:et
