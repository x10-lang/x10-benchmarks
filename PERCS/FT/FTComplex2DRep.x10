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
 * <p>The input is represented as a 2D SQRTN * SQRTN array of Complex,
 * row partitioned across P places. Local FFT computations are performed using
 * FFTW. 
 */
class FTComplex2DRep(M:Long, verify:Boolean) {
	// TODO Fix native code so it takes a Rail[Complex]
    @Native("c++", "execute_plan(#1, &(#2)->raw[0], &(#3)->raw[0], #4, #5, #6)")
    @Native("java", "FTNatives.execute_plan(#plan, #A.getDoubleArray(), #B.getDoubleArray(), #SQRTN, #i0, #i1)")
    native static def execute_plan(plan:Long, A:Rail[Complex], B:Rail[Complex], SQRTN:Int, i0:Int, i1:Int):void;

    @Native("c++", "create_plan(#1, #2, #3)")
    @Native("java", "FTNatives.create_plan(#SQRTN, #direction, #flags)")
    native static def create_plan(SQRTN:Int, direction:Int, flags:Int):Long;

    val SQRTNL=1<<M,SQRTN=SQRTNL as Int,N=SQRTNL*SQRTNL;
    val I=Runtime.hereInt();
    val nRowsL=SQRTN/Place.numPlaces(), nRows=nRowsL as Int;
    val localSize=SQRTN*nRows;
    val allocator=Runtime.MemoryAllocator.requestAllocator(true, false);
    
    //need to be var because we are using the red black idiom
    var A0:Rail[Complex]{self!=null}=new Rail[Complex](localSize,allocator);
    var B0:Rail[Complex]{self!=null}=new Rail[Complex](localSize,allocator);
    
    val A=Array_2.makeView(A0,nRowsL,SQRTNL);
    val B=Array_2.makeView(B0,SQRTNL,nRowsL); // transposed shape
    val O=new Array_2[Complex](nRows,SQRTN);
    
    val fftwPlan=create_plan(SQRTN,-1n,0n);
    val fftwInversePlan=create_plan(SQRTN,1n,0n);
    
    def this(M:Long, verify:Boolean) {
    	property(M,verify);
    	val mbytes = N*2.0*8.0*2/(1024*1024);
    	if (I==0n) 
    		Console.OUT.println("M=" + M + " SQRTN=" + SQRTN + " N=" + N + " nRows=" + nRows +
    				" localSize=" + localSize + " MAX_PLACES=" + Place.numPlaces() +
    				              " Mem=" + mbytes + " mem/MAX_PLACES=" + mbytes/Place.numPlaces());
    	val r = new Random(I);
    	for ([i,j] in O.indices())
    		O(i,j)=A(i,j)=Complex(r.next()-0.5,r.next()-0.5);
    }

    def rowFFTS(fwd:Boolean) {
        execute_plan(fwd?fftwPlan:fftwInversePlan, A0, B0, SQRTN, 0n, nRows);
    }

    @Inline min(i:Long, j:Long):Long=i<j?i:j;
    @Inline global(i:Long,j:Long):Long = (I*nRows+i)*j;
    @Inline def root(sign:Int, N:Long, u:Long):Complex = {
    	val W_N=2.0*Math.PI/N,UW=u*W_N;
    	Complex(Math.cos(UW), sign*Math.sin(UW))
    }
    def bytwiddle(sign:Int) {
        for ([i,j] in  A.indices()) 
           A(i,j) *= root(sign, N, (global(i,j)));
    }

    def check() {
        val threshold = 1.0e-15*Math.log(N as Double)/Math.log(2.0)*16;
        for ([i,j] in A.indices()) {
            if ((A(i,j)-O(i,j)).abs() > threshold) 
            	Console.ERR.println("Error at ("+i+","+j+") "+A(i,j)+", expected "+O(i,j));
        }
    }

    def warmup() {
        val chunkSize = 2 * nRows * nRows; 
        var t:Long = -System.nanoTime();
        Team.WORLD.alltoall(A0, 0, B0, 0, chunkSize);
        t += System.nanoTime();
        if (I == 0n) Console.OUT.println("1st alltoall: " + format(t) + " s");
        t = -System.nanoTime();
        Team.WORLD.alltoall(A0, 0, B0, 0, chunkSize);
        t += System.nanoTime();
        if (I == 0n) Console.OUT.println("2nd alltoall: " + format(t) + " s");
    }
/*
     * TODO: determine vocabulary of annotations on loops that would permit
     * a declarative specification of this particular loop nest, specified on
     * for ([i,j] in A.indices()) B(j,i)=A(i,j)
     */
    def transpose() {
        for (p in 0n..(Place.numPlaces() as Int-1n)) 
        	for (var ii:Int=0n; ii<nRows; ii+=16n) 
        		for (var jj:Int=p*nRows; jj<(p+1)*nRows; jj+=16n) 
        			for (i in ii..(min(ii+16n,nRows)-1n)) 
        				for (j in jj..(min(jj+16n,SQRTN)-1n)) 
        					B(j,i) = A(i,j);
    }

    def alltoall() {
        Team.WORLD.alltoall(B0,0,A0,0,1*nRows*nRows);
        val C = B0;
        B0 = A0;
        A0 = C;
    }

    def scatter() {
        val n1 = Place.numPlaces() as Int,n2=nRows;
        for (k in 0..(nRows-1)) 
        	for (var ii:Int=0n; ii<n1; ii += 16n) 
        		for (var jj:Int=0n; jj<n2; jj += 16n) 
        			for (i in ii..(min(ii+16n,n1)-1)) 
        				for (j in jj..(min(jj+16n,n2)-1)) 
        					A(k*n1+i, j)=B(i*n2+k,j);
    }

    static def format(t:Long) = (t as Double) * 1.0e-9;

    def globalTranspose(i:Long,timers:Rail[Long]{self!=null}) {
    	timers(i)=System.nanoTime(); transpose();
    	timers(i+1)=System.nanoTime(); alltoall();
    	timers(i+2)=System.nanoTime(); scatter();
    }
    
    /**
     * Perform the Discrete FFT. If fwd, run the forward
     * DFT algorithm, else run the inverse DFT algorithm.
     * Return the time it takes to perform the operation.
     */ 
    def compute(fwd:Boolean) {
        val timers = new Rail[Long](13);
        globalTranspose(0,timers);
        timers(3)=System.nanoTime(); rowFFTS(fwd);
        globalTranspose(4,timers);
        timers(7)=System.nanoTime(); bytwiddle(fwd ? 1n : -1n);
        timers(8)=System.nanoTime(); rowFFTS(fwd);
        globalTranspose(9,timers);// transpose back to unscrambled order
        timers(12)=System.nanoTime(); 
        // Output
        val secs = format(timers(12) - timers(0));
        val Gigaflops = 1.0e-9*N*5*Math.log(N as Double)/Math.log(2.0)/secs;
        if (I == 0n) Console.OUT.println("execution time=" + secs + " secs" + " Gigaflops=" + Gigaflops);
        val steps = ["transpose1", "alltoall1 ", "scatter1  ", "row_ffts1 ",
                "transpose2", "alltoall2 ", "scatter2  ", "twiddle   ", "row_ffts2 ",
                "transpose3", "alltoall3 ", "scatter3  "];
        if (I == 0n) {
            for (i in steps.range()) 
                Console.OUT.println("Step " + steps(i) + " took " + format(timers(i+1) - timers(i)) + " s");
            val v = timers(12)-timers(11) + timers(10)-timers(6) + timers(5)-timers(2) + timers(1)-timers(0);
            Console.OUT.println("Computation time: " + format(v) + "s of total time: "
                    + secs + "s (" + (100*format(v)/secs) + "%)");
        }
        return secs;
    }
    
    def run() {
        if (I == 0n) Console.OUT.println("Warmup"); //Warmup
        warmup();
        Team.WORLD.barrier();
        if (I == 0n) Console.OUT.println("Warmup complete;starting FFT");
        var secs:Double = compute(true);
        Team.WORLD.barrier();
        if (I == 0n) Console.OUT.println("FFT complete; starting reverse FFT");
        secs += compute(false);
        Team.WORLD.barrier();
        if (I == 0n) {// Output
        	Console.OUT.println("Reverse FFT complete");
        	Console.OUT.println("Now combining forward and inverse FTT measurements");
            val Gigaflops = 2.0e-9*N*5*Math.log(N as Double)/Math.log(2.0)/secs;
            Console.OUT.println("execution time=" + secs + " secs"+" Gigaflops="+Gigaflops);
        }
        if (verify) {  // Verification
            if (I == 0n) Console.OUT.println("Start verification");
            check();
            if (I == 0n) Console.OUT.println("Verification complete");
        }
    }
    
    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, [
            Option("v", "verify", "verify results"),
            Option.HELP
        ], [
            Option("m", "magnitude", "log2 size of the vector (default 10)")
        ]);
        if (opts.wantsUsageOnly("")) {
            return;
        }
        val M = opts("-m", 10n);
        val verify = opts("-v", false);
        val SQRTN = 1n << M, nRows = SQRTN / (Place.numPlaces() as Int);
        if (nRows * (Place.numPlaces() as Int) != SQRTN) {
            Console.ERR.println("SQRTN must be divisible by Place.numPlaces()!");
            return;
        }
        val plh = PlaceLocalHandle.makeFlat[FTComplex2DRep](Place.places(), 
        		()=>new FTComplex2DRep(M, verify));
        Place.places().broadcastFlat(()=>{plh().run();});
    }
}
