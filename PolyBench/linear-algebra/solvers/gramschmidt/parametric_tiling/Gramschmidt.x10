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
                    var ___pace_tile_sizes : Rail[long] = new Rail[Long](0L);
                    Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,0,2);
                    var c1 : long;
                    nrm = (0L) as double;
                    for (c1 = 0; (c1 <= (ni + -1)); c1++) {
                        nrm += A(c1,k) * A(c1,k);
                    }
                }
                R(k,k) = x10.lang.Math.sqrt(nrm);
                {
                    var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
                    Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,3);
                    var c4 : long;
                    var c1t1 : long;
                    var T1c4 : float = (___pace_tile_sizes(0L)) as float;
                    var T1c1 : float = (___pace_tile_sizes(1L)) as float;
                    var c4t1 : long;
                    var c1 : long;
                    for (c1 = 0; (c1 <= (k < (ni + -1) ? (k) as long : ((ni + -1)) as long)); c1++) {
                        Q(c1,k) = A(c1,k) / R(k,k);
                    }
                    for (c1 = (k + 1); (c1 <= (-1 < (nj + -1) ? (-1) as long : ((nj + -1)) as long)); c1++) {
                        R(k,c1) = (0L) as double;
                    }
                    for (c1 = (0 > (k + 1) ? (0) as long : ((k + 1)) as long); (c1 <= ((ni + -1) < (nj + -1) ? ((ni + -1)) as long : ((nj + -1)) as long)); c1++) {
                        Q(c1,k) = A(c1,k) / R(k,k);
                        R(k,c1) = (0L) as double;
                    }
                    for (c1 = ((0 > nj ? (0) as long : (nj) as long) > (k + 1) ? ((0 > nj ? (0) as long : (nj) as long)) as long : ((k + 1)) as long); (c1 <= (ni + -1)); c1++) {
                        Q(c1,k) = A(c1,k) / R(k,k);
                    }
                    for (c1 = ((0 > ni ? (0) as long : (ni) as long) > (k + 1) ? ((0 > ni ? (0) as long : (ni) as long)) as long : ((k + 1)) as long); (c1 <= (nj + -1)); c1++) {
                        R(k,c1) = (0L) as double;
                    }
                    if ((ni >= 1)) {
                        {
                            var tmpLb : long;
                            var tmpUb : long;
                            tmpLb = (Math.round(((((k * (1 / T1c1)) + -1) + ((1 / T1c1) * 2))) as double)) as long;
                            tmpUb = (Math.round((((nj * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                            {
                                val k_4 = k;
                                val T1c1_3 = T1c1;
                                val T1c4_2 = T1c4;
                                val tmpUb_1 = tmpUb;
                                val tmpLb_0 = tmpLb;
                                Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                                    var c4 : long;
                                    var c4t1 : long;
                                    var c1 : long;
                                    for (c4t1 = (Math.round(((-1 + (1 / T1c4_2))) as double)) as long; (c4t1 <= (Math.round((((ni * (1 / T1c4_2)) + ((1 / T1c4_2) * -1))) as double)) as long); ++c4t1) {
                                        for (c1 = ((c1t1 * T1c1_3) > (k_4 + 1) ? ((c1t1 * T1c1_3)) as long : ((k_4 + 1)) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (nj + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((nj + -1)) as long)); c1++) {
                                            for (c4 = ((c4t1 * T1c4_2) > 0 ? ((c4t1 * T1c4_2)) as long : (0) as long); (c4 <= (((c4t1 * T1c4_2) + (T1c4_2 + -1)) < (ni + -1) ? (((c4t1 * T1c4_2) + (T1c4_2 + -1))) as long : ((ni + -1)) as long)); c4++) {
                                                R(k_4,c1) += Q(c4,k_4) * A(c4,c1);
                                            }
                                        }
                                    }
                                    for (c4t1 = (Math.round(((-1 + (1 / T1c4_2))) as double)) as long; (c4t1 <= (Math.round((((ni * (1 / T1c4_2)) + ((1 / T1c4_2) * -1))) as double)) as long); ++c4t1) {
                                        for (c1 = ((c1t1 * T1c1_3) > (k_4 + 1) ? ((c1t1 * T1c1_3)) as long : ((k_4 + 1)) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (nj + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((nj + -1)) as long)); c1++) {
                                            for (c4 = ((c4t1 * T1c4_2) > 0 ? ((c4t1 * T1c4_2)) as long : (0) as long); (c4 <= (((c4t1 * T1c4_2) + (T1c4_2 + -1)) < (ni + -1) ? (((c4t1 * T1c4_2) + (T1c4_2 + -1))) as long : ((ni + -1)) as long)); c4++) {
                                                A(c4,c1) = A(c4,c1) - Q(c4,k_4) * R(k_4,c1);
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
