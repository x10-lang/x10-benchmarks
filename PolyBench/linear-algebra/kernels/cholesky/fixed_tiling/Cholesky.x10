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
public class Cholesky {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		p : Rail[Double],
  		A : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        p(i) = 1.0 / n;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = 1.0 / n;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 A : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
      Console.ERR.printf("%0.2lf ", A(i,j));
      if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_cholesky(n : long, p : Rail[double], A : Array_2[double])  {
        {
            var x : double;
            for (var i : long = 0L; i < n; ++i) {
                {
                    var c2 : long;
                    x = A(i,i);
                    for (c2 = 0; (c2 <= (i + -1)); c2++) {
                        x = x - A(i,c2) * A(i,c2);
                    }
                }
                p(i) = 1.0 / x10.lang.Math.sqrt(x);
                {
                    var c0 : long;
                    var c2 : long;
                    var c1 : long;
                    if ((i <= (n + -2))) {
                        for (c0 = ((i + -30) * 256 < 0 ?  -( -((i + -30)) / 256) : (256 < 0 ? ( -((i + -30)) +  -(256) - 1) /  -(256) : ((i + -30) + 256 - 1) / 256)); (c0 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c0++) {
                            if ((i >= 1)) {
                                for (c1 = ((256 * c0) > (i + 1) ? ((256 * c0)) as long : ((i + 1)) as long); (c1 <= (((256 * c0) + 255) < (n + -1) ? (((256 * c0) + 255)) as long : ((n + -1)) as long)); c1++) {
                                    x = A(i,c1);
                                    for (c2 = 0; (c2 <= (i + -1)); c2++) {
                                        x = x - A(c1,c2) * A(i,c2);
                                    }
                                    A(c1,i) = x * p(i);
                                }
                            }
                            if ((i <= 0)) {
                                for (c1 = ((256 * c0) > (i + 1) ? ((256 * c0)) as long : ((i + 1)) as long); (c1 <= (((256 * c0) + 255) < (n + -1) ? (((256 * c0) + 255)) as long : ((n + -1)) as long)); c1++) {
                                    if (((c0 == 0) && (c1 == 0))) {
                                        x = A(i,0);
                                        A(0,i) = x * p(i);
                                    }
                                    if ((c1 >= 1)) {
                                        x = A(i,c1);
                                    }
                                    if ((c1 >= 1)) {
                                        A(c1,i) = x * p(i);
                                    }
                                    if ((c1 <= -1)) {
                                        A(c1,i) = x * p(i);
                                    }
                                    if ((c1 <= -1)) {
                                        x = A(i,c1);
                                    }
                                }
                            }
                        }
                    }
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
    
    val cholesky = new Cholesky();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    cholesky.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val p = new Rail[Double](n);  
    /* Initialize array(s). */
    cholesky.init_array (n, p, A);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    cholesky.kernel_cholesky (n, p, A);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // cholesky.print_array(n, A);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
