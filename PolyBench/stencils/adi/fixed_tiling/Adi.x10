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
public class Adi {

  var _PB_TSTEPS : Long;
  var _PB_N : Long;

  def setPBs(tsteps : Long, n : Long) {
    _PB_TSTEPS = tsteps; 
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 X : Array_2[Double],
  		 A : Array_2[Double],
  		 B : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        {
  	X(i,j) = ((i as Double)*(j+1) + 1) / n;
  	A(i,j) = ((i as Double)*(j+2) + 2) / n;
  	B(i,j) = ((i as Double)*(j+3) + 3) / n;
        }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 X : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf ", X(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_adi(tsteps : long, n : long, X : Array_2[double], A : Array_2[double], B : Array_2[double])  {
        var c0 : long;
        var c2 : long;
        var c8 : long;
        var c9 : long;
        var c15 : long;
        if (((n >= 1) && (tsteps >= 1))) {
            for (c0 = 0; (c0 <= (tsteps + -1)); c0++) {
                if ((n >= 2)) {
                    {
                        Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c2 : long) => {
                            var c8 : long;
                            var c9 : long;
                            var c15 : long;
                            for (c8 = 0; (c8 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c8++) {
                                for (c9 = (1 > (256 * c8) ? (1) as long : ((256 * c8)) as long); (c9 <= (((256 * c8) + 255) < (n + -1) ? (((256 * c8) + 255)) as long : ((n + -1)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        B(c15,c9) = B(c15,c9) - A(c15,c9) * A(c15,c9) / B(c15,c9 - 1L);
                                    }
                                }
                            }
                            for (c8 = 0; (c8 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c8++) {
                                for (c9 = (1 > (256 * c8) ? (1) as long : ((256 * c8)) as long); (c9 <= (((256 * c8) + 255) < (n + -1) ? (((256 * c8) + 255)) as long : ((n + -1)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        X(c15,c9) = X(c15,c9) - X(c15,c9 - 1L) * A(c15,c9) / B(c15,c9 - 1L);
                                    }
                                }
                            }
                            for (c8 = 0; (c8 <= ((n + -3) * 256 < 0 ? (256 < 0 ?  -(( -((n + -3)) + 256 + 1) / 256) :  -(( -((n + -3)) + 256 - 1) / 256)) : (n + -3) / 256)); c8++) {
                                for (c9 = (256 * c8); (c9 <= (((256 * c8) + 255) < (n + -3) ? (((256 * c8) + 255)) as long : ((n + -3)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        X(c15,n - c9 - 2L) = (X(c15,n - 2L - c9) - X(c15,n - 2L - c9 - 1L) * A(c15,n - c9 - 3L)) / B(c15,n - 3L - c9);
                                    }
                                }
                            }
                        }
);
                    }
                }
                {
                    Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c2 : long) => {
                        var c8 : long;
                        var c9 : long;
                        var c15 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                        for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                            X(c15,n - 1L) = X(c15,n - 1L) / B(c15,n - 1L);
                        }
                    }
);
                }
                if ((n >= 2)) {
                    {
                        Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c2 : long) => {
                            var c8 : long;
                            var c9 : long;
                            var c15 : long;
                            for (c8 = 0; (c8 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c8++) {
                                for (c9 = (1 > (256 * c8) ? (1) as long : ((256 * c8)) as long); (c9 <= (((256 * c8) + 255) < (n + -1) ? (((256 * c8) + 255)) as long : ((n + -1)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        B(c9,c15) = B(c9,c15) - A(c9,c15) * A(c9,c15) / B(c9 - 1L,c15);
                                    }
                                }
                            }
                            for (c8 = 0; (c8 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c8++) {
                                for (c9 = (1 > (256 * c8) ? (1) as long : ((256 * c8)) as long); (c9 <= (((256 * c8) + 255) < (n + -1) ? (((256 * c8) + 255)) as long : ((n + -1)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        X(c9,c15) = X(c9,c15) - X(c9 - 1L,c15) * A(c9,c15) / B(c9 - 1L,c15);
                                    }
                                }
                            }
                            for (c8 = 0; (c8 <= ((n + -3) * 256 < 0 ? (256 < 0 ?  -(( -((n + -3)) + 256 + 1) / 256) :  -(( -((n + -3)) + 256 - 1) / 256)) : (n + -3) / 256)); c8++) {
                                for (c9 = (256 * c8); (c9 <= (((256 * c8) + 255) < (n + -3) ? (((256 * c8) + 255)) as long : ((n + -3)) as long)); c9++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                                        X(n - 2L - c9,c15) = (X(n - 2L - c9,c15) - X(n - c9 - 3L,c15) * A(n - 3L - c9,c15)) / B(n - 2L - c9,c15);
                                    }
                                }
                            }
                        }
);
                    }
                }
                {
                    Foreach.block(0,((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256),(var c2 : long) => {
                        var c8 : long;
                        var c9 : long;
                        var c15 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                        for (c15 = (256 * c2); (c15 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c15++) {
                            X(n - 1L,c15) = X(n - 1L,c15) / B(n - 1L,c15);
                        }
                    }
);
                }
            }
        }
    }  public static def main(args : Rail[String])
  {
    var TSTEPS : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        TSTEPS = 100;
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        TSTEPS = 50;
        N = 1024;
    }
    @Ifdef("MINI_DATASET") {
        TSTEPS = 2;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        TSTEPS = 10;
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        TSTEPS = 50;
        N = 2000;
    }
    
    val adi = new Adi();
    /* Retrieve problem size. */
    var n  : Long= N;
    var tsteps  : Long= TSTEPS;
  
    adi.setPBs(tsteps, n);
    /* Variable declaration/allocation. */
    val X = new Array_2[Double](n,n);

    val A = new Array_2[Double](n,n);

    val B = new Array_2[Double](n,n);  
    /* Initialize array(s). */
    adi.init_array (n, X, A, B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    adi.kernel_adi (tsteps, n, X,
  	      A, B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // adi.print_array(n, X);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
