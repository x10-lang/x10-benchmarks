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
public class Gemm {

  var _PB_NI : Long;
  var _PB_NJ : Long;
  var _PB_NK : Long;  

  def setPBs(ni : Long, nj : Long, nk : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
    _PB_NK = nk; 
  }
  def init_array(ni : Long,
  nj : Long,
  nk : Long,
  		alpha : Rail[Double],
  		beta : Rail[Double],
  		C : Array_2[Double],
  		A : Array_2[Double],
  		B : Array_2[Double])
  {
    alpha(0) = 32412;
    beta(0) = 2123;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++)
        C(i,j) = ((i as Double) *j) / ni;
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nk; j++)
        A(i,j) = ((i as Double) *j) / ni;
    for (var i : Long = 0; i < nk; i++)
      for (var j : Long = 0; j < nj; j++)
        B(i,j) = ((i as Double) *j) / ni;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long,
  nj : Long,
  		 C : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf ", C(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_gemm(ni : long, nj : long, nk : long, alpha : double, beta : double, C : Array_2[double], A : Array_2[double], B : Array_2[double])  {
        var c3 : long;
        var c5 : long;
        var c1 : long;
        var c2 : long;
        var c4 : long;
        var c6 : long;
        if (((ni >= 1) && (nj >= 1))) {
            {
                Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c5 : long;
                    var c2 : long;
                    var c4 : long;
                    var c6 : long;
                    for (c2 = 0; (c2 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256)); c2++) {
                        for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c6 = (256 * c2); (c6 <= (((256 * c2) + 255) < (nj + -1) ? (((256 * c2) + 255)) as long : ((nj + -1)) as long)); c6++) {
                                C(c4,c6) *= beta;
                            }
                        }
                    }
                }
);
            }
            if ((nk >= 1)) {
                {
                    Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                        var c3 : long;
                        var c5 : long;
                        var c2 : long;
                        var c4 : long;
                        var c6 : long;
                        for (c2 = 0; (c2 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256)); c2++) {
                            for (c3 = 0; (c3 <= ((nk + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nk + -1)) + 256 + 1) / 256) :  -(( -((nk + -1)) + 256 - 1) / 256)) : (nk + -1) / 256)); c3++) {
                                for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c4++) {
                                    for (c5 = (256 * c3); (c5 <= (((256 * c3) + 255) < (nk + -1) ? (((256 * c3) + 255)) as long : ((nk + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c6 = (256 * c2); (c6 <= (((256 * c2) + 255) < (nj + -1) ? (((256 * c2) + 255)) as long : ((nj + -1)) as long)); c6++) {
                                            C(c4,c6) += alpha * A(c4,c5) * B(c5,c6);
                                        }
                                    }
                                }
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
    var NK : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NI = 4000;
        NJ = 4000;
        NK = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        NI = 1024;
        NJ = 1024;
        NK = 1024;
    }
    @Ifdef("MINI_DATASET") {
        NI = 32;
        NJ = 32;
        NK = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NI = 128;
        NJ = 128;
        NK = 128;
    }
    @Ifdef("LARGE_DATASET") {
        NI = 2000;
        NJ = 2000;
        NK = 2000;
    }
    
    val gemm = new Gemm();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
    var nk  : Long= NK;
  
    gemm.setPBs(ni, nj, nk);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val C = new Array_2[Double](ni,nj);

    val A = new Array_2[Double](ni,nk);

    val B = new Array_2[Double](nk,nj);    /* Initialize array(s). */
    gemm.init_array (ni, nj, nk, alpha, beta,
  	      C,
  	      A,
  	      B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    gemm.kernel_gemm (ni, nj, nk,
  	       alpha(0), beta(0),
  	       C,
  	       A,
  	       B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // gemm.print_array(ni, nj, C);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
