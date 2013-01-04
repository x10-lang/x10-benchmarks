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
import x10.lang.Complex;

public class mandelbrot {
    public static def main(args: Array[String](1){rail}) {
    	val start = System.nanoTime();
        val size = args.size> 0 ? Int.parse(args(0)) : 200; 

        Console.OUT.println("P4\n" + size + " " + size);

        val width_bytes = size /8 +1;
        val output_data = new Array[Byte]((0..(size-1))*(0..(width_bytes-1)));
        val bytes_per_line = new Array[Int](size);

        compute(size, output_data, bytes_per_line);

        for ([i] in 0..(size-1)) {
            for ([j] in 0..(bytes_per_line(i)-1)) {
                Console.OUT.write(output_data(i,j));  
            }
        }
        val end = System.nanoTime();
        Console.OUT.println("Program runtime: " + (end - start));
    }

    private static final def compute(n:Int,output:Array[Byte](2),bytes_per_line:Array[Int](1){rail}) {
        val inverse_N = 2.0 / n;

        val current_line = new AtomicInteger(0);

        val nProcs = 2; // TODO 1) there is no way to detect number of procs, so guessing 2  2) try one worker per row, and eliminate current_line
        finish {
        	for ([m] in 1..nProcs) async {
                while (true) {
                    val y = current_line.getAndIncrement();

                    if (y >= n) {
                        break;
                    }
                    var bit_num:int = 0;
                    var byte_count:int = 0;
                    var byte_accumulate:int = 0;

                    val Civ = y * inverse_N - 1.0;
                    for ([x] in 0..(n-1)) {
                        val Crv = x * inverse_N - 1.5;
                        var z:Complex = Complex(Crv, Civ);
                        var t:Complex = Complex(Crv*Crv,Civ*Civ);
                        var i:int = 49;
                        do
                        {
                            z = Complex(t.re - t.im + Crv, z.re * z.im + z.re * z.im + Civ);
                            t = Complex(z.re * z.re, z.im * z.im);
                        } while ( ((t.re + t.im) <= 4.0) && (--i > 0));
                        byte_accumulate <<= 1;
                        if (i == 0)
                            byte_accumulate++;

                        if (++bit_num == 8)
                            {
                            output(y,byte_count++) = byte_accumulate as byte;
                            bit_num = byte_accumulate = 0;
                        }
                    }
                    if (bit_num != 0) {
                        byte_accumulate <<= (8 - (n & 7));
                        output(y, byte_count++) = byte_accumulate as byte;
                    }

                    bytes_per_line(y) = byte_count;
                }
            }
        }
    }
}
