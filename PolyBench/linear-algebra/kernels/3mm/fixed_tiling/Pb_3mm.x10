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
  	Console.ERR.printf("%0.2lf ", G(i,j));
  	if ((i * ni + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_3mm(ni : long, nj : long, nk : long, nl : long, nm : long, E : Array_2[double], A : Array_2[double], B : Array_2[double], F : Array_2[double], C : Array_2[double], D : Array_2[double], G : Array_2[double])  {
        var c1 : long;
        var c2 : long;
        var c10 : long;
        var c6 : long;
        var c7 : long;
        var c5 : long;
        if ((((ni >= 0) && (nj >= 0)) && (nl >= 1))) {
            {
                Foreach.block(0,(((nj + ni) + -1) * 256 < 0 ? (256 < 0 ?  -(( -(((nj + ni) + -1)) + 256 + 1) / 256) :  -(( -(((nj + ni) + -1)) + 256 - 1) / 256)) : ((nj + ni) + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nl + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nl + -1)) + 256 + 1) / 256) :  -(( -((nl + -1)) + 256 - 1) / 256)) : (nl + -1) / 256)); c2++) {
                        if ((c1 <= ((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256))) {
                            for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nl + -1) ? (((256 * c2) + 255)) as long : ((nl + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c10++) {
                                    G(c10,c7) = (0L) as double;
                                }
                            }
                        }
                        if ((c1 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256))) {
                            for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nl + -1) ? (((256 * c2) + 255)) as long : ((nl + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c10++) {
                                    F(c10,c7) = (0L) as double;
                                }
                            }
                        }
                    }
                }
);
            }
        }
        if (((ni <= -1) && (nl >= 1))) {
            {
                Foreach.block(0,((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nl + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nl + -1)) + 256 + 1) / 256) :  -(( -((nl + -1)) + 256 - 1) / 256)) : (nl + -1) / 256)); c2++) {
                        for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nl + -1) ? (((256 * c2) + 255)) as long : ((nl + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c10++) {
                                F(c10,c7) = (0L) as double;
                            }
                        }
                    }
                }
);
            }
        }
        if (((nj <= -1) && (nl >= 1))) {
            {
                Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nl + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nl + -1)) + 256 + 1) / 256) :  -(( -((nl + -1)) + 256 - 1) / 256)) : (nl + -1) / 256)); c2++) {
                        for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nl + -1) ? (((256 * c2) + 255)) as long : ((nl + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c10++) {
                                G(c10,c7) = (0L) as double;
                            }
                        }
                    }
                }
);
            }
        }
        if (((nl >= 1) && (nm >= 1))) {
            {
                Foreach.block(0,((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nl + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nl + -1)) + 256 + 1) / 256) :  -(( -((nl + -1)) + 256 - 1) / 256)) : (nl + -1) / 256)); c2++) {
                        for (c5 = 0; (c5 <= ((nm + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nm + -1)) + 256 + 1) / 256) :  -(( -((nm + -1)) + 256 - 1) / 256)) : (nm + -1) / 256)); c5++) {
                            for (c6 = (256 * c5); (c6 <= (((256 * c5) + 255) < (nm + -1) ? (((256 * c5) + 255)) as long : ((nm + -1)) as long)); c6++) {
                                for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nl + -1) ? (((256 * c2) + 255)) as long : ((nl + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c10++) {
                                        F(c10,c7) += C(c10,c6) * D(c6,c7);
                                    }
                                }
                            }
                        }
                    }
                }
);
            }
        }
        if ((nj >= 1)) {
            {
                Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256)); c2++) {
                        for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nj + -1) ? (((256 * c2) + 255)) as long : ((nj + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c10++) {
                                E(c10,c7) = (0L) as double;
                            }
                        }
                    }
                }
);
            }
        }
        if ((nj >= 1)) {
            {
                Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                    var c2 : long;
                    var c10 : long;
                    var c6 : long;
                    var c7 : long;
                    var c5 : long;
                    for (c2 = 0; (c2 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256)); c2++) {
                        for (c5 = 0; (c5 <= ((nk + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nk + -1)) + 256 + 1) / 256) :  -(( -((nk + -1)) + 256 - 1) / 256)) : (nk + -1) / 256)); c5++) {
                            for (c6 = (256 * c5); (c6 <= (((256 * c5) + 255) < (nk + -1) ? (((256 * c5) + 255)) as long : ((nk + -1)) as long)); c6++) {
                                for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nj + -1) ? (((256 * c2) + 255)) as long : ((nj + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c10++) {
                                        E(c10,c7) += A(c10,c6) * B(c6,c7);
                                    }
                                }
                            }
                        }
                        for (c5 = 0; (c5 <= ((nl + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nl + -1)) + 256 + 1) / 256) :  -(( -((nl + -1)) + 256 - 1) / 256)) : (nl + -1) / 256)); c5++) {
                            for (c6 = (256 * c5); (c6 <= (((256 * c5) + 255) < (nl + -1) ? (((256 * c5) + 255)) as long : ((nl + -1)) as long)); c6++) {
                                for (c7 = (256 * c2); (c7 <= (((256 * c2) + 255) < (nj + -1) ? (((256 * c2) + 255)) as long : ((nj + -1)) as long)); c7++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c10 = (256 * c1); (c10 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c10++) {
                                        G(c10,c6) += E(c10,c7) * F(c7,c6);
                                    }
                                }
                            }
                        }
                    }
                }
);
            }
        }
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
