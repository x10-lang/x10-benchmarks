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
public class Doitgen {

  var _PB_NP : Long;
  var _PB_NQ : Long;
  var _PB_NR : Long;  

  def setPBs(np : Long, nq : Long, nr : Long) {
    _PB_NP = np; 
    _PB_NQ = nq; 
    _PB_NR = nr; 
  }
  def init_array(nr : Long,
  nq : Long,
  np : Long,
  		A : Array_3[Double],
  		C4 : Array_2[Double])
  {
    for (var i : Long = 0; i < nr; i++)
      for (var j : Long = 0; j < nq; j++)
        for (var k : Long = 0; k < np; k++)
  	A(i,j,k) = ((i as Double) *j + k) / np;
    for (var i : Long = 0; i < np; i++)
      for (var j : Long = 0; j < np; j++)
        C4(i,j) = ((i as Double) *j) / np;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(nr : Long,
  nq : Long,
  np : Long,
  		 A : Array_3[Double])
  {
    for (var i : Long = 0; i < nr; i++)
      for (var j : Long = 0; j < nq; j++)
        for (var k : Long = 0; k < np; k++) {
  	Console.ERR.printf("%0.2lf", A(i,j,k));
  	if (i % 20 == 0) Console.ERR.printf("\n");
        }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_doitgen(nr : Long,
  nq : Long,
  np : Long,
  		    A : Array_3[Double],
  		    C4 : Array_2[Double],
  		    sum : Array_3[Double])
  {
  // #pragma scop
    for (var r : Long = 0; r < nr; r++)
      for (var q : Long = 0; q < nq; q++)  {
        for (var p : Long = 0; p < np; p++)  {
  	sum(r,q,p) = 0;
  	for (var s : Long = 0; s < np; s++)
  	  sum(r,q,p) = sum(r,q,p) + A(r,q,s) * C4(s,p);
        }
        for (var p : Long = 0; p < nr; p++)
  	A(r,q,p) = sum(r,q,p);
      }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var NP : Long = 0;
    var NQ : Long = 0;
    var NR : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NP = 1000;
        NQ = 1000;
        NR = 1000;
    }
    @Ifdef("STANDARD_DATASET") {
        NP = 128;
        NQ = 128;
        NR = 128;
    }
    @Ifdef("MINI_DATASET") {
        NP = 10;
        NQ = 10;
        NR = 10;
    }
    @Ifdef("SMALL_DATASET") {
        NP = 32;
        NQ = 32;
        NR = 32;
    }
    @Ifdef("LARGE_DATASET") {
        NP = 256;
        NQ = 256;
        NR = 256;
    }
    
    val doitgen = new Doitgen();
    /* Retrieve problem size. */
    var nr  : Long= NR;
    var nq  : Long= NQ;
    var np  : Long= NP;
  
    doitgen.setPBs(np, nq, nr);
    /* Variable declaration/allocation. */
    val A = new Array_3[Double](nr,nq,np);

    val sum = new Array_3[Double](nr,nq,np);

    val C4 = new Array_2[Double](np,np);    /* Initialize array(s). */
    doitgen.init_array (nr, nq, np,
  	      A,
  	      C4);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    doitgen.kernel_doitgen (nr, nq, np,
  		  A,
  		  C4,
  		  sum);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // doitgen.print_array(nr, nq, np, A);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
