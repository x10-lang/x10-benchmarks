// memory per place: 3*8*n
// default: n = 64M -> 1.5G per place
// n is intended to remain constant (independent of the number of places)

// p7ih: 32 places per node -> 48G -> 3072 16M pages

import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;

public class Stream {

    static MEG = 1024*1024;
    static alpha = 3.0D;

    static NUM_TIMES = 10;

    static DEFAULT_SIZE = 64 * MEG;

    static NUM_PLACES = Place.MAX_PLACES;

    public static def main(args:Rail[String]){here == Place.FIRST_PLACE} {
        val verified = new Cell[Boolean](true);
        val times = GlobalRef[Rail[Double]](new Rail[Double](NUM_TIMES));

        val opts = new OptionsParser(args, [
            Option.HELP as Option
        ], [
            Option("n", "", "size of local arrays (default " + DEFAULT_SIZE + ")")
        ]);
        if (opts.wantsUsageOnly("")) {
            return;
        }
        val N0 = opts("-n", DEFAULT_SIZE);

        val N = N0 * NUM_PLACES;
        val localSize =  N0;

        Console.OUT.println("localSize=" + localSize);

        PlaceGroup.WORLD.broadcastFlat(()=>{
                val p = here.id;
                val allocator = Runtime.MemoryAllocator.requestAllocator(true, false);
                val a = new Rail[Double](localSize, allocator);
                val b = new Rail[Double](localSize, allocator);
                val c = new Rail[Double](localSize, allocator);
                
                for (var i:Long=0; i<localSize; i++) {
                    b(i) = 1.5 * (p*localSize+i);
                    c(i) = 2.5 * (p*localSize+i);
                }
                
                val beta = alpha;
                
                for (var j:Long=0; j<NUM_TIMES; j++) {
                    if (p==0) {
                        val t = times as GlobalRef[Rail[Double]]{self.home==here};
                        t()(j) = -now();
                    }
                    for (var i:Long=0; i<localSize; i++)
                        a(i) = b(i) + beta*c(i);
                    Team.WORLD.barrier();
                    if (p==0) {
                        val t = times as GlobalRef[Rail[Double]]{self.home==here};
                        t()(j) += now();
                    }
                }
                
                // verification
                for (var i:Long=0; i<localSize; i++)
                    if (a(i) != b(i) + alpha*c(i)) 
                        verified.set(false);
            });

        var min:Double = 1000000;
        for (var j:Long=1; j<NUM_TIMES; j++)
            if (times()(j) < min)
                min = times()(j);
        printStats(N, min, verified());
    }

    static def now():Double = System.nanoTime() * 1e-9;

    static def printStats(N:Long, time:Double, verified:Boolean) {
        val size = (3*8*N/MEG);
        val rate = (3*8*N) / (1.0E9*time);
        Console.OUT.println("Number of places=" + NUM_PLACES);
        Console.OUT.println("Size of arrays: " + size +" MB (total) " + size/NUM_PLACES + " MB (per place)");
        Console.OUT.println("Min time: " + time + " rate=" + rate + " GB/s");
        Console.OUT.println("Result is " + (verified ? "verified." : "NOT verified."));
    }                                
}
