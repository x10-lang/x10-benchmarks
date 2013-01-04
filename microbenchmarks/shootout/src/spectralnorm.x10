/*
The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/

Based on Java-6 entry by Isaac Gouy, Jarkko Miettinen, The Anh Tran
* 
* v2: v1 + general clean up and use x10 idioms
 */

import x10.io.Console;
public class spectralnorm {

    public static def main(args: Array[String](1){rail}) {
    	val start = System.nanoTime();
    	val n = args.size> 0 ? Int.parse(args(0)) : 1000; 
        Console.OUT.printf("%.9f\n", spectralnormGame(n));	
        val end = System.nanoTime();
        Console.OUT.println("Program runtime: " + (end - start));
    }


    private static def spectralnormGame(n:int) {
        // create unit vector
        val u = new Array[double](n, (Int)=>1.0);
        val v = new Array[double](n);
        val tmp = new Array[double](n);

        val nthread = 2;  // TODO: need a way to query nProcessors
        val chunk = n / nthread;


        val reduced = finish(Adder()) { /* todo: syntax issue XTENLANG-1549 */ async { 
            val c1 = Clock.make();
            for ([i] in 0..(nthread-1)) { 
                val rbegin = i * chunk; 
                val rend = (i < (nthread -1)) ? rbegin + chunk : n;
                val myRegion = rbegin..(rend-1);
                async clocked(c1) {
                    var m_vBv:double = 0;
                    var m_vv:double = 0;
                    // 20 steps of the power method
                    for ([j] in 1..10) {
                        MultiplyAtAv (u, tmp, v, myRegion);
                        MultiplyAtAv (v, tmp, u, myRegion);
                    }
                    for ([j] in myRegion) {
                        offer Accum(u(j) * v(j), v(j) * v(j));
                    }
                }
            }}
        };

        return Math.sqrt (reduced.vBv/reduced.vv);
    }


    static struct Accum(vBv:double, vv:double) {}
    static struct Adder implements Reducible[Accum] {
        public def zero() = Accum(0,0);
        public operator this(a:Accum, b:Accum) = Accum(a.vBv+b.vBv,a.vv+b.vv);
    }

    /* multiply vector v by matrix A and then by matrix A transposed */
    private static def MultiplyAtAv (v:Array[double](1){rail}, tmp:Array[double](1){rail}, AtAv:Array[double](1){rail}, r:Region(1)) {
        MultiplyAv (v, tmp, r);
        Clock.advanceAll();
        MultiplyAtv (tmp, AtAv, r);
        Clock.advanceAll();
    }

    /* multiply vector v by matrix A, each thread evaluate its range only */
    private static def MultiplyAv (v:Array[double](1){rail}, Av:Array[double](1){rail}, r:Region(1))  {
        for ([i] in r) {
            var sum:double = 0;
            for ([j] in v.region) {
                sum += eval_A(i,j) * v(j); 
            }
            Av(i) = sum;
        }
    }

    /* multiply vector v by matrix A transposed */
    private static def MultiplyAtv (v:Array[double](1){rail}, Atv:Array[double](1){rail}, r:Region(1))
    {
        for ([i] in r) {
            var sum:double = 0;
            for ([j] in v.region)
                sum += eval_A (j, i) * v(j); 

            Atv(i) = sum;
        }
    }

    /* return element i,j of infinite matrix A */
    private static def eval_A (i:int, j:int) {
        val div = ( ((i+j) * (i+j+1) >>> 1) +i+1 );
        return 1.0 / div;
    }
}
