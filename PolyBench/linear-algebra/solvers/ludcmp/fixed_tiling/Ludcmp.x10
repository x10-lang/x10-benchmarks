/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2015.
 * 
 *
 *  @author HUANG RUOCHEN (hrc706@gmail.com)
 */

import x10.compiler.Ifdef;
import x10.array.Array_2;
import x10.array.Array_3;
import x10.compiler.Foreach;
public class Ludcmp {

  var _PB_N : Long;

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 A : Array_2[Double],
  		 b : Rail[Double],
  		 x : Rail[Double],
  		 y : Rail[Double])
  {
    for (var i : Long = 0; i <= n; i++)
      {
        x(i) = i + 1;
        y(i) = (i+1)/n/2.0 + 1;
        b(i) = (i+1)/n/2.0 + 42;
        for (var j : Long = 0; j <= n; j++) {
  	A(i,j) = (((i+1) as Double) *(j+1)) / n;
        }
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 x : Rail[Double])
  
  {
    for (var i : Long = 0; i <= n; i++) {
      Console.ERR.printf("%0.2lf", x(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_ludcmp(n : long, A : Array_2[double], b : Rail[double], x : Rail[double], y : Rail[double])  {
        {
            var w : double;
            {
                var c7 : long;
                var c1 : long;
                var c8 : long;
                if ((n >= 1)) {
                    for (c7 = 1; (c7 <= n); c7++) {
                        w = A(c7,0);
                        A(c7,0) = w / A(0,0);
                    }
                    for (c7 = 1; (c7 <= n); c7++) {
                        w = A(0 + 1L,c7);
                        w = w - A(0 + 1L,0) * A(0,c7);
                        A(0 + 1L,c7) = w;
                    }
                }
                for (c1 = 1; (c1 <= (n + -1)); c1++) {
                    for (c7 = (c1 + 1); (c7 <= n); c7++) {
                        w = A(c7,c1);
                        for (c8 = 0; (c8 <= (c1 + -1)); c8++) {
                            w = w - A(c7,c8) * A(c8,c1);
                        }
                        A(c7,c1) = w / A(c1,c1);
                    }
                    for (c7 = (c1 + 1); (c7 <= n); c7++) {
                        w = A(c1 + 1L,c7);
                        for (c8 = 0; (c8 <= c1); c8++) {
                            w = w - A(c1 + 1L,c8) * A(c8,c7);
                        }
                        A(c1 + 1L,c7) = w;
                    }
                }
                b(0L) = 1.0;
                y(0L) = b(0L);
                for (c1 = 1; (c1 <= n); c1++) {
                    w = b(c1);
                    for (c7 = 0; (c7 <= (c1 + -1)); c7++) {
                        w = w - A(c1,c7) * y(c7);
                    }
                    y(c1) = w;
                }
                x(n) = y(n) / A(n,n);
                for (c1 = 0; (c1 <= (n + -1)); c1++) {
                    w = y(n - 1L - c1);
                    for (c7 = ((-1 * c1) + n); (c7 <= n); c7++) {
                        w = w - A(n - 1L - c1,c7) * x(c7);
                    }
                    x(n - 1L - c1) = w / A(n - 1L - c1,n - 1L - c1);
                }
            }
        }
    }  public static def main(args : Rail[String])
  {
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 1024;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 128;
    }
    @Ifdef("LARGE_DATASET") {
        N = 2000;
    }
    
    val ludcmp = new Ludcmp();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    ludcmp.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n+1,n+1);

    val b = new Rail[Double](n+1);

    val x = new Rail[Double](n+1);

    val y = new Rail[Double](n+1);  
    /* Initialize array(s). */
    ludcmp.init_array (n,
  	      A,
  	      b,
  	      x,
  	      y);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    ludcmp.kernel_ludcmp (n,
  		 A,
  		 b,
  		 x,
  		 y);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // ludcmp.print_array(n, x);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
