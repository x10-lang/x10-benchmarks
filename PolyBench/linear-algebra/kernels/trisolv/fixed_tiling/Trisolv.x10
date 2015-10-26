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
public class Trisolv {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		A : Array_2[Double],
  		x : Rail[Double],
  		c : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        c(i) = x(i) = ((i as Double)) / n;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = ((i as Double) *j) / n;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 x : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", x(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_trisolv(n : long, A : Array_2[double], x : Rail[double], c : Rail[double])  {
        var c4 : long;
        var c1 : long;
        var c2 : long;
        var c3 : long;
        if ((n >= 1)) {
            for (c1 = 0; (c1 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c1++) {
                for (c3 = (256 * c1); (c3 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c3++) {
                    x(c3) = c(c3);
                }
            }
            for (c1 = -1; (c1 <= ((n + -1) * 16 < 0 ? (16 < 0 ?  -(( -((n + -1)) + 16 + 1) / 16) :  -(( -((n + -1)) + 16 - 1) / 16)) : (n + -1) / 16)); c1++) {
                {
                    val c1_0 = c1;
                    Foreach.block((0 > ((((256 * c1_0) + (-1 * n)) + 1) * 256 < 0 ?  -( -((((256 * c1_0) + (-1 * n)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c1_0) + (-1 * n)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c1_0) + (-1 * n)) + 1) + 256 - 1) / 256)) ? (0) as long : (((((256 * c1_0) + (-1 * n)) + 1) * 256 < 0 ?  -( -((((256 * c1_0) + (-1 * n)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c1_0) + (-1 * n)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c1_0) + (-1 * n)) + 1) + 256 - 1) / 256))) as long),((c1_0 + -1) * 2 < 0 ? (2 < 0 ?  -(( -((c1_0 + -1)) + 2 + 1) / 2) :  -(( -((c1_0 + -1)) + 2 - 1) / 2)) : (c1_0 + -1) / 2),(var c2 : long) => {
                        var c4 : long;
                        var c3 : long;
                        for (c3 = ((256 * c1_0) + (-256 * c2)); (c3 <= ((n + -1) < (((256 * c1_0) + (-256 * c2)) + 255) ? ((n + -1)) as long : ((((256 * c1_0) + (-256 * c2)) + 255)) as long)); c3++) {
                            for (c4 = (256 * c2); (c4 <= ((256 * c2) + 255)); c4++) {
                                x(c3) = x(c3) - A(c3,c4) * x(c4);
                            }
                        }
                    }
);
                }
                if (((16 * c1) == (n + -1))) {
                    if ((((n + 255) % 256) == 0)) {
                        x((n + -1)) = x((n + -1)) / A((n + -1),(n + -1));
                    }
                }
                if ((c1 <= ((n + -2) * 16 < 0 ? (16 < 0 ?  -(( -((n + -2)) + 16 + 1) / 16) :  -(( -((n + -2)) + 16 - 1) / 16)) : (n + -2) / 16))) {
                    if (((c1 % 2) == 0)) {
                        x((16 * c1)) = x((16 * c1)) / A((16 * c1),(16 * c1));
                        for (c3 = ((16 * c1) + 1); (c3 <= (((16 * c1) + 255) < (n + -1) ? (((16 * c1) + 255)) as long : ((n + -1)) as long)); c3++) {
                            for (c4 = (16 * c1); (c4 <= (c3 + -1)); c4++) {
                                x(c3) = x(c3) - A(c3,c4) * x(c4);
                            }
                            x(c3) = x(c3) / A(c3,c3);
                        }
                    }
                }
            }
        }
    }  public static def main(args : Rail[String])
  {
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 100000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 4000;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        N = 40000;
    }
    
    val trisolv = new Trisolv();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    trisolv.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val x = new Rail[Double](n);

    val c = new Rail[Double](n);  
    /* Initialize array(s). */
    trisolv.init_array (n, A, x, c);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    trisolv.kernel_trisolv (n, A, x, c);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // trisolv.print_array(n, x);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
