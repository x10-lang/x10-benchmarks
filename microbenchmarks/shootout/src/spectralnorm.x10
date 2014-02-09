/*
The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/

Based on Java-6 entry by Isaac Gouy, Jarkko Miettinen, The Anh Tran
* 
* v2: v1 + general clean up and use x10 idioms
 */

import x10.io.Console;
public class spectralnorm {

    public static def main(args:Rail[String]) {
    	val start = System.nanoTime();
    	val n = args.size>0 ? Int.parse(args(0)) : 1000n; 
        Console.OUT.printf("%.9f\n", spectralnormGame(n));	
        val end = System.nanoTime();
        Console.OUT.println("Program runtime: " + (end - start));
    }


    private static def spectralnormGame(n:long) {
        // create unit vector
        val u = new Rail[double](n, 1.0);
        val v = new Rail[double](n);
        val tmp = new Rail[double](n);

        val nthread = 2;  // TODO: need a way to query nProcessors
        val chunk = n / nthread;


        val reduced = finish(Adder()) { async { 
            val c1 = Clock.make();
            for (i in 0..(nthread-1)) { 
                val rbegin = i * chunk; 
                val rend = (i < (nthread -1)) ? rbegin + chunk : n;
                val myRegion = rbegin..(rend-1);
                async clocked(c1) {
                    var m_vBv:double = 0;
                    var m_vv:double = 0;
                    // 20 steps of the power method
                    for (j in 1..10) {
                        MultiplyAtAv (u, tmp, v, myRegion);
                        MultiplyAtAv (v, tmp, u, myRegion);
                    }
                    for (j in myRegion) {
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
    private static def MultiplyAtAv (v:Rail[double], tmp:Rail[double], AtAv:Rail[double], r:LongRange) {
        MultiplyAv (v, tmp, r);
        Clock.advanceAll();
        MultiplyAtv (tmp, AtAv, r);
        Clock.advanceAll();
    }

    /* multiply vector v by matrix A, each thread evaluate its range only */
    private static def MultiplyAv (v:Rail[double], Av:Rail[double], r:LongRange)  {
        for (i in r) {
            var sum:double = 0;
            for (j in v.range()) {
                sum += eval_A(i,j) * v(j); 
            }
            Av(i) = sum;
        }
    }

    /* multiply vector v by matrix A transposed */
    private static def MultiplyAtv (v:Rail[double], Atv:Rail[double], r:LongRange) {
        for (i in r) {
            var sum:double = 0;
            for (j in v.range())
                sum += eval_A (j, i) * v(j); 

            Atv(i) = sum;
        }
    }

    /* return element i,j of infinite matrix A */
    private static def eval_A (i:long, j:long) {
        val div = ( ((i+j) * (i+j+1) >>> 1) +i+1 );
        return 1.0 / div;
    }
}
