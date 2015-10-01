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
public class Pb_3mm {

  var _PB_NI : Long;
  var _PB_NJ : Long;
  var _PB_NK : Long;
  var _PB_NL : Long;
  var _PB_NM : Long;  

  def setPBs(ni : Long, nj : Long, nk : Long, nl : Long, nm : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
    _PB_NK = nk; 
    _PB_NL = nl; 
    _PB_NM = nm; 
  }
  def init_array(ni : Long,
  nj : Long,
  nk : Long,
  nl : Long,
  nm : Long,
  		A : Array_2[Double],
  		B : Array_2[Double],
  		C : Array_2[Double],
  		D : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nk; j++)
        A(i,j) = ((i as Double) *j) / ni;
    for (var i : Long = 0; i < nk; i++)
      for (var j : Long = 0; j < nj; j++)
        B(i,j) = ((i as Double)*(j+1)) / nj;
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nm; j++)
        C(i,j) = ((i as Double)*(j+3)) / nl;
    for (var i : Long = 0; i < nm; i++)
      for (var j : Long = 0; j < nl; j++)
        D(i,j) = ((i as Double)*(j+2)) / nk;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  nl : Long,
  		 G : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nl; j++) {
  	Console.ERR.printf("%0.2lf", G(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_3mm(ni : Long,
  nj : Long,
  nk : Long,
  nl : Long,
  nm : Long,
  		E : Array_2[Double],
  		A : Array_2[Double],
  		B : Array_2[Double],
  		F : Array_2[Double],
  		C : Array_2[Double],
  		D : Array_2[Double],
  		G : Array_2[Double])
  {
  // #pragma scop
    /* E := A *B */
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++)
        {
  	E(i,j) = 0;
  	for (var k : Long = 0; k < nk; ++k)
  	  E(i,j) += A(i,k) * B(k,j);
        }
    /* F := C *D */
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nl; j++)
        {
  	F(i,j) = 0;
  	for (var k : Long = 0; k < nm; ++k)
  	  F(i,j) += C(i,k) * D(k,j);
        }
    /* G := E *F */
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nl; j++)
        {
  	G(i,j) = 0;
  	for (var k : Long = 0; k < nj; ++k)
  	  G(i,j) += E(i,k) * F(k,j);
        }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var NI : Long = 0;
    var NJ : Long = 0;
    var NK : Long = 0;
    var NL : Long = 0;
    var NM : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NI = 4000;
        NJ = 4000;
        NK = 4000;
        NL = 4000;
        NM = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        NI = 1024;
        NJ = 1024;
        NK = 1024;
        NL = 1024;
        NM = 1024;
    }
    @Ifdef("MINI_DATASET") {
        NI = 32;
        NJ = 32;
        NK = 32;
        NL = 32;
        NM = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NI = 128;
        NJ = 128;
        NK = 128;
        NL = 128;
        NM = 128;
    }
    @Ifdef("LARGE_DATASET") {
        NI = 2000;
        NJ = 2000;
        NK = 2000;
        NL = 2000;
        NM = 2000;
    }
    
    val pb_3mm = new Pb_3mm();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
    var nk  : Long= NK;
    var nl  : Long= NL;
    var nm  : Long= NM;
  
    pb_3mm.setPBs(ni, nj, nk, nl, nm);
    /* Variable declaration/allocation. */
    val E = new Array_2[Double](ni,nj);

    val A = new Array_2[Double](ni,nk);

    val B = new Array_2[Double](nk,nj);

    val F = new Array_2[Double](nj,nl);

    val C = new Array_2[Double](nj,nm);

    val D = new Array_2[Double](nm,nl);

    val G = new Array_2[Double](ni,nl);    /* Initialize array(s). */
    pb_3mm.init_array (ni, nj, nk, nl, nm,
  	      A,
  	      B,
  	      C,
  	      D);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    pb_3mm.kernel_3mm (ni, nj, nk, nl, nm,
  	      E,
  	      A,
  	      B,
  	      F,
  	      C,
  	      D,
  	      G);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // pb_3mm.print_array(ni, nl, G);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
