/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2014.
 */

import x10.util.Option;
import x10.util.OptionsParser;
import x10.xrx.Runtime;

// memory per place: 8*2^m
// default: m = 12 -> 32K per place
// m is intended to remain constant (independent of the number of places)

// p7ih: -m 28 -> 2G per place
// p7ih: 32 places per node -> 64G -> 4096 16M pages

public class RandomAccess {

    static POLY = 0x0000000000000007L;
    static PERIOD = 1317624576693539401L;

    // Utility routine to start random number generator at Nth step
    static def HPCC_starts(var n:Long): Long {
        var i:Int, j:Int;
        val m2 = new Rail[Long](64);
        while (n < 0) n += PERIOD;
        while (n > PERIOD) n -= PERIOD;
        if (n == 0) return 0x1;
        var temp:Long = 0x1;
        for (i=0n; i<64n; i++) {
            m2(i) = temp;
            temp = (temp << 1) ^ (temp < 0 ? POLY : 0);
            temp = (temp << 1) ^ (temp < 0 ? POLY : 0);
        }
        for (i=62n; i>=0n; i--) if (((n >> i) & 1n) != 0) break;
        var ran:Long = 0x2;
        while (i > 0n) {
            temp = 0;
            for (j=0n; j<64n; j++) if (((ran >> j) & 1n) != 0) temp ^= m2(j);
            ran = temp;
            i -= 1n;
            if (((n >> i) & 1) != 0)
                ran = (ran << 1) ^ (ran < 0 ? POLY : 0);
        }
        return ran;
    }

    static def runBenchmark(dr:DistRail, logLocalTableSize:Long, numUpdates:Long) {
        dr.pg.broadcastFlat(()=>{
          finish {
            val numLocalUpdates = numUpdates / Place.numPlaces();
            var ran:Long = HPCC_starts(here.id*numLocalUpdates);
            val mask1 = (1<<logLocalTableSize)-1;
            val mask2 = Place.numPlaces() - 1;
            for (1..numLocalUpdates) {
                val placeId = (ran >> logLocalTableSize) & mask2;
                val index = ran & mask1;
                val update = ran;
                dr.xor(placeId, index, update);
                ran = (ran << 1) ^ (ran < 0 ? POLY : 0);
            }
            GlobalRail.flushRemoteOps();
          }
        });
    }

    public static def main (args:Rail[String]) {
        if (!Math.powerOf2(Place.numPlaces())) {
            Console.ERR.println("The number of places must be a power of 2.");
            return;
        }

        val opts = new OptionsParser(args, [
            Option("d", "dumpTable", "print first elements of local tables after each phase"),
            Option("c", "congruent", "use congruent memory (same virtual address in all places)"),
            Option("l", "largePages", "use large pages when allocating table"),
	    Option.HELP
	], [
            Option("m", "magnitude", "log2 size of the local table (default 12)"),
            Option("u", "updates", "number of updates per element (default 4)")
        ]);
        if (opts.wantsUsageOnly("ra")) {
            return;
        }

        val logLocalTableSize = opts("-m", 12);
        val updates = opts("-u", 4d);
	val dumpTable = opts("-d");
	val largePages = opts("-l");
	val congruent = opts("-c");
        if (largePages) {
            Console.OUT.println("Will request large pages.  Available? " +Runtime.MemoryAllocator.hugePagesAvailable());
        }
        if (congruent) {
            Console.OUT.println("Will request congruent pages.  Available? " +Runtime.MemoryAllocator.congruentAvailable());
        }

        // calculate the size of update array
        val localTableSize = 1<<logLocalTableSize;
        val tableSize = localTableSize * Place.numPlaces();
        val numUpdates = (updates * tableSize) as Long;

        // create distributed rail 
	val dr = new DistRail(Place.places(), localTableSize, congruent, largePages, (i:long)=>i);

	if (dumpTable) dr.printAll();

        // print some info
        Console.OUT.println("Main table size:         2^"+logLocalTableSize+"*"+Place.numPlaces()
                                       +" == "+tableSize+" words"
                                       +" ("+tableSize*8.0/1024/1024+" MB)");
        Console.OUT.println("Per-process table size:  2^"+logLocalTableSize
                                       +" == "+localTableSize+" words"
                                       +" ("+localTableSize*8.0/1024/1024+" MB)");
        Console.OUT.println("Number of places:        " + Place.numPlaces());
        Console.OUT.println("Number of updates:       " + numUpdates);

        // time it
        var cpuTime:Double = -System.nanoTime() * 1e-9D;
        runBenchmark(dr, logLocalTableSize, numUpdates);
        cpuTime += System.nanoTime() * 1e-9D;

	if (dumpTable) dr.printAll();

        // print statistics
        val GUPs = (cpuTime > 0.0 ? 1.0 / cpuTime : -1.0) * numUpdates / 1e9;
        Console.OUT.println("CPU time used: "+cpuTime+" seconds");
        Console.OUT.println(GUPs+" Billion(10^9) Updates per second (GUP/s)");

        // repeat for testing.
        runBenchmark(dr, logLocalTableSize, numUpdates);
        Place.places().broadcastFlat(()=>{
            var err:Int = 0n;
            for (i in 0..(localTableSize-1)) 
                if (dr(i) != (i as Long)) err++;
            Console.OUT.println(here+": Found " + err + " errors.");
        });

	if (dumpTable) dr.printAll();

        // print statistics again
        Console.OUT.println("CPU time used: "+cpuTime+" seconds");
        Console.OUT.println(GUPs+" Billion(10^9) Updates per second (GUP/s)");
    }
}
