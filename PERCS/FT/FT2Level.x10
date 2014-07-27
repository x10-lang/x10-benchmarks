// memory per place: 2*16*4^m / MAX_PLACES
// default: m = 10 -> 32M / MAX_PLACES
// m is intended to be incremented by one for every 4x increase in the number of places
// constraint: MAX_PLACES must divide 2^m

// p7ih with 1 place: m = 13 -> 2G -> 4096 16M pages


import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;
import x10.array.Array_2;
import x10.compiler.Inline;
import FT;

/**
 * Implementation of a 1-D Discrete FFT on Complex inputs of size N=2^M, using the transpose
 * method. See e.g. 
 * <a url="http://courses.engr.illinois.edu/cs554/notes/13_fft_8up.pdf">FFT lecture</a>.
 * 
 * <p>The input is represented as a 2D SQRTN * (SQRTN) array of Complex.
 * The array is row partitioned across P places. To perform an FFT, each place transposes
 * its data, performs an all to all, scatters the data to the correct indices (thus 
 * completing a global transpose), then performs a local FFT operation (using FFTW), 
 * then a global transpose, then a bytwiddle and local FFT, completing with a global transpose.
 * <p> Validation is done by performing a forward FFT, then a reverse FFT. These should compute
 * the identity transformation. (Reverse FFT is the same as a forward fft with the sign changed
 * for the bytwiddle operation.)
 */
class FT2Level(workers:Rail[FT]) {
    val I = here.id;
    def twoLevelBarrier(j:Long, phase:Int) {
	Logger.debug(()=> I + "/" + j + " in advanceAll " + phase + "a.");
	Clock.advanceAll();
	Logger.debug(()=> I + "/" + j + " exited advanceAll " + phase + "a.");
	if (j == 0) {
	    Logger.info(()=> I + "/" + "0 entering barrier " + phase + ".");
	    Team.WORLD.barrier();
	    Logger.info(()=> I + "/" +"0 exiting barrier " + phase + ".");
	}
	Logger.info(()=>I + "/" + j + " entering advanceAll " + phase + "b.");
	Clock.advanceAll();
	Logger.info(()=>I + "/" + j + " exited advanceAll " + phase + "b.");

    }
   
    def run() {
             if (I == 0) Logger.info(()=>"Warmup"); //Warmup
        val tumbler = new Tumbler(workers.size as Int);
        clocked finish for (j in workers.range()) clocked async {
            val w = workers(j);

            if (j == 0) w.warmup();
            
	    twoLevelBarrier(j, 1n);
            
            if (I == 0 && j == 0) Logger.info(()=>"Warmup complete;starting FFT");
            
            var secs:Double = w.compute(j as Int, tumbler, true);

	    twoLevelBarrier(j, 2n);


            if (I == 0) Logger.info(()=>"FFT complete; starting reverse FFT");

            secs += w.compute(j as Int, tumbler, false);
            
	    twoLevelBarrier(j, 3n);

            if (j == 0) {
                if (I == 0) {// Output
                    Logger.info(()=>"Reverse FFT complete");
                    Logger.info(()=>"Now combining forward and inverse FTT measurements");
		    val  N=workers(0).N;
                    val Gigaflops = 2.0e-9*N*5*Math.log(N as Double)/Math.log(2.0)/secs; 
                    val secs_=secs;
                    Logger.info(()=>"execution time=" + secs_ + " secs"+" Gigaflops="+Gigaflops);
                }
                
                if (workers(0).verify) {  // Verification
                    if (I == 0) Logger.info(()=>"Start verification");
                    workers(0).check();
                    if (I == 0) Logger.info(()=>"Verification complete");
                }
            }
        }
    }

    static def format(t:Long) = (t as Double) * 1.0e-9;
    
    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, [
            Option("v", "verify", "verify results"),
            Option.HELP
        ], [
            Option("m", "magnitude", "log2 size of the vector (default 10)"),
            Option("w", "workers/place", "number of workers per place (default 1)")
        ]);
        if (opts.wantsUsageOnly("")) return;
        val M = opts("-m", 10n);
        val W = opts("-w", 1n);
        val verify = opts("-v", false);
        val SQRTN = 1 << M, N = SQRTN * SQRTN;
        val nRows = SQRTN / Place.numPlaces();
        if (nRows * Place.numPlaces() != SQRTN) {
            Console.ERR.println("SQRTN must be divisible by Place.numPlaces()!");
            return;
        }
        val plh = PlaceLocalHandle.makeFlat[FT2Level](Place.places(), 
                ()=>new FT2Level(new Rail[FT](W, (i:Long)=> new FT(M,verify))));
        val o=plh();
        val mbytes = N*2.0*8.0*2/(1024*1024);
        Logger.info(()=>"M=" + M + " SQRTN=" + SQRTN + " N=" + N + " nRows=" + nRows +
                " localSize=" + plh().workers(0).localSize + " MAX_PLACES=" + Place.numPlaces() + " workers/place=" + W +
                              " Mem=" + mbytes + " mem/MAX_PLACES=" + mbytes/Place.numPlaces());
        
        Place.places().broadcastFlat(()=>{plh().run();});
    }
}
