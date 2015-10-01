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
public class Durbin {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 y : Array_2[Double],
  		 sum : Array_2[Double],
  		 alpha : Rail[Double],
  		 beta : Rail[Double],
  		 r : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        alpha(i) = i;
        beta(i) = (i+1)/n/2.0;
        r(i) = (i+1)/n/4.0;
        for (var j : Long = 0; j < n; j++) {
  	y(i,j) = ((i as Double) *j) / n;
  	sum(i,j) = ((i as Double) *j) / n;
        }
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 out : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf", out(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_durbin(n : Long,
  		   y : Array_2[Double],
  		   sum : Array_2[Double],
  		   alpha : Rail[Double],
  		   beta : Rail[Double],
  		   r : Rail[Double],
  		   out : Rail[Double])
  {
  // #pragma scop
    y(0,0) = r(0);
    beta(0) = 1;
    alpha(0) = r(0);
    for (var k : Long = 1; k < n; k++)
      {
        beta(k) = beta(k-1) - alpha(k-1) * alpha(k-1) * beta(k-1);
        sum(0,k) = r(k);
        for (var i : Long = 0; i <= k - 1; i++)
  	sum(i+1,k) = sum(i,k) + r(k-i-1) * y(i,k-1);
        alpha(k) = -sum(k,k) * beta(k);
        for (var i : Long = 0; i <= k-1; i++)
  	y(i,k) = y(i,k-1) + alpha(k) * y(k-i-1,k-1);
        y(k,k) = alpha(k);
      }
    for (var i : Long = 0; i < n; i++)
      out(i) = y(i,_PB_N-1);
  // #pragma endscop
  
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
        N = 14000;
    }
    
    val durbin = new Durbin();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    durbin.setPBs(n);
    /* Variable declaration/allocation. */
    val y = new Array_2[Double](n,n);

    val sum = new Array_2[Double](n,n);

    val alpha = new Rail[Double](n);

    val beta = new Rail[Double](n);

    val r = new Rail[Double](n);

    val out = new Rail[Double](n);  
    /* Initialize array(s). */
    durbin.init_array (n,
  	      y,
  	      sum,
  	      alpha,
  	      beta,
  	      r);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    durbin.kernel_durbin (n,
  		 y,
  		 sum,
  		 alpha,
  		 beta,
  		 r,
  		 out);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // durbin.print_array(n, out);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
