// memory per place: 2*16*4^args(0) / MAX_PLACES
// default: m = 10 -> 32M / MAX_PLACES
// args(0) is intended to be incremented by one for every 4x increase in the number of places
// constraint: MAX_PLACES must divide 2^m

// p7ih with 1 place: args(0) = 13 -> 2G -> 4096 16M pages

import x10.compiler.Native;
import x10.compiler.NativeCPPInclude;
import x10.compiler.NativeCPPOutputFile;
import x10.compiler.NativeCPPCompilationUnit;
import x10.compiler.NativeRep;
import x10.util.Team;
import x10.array.Array_2;
import x10.compiler.Inline;
import x10.regionarray.Region;

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
class FT2DRepNativeComplex(M:Long, verify:Boolean) {
    // TODO: pass through as complex** to native code
    @Native("c++", "execute_plan(#1, (x10_double*)(&(#2->raw())->raw[0]), (x10_double*)(&(#3->raw())->raw[0]), #4, #5, #6)")
    @Native("java", "FTNatives.execute_plan(#plan, #A.getDoubleArray(), #B.getDoubleArray(), #SQRTN, #i0, #i1)")
    native static def execute_plan(plan:Long, A:Array_2[Complex], B:Array_2[Complex], SQRTN:Int, i0:Int, i1:Int):void;

    @Native("c++", "create_plan(#1, #2, #3)")
    @Native("java", "FTNatives.create_plan(#SQRTN, #direction, #flags)")
    native static def create_plan(SQRTN:Int, direction:Int, flags:Int):Long;
    
    val SQRTNL=1<<M,SQRTN=SQRTNL as Int,N=SQRTNL*SQRTNL;
    val I=Runtime.hereInt();
    val nRowsL=SQRTN/Place.MAX_PLACES, nRows=nRowsL as Int, nCols=SQRTN;
    val localSize=SQRTN*nRows;
    
    var A:Array_2[Complex] = new Array_2[Complex](nRowsL, SQRTNL);
    var B:Array_2[Complex] = new Array_2[Complex](SQRTNL, nRowsL); // transposed shape
    val fftwPlan=create_plan(SQRTN,-1n,0n);
    val fftwInversePlan=create_plan(SQRTN,1n,0n);
    
    def this(M:Long, verify:Boolean) {
    	property(M,verify);
    	val mbytes = N*2.0*8.0*2/(1024*1024);
    	if (I==0n) 
    		Console.OUT.println("M=" + M + " SQRTN=" + SQRTN + " N=" + N + " nRows=" + nRows +
    				" localSize=" + localSize + " MAX_PLACES=" + Place.MAX_PLACES +
    				              " Mem=" + mbytes + " mem/MAX_PLACES=" + mbytes/Place.MAX_PLACES);
		val r = new Random2(I);
		for ([i, j] in A.indices())
			A(i,j)=Complex(r.next()-0.5,r.next()-0.5);
	
    }
   
    def rowFFTS(fwd:Boolean) {
	   execute_plan(fwd?fftwPlan:fftwInversePlan, A, B, SQRTN, 0n, nRows);
    }

    @Inline min(i:Long, j:Long):Long=i<j?i:j;
    @Inline global(i:Long):Long = (I*nRows+i);
    def bytwiddle(sign:Int) {
    	val W_N=2.0*Math.PI/N;
    	for ([i,j] in A.indices()) {
		val UW=global(i)*j*W_N;
		A(i,j) *= Complex(Math.cos(UW), -sign*Math.sin(UW));
	}
    }

    def check() {
    	val threshold = 1.0e-15*Math.log(N as Double)/Math.log(2.0)*16;
    	val random = new Random2(I);
    	for ([i,j] in A.indices()) {
	    val c =Complex(random.next()-0.5,random.next()-0.5);
            if ((A(i,j)-c).abs() > threshold) 
            	Console.ERR.println("Error at ("+i+","+j+") "+A(i,j)+", expected "+c);
    	}
    }
    def warmup() {
        val chunkSize = nRows * nRows; 
        var t:Long = -System.nanoTime();
        Team.WORLD.alltoall(A.raw(), 0, B.raw(), 0, chunkSize as Long);
        t += System.nanoTime();
        if (I == 0n) Console.OUT.println("1st alltoall: " + format(t) + " s");
        t = -System.nanoTime();
        Team.WORLD.alltoall(A.raw(), 0, B.raw(), 0, chunkSize as Long);
        t += System.nanoTime();
        if (I == 0n) Console.OUT.println("2nd alltoall: " + format(t) + " s");
    }

    /*
     * TODO: determine vocabulary of annotations on loops that would permit
     * a declarative specification of this particular loop nest.
     * Tiled version of loop: for ([i,j] in (0..(nRows-1)*(0..(nCols-1)))) B(j,i)=A(i,j)
     */
    def transpose() {
        val n1 = Place.MAX_PLACES as Int,n2=nRows as Int;
        for (p in 0n..(n1-1n)) 
        	for (var ii:Int=0n; ii<n2; ii+=16n) 
        		for (var jj:Int=p*n2; jj<(p+1)*n2; jj+=16n) 
        			for (i in ii..(min(ii+16n,n2)-1n)) 
        				for (j in jj..(min(jj+16n,nCols)-1n)) 
        					B(j,i) = A(i,j);
    }

    def alltoall() {
        Team.WORLD.alltoall(B.raw(),0,A.raw(),0,(nRows*nRows) as Long);
        val C = B;
        B = A;
        A = C;
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
        val n1 = Place.MAX_PLACES as Int,n2=nRows;
        for (i in 0..(n2-1)) 
        	for (var ii:Int=0n; ii<n1; ii += 16n) 
        		for (var jj:Int=0n; jj<n2; jj += 16n) 
        			for (p in ii..(min(ii+16n,n1)-1)) 
        				for (j in jj..(min(jj+16n,n2)-1)) 
					    A(i,n2*p+j)=B(n2*p+i,j);
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

        timers(7)=System.nanoTime(); bytwiddle(fwd?1n:-1n);
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
        val M = (args.size > 0) ? Int.parse(args(0)) : 10n;
        val verify = (args.size > 1) ? Boolean.parse(args(1)) : false;
        val SQRTN = 1n << M, nRows = SQRTN / (Place.MAX_PLACES as Int);
        if (nRows * (Place.MAX_PLACES as Int) != SQRTN) {
            Console.ERR.println("SQRTN must be divisible by Place.MAX_PLACES!");
            return;
        }
        val plh = PlaceLocalHandle.makeFlat[FT2DRep](PlaceGroup.WORLD, ()=>new FT2DRep(M, verify));
        PlaceGroup.WORLD.broadcastFlat(()=>{plh().run();});
    }
}
