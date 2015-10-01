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
public class Gemver {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 alpha : Rail[Double],
  		 beta : Rail[Double],
  		 A : Array_2[Double],
  		 u1 : Rail[Double],
  		 v1 : Rail[Double],
  		 u2 : Rail[Double],
  		 v2 : Rail[Double],
  		 w : Rail[Double],
  		 x : Rail[Double],
  		 y : Rail[Double],
  		 z : Rail[Double])
  {
    alpha(0) = 43532;
    beta(0) = 12313;
  
    for (var i : Long = 0; i < n; i++)
      {
        u1(i) = i;
        u2(i) = (i+1)/n/2.0;
        v1(i) = (i+1)/n/4.0;
        v2(i) = (i+1)/n/6.0;
        y(i) = (i+1)/n/8.0;
        z(i) = (i+1)/n/9.0;
        x(i) = 0.0;
        w(i) = 0.0;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = ((i as Double) *j) / n;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 w : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", w(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_gemver(n : long, alpha : double, beta : double, A : Array_2[double], u1 : Rail[double], v1 : Rail[double], u2 : Rail[double], v2 : Rail[double], w : Rail[double], x : Rail[double], y : Rail[double], z : Rail[double])  {
        var c1 : long;
        var c2 : long;
        if ((n >= 1)) {
            {
                Foreach.block(0,(n + -1),(var c1 : long) => {
                    var c2 : long;
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        A(c2,c1) = A(c2,c1) + u1(c2) * v1(c1) + u2(c2) * v2(c1);
                        x(c1) = x(c1) + beta * A(c2,c1) * y(c2);
                    }
                }
);
            }
            {
                Foreach.block(0,(n + -1),(var c1 : long) => {
                    var c2 : long;
                    x(c1) = x(c1) + z(c1);
                }
);
            }
            {
                Foreach.block(0,(n + -1),(var c1 : long) => {
                    var c2 : long;
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        w(c1) = w(c1) + alpha * A(c1,c2) * x(c2);
                    }
                }
);
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
        /*N = 8000;*/
        N = 36000;
    }
    
    val gemver = new Gemver();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    gemver.setPBs(n);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val A = new Array_2[Double](n,n);

    val u1 = new Rail[Double](n);

    val v1 = new Rail[Double](n);

    val u2 = new Rail[Double](n);

    val v2 = new Rail[Double](n);

    val w = new Rail[Double](n);

    val x = new Rail[Double](n);

    val y = new Rail[Double](n);

    val z = new Rail[Double](n);  
    /* Initialize array(s). */
    gemver.init_array (n, alpha, beta,
  	      A,
  	      u1,
  	      v1,
  	      u2,
  	      v2,
  	      w,
  	      x,
  	      y,
  	      z);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    gemver.kernel_gemver (n, alpha(0), beta(0),
  		 A,
  		 u1,
  		 v1,
  		 u2,
  		 v2,
  		 w,
  		 x,
  		 y,
  		 z);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // gemver.print_array(n, w);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
