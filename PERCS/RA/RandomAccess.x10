// memory per place: 8*2^m
// default: m = 12 -> 32K per place
// m is intended to remain constant (independent of the number of places)

// p7ih: -m 28 -> 2G per place
// p7ih: 32 places per node -> 64G -> 4096 16M pages

class RandomAccess {

    static POLY = 0x0000000000000007L;
    static PERIOD = 1317624576693539401L;

    // Utility routine to start random number generator at Nth step
    static def HPCC_starts(var n:Long): Long {
        var i:Int, j:Int;
        val m2 = new Rail[Long](64);
        while (n < 0) n += PERIOD;
        while (n > PERIOD) n -= PERIOD;
        if (n == 0L) return 0x1L;
        var temp:Long = 0x1;
        for (i=0n; i<64n; i++) {
            m2(i) = temp;
            temp = (temp << 1) ^ (temp < 0 ? POLY : 0L);
            temp = (temp << 1) ^ (temp < 0 ? POLY : 0L);
        }
        for (i=62n; i>=0n; i--) if (((n >> i) & 1n) != 0L) break;
        var ran:Long = 0x2;
        while (i > 0n) {
            temp = 0;
            for (j=0n; j<64n; j++) if (((ran >> j) & 1n) != 0L) temp ^= m2(j);
            ran = temp;
            i -= 1n;
            if (((n >> i) & 1) != 0L)
                ran = (ran << 1) ^ (ran < 0 ? POLY : 0L);
        }
        return ran;
    }

    static def runBenchmark(plh: PlaceLocalHandle[Rail[Long]],
                            logLocalTableSize: Int, numUpdates: Long) {
        val mask = (1<<logLocalTableSize)-1;
        val local_updates = numUpdates / Place.MAX_PLACES;

        val max = Place.MAX_PLACES;

        PlaceGroup.WORLD.broadcastFlat(()=>{
            val jj = Runtime.hereLong();
            val t = System.nanoTime();
            var ran:Long = HPCC_starts(jj*(numUpdates/Place.MAX_PLACES));
            val rail = plh() as Rail[Long]{self!=null};
            val size = logLocalTableSize;
            val mask1 = mask;
            val mask2 = Place.MAX_PLACES - 1;
            val poly = POLY;
            val lu = local_updates;
            for (var k:Long=0 ; k<lu ; k+=1L) {
                val place_id = ((ran>>size) as Int) & mask2;
                val index = (ran as Int) & mask1;
                val update = ran;
                if (place_id==jj) {
                    rail(index) ^= update;
                } else {
                    GlobalRail.remoteXor(Unsafe.getCongruentSibling(rail, Place(place_id)), index, update);
                }
                ran = (ran << 1) ^ (ran<0L ? poly : 0L);
            }
	    GlobalRail.flushRemoteOps();
            
            val u = System.nanoTime() - t;
//            Runtime.println("" + jj + " -> " + (u/1e9));
        });
    }

    private static def help (err:Boolean) {
        if (here.id!=0L) return;
        val out = err ? Console.ERR : Console.OUT;
        out.println("Usage: ra [-m <mem>] [-u <updates>]");
        out.println("where");
        out.println("   <mem> is the log2 size of the local table (default 12)");
        out.println("   <updates> is the number of updates per element (default 4)");
    }

    public static def main (args:Rail[String]) {

        if ((Place.MAX_PLACES & (Place.MAX_PLACES-1)) > 0) {
            Console.ERR.println("The number of places must be a power of 2.");
            return;
        }

        var logLocalTableSize_ : Int = 12n;
        var updates_ : Int = 4n;

        // parse arguments
        for (var i:Long=0 ; i<args.size ; ) {
            if (args(i).equals("-m")) {
                i++;
                if (i >= args.size) {
                    if (here.id==0L)
                        Console.ERR.println("Too few cmdline params.");
                    help(true);
                    return;
                }
                logLocalTableSize_ = Int.parseInt(args(i++));
            } else if (args(i).equals("-u")) {
                i++;
                if (i >= args.size) {
                    if (here.id==0L)
                        Console.ERR.println("Too few cmdline params.");
                    help(true);
                    return;
                }
                updates_ = Int.parseInt(args(i++));
            } else {
                if (here.id==0L)
                    Console.ERR.println("Unrecognised cmdline param: \""+args(i)+"\"");
                help(true);
                return;
            }
        }

        // calculate the size of update array (must be a power of 2)
        val logLocalTableSize = logLocalTableSize_;
        val localTableSize = 1<<logLocalTableSize;
        val tableSize = (localTableSize as Long)*Place.MAX_PLACES;
        val numUpdates = updates_*tableSize;

        // create congruent array (same address at each place)
        val hugePagesAvailable = Runtime.MemoryAllocator.hugePagesAvailable();
        Console.OUT.println("Huge pages available:    " + hugePagesAvailable);
        val init = ():Rail[Long] => { new Rail[Long](localTableSize, Runtime.MemoryAllocator.requireAllocator(hugePagesAvailable, true)) };;
        val plh = PlaceLocalHandle.makeFlat[Rail[Long]](PlaceGroup.WORLD, init);
        PlaceGroup.WORLD.broadcastFlat(()=>{
            for (i in 0..(localTableSize-1)) plh()(i) = i as Long;
        });

        // print some info
        Console.OUT.println("Main table size:         2^"+logLocalTableSize+"*"+Place.MAX_PLACES
                                       +" == "+tableSize+" words"
                                       +" ("+tableSize*8.0/1024/1024+" MB)");
        Console.OUT.println("Per-process table size:  2^"+logLocalTableSize
                                       +" == "+localTableSize+" words"
                                       +" ("+localTableSize*8.0/1024/1024+" MB)");
        Console.OUT.println("Number of places:        " + Place.MAX_PLACES);
        Console.OUT.println("Number of updates:       " + numUpdates);

        // time it
        var cpuTime:Double = -System.nanoTime() * 1e-9D;
        runBenchmark(plh, logLocalTableSize, numUpdates);
        cpuTime += System.nanoTime() * 1e-9D;

        // print statistics
        val GUPs = (cpuTime > 0.0 ? 1.0 / cpuTime : -1.0) * numUpdates / 1e9;
        Console.OUT.println("CPU time used: "+cpuTime+" seconds");
        Console.OUT.println(GUPs+" Billion(10^9) Updates per second (GUP/s)");

        // repeat for testing.
        runBenchmark(plh, logLocalTableSize, numUpdates);
        PlaceGroup.WORLD.broadcastFlat(()=>{
            var err:Int = 0n;
            for (i in 0..(localTableSize-1)) 
                if (plh()(i) != (i as Long)) err++;
            Console.OUT.println(here+": Found " + err + " errors.");
        });

        // print statistics again
        Console.OUT.println("CPU time used: "+cpuTime+" seconds");
        Console.OUT.println(GUPs+" Billion(10^9) Updates per second (GUP/s)");
    }
}
