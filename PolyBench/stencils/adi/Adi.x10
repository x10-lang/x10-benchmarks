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
public class Adi {

  var _PB_TSTEPS : Long;
  var _PB_N : Long;

  def setPBs(tsteps : Long, n : Long) {
    _PB_TSTEPS = tsteps; 
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 X : Array_2[Double],
  		 A : Array_2[Double],
  		 B : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        {
  	X(i,j) = ((i as Double)*(j+1) + 1) / n;
  	A(i,j) = ((i as Double)*(j+2) + 2) / n;
  	B(i,j) = ((i as Double)*(j+3) + 3) / n;
        }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 X : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf", X(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_adi(tsteps : Long,
  		n : Long,
  		X : Array_2[Double],
  		A : Array_2[Double],
  		B : Array_2[Double])
  {
  // #pragma scop
    for (var t : Long = 0; t < tsteps; t++)
      {
        for (var i1 : Long = 0; i1 < n; i1++)
  	for (var i2 : Long = 1; i2 < n; i2++)
  	  {
  	    X(i1,i2) = X(i1,i2) - X(i1,i2-1) * A(i1,i2) / B(i1,i2-1);
  	    B(i1,i2) = B(i1,i2) - A(i1,i2) * A(i1,i2) / B(i1,i2-1);
  	  }
  
        for (var i1 : Long = 0; i1 < n; i1++)
  	X(i1,n-1) = X(i1,n-1) / B(i1,n-1);
  
        for (var i1 : Long = 0; i1 < n; i1++)
  	for (var i2 : Long = 0; i2 < n-2; i2++)
  	  X(i1,n-i2-2) = (X(i1,n-2-i2) - X(i1,n-2-i2-1) * A(i1,n-i2-3)) / B(i1,n-3-i2);
  
        for (var i1 : Long = 1; i1 < n; i1++)
  	for (var i2 : Long = 0; i2 < n; i2++) {
  	  X(i1,i2) = X(i1,i2) - X(i1-1,i2) * A(i1,i2) / B(i1-1,i2);
  	  B(i1,i2) = B(i1,i2) - A(i1,i2) * A(i1,i2) / B(i1-1,i2);
  	}
  
        for (var i2 : Long = 0; i2 < n; i2++)
  	X(n-1,i2) = X(n-1,i2) / B(n-1,i2);
  
        for (var i1 : Long = 0; i1 < n-2; i1++)
  	for (var i2 : Long = 0; i2 < n; i2++)
  	  X(n-2-i1,i2) = (X(n-2-i1,i2) - X(n-i1-3,i2) * A(n-3-i1,i2)) / B(n-2-i1,i2);
      }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var TSTEPS : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        TSTEPS = 100;
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        TSTEPS = 50;
        N = 1024;
    }
    @Ifdef("MINI_DATASET") {
        TSTEPS = 2;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        TSTEPS = 10;
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        TSTEPS = 50;
        N = 2000;
    }
    
    val adi = new Adi();
    /* Retrieve problem size. */
    var n  : Long= N;
    var tsteps  : Long= TSTEPS;
  
    adi.setPBs(tsteps, n);
    /* Variable declaration/allocation. */
    val X = new Array_2[Double](n,n);

    val A = new Array_2[Double](n,n);

    val B = new Array_2[Double](n,n);  
    /* Initialize array(s). */
    adi.init_array (n, X, A, B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    adi.kernel_adi (tsteps, n, X,
  	      A, B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // adi.print_array(n, X);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
