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
public class Mvt {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		x1 : Rail[Double],
  		x2 : Rail[Double],
  		y_1 : Rail[Double],
  		y_2 : Rail[Double],
  		A : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        x1(i) = ((i as Double)) / n;
        x2(i) = ((i as Double) + 1) / n;
        y_1(i) = ((i as Double) + 3) / n;
        y_2(i) = ((i as Double) + 4) / n;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = ((i as Double) *j) / _PB_N;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 x1 : Rail[Double],
  		 x2 : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf", x1(i));
      Console.ERR.printf("%0.2lf", x2(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_mvt(n : Long,
  		x1 : Rail[Double],
  		x2 : Rail[Double],
  		y_1 : Rail[Double],
  		y_2 : Rail[Double],
  		A : Array_2[Double])
  {
  // #pragma scop
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        x1(i) = x1(i) + A(i,j) * y_1(j);
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        x2(i) = x2(i) + A(j,i) * y_2(j);
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
        N = 28000;
    }
    
    val mvt = new Mvt();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    mvt.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val x1 = new Rail[Double](n);

    val x2 = new Rail[Double](n);

    val y_1 = new Rail[Double](n);

    val y_2 = new Rail[Double](n);  
    /* Initialize array(s). */
    mvt.init_array (n,
  	      x1,
  	      x2,
  	      y_1,
  	      y_2,
  	      A);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    mvt.kernel_mvt (n,
  	      x1,
  	      x2,
  	      y_1,
  	      y_2,
  	      A);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // mvt.print_array(n, x1, x2);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
