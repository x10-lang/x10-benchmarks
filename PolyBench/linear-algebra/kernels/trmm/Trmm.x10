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
public class Trmm {

  var _PB_NI : Long;  

  def setPBs(ni : Long) {
    _PB_NI = ni; 
  }
  def init_array(ni : Long,
  		alpha : Rail[Double],
  		A : Array_2[Double],
  		B : Array_2[Double])
  {
    alpha(0) = 32412;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < ni; j++) {
        A(i,j) = ((i as Double) *j) / ni;
        B(i,j) = ((i as Double) *j) / ni;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  		 B : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < ni; j++) {
  	Console.ERR.printf("%0.2lf ", B(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_trmm(ni : Long,
  		 alpha : Double,
  		 A : Array_2[Double],
  		 B : Array_2[Double])
  {
  // #pragma scop
    /*  B := alpha *A' *B, A triangular */
    for (var i : Long = 1; i < ni; i++)
      for (var j : Long = 0; j < ni; j++)
        for (var k : Long = 0; k < i; k++)
          B(i,j) += alpha * A(i,k) * B(j,k);
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var NI : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NI = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        NI = 1024;
    }
    @Ifdef("MINI_DATASET") {
        NI = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NI = 128;
    }
    @Ifdef("LARGE_DATASET") {
        NI = 2000;
    }
    
    val trmm = new Trmm();
    /* Retrieve problem size. */
    var ni  : Long= NI;
  
    trmm.setPBs(ni);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val A = new Array_2[Double](ni,ni);

    val B = new Array_2[Double](ni,ni);    /* Initialize array(s). */
    trmm.init_array (ni, alpha, A, B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    trmm.kernel_trmm (ni, alpha(0), A, B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // trmm.print_array(ni, B);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
