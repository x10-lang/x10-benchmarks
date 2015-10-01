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
public class Symm {

  var _PB_NI : Long;
  var _PB_NJ : Long;  

  def setPBs(ni : Long, nj : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
  }
  def init_array(ni : Long,
  nj : Long,
  		alpha : Rail[Double],
  		beta : Rail[Double],
  		C : Array_2[Double],
  		A : Array_2[Double],
  		B : Array_2[Double])
  {
    alpha(0) = 32412;
    beta(0) = 2123;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
        C(i,j) = ((i as Double) *j) / ni;
        B(i,j) = ((i as Double) *j) / ni;
      }
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nj; j++)
        A(i,j) = ((i as Double) *j) / ni;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  nj : Long,
  		 C : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf", C(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_symm(ni : Long,
  nj : Long,
  		 alpha : Double,
  		 beta : Double,
  		 C : Array_2[Double],
  		 A : Array_2[Double],
  		 B : Array_2[Double])
  {
    var acc : Double;
  
  // #pragma scop
    /*  C := alpha *A *B + beta *C, A is symetric */
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++)
        {
  	acc = 0;
  	for (var k : Long = 0; k < j - 1; k++)
  	  {
  	    C(k,j) += alpha * A(k,i) * B(i,j);
  	    acc += B(k,j) * A(k,i);
  	  }
  	C(i,j) = beta * C(i,j) + alpha * A(i,i) * B(i,j) + alpha * acc;
        }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var NI : Long = 0;
    var NJ : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NI = 4000;
        NJ = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        NI = 1024;
        NJ = 1024;
    }
    @Ifdef("MINI_DATASET") {
        NI = 32;
        NJ = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NI = 128;
        NJ = 128;
    }
    @Ifdef("LARGE_DATASET") {
        NI = 2000;
        NJ = 2000;
    }
    
    val symm = new Symm();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
  
    symm.setPBs(ni, nj);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val C = new Array_2[Double](ni,nj);

    val A = new Array_2[Double](nj,nj);

    val B = new Array_2[Double](ni,nj);    /* Initialize array(s). */
    symm.init_array (ni, nj, alpha, beta,
  	      C,
  	      A,
  	      B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    symm.kernel_symm (ni, nj,
  	       alpha(0), beta(0),
  	       C,
  	       A,
  	       B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // symm.print_array(ni, nj, C);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
