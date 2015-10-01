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
                    var c1 : long;
                    x = A(i,i);
                    for (c1 = 0; (c1 <= (i + -1)); c1++) {
                        x = x - A(i,c1) * A(i,c1);
                    }
                }
                p(i) = 1.0 / x10.lang.Math.sqrt(x);
                {
                    var c1 : long;
                    var c0 : long;
                    if ((i <= (n + -2))) {
                        if ((i >= 1)) {
                            for (c0 = (i + 1); (c0 <= (n + -1)); c0++) {
                                x = A(i,c0);
                                for (c1 = 0; (c1 <= (i + -1)); c1++) {
                                    x = x - A(c0,c1) * A(i,c1);
                                }
                                A(c0,i) = x * p(i);
                            }
                        }
                        if ((i <= 0)) {
                            for (c0 = (i + 1); (c0 <= (n + -1)); c0++) {
                                if ((c0 == 0)) {
                                    x = A(i,0);
                                    A(0,i) = x * p(i);
                                }
                                if ((c0 >= 1)) {
                                    x = A(i,c0);
                                }
                                if ((c0 >= 1)) {
                                    A(c0,i) = x * p(i);
                                }
                                if ((c0 <= -1)) {
                                    A(c0,i) = x * p(i);
                                }
                                if ((c0 <= -1)) {
                                    x = A(i,c0);
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
