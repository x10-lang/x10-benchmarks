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
public class Pb_2mm {

  var _PB_NI : Long;
  var _PB_NJ : Long;
  var _PB_NK : Long;
  var _PB_NL : Long;  

  def setPBs(ni : Long, nj : Long, nk : Long, nl : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
    _PB_NK = nk; 
    _PB_NL = nl; 
  }
  def init_array(ni : Long,
  nj : Long,
  nk : Long,
  nl : Long,
  		alpha : Rail[Double],
  		beta : Rail[Double],
  		A : Array_2[Double],
  		B : Array_2[Double],
  		C : Array_2[Double],
  		D : Array_2[Double])
  {
    alpha(0) = 32412;
    beta(0) = 2123;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nk; j++)
        A(i,j) = ((i as Double) *j) / ni;
    for (var i : Long = 0; i < nk; i++)
      for (var j : Long = 0; j < nj; j++)
        B(i,j) = ((i as Double)*(j+1)) / nj;
    for (var i : Long = 0; i < nl; i++)
      for (var j : Long = 0; j < nj; j++)
        C(i,j) = ((i as Double)*(j+3)) / nl;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nl; j++)
        D(i,j) = ((i as Double)*(j+2)) / nk;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  nl : Long,
  		 D : Array_2[Double])
  {
    var i : Long; 
    var j : Long;
    for (i = 0; i < ni; i++)
      for (j = 0; j < nl; j++) {
  	Console.ERR.printf("%0.2lf", D(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_2mm(ni : Long,
  nj : Long,
  nk : Long,
  nl : Long,
  		alpha : Double,
  		beta : Double,
  		tmp : Array_2[Double],
  		A : Array_2[Double],
  		B : Array_2[Double],
  		C : Array_2[Double],
  		D : Array_2[Double])
  {
  
  // #pragma scop
    /* D := alpha *A *B *C + beta *D */
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++)
        {
  	tmp(i,j) = 0;
  	for (var k : Long = 0; k < nk; ++k)
  	  tmp(i,j) += alpha * A(i,k) * B(k,j);
        }
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nl; j++)
        {
  	D(i,j) *= beta;
  	for (var k : Long = 0; k < nj; ++k)
  	  D(i,j) += tmp(i,k) * C(k,j);
        }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var NI : Long = 0;
    var NJ : Long = 0;
    var NK : Long = 0;
    var NL : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NI = 4000;
        NJ = 4000;
        NK = 4000;
        NL = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        NI = 1024;
        NJ = 1024;
        NK = 1024;
        NL = 1024;
    }
    @Ifdef("MINI_DATASET") {
        NI = 32;
        NJ = 32;
        NK = 32;
        NL = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NI = 128;
        NJ = 128;
        NK = 128;
        NL = 128;
    }
    @Ifdef("LARGE_DATASET") {
        NI = 2000;
        NJ = 2000;
        NK = 2000;
        NL = 2000;
    }
    
    val pb_2mm = new Pb_2mm();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
    var nk  : Long= NK;
    var nl  : Long= NL;
  
    pb_2mm.setPBs(ni, nj, nk, nl);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val tmp = new Array_2[Double](ni,nj);

    val A = new Array_2[Double](ni,nk);

    val B = new Array_2[Double](nk,nj);

    val C = new Array_2[Double](nl,nj);

    val D = new Array_2[Double](ni,nl);    /* Initialize array(s). */
    pb_2mm.init_array (ni, nj, nk, nl, alpha, beta,
  	      A,
  	      B,
  	      C,
  	      D);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    pb_2mm.kernel_2mm (ni, nj, nk, nl,
  	      alpha(0), beta(0),
  	      tmp,
  	      A,
  	      B,
  	      C,
  	      D);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // pb_2mm.print_array(ni, nl, D);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
