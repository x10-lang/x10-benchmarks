// memory per place: 2*16*4^m / MAX_PLACES
// default: m = 10 -> 32M / MAX_PLACES
// m is intended to be incremented by one for every 4x increase in the number of places
// constraint: MAX_PLACES must divide 2^m

// p7ih with 1 place: m = 13 -> 2G -> 4096 16M pages

import x10.compiler.Native;
import x10.compiler.NativeCPPInclude;
import x10.compiler.NativeCPPOutputFile;
import x10.compiler.NativeCPPCompilationUnit;
import x10.compiler.NativeRep;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;
import x10.array.Array_2;
import x10.compiler.Inline;

@NativeCPPInclude("ft_natives.h")
@NativeCPPOutputFile("hpccfft.h")
@NativeCPPOutputFile("wrapfftw.h")
@NativeCPPCompilationUnit("fft235.c")
@NativeCPPCompilationUnit("wrapfftw.c")
@NativeCPPCompilationUnit("zfft1d.c")
@NativeCPPCompilationUnit("ft_natives.cc")

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
class FT(M:Long, verify:Boolean) {
    // TODO: pass through as complex** to native code
    @Native("c++", "execute_plan(#1, (x10_double*)(&((#2)->raw[0])), (x10_double*)(&((#3)->raw[0])), #4, #5, #6)")
    @Native("java", "FTNatives.execute_plan(#plan, #A, #B, #SQRTN, #i0, #i1)")
    native static def execute_plan(plan:Long, A:Rail[Complex], B:Rail[Complex], SQRTN:Long, i0:Long, i1:Long):void;

    @Native("c++", "create_plan(#1, #2, #3)")
    @Native("java", "FTNatives.create_plan(#SQRTN, #direction, #flags)")
    native static def create_plan(SQRTN:Long, direction:Int, flags:Int):Long;
    
    val I = here.id;
    static val r = new Random(here.id);
    
    val SQRTN = 1<<M;
    val N = SQRTN*SQRTN;
    
    val nRows = SQRTN/Place.numPlaces();
    val nCols = SQRTN;
    val localSize = nRows*nCols;
    val chunkSize = nRows*nRows;
    
    val A = new Array_2[Complex](nRows, nCols, (i:Long,j:Long)=>randomComplex(r));
    val B = new Array_2[Complex](nCols, nRows); // transposed shape
    val fftwPlan = create_plan(nCols, -1n, 0n);
    val fftwInversePlan = create_plan(nCols, 1n, 0n);

    @Inline final static def randomComplex(r:Random)=Complex(r.next()-0.5, r.next()-0.5);
   
    def rowFFTS(fwd:Boolean) {
           execute_plan(fwd?fftwPlan:fftwInversePlan, A.raw(), B.raw(), SQRTN, 0, nRows);
    }

    def bytwiddle(sign:Int) {
        val W_N = 2.0*Math.PI/N;
        val s = -sign as Double;
        val globalBase = I*nRows;
        for ([i,j] in A.indices()) {
            val UW = (globalBase+i)*j*W_N;
            A(i,j) *= Complex(Math.cos(UW), s*Math.sin(UW));
        }
    }

    def check() {
        val threshold = 1.0e-15*Math.log(N as Double)/Math.log(2.0)*16;
        val r = new Random(I);
        for ([i,j] in A.indices()) {
            val c =randomComplex(r);
            if ((A(i,j)-c).abs() > threshold) 
                Console.ERR.println("Error at ("+i+","+j+") "+A(i,j)+", expected "+c);
        }
    }

    def warmup() {
        var t:Long = -System.nanoTime();
        Team.WORLD.alltoall(A.raw(), 0, B.raw(), 0, chunkSize);
        t += System.nanoTime(); val t_=t;
        if (I == 0) Logger.info(()=>"1st alltoall: " + format(t_) + " s");
        t = -System.nanoTime(); 
        Team.WORLD.alltoall(A.raw(), 0, B.raw(), 0, chunkSize);
        t += System.nanoTime(); val t__=t;
        if (I == 0) Logger.info(()=>"2nd alltoall: " + format(t__) + " s");
    }

    /*
     * TODO: determine vocabulary of annotations on loops that would permit
     * a declarative specification of this particular loop nest.
     * Tiled version of loop: for ([i,j] in (0..(nRows-1)*(0..(nCols-1)))) B(j,i)=A(i,j)
     */
    def transpose() {
        val n1 = Place.numPlaces();
        val n2 = nRows;
        for (p in 0..(Place.numPlaces()-1)) 
            for (var ii:Long=0; ii<n2; ii+=16) 
                for (var jj:Long=p*n2; jj<(p+1)*n2; jj+=16) 
                    for (i in ii..(Math.min(ii+16,n2)-1)) 
                        for (j in jj..(Math.min(jj+16,nCols)-1)) 
                            B(j,i) = A(i,j);
    }

    def alltoall() {
        Team.WORLD.alltoall(B.raw(), 0, A.raw(), 0, chunkSize);
        val tmp = B.raw();
        B.modifyRaw(A.raw() as Rail[Complex]{self!=null,self.size==B.size});
        A.modifyRaw(tmp as Rail[Complex]{self!=null,self.size==B.size});
    }

    /**
      Scatter elements to the right positions. 
      After a local transpose and an all to all, each location has nPlaces
      arrays, each of size nRows x nRows in row-major order. These need to be collected into
      a single nRows x (nRows*nPlaces) array in row-major order.
     
      Tiled version of loop:       
        for ([i,p,j] in (0..(n2-1))*(0..(n1-1))*(0..(n2-1)) A(i,n2*p+j)=B(n2*p+i,j);
     */
    def scatter() {
        val n1 = Place.numPlaces();
        for (i in 0..(nRows-1)) 
            for (var ii:Long=0; ii<n1; ii += 16) 
                for (var jj:Long=0; jj<nRows; jj += 16) 
                    for (p in ii..(Math.min(ii+16,n1)-1)) 
                        for (j in jj..(Math.min(jj+16,nRows)-1))
                            A(i,nRows*p+j)=B(nRows*p+i,j);
    }

    def globalTranspose(t:Long, timers:Rail[Long]{self!=null}, j:Int, tumbler:Tumbler) {
        timers(t)=System.nanoTime(); transpose();
        
        if (tumbler!= null) tumbler.await(j);
        timers(t+1)=System.nanoTime(); alltoall();
        if (tumbler != null) tumbler.advance(j);
        
        timers(t+2)=System.nanoTime(); scatter();
    }
    
    /**
     * Perform the Discrete FFT. If fwd, run the forward
     * DFT algorithm, else run the inverse DFT algorithm.
     * Return the time it takes to perform the operation.
     */ 
    def compute(j:Int, tumbler:Tumbler, fwd:Boolean) {
        val timers = new Rail[Long](13);
        globalTranspose(0,timers, j, tumbler);

        timers(3)=System.nanoTime(); rowFFTS(fwd);
        globalTranspose(4,timers, j, tumbler);

        timers(7)=System.nanoTime(); bytwiddle(fwd?1n:-1n);
        timers(8)=System.nanoTime(); rowFFTS(fwd);

        globalTranspose(9, timers, j, tumbler);// transpose back to unscrambled order
        timers(12)=System.nanoTime(); 
        // Output
        val secs = format(timers(12) - timers(0));
        val Gigaflops = 1.0e-9*N*5*Math.log(N as Double)/Math.log(2.0)/secs;
        if (I == 0) Logger.info(()=>"execution time=" + secs + " secs" + " Gigaflops=" + Gigaflops);
        val steps = ["transpose1", "alltoall1 ", "scatter1  ", "row_ffts1 ",
                "transpose2", "alltoall2 ", "scatter2  ", "twiddle   ", "row_ffts2 ",
                "transpose3", "alltoall3 ", "scatter3  "];
        if (I == 0) {
            for (i in steps.range()) 
                Logger.info(()=>"Step " + steps(i) + " took " + format(timers(i+1) - timers(i)) + " s");
            val v = timers(12)-timers(11) + timers(10)-timers(6) + timers(5)-timers(2) + timers(1)-timers(0);
            Logger.info(()=>"Computation time: " + format(v) + "s of total time: "
                    + secs + "s (" + (100*format(v)/secs) + "%)");
        }
        return secs;
    }
    
    def run() {
        if (I == 0) Logger.info(()=>"Warmup"); //Warmup
        warmup();
        Team.WORLD.barrier();
        if (I == 0) Logger.info(()=>"Warmup complete;starting FFT");
        var secs:Double = compute(0n, null, true);
        Team.WORLD.barrier();
        if (I == 0) Logger.info(()=>"FFT complete; starting reverse FFT");
        secs += compute(0n, null, false);
        Team.WORLD.barrier();
        if (I == 0) {// Output
            Logger.info(()=>"Reverse FFT complete");
            Logger.info(()=>"Now combining forward and inverse FTT measurements");
            val Gigaflops = 2.0e-9*N*5*Math.log(N as Double)/Math.log(2.0)/secs, secs_=secs;
            Logger.info(()=>"execution time=" + secs_ + " secs"+" Gigaflops="+Gigaflops);
        }
        if (verify) {  // Verification
            if (I == 0) Logger.info(()=>"Start verification");
            check();
            if (I == 0) Logger.info(()=>"Verification complete");
        }
    }

    static def format(t:Long) = (t as Double) * 1.0e-9;
    
    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, [
            Option("v", "verify", "verify results"),
            Option.HELP
        ], [
            Option("m", "magnitude", "log2 size of the vector (default 10)")
        ]);
        if (opts.wantsUsageOnly("")) return;
        val M = opts("-m", 10n);
        val verify = opts("-v", false);
        val SQRTN = 1 << M;
        val nRows = SQRTN / Place.numPlaces();
        if (nRows * Place.numPlaces() != SQRTN) {
            Console.ERR.println("SQRTN must be divisible by Place.numPlaces()!");
            return;
        }
        val plh = PlaceLocalHandle.makeFlat[FT](Place.places(), ()=>new FT(M, verify));
        val o=plh();
        val mbytes = o.N*2.0*8.0*2/(1024*1024);
        Logger.info(()=>"M=" + o.M + " SQRTN=" + o.SQRTN + " N=" + o.N + " nRows=" + o.nRows +
                " localSize=" + o.localSize + " MAX_PLACES=" + Place.numPlaces() +
                              " Mem=" + mbytes + " mem/MAX_PLACES=" + mbytes/Place.numPlaces());
        
        Place.places().broadcastFlat(()=>{plh().run();});
    }
}
