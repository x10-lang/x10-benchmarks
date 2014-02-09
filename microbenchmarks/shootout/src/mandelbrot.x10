/** 
* The Computer Language Benchmarks Game
* http://shootout.alioth.debian.org/
* 
* Based on Java-6 version, from Stefan Krause, Chad Whipkey, Colin D Bennett, The Anh Tran
* 
* * 
* v2: v1 + general clean up and use x10 idioms*/

import x10.io.IOException;
import x10.io.Console;
import x10.util.concurrent.AtomicInteger;
import x10.array.*;

public class mandelbrot {
    public static def main(args:Rail[String]) {
    	val start = System.nanoTime();
        val size = args.size>0 ? Int.parse(args(0)) : 200n; 

        Console.OUT.println("P4\n" + size + " " + size);

        val width_bytes = size/8n +1n;
        val output_data = new Array_2[Byte](size, width_bytes);
        val bytes_per_line = new Rail[Int](size);

        compute(size, output_data, bytes_per_line);

        for (i in 0..(size-1)) {
            for (j in 0..(bytes_per_line(i)-1)) {
                Console.OUT.write(output_data(i,j));  
            }
        }
        val end = System.nanoTime();
        Console.OUT.println("Program runtime: " + (end - start));
    }

    private static final def compute(n:Int, output:Array_2[Byte], bytes_per_line:Rail[Int]) {
        val inverse_N = 2.0 / n;

        val current_line = new AtomicInteger(0n);

        val nProcs = 2; // TODO 1) there is no way to detect number of procs, so guessing 2  2) try one worker per row, and eliminate current_line
        finish {
        	for (m in 1..nProcs) async {
                while (true) {
                    val y = current_line.getAndIncrement();

                    if (y >= n) {
                        break;
                    }
                    var bit_num:int = 0n;
                    var byte_count:int = 0n;
                    var byte_accumulate:int = 0n;

                    val Civ = y * inverse_N - 1.0;
                    for (x in 0..(n-1)) {
                        val Crv = x * inverse_N - 1.5;
                        var z:Complex = Complex(Crv, Civ);
                        var t:Complex = Complex(Crv*Crv,Civ*Civ);
                        var i:int = 49n;
                        do {
                            z = Complex(t.re - t.im + Crv, z.re * z.im + z.re * z.im + Civ);
                            t = Complex(z.re * z.re, z.im * z.im);
                        } while ( ((t.re + t.im) <= 4.0) && (--i > 0));
                        byte_accumulate <<= 1;
                        if (i == 0n)
                            byte_accumulate++;

                        if (++bit_num == 8n) {
                            output(y,byte_count++) = byte_accumulate as byte;
                            bit_num = byte_accumulate = 0n;
                        }
                    }
                    if (bit_num != 0n) {
                        byte_accumulate <<= (8n - (n & 7n));
                        output(y, byte_count++) = byte_accumulate as byte;
                    }

                    bytes_per_line(y) = byte_count;
                }
            }
        }
    }
}
