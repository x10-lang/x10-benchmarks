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
      Console.ERR.printf("%0.2lf", x(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_trisolv(n : Long,
  		    A : Array_2[Double],
  		    x : Rail[Double],
  		    c : Rail[Double])
  {
  // #pragma scop
    for (var i : Long = 0; i < n; i++)
      {
        x(i) = c(i);
        for (var j : Long = 0; j <= i - 1; j++)
          x(i) = x(i) - A(i,j) * x(j);
        x(i) = x(i) / A(i,i);
      }
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
