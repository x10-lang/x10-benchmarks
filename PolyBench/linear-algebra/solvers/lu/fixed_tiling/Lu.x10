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
public class Lu {

  var _PB_N : Long;

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 A : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        A(i,j) = (((i+1) as Double) *(j+1)) / n;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 A : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf ", A(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_lu(n : long, A : Array_2[double])  {
        var c5 : long;
        var c0 : long;
        var c2 : long;
        var c4 : long;
        var c3 : long;
        var c1 : long;
        if ((n >= 2)) {
            for (c0 = 0; (c0 <= ((n + -2) * 16 < 0 ? (16 < 0 ?  -(( -((n + -2)) + 16 + 1) / 16) :  -(( -((n + -2)) + 16 - 1) / 16)) : (n + -2) / 16)); c0++) {
                {
                    val c0_0 = c0;
                    Foreach.block((c0_0 * 2 < 0 ?  -( -(c0_0) / 2) : (2 < 0 ? ( -(c0_0) +  -(2) - 1) /  -(2) : (c0_0 + 2 - 1) / 2)),(((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256) < c0_0 ? (((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)) as long : (c0_0) as long),(var c1 : long) => {
                        var c5 : long;
                        var c2 : long;
                        var c4 : long;
                        var c3 : long;
                        for (c2 = (c0_0 + (-1 * c1)); (c2 <= ((n + -1) * 256 < 0 ? (256 < 0 ?  -(( -((n + -1)) + 256 + 1) / 256) :  -(( -((n + -1)) + 256 - 1) / 256)) : (n + -1) / 256)); c2++) {
                            if ((c0_0 == (c1 + c2))) {
                                for (c3 = ((256 * c0_0) + (-256 * c1)); (c3 <= ((n + -2) < (((256 * c0_0) + (-256 * c1)) + 30) ? ((n + -2)) as long : ((((256 * c0_0) + (-256 * c1)) + 30)) as long)); c3++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c5 = ((256 * c1) > (c3 + 1) ? ((256 * c1)) as long : ((c3 + 1)) as long); (c5 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c5++) {
                                        A(c3,c5) = A(c3,c5) / A(c3,c3);
                                    }
                                    for (c4 = (c3 + 1); (c4 <= ((n + -1) < (((256 * c0_0) + (-256 * c1)) + 255) ? ((n + -1)) as long : ((((256 * c0_0) + (-256 * c1)) + 255)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c5 = ((256 * c1) > (c3 + 1) ? ((256 * c1)) as long : ((c3 + 1)) as long); (c5 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c5++) {
                                            A(c4,c5) = A(c4,c5) - A(c4,c3) * A(c3,c5);
                                        }
                                    }
                                }
                            }
                            if (((c0_0 == (c1 + c2)) && (c0_0 <= ((2 * c1) + -1)))) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c5 = (256 * c1); (c5 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c5++) {
                                    A((((256 * c0_0) + (-256 * c1)) + 255),c5) = A((((256 * c0_0) + (-256 * c1)) + 255),c5) / A((((256 * c0_0) + (-256 * c1)) + 255),(((256 * c0_0) + (-256 * c1)) + 255));
                                }
                            }
                            if ((c0_0 <= ((c1 + c2) + -1))) {
                                for (c3 = ((256 * c0_0) + (-256 * c1)); (c3 <= (((256 * c1) + 30) < (((256 * c0_0) + (-256 * c1)) + 255) ? (((256 * c1) + 30)) as long : ((((256 * c0_0) + (-256 * c1)) + 255)) as long)); c3++) {
                                    for (c4 = (256 * c2); (c4 <= (((256 * c2) + 255) < (n + -1) ? (((256 * c2) + 255)) as long : ((n + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c5 = ((256 * c1) > (c3 + 1) ? ((256 * c1)) as long : ((c3 + 1)) as long); (c5 <= (((256 * c1) + 255) < (n + -1) ? (((256 * c1) + 255)) as long : ((n + -1)) as long)); c5++) {
                                            A(c4,c5) = A(c4,c5) - A(c4,c3) * A(c3,c5);
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
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 1024;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 128;
    }
    @Ifdef("LARGE_DATASET") {
        N = 2000;
    }
    
    val lu = new Lu();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    lu.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);  
    /* Initialize array(s). */
    lu.init_array (n, A);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    lu.kernel_lu (n, A);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // lu.print_array(n, A);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
