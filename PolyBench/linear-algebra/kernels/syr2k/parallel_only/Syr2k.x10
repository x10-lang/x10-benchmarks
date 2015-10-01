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
public class Syr2k {

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
        A(i,j) = ((i as Double) *j) / ni;
        B(i,j) = ((i as Double) *j) / ni;
      }
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < ni; j++)
        C(i,j) = ((i as Double) *j) / ni;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  		 C : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < ni; j++) {
  	Console.ERR.printf("%0.2lf ", C(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_syr2k(ni : long, nj : long, alpha : double, beta : double, C : Array_2[double], A : Array_2[double], B : Array_2[double])  {
        var c2 : long;
        var c1 : long;
        var c3 : long;
        if ((ni >= 1)) {
            {
                Foreach.block(0,(ni + -1),(var c1 : long) => {
                    var c2 : long;
                    var c3 : long;
                    for (c2 = 0; (c2 <= (ni + -1)); c2++) {
                        C(c1,c2) *= beta;
                    }
                }
);
            }
            if ((nj >= 1)) {
                {
                    Foreach.block(0,(ni + -1),(var c1 : long) => {
                        var c2 : long;
                        var c3 : long;
                        for (c2 = 0; (c2 <= (ni + -1)); c2++) {
                            for (c3 = 0; (c3 <= (nj + -1)); c3++) {
                                C(c1,c2) += alpha * A(c1,c3) * B(c2,c3);
                                C(c1,c2) += alpha * B(c1,c3) * A(c2,c3);
                            }
                        }
                    }
);
                }
            }
        }
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
    
    val syr2k = new Syr2k();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
  
    syr2k.setPBs(ni, nj);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val C = new Array_2[Double](ni,ni);

    val A = new Array_2[Double](ni,nj);

    val B = new Array_2[Double](ni,nj);    /* Initialize array(s). */
    syr2k.init_array (ni, nj, alpha, beta,
  	      C,
  	      A,
  	      B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    syr2k.kernel_syr2k (ni, nj,
  		alpha(0), beta(0),
  		C,
  		A,
  		B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // syr2k.print_array(ni, C);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
