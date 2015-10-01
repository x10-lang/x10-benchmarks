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
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](4L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,4,2);
        var c1t1 : long;
        var T1c4 : float = (___pace_tile_sizes(0L)) as float;
        var c2t1 : long;
        var c3t1 : long;
        var T1c1 : float = (___pace_tile_sizes(3L)) as float;
        var c4 : long;
        var c3 : long;
        var c2 : long;
        var c4t1 : long;
        var T1c2 : float = (___pace_tile_sizes(2L)) as float;
        var T1c3 : float = (___pace_tile_sizes(1L)) as float;
        var c1 : long;
        if (((nq >= 1) && (nr >= 1))) {
            if ((np >= 1)) {
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                    tmpUb = (Math.round((((nr * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                    {
                        val T1c1_4 = T1c1;
                        val T1c3_3 = T1c3;
                        val T1c2_2 = T1c2;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                            var c2t1 : long;
                            var c3t1 : long;
                            var c3 : long;
                            var c2 : long;
                            var c1 : long;
                            for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((nq * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                                for (c3t1 = (Math.round(((-1 + (1 / T1c3_3))) as double)) as long; (c3t1 <= (Math.round((((np * (1 / T1c3_3)) + ((1 / T1c3_3) * -1))) as double)) as long); ++c3t1) {
                                    for (c1 = ((c1t1 * T1c1_4) > 0 ? ((c1t1 * T1c1_4)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (nr + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((nr + -1)) as long)); c1++) {
                                        for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (nq + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((nq + -1)) as long)); c2++) {
                                            for (c3 = ((c3t1 * T1c3_3) > 0 ? ((c3t1 * T1c3_3)) as long : (0) as long); (c3 <= (((c3t1 * T1c3_3) + (T1c3_3 + -1)) < (np + -1) ? (((c3t1 * T1c3_3) + (T1c3_3 + -1))) as long : ((np + -1)) as long)); c3++) {
                                                sum(c1,c2,c3) = (0L) as double;
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
            if ((np >= 1)) {
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                    tmpUb = (Math.round((((nr * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                    {
                        val T1c1_5 = T1c1;
                        val T1c4_4 = T1c4;
                        val T1c3_3 = T1c3;
                        val T1c2_2 = T1c2;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                            var c2t1 : long;
                            var c3t1 : long;
                            var c4 : long;
                            var c3 : long;
                            var c2 : long;
                            var c4t1 : long;
                            var c1 : long;
                            for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((nq * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                                for (c3t1 = (Math.round(((-1 + (1 / T1c3_3))) as double)) as long; (c3t1 <= (Math.round((((np * (1 / T1c3_3)) + ((1 / T1c3_3) * -1))) as double)) as long); ++c3t1) {
                                    for (c4t1 = (Math.round(((-1 + (1 / T1c4_4))) as double)) as long; (c4t1 <= (Math.round((((np * (1 / T1c4_4)) + ((1 / T1c4_4) * -1))) as double)) as long); ++c4t1) {
                                        for (c1 = ((c1t1 * T1c1_5) > 0 ? ((c1t1 * T1c1_5)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_5) + (T1c1_5 + -1)) < (nr + -1) ? (((c1t1 * T1c1_5) + (T1c1_5 + -1))) as long : ((nr + -1)) as long)); c1++) {
                                            for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (nq + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((nq + -1)) as long)); c2++) {
                                                for (c3 = ((c3t1 * T1c3_3) > 0 ? ((c3t1 * T1c3_3)) as long : (0) as long); (c3 <= (((c3t1 * T1c3_3) + (T1c3_3 + -1)) < (np + -1) ? (((c3t1 * T1c3_3) + (T1c3_3 + -1))) as long : ((np + -1)) as long)); c3++) {
                                                    for (c4 = ((c4t1 * T1c4_4) > 0 ? ((c4t1 * T1c4_4)) as long : (0) as long); (c4 <= (((c4t1 * T1c4_4) + (T1c4_4 + -1)) < (np + -1) ? (((c4t1 * T1c4_4) + (T1c4_4 + -1))) as long : ((np + -1)) as long)); c4++) {
                                                        sum(c1,c2,c3) = sum(c1,c2,c3) + A(c1,c2,c4) * C4(c4,c3);
                                                    }
                                                }
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
            {
                var tmpLb : long;
                var tmpUb : long;
                tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                tmpUb = (Math.round((((nr * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                {
                    val T1c1_4 = T1c1;
                    val T1c3_3 = T1c3;
                    val T1c2_2 = T1c2;
                    val tmpUb_1 = tmpUb;
                    val tmpLb_0 = tmpLb;
                    Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                        var c2t1 : long;
                        var c3t1 : long;
                        var c4 : long;
                        var c3 : long;
                        var c2 : long;
                        var c4t1 : long;
                        var c1 : long;
                        for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((nq * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                            for (c3t1 = (Math.round(((-1 + (1 / T1c3_3))) as double)) as long; (c3t1 <= (Math.round((((nr * (1 / T1c3_3)) + ((1 / T1c3_3) * -1))) as double)) as long); ++c3t1) {
                                for (c1 = ((c1t1 * T1c1_4) > 0 ? ((c1t1 * T1c1_4)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (nr + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((nr + -1)) as long)); c1++) {
                                    for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (nq + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((nq + -1)) as long)); c2++) {
                                        for (c3 = ((c3t1 * T1c3_3) > 0 ? ((c3t1 * T1c3_3)) as long : (0) as long); (c3 <= (((c3t1 * T1c3_3) + (T1c3_3 + -1)) < (nr + -1) ? (((c3t1 * T1c3_3) + (T1c3_3 + -1))) as long : ((nr + -1)) as long)); c3++) {
                                            A(c1,c2,c3) = sum(c1,c2,c3);
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
