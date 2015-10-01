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
public class Gesummv {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		alpha : Rail[Double],
  		beta : Rail[Double],
  		A : Array_2[Double],
  		B : Array_2[Double],
  		x : Rail[Double])
  {
    alpha(0) = 43532;
    beta(0) = 12313;
    for (var i : Long = 0; i < n; i++)
      {
        x(i) = ((i as Double)) / n;
        for (var j : Long = 0; j < n; j++) {
  	A(i,j) = ((i as Double) *j) / n;
  	B(i,j) = ((i as Double) *j) / n;
        }
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 y : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", y(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_gesummv(n : long, alpha : double, beta : double, A : Array_2[double], B : Array_2[double], tmp : Rail[double], x : Rail[double], y : Rail[double])  {
        var c1 : long;
        var c3 : long;
        var c2 : long;
        var c4 : long;
        if ((n >= 1)) {
            {
                Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                    for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c4++) {
                        y(c4) = (0L) as double;
                    }
                }
);
            }
            {
                Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
                    for (c2 = 0; (c2 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c2++) {
                        for (c3 = (256 * c2); (c3 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c3++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c4++) {
                                y(c4) = B(c4,c3) * x(c3) + y(c4);
                            }
                        }
                    }
                }
);
            }
            {
                Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                    for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c4++) {
                        tmp(c4) = (0L) as double;
                    }
                }
);
            }
            {
                Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
                    for (c2 = 0; (c2 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c2++) {
                        for (c3 = (256 * c2); (c3 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c3++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c4++) {
                                tmp(c4) = A(c4,c3) * x(c3) + tmp(c4);
                            }
                        }
                    }
                }
);
            }
            {
                Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c1 : long) => {
                    var c3 : long;
                    var c2 : long;
                    var c4 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                    for (c4 = (256 * c1); (c4 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c4++) {
                        y(c4) = alpha * tmp(c4) + beta * y(c4);
                    }
                }
);
            }
        }
    }  public static def main(args : Rail[String])
  {
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 100000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 4000;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        /*N = 8000;*/
        N = 42000;
    }
    
    val gesummv = new Gesummv();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    gesummv.setPBs(n);
    /* Variable declaration/allocation. */
    val alpha = new Rail[Double](1);
    val beta = new Rail[Double](1);
    val A = new Array_2[Double](n,n);

    val B = new Array_2[Double](n,n);

    val tmp = new Rail[Double](n);

    val x = new Rail[Double](n);

    val y = new Rail[Double](n);  
    /* Initialize array(s). */
    gesummv.init_array (n, alpha, beta,
  	      A,
  	      B,
  	      x);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    gesummv.kernel_gesummv (n, alpha(0), beta(0),
  		  A,
  		  B,
  		  tmp,
  		  x,
  		  y);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // gesummv.print_array(n, y);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
