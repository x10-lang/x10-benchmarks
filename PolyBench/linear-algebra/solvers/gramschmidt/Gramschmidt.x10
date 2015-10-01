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
public class Gramschmidt {

  var _PB_NI : Long;
  var _PB_NJ : Long;

  def setPBs(ni : Long, nj : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
  }
  def init_array(ni : Long,
  nj : Long,
  		A : Array_2[Double],
  		R : Array_2[Double],
  		Q : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
        A(i,j) = ((i as Double) *j) / ni;
        Q(i,j) = ((i as Double)*(j+1)) / nj;
      }
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nj; j++)
        R(i,j) = ((i as Double)*(j+2)) / nj;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  nj : Long,
  		 A : Array_2[Double],
  		 R : Array_2[Double],
  		 Q : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf", A(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf", R(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf", Q(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_gramschmidt(ni : Long,
  nj : Long,
  			A : Array_2[Double],
  			R : Array_2[Double],
  			Q : Array_2[Double])
  {
    var nrm : Double;
  
  // #pragma scop
    for (var k : Long = 0; k < nj; k++)
      {
        nrm = 0;
        for (var i : Long = 0; i < ni; i++)
          nrm += A(i,k) * A(i,k);
        R(k,k) = Math.sqrt(nrm);
        for (var i : Long = 0; i < ni; i++)
          Q(i,k) = A(i,k) / R(k,k);
        for (var j : Long = k + 1; j < nj; j++)
  	{
  	  R(k,j) = 0;
  	  for (var i : Long = 0; i < ni; i++)
  	    R(k,j) += Q(i,k) * A(i,j);
  	  for (var i : Long = 0; i < ni; i++)
  	    A(i,j) = A(i,j) - Q(i,k) * R(k,j);
  	}
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
        NI = 512;
        NJ = 512;
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
    
    val gramschmidt = new Gramschmidt();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
  
    gramschmidt.setPBs(ni, nj);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](ni,nj);

    val R = new Array_2[Double](nj,nj);

    val Q = new Array_2[Double](ni,nj);    /* Initialize array(s). */
    gramschmidt.init_array (ni, nj,
  	      A,
  	      R,
  	      Q);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    gramschmidt.kernel_gramschmidt (ni, nj,
  		      A,
  		      R,
  		      Q);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // gramschmidt.print_array(ni, nj, A, R, Q);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
