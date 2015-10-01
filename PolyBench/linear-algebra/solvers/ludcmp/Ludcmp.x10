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
  def kernel_ludcmp(n : Long,
  		   A : Array_2[Double],
  		   b : Rail[Double],
  		   x : Rail[Double],
  		   y : Rail[Double])
  {
    var w : Double;
  // #pragma scop
    b(0) = 1.0;
    for (var i : Long = 0; i < n; i++)
      {
        for (var j : Long = i+1; j <= n; j++)
          {
  	  w = A(j,i);
  	  for (var k : Long = 0; k < i; k++)
  	    w = w- A(j,k) * A(k,i);
  	  A(j,i) = w / A(i,i);
          }
        for (var j : Long = i+1; j <= n; j++)
          {
  	  w = A(i+1,j);
  	  for (var k : Long = 0; k <= i; k++)
  	    w = w  - A(i+1,k) * A(k,j);
  	  A(i+1,j) = w;
          }
      }
    y(0) = b(0);
    for (var i : Long = 1; i <= n; i++)
      {
        w = b(i);
        for (var j : Long = 0; j < i; j++)
  	w = w - A(i,j) * y(j);
        y(i) = w;
      }
    x(n) = y(n) / A(n,n);
    for (var i : Long = 0; i <= n - 1; i++)
      {
        w = y(n - 1 - (i));
        for (var j : Long = n - i; j <= n; j++)
  	w = w - A(n - 1 - i,j) * x(j);
        x(n - 1 - i) = w / A(n - 1 - i, n - 1 - i);
      }
  // #pragma endscop
  
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
