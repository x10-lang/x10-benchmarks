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
public class Dynprog {

  var _PB_LENGTH : Long;
  var _PB_TSTEPS : Long;  

  def setPBs(length : Long, tsteps : Long) {
    _PB_LENGTH = length; 
    _PB_TSTEPS = tsteps; 
  }
  def init_array(length : Long,
  		c : Array_2[Long],
  		W : Array_2[Long])
  {
    for (var i : Long = 0; i < length; i++)
      for (var j : Long = 0; j < length; j++) {
        c(i,j) = i *j % 2;
        W(i,j) = ((i as Long)-j) / length;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(out : Long)
  {
    Console.ERR.printf("%d ", out);
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_dynprog(tsteps : Long,
  length : Long,
  		    c : Array_2[Long],
  		    W : Array_2[Long],
  		    sum_c : Array_3[Long],
  		    out : Rail[Long])
  {
    var out_l : Long = 0;
  
  // #pragma scop
    for (var iter : Long = 0; iter < tsteps; iter++)
      {
        for (var i : Long = 0; i <= length - 1; i++)
  	for (var j : Long = 0; j <= length - 1; j++)
  	  c(i,j) = 0;
  
        for (var i : Long = 0; i <= length - 2; i++)
  	{
  	  for (var j : Long = i + 1; j <= length - 1; j++)
  	    {
  	      sum_c(i,j,i) = 0;
  	      for (var k : Long = i + 1; k <= j-1; k++)
  		sum_c(i,j,k) = sum_c(i,j,k - 1) + c(i,k) + c(k,j);
  	      c(i,j) = sum_c(i,j,j-1) + W(i,j);
  	    }
  	}
        out_l += c(0,length - 1);
      }
  // #pragma endscop
  
    out(0) = out_l;
  }  public static def main(args : Rail[String])
  {
    var LENGTH : Long = 0;
    var TSTEPS : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        LENGTH = 500;
        TSTEPS = 10000;
    }
    @Ifdef("STANDARD_DATASET") {
        LENGTH = 50;
        TSTEPS = 10000;
    }
    @Ifdef("MINI_DATASET") {
        LENGTH = 32;
        TSTEPS = 10;
    }
    @Ifdef("SMALL_DATASET") {
        LENGTH = 50;
        TSTEPS = 100;
    }
    @Ifdef("LARGE_DATASET") {
        LENGTH = 500;
        TSTEPS = 1000;
    }
    
    val dynprog = new Dynprog();
    /* Retrieve problem size. */
    var length  : Long= LENGTH;
    var tsteps  : Long= TSTEPS;
  
    dynprog.setPBs(length, tsteps);
    /* Variable declaration/allocation. */
    val out = new Rail[Long](1);
    val sum_c = new Array_3[Long](length,length,length);

    val c = new Array_2[Long](length,length);

    val W = new Array_2[Long](length,length);    /* Initialize array(s). */
    dynprog.init_array (length, c, W);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    dynprog.kernel_dynprog (tsteps, length,
  		  c,
  		  W,
  		  sum_c,
  		  out);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // dynprog.print_array(out(0));
  
    /* Prevent dead-code elimination. All live-out(0) data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
