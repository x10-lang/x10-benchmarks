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
public class Gramschmidt {

  var _PB_NI : Long;
  var _PB_NJ : Long;

  def setPBs(ni : Long, nj : Long) {
    _PB_NI = ni; 
    _PB_NJ = nj; 
  }
  def init_array(ni : Long, nj : Long,
  		A : Array_2[Double],
  		R : Array_2[Double],
  		Q : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
        A(i,j) = ((i as Double) *j) / ni;
        Q(i,j) = ((i as Double)*(j+1)) / nj;
      }
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nj; j++)
        R(i,j) = ((i as Double)*(j+2)) / nj;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(ni : Long, nj : Long,
  		 A : Array_2[Double],
  		 R : Array_2[Double],
  		 Q : Array_2[Double])
  {
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf ", A(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
    for (var i : Long = 0; i < nj; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf ", R(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
    for (var i : Long = 0; i < ni; i++)
      for (var j : Long = 0; j < nj; j++) {
  	Console.ERR.printf("%0.2lf ", Q(i,j));
  	if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_gramschmidt(ni : long, nj : long, A : Array_2[double], R : Array_2[double], Q : Array_2[double])  {
        {
            var nrm : double;
            for (var k : long = 0L; k < nj; k++) {
                {
                    var c2 : long;
                    nrm = (0L) as double;
                    for (c2 = 0; (c2 <= (ni + -1)); c2++) {
                        nrm += A(c2,k) * A(c2,k);
                    }
                }
                R(k,k) = x10.lang.Math.sqrt(nrm);
                {
                    var c1 : long;
                    var c8 : long;
                    var c4 : long;
                    var c5 : long;
                    if ((((k >= 0) && (ni >= (0 > (((-1 * nj) + 2) * 2 < 0 ?  -( -(((-1 * nj) + 2)) / 2) : (2 < 0 ? ( -(((-1 * nj) + 2)) +  -(2) - 1) /  -(2) : (((-1 * nj) + 2) + 2 - 1) / 2)) ? (0) as long : ((((-1 * nj) + 2) * 2 < 0 ?  -( -(((-1 * nj) + 2)) / 2) : (2 < 0 ? ( -(((-1 * nj) + 2)) +  -(2) - 1) /  -(2) : (((-1 * nj) + 2) + 2 - 1) / 2))) as long))) && (nj >= 0))) {
                        {
                            val k_0 = k;
                            Foreach.block(0,(((ni + nj) + -1) * 256 < 0 ? (256 < 0 ?  -(( -(((ni + nj) + -1)) + 256 + 1) / 256) :  -(( -(((ni + nj) + -1)) + 256 - 1) / 256)) : ((ni + nj) + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = (256 * c1); (c8 <= ((k_0 < ((256 * c1) + 255) ? (k_0) as long : (((256 * c1) + 255)) as long) < (ni + -1) ? ((k_0 < ((256 * c1) + 255) ? (k_0) as long : (((256 * c1) + 255)) as long)) as long : ((ni + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= ((((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long) < (nj + -1) ? ((((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)) as long : ((nj + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                    R(k_0,c8) = (0L) as double;
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = (((256 * c1) > nj ? ((256 * c1)) as long : (nj) as long) > (k_0 + 1) ? (((256 * c1) > nj ? ((256 * c1)) as long : (nj) as long)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = (((256 * c1) > ni ? ((256 * c1)) as long : (ni) as long) > (k_0 + 1) ? (((256 * c1) > ni ? ((256 * c1)) as long : (ni) as long)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
                            }
);
                        }
                    }
                    if (((k >= 0) && (nj <= -1))) {
                        {
                            val k_0 = k;
                            Foreach.block(0,((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = (256 * c1); (c8 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                }
                            }
);
                        }
                    }
                    if ((((k <= -1) && (ni >= 0)) && (nj >= 0))) {
                        {
                            val k_0 = k;
                            Foreach.block((((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)) > ((((256 * k_0) + (-255 * nj)) + 256) * 256 < 0 ?  -( -((((256 * k_0) + (-255 * nj)) + 256)) / 256) : (256 < 0 ? ( -((((256 * k_0) + (-255 * nj)) + 256)) +  -(256) - 1) /  -(256) : ((((256 * k_0) + (-255 * nj)) + 256) + 256 - 1) / 256)) ? (((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256))) as long : (((((256 * k_0) + (-255 * nj)) + 256) * 256 < 0 ?  -( -((((256 * k_0) + (-255 * nj)) + 256)) / 256) : (256 < 0 ? ( -((((256 * k_0) + (-255 * nj)) + 256)) +  -(256) - 1) /  -(256) : ((((256 * k_0) + (-255 * nj)) + 256) + 256 - 1) / 256))) as long),(((ni + nj) + -1) * 256 < 0 ? (256 < 0 ?  -(( -(((ni + nj) + -1)) + 256 + 1) / 256) :  -(( -(((ni + nj) + -1)) + 256 - 1) / 256)) : ((ni + nj) + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (-1 < ((256 * c1) + 255) ? (-1) as long : (((256 * c1) + 255)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = (0 > (256 * c1) ? (0) as long : ((256 * c1)) as long); (c8 <= ((((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long) < (nj + -1) ? ((((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)) as long : ((nj + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                    R(k_0,c8) = (0L) as double;
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > nj ? ((256 * c1)) as long : (nj) as long); (c8 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c8++) {
                                    Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > ni ? ((256 * c1)) as long : (ni) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
                            }
);
                        }
                    }
                    if ((((k <= -1) && (ni >= (0 > ((k + 3) * 2 < 0 ?  -( -((k + 3)) / 2) : (2 < 0 ? ( -((k + 3)) +  -(2) - 1) /  -(2) : ((k + 3) + 2 - 1) / 2)) ? (0) as long : (((k + 3) * 2 < 0 ?  -( -((k + 3)) / 2) : (2 < 0 ? ( -((k + 3)) +  -(2) - 1) /  -(2) : ((k + 3) + 2 - 1) / 2))) as long))) && (nj <= -1))) {
                        {
                            val k_0 = k;
                            Foreach.block((((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)) > (((33 * k_0) + 33) * 64 < 0 ?  -( -(((33 * k_0) + 33)) / 64) : (64 < 0 ? ( -(((33 * k_0) + 33)) +  -(64) - 1) /  -(64) : (((33 * k_0) + 33) + 64 - 1) / 64)) ? (((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256))) as long : ((((33 * k_0) + 33) * 64 < 0 ?  -( -(((33 * k_0) + 33)) / 64) : (64 < 0 ? ( -(((33 * k_0) + 33)) +  -(64) - 1) /  -(64) : (((33 * k_0) + 33) + 64 - 1) / 64))) as long),((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
                                if (((c1 <= ((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256)) && (k_0 <= (nj + -2)))) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                        R(k_0,c8) = (0L) as double;
                                    }
                                }
                                if ((c1 >= 0)) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                    for (c8 = (256 * c1); (c8 <= (((256 * c1) + 255) < (ni + -1) ? (((256 * c1) + 255)) as long : ((ni + -1)) as long)); c8++) {
                                        Q(c8,k_0) = A(c8,k_0) / R(k_0,k_0);
                                    }
                                }
                            }
);
                        }
                    }
                    if ((((k >= 0) && (k <= (nj + -2))) && (ni <= -1))) {
                        {
                            val k_0 = k;
                            Foreach.block(((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)),((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
                            }
);
                        }
                    }
                    if ((((k <= (-1 < (nj + -2) ? (-1) as long : ((nj + -2)) as long)) && (ni <= -1)) && (nj >= 0))) {
                        {
                            val k_0 = k;
                            Foreach.block(((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)),((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
                            }
);
                        }
                    }
                    if ((((k <= (nj + -2)) && (ni <= -1)) && (nj <= -1))) {
                        {
                            val k_0 = k;
                            Foreach.block(((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)),((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                    R(k_0,c8) = (0L) as double;
                                }
                            }
);
                        }
                    }
                    if (((k <= (nj + -2)) && (ni >= 1))) {
                        {
                            val k_0 = k;
                            Foreach.block(((k_0 + -30) * 256 < 0 ?  -( -((k_0 + -30)) / 256) : (256 < 0 ? ( -((k_0 + -30)) +  -(256) - 1) /  -(256) : ((k_0 + -30) + 256 - 1) / 256)),((nj + -1) * 256 < 0 ? (256 < 0 ?  -(( -((nj + -1)) + 256 + 1) / 256) :  -(( -((nj + -1)) + 256 - 1) / 256)) : (nj + -1) / 256),(var c1 : long) => {
                                var c8 : long;
                                var c4 : long;
                                var c5 : long;
                                for (c4 = 0; (c4 <= ((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256)); c4++) {
                                    for (c5 = (256 * c4); (c5 <= (((256 * c4) + 255) < (ni + -1) ? (((256 * c4) + 255)) as long : ((ni + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                            R(k_0,c8) += Q(c5,k_0) * A(c5,c8);
                                        }
                                    }
                                }
                                for (c4 = 0; (c4 <= ((ni + -1) * 256 < 0 ? (256 < 0 ?  -(( -((ni + -1)) + 256 + 1) / 256) :  -(( -((ni + -1)) + 256 - 1) / 256)) : (ni + -1) / 256)); c4++) {
                                    for (c5 = (256 * c4); (c5 <= (((256 * c4) + 255) < (ni + -1) ? (((256 * c4) + 255)) as long : ((ni + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c8 = ((256 * c1) > (k_0 + 1) ? ((256 * c1)) as long : ((k_0 + 1)) as long); (c8 <= (((256 * c1) + 255) < (nj + -1) ? (((256 * c1) + 255)) as long : ((nj + -1)) as long)); c8++) {
                                            A(c5,c8) = A(c5,c8) - Q(c5,k_0) * R(k_0,c8);
                                        }
                                    }
                                }
                            }
);
                        }
                    }
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
        NI = 512;
        NJ = 512;
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
    
    val gramschmidt = new Gramschmidt();
    /* Retrieve problem size. */
    var ni  : Long= NI;
    var nj  : Long= NJ;
  
    gramschmidt.setPBs(ni, nj);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](ni,nj);

    val R = new Array_2[Double](nj,nj);

    val Q = new Array_2[Double](ni,nj);    /* Initialize array(s). */
    gramschmidt.init_array (ni, nj,
  	      A,
  	      R,
  	      Q);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    gramschmidt.kernel_gramschmidt (ni, nj,
  		      A,
  		      R,
  		      Q);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // gramschmidt.print_array(ni, nj, A, R, Q);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
