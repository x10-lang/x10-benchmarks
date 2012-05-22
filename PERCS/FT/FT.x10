import x10.compiler.Native;
import x10.compiler.NativeCPPInclude;
import x10.compiler.NativeCPPOutputFile;
import x10.compiler.NativeCPPCompilationUnit;
import x10.util.Team;

@NativeCPPInclude("ft_natives.h")
@NativeCPPOutputFile("hpccfft.h")
@NativeCPPOutputFile("wrapfftw.h")
@NativeCPPCompilationUnit("fft235.c")
@NativeCPPCompilationUnit("wrapfftw.c")
@NativeCPPCompilationUnit("zfft1d.c")
@NativeCPPCompilationUnit("ft_natives.cc")

class Random {
    @Native("c++", "srandom(#seed)")
    static native def srandom(seed:Int):void;

    @Native("c++", "random()")
    native def rand():Long;

    def this(seed:Int) {
        srandom(seed);
    }

    def next() = rand() / (4294967296L as Double);
}

class FT {
    @Native("c++", "execute_plan(#1, &(#2)->raw()[0], &(#3)->raw()[0], #4, #5, #6)")
    native static def execute_plan(plan:Long, A:Rail[Double], B:Rail[Double], SQRTN:Int, i0:Int, i1:Int):void;

    @Native("c++", "create_plan(#1, #2, #3)")
    native static def create_plan(SQRTN:Int, direction:Int, flags:Int):Long;

    val A:Rail[Double];
    val B:Rail[Double];
    val C:Rail[Double];
    val D:Rail[Double];
    val I:Int;
    val nRows:Int;
    val N:Long;
    val SQRTN:Int;
    val verify:Boolean;
    val fftwPlan:Long;
    val fftwInversePlan:Long;
    var alltoall_timer:Long = 0;
    var twiddle_timer:Long = 0;

    def this(nRows:Int, localSize:Int, N:Long, SQRTN:Int, verify:Boolean) {
        I = Runtime.hereInt();

        this.nRows = nRows;
        this.N = N;
        this.SQRTN = SQRTN;
        this.verify = verify;

        fftwPlan = create_plan(SQRTN, -1, 0);
        fftwInversePlan = create_plan(SQRTN, 1, 0);

        A = new Rail[Double](localSize);
        B = new Rail[Double](localSize);
        C = new Rail[Double](localSize);

        val random = new Random(I);
        for (var i:Int=0; i<localSize; ++i) A(i) = random.next() - 0.5;

        if (verify) D = new Rail[Double](A); else D = null;
    }

    def rowFFTS(fwd:Boolean) {
        execute_plan(fwd?fftwPlan:fftwInversePlan, A, B, SQRTN, 0, nRows);
    }

    def bytwiddle(sign:Int) {
        twiddle_timer -= System.nanoTime();
        val W_N = 2.0 * Math.PI / N;
        for (var i:Int=0; i<nRows; ++i) {
            for (var j:Int=0; j<SQRTN; ++j) {
                val idx = 2*(i*SQRTN+j);
                val ar = A(idx);
                val ai = A(idx+1);
                val ij = (I*nRows+i)*j;
                val c = Math.cos(W_N*ij);
                val s = Math.sin(W_N*ij)*sign;
                A(idx) = ar*c+ai*s;
                A(idx+1) = ai*c-ar*s;
            }
        }
        twiddle_timer += System.nanoTime();
    }

    def check() {
        val threshold = 1.0e-15*Math.log(N as double)/Math.log(2.0)*16;
        for (var q:Int=0; q<A.size; ++q) {
            if (Math.abs(A(q)-D(q)) > threshold) Console.ERR.println("Error at "+q+" "+A(q).toString()+" "+D(q).toString());
        }
    }

    def warmup() {
        val chunkSize = 2 * nRows * nRows; 
        var t:Long = -System.nanoTime();
        Team.WORLD.alltoall(I, B, 0, C, 0, chunkSize);
        t += System.nanoTime();
        if (I == 0) Console.OUT.println("1st alltoall: " + format(t) + " s");
        t = -System.nanoTime();
        Team.WORLD.alltoall(I, B, 0, C, 0, chunkSize);
        t += System.nanoTime();
        if (I == 0) Console.OUT.println("2nd alltoall: " + format(t) + " s");
    }

    def transpose() {
        val n0 = Place.MAX_PLACES;
        val n1 = nRows;
        val n2 = SQRTN;
        val chunkSize = 2 * nRows * nRows; 
        val dstIndex = I * chunkSize;
        val FFTE_NBLK = 16;

        for (var k:Int = 0; k < n0; ++k) {
            for (var ii:Int = 0; ii < n1; ii += FFTE_NBLK) {
                for (var jj:Int = k * nRows; jj < (k+1) * nRows; jj += FFTE_NBLK) {
                    val tmin1 = ii + FFTE_NBLK < n1 ? ii + FFTE_NBLK : n1;
                    for (var i:Int = ii; i < tmin1; ++i) {
                        val tmin2 = jj + FFTE_NBLK < n2 ? jj + FFTE_NBLK : n2;
                        for (var j:Int = jj; j < tmin2; ++j) {
                            B(2*(n1 * j + i)) = A(2*(n2 * i + j));
                            B(2*(n1 * j + i)+1) = A(2*(n2 * i + j)+1);
                        }
                    }
                }
            }
        }
        alltoall_timer -= System.nanoTime();
        Team.WORLD.alltoall(I, B, 0, C, 0, chunkSize);
        alltoall_timer += System.nanoTime();
    }

    def scatter() {
        val n1 = Place.MAX_PLACES;
        val n2 = nRows;
        val FFTE_NBLK = 16;

        for (var k:Int = 0; k < n2; ++k) {
            for (var ii:Int = 0; ii < n1; ii += FFTE_NBLK) {
                for (var jj:Int = 0; jj < n2; jj += FFTE_NBLK) {
                    val tmin1 = ii + FFTE_NBLK < n1 ? ii + FFTE_NBLK : n1;
                    for (var i:Int = ii; i < tmin1; ++i) {
                        val tmin2 = jj + FFTE_NBLK < n2 ? jj + FFTE_NBLK : n2;
                        for (var j:Int = jj; j < tmin2; ++j) {
                            A(2*(k * n2 * n1 + j + i * n2)) = C(2*(i * n2 * n2 + k * n2 + j));
                            A(2*(k * n2 * n1 + j + i * n2)+1) = C(2*(i * n2 * n2 + k * n2 + j)+1);
                        }
                    }
                }
            }
        }
    }

    static def format(t:Long) = (t as Double) * 1.0e-9;

    def compute(fwd:Boolean, N:Long) {
        val timers = new Rail[Long](7);
        timers(0)=System.nanoTime(); transpose(); scatter();
        timers(1)=System.nanoTime(); rowFFTS(fwd);
        timers(2)=System.nanoTime(); transpose(); scatter();
        timers(3)=System.nanoTime(); bytwiddle(fwd ? 1 : -1);
        timers(4)=System.nanoTime(); rowFFTS(fwd);
        timers(5)=System.nanoTime(); transpose(); scatter();
        timers(6)=System.nanoTime(); 

        // Output
        val secs = format(timers(6) - timers(0));
        val Gigaflops = 1.0e-9*N*5*Math.log(N as double)/Math.log(2.0)/secs;
        if (I == 0) Console.OUT.println("execution time=" + secs + " secs" + " Gigaflops=" + Gigaflops);
        val steps = ["transpose1", "row_ffts1", "transpose2", "twiddle", "row_ffts2", "transpose3"];
        if (I == 0) for (var i:Int = 0; i < steps.size; ++i) {
            Console.OUT.println("Step " + steps(i) + " took " + format(timers(i+1) - timers(i)) + " s");
        }

        return secs;
    }

    def run() {
        // Warmup
        if (I == 0) Console.OUT.println("Warmup");
        warmup();
        if (I == 0) Console.OUT.println("Warmup complete");

        // FFT
        if (I == 0) Console.OUT.println("Start FFT");
        var secs:Double = compute(true, N);
        if (I == 0) Console.OUT.println("alltoall: " + format(alltoall_timer) + " s");
        if (I == 0) Console.OUT.println("twiddle: " + format(twiddle_timer) + " s");
        if (I == 0) Console.OUT.println("FFT complete");

        // Reverse FFT
        if (I == 0) Console.OUT.println("Start reverse FFT");
        secs += compute(false, N);
        if (I == 0) Console.OUT.println("Reverse FFT complete");

        // Output
        if (I == 0) Console.OUT.println("Now combining forward and inverse FTT measurements");
        val Gigaflops = 2.0e-9*N*5*Math.log(N as double)/Math.log(2.0)/secs;
        if (I == 0) Console.OUT.println("execution time=" + secs + " secs"+" Gigaflops="+Gigaflops);

        // Verification
        if (verify) {
            if (I == 0) Console.OUT.println("Start verification");
            check();
            if (I == 0) Console.OUT.println("Verification complete");
        }
    }

    public static def main(args:Rail[String]) {
        val M = (args.size > 0) ? Int.parseInt(args(0)) : 10;
        val verify = (args.size > 1) ? Boolean.parseBoolean(args(1)) : false;
        val SQRTN = 1 << M;
        val N = (SQRTN as Long) * SQRTN;
        val nRows = SQRTN / Place.MAX_PLACES;
        val localSize = 2 * SQRTN * nRows;
        val mbytes = N*2.0*8.0*2/(1024*1024);

        Console.OUT.println("M=" + M + " SQRTN=" + SQRTN + " N=" + N + " nRows=" + nRows +
            " localSize=" + localSize + " MAX_PLACES=" + Place.MAX_PLACES +
            " Mem=" + mbytes + " mem/MAX_PLACES=" + mbytes/Place.MAX_PLACES);

        if (nRows * Place.MAX_PLACES != SQRTN) {
            Console.ERR.println("SQRTN must be divisible by Place.MAX_PLACES!");
            return;
        }

        // Initialization
        val plh = PlaceLocalHandle.make[FT](Dist.makeUnique(), ()=>new FT(nRows, localSize, N, SQRTN, verify));

        // Benchmark
        for (var p:Int=0; p<Place.MAX_PLACES; ++p) at (Place(p)) async plh().run();
    }
}
