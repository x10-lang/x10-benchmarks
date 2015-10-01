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
import x10.compiler.Foreach;
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
  	Console.ERR.printf("%0.2lf ", A(i,j,k));
  	if (i % 20 == 0) Console.ERR.printf("\n");
        }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_doitgen(nr : long, nq : long, np : long, A : Array_3[double], C4 : Array_2[double], sum : Array_3[double])  {
        var c3 : long;
        var c1 : long;
        var c2 : long;
        var c4 : long;
        if (((nq >= 1) && (nr >= 1))) {
            if ((np >= 1)) {
                {
                    Foreach.block(0,(nr + -1),(var c1 : long) => {
                        var c3 : long;
                        var c2 : long;
                        var c4 : long;
                        for (c2 = 0; (c2 <= (nq + -1)); c2++) {
                            for (c3 = 0; (c3 <= (np + -1)); c3++) {
                                sum(c1,c2,c3) = (0L) as double;
                            }
                        }
                    }
);
                }
            }
            if ((np >= 1)) {
                {
                    Foreach.block(0,(nr + -1),(var c1 : long) => {
                        var c3 : long;
                        var c2 : long;
                        var c4 : long;
                        for (c2 = 0; (c2 <= (nq + -1)); c2++) {
                            for (c3 = 0; (c3 <= (np + -1)); c3++) {
                                for (c4 = 0; (c4 <= (np + -1)); c4++) {
                                    sum(c1,c2,c3) = sum(c1,c2,c3) + A(c1,c2,c4) * C4(c4,c3);
                                }
                            }
                        }
                    }
);
                }
            }
            {
                Foreach.block(0,(nr + -1),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
                    for (c2 = 0; (c2 <= (nq + -1)); c2++) {
                        for (c3 = 0; (c3 <= (nr + -1)); c3++) {
                            A(c1,c2,c3) = sum(c1,c2,c3);
                        }
                    }
                }
);
            }
        }
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
