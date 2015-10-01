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
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
        var c2t1 : long;
        var c0t1 : long;
        var T1c2 : float = (___pace_tile_sizes(1L)) as float;
        var T1c0 : float = (___pace_tile_sizes(0L)) as float;
        var wPTile : long;
        var c0 : long;
        var c2 : long;
        var c8 : long;
        if (((n >= 1) && (tsteps >= 1))) {
            if ((n >= 3)) {
                for (c0 = 0; (c0 <= (tsteps + -1)); c0++) {
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        for (c8 = 1; (c8 <= (n + -1)); c8++) {
                            B(c2,c8) = B(c2,c8) - A(c2,c8) * A(c2,c8) / B(c2,c8 - 1L);
                        }
                        for (c8 = 1; (c8 <= (n + -1)); c8++) {
                            X(c2,c8) = X(c2,c8) - X(c2,c8 - 1L) * A(c2,c8) / B(c2,c8 - 1L);
                        }
                        for (c8 = 0; (c8 <= (n + -3)); c8++) {
                            X(c2,n - c8 - 2L) = (X(c2,n - 2L - c8) - X(c2,n - 2L - c8 - 1L) * A(c2,n - c8 - 3L)) / B(c2,n - 3L - c8);
                        }
                    }
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        X(c2,n - 1L) = X(c2,n - 1L) / B(c2,n - 1L);
                    }
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        for (c8 = 1; (c8 <= (n + -1)); c8++) {
                            B(c8,c2) = B(c8,c2) - A(c8,c2) * A(c8,c2) / B(c8 - 1L,c2);
                        }
                        for (c8 = 1; (c8 <= (n + -1)); c8++) {
                            X(c8,c2) = X(c8,c2) - X(c8 - 1L,c2) * A(c8,c2) / B(c8 - 1L,c2);
                        }
                        for (c8 = 0; (c8 <= (n + -3)); c8++) {
                            X(n - 2L - c8,c2) = (X(n - 2L - c8,c2) - X(n - c8 - 3L,c2) * A(n - 3L - c8,c2)) / B(n - 2L - c8,c2);
                        }
                    }
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        X(n - 1L,c2) = X(n - 1L,c2) / B(n - 1L,c2);
                    }
                }
            }
            if ((n == 2)) {
                for (wPTile = (Math.round(((((-1 + (1 / T1c2)) + -1) + (1 / T1c0))) as double)) as long; (wPTile <= (Math.round(((((tsteps * (1 / T1c0)) + (1 / T1c2)) + ((1 / T1c0) * -1))) as double)) as long); ++wPTile) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = ((Math.round(((wPTile + ((1 / T1c2) * -1))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round(((wPTile + ((1 / T1c2) * -1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                        tmpUb = ((Math.round((((wPTile + 1) + ((1 / T1c2) * -1))) as double)) as long < (Math.round((((tsteps * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round((((wPTile + 1) + ((1 / T1c2) * -1))) as double)) as long) as long : ((Math.round((((tsteps * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                        {
                            val T1c0_4 = T1c0;
                            val T1c2_3 = T1c2;
                            val wPTile_2 = wPTile;
                            val tmpUb_1 = tmpUb;
                            val tmpLb_0 = tmpLb;
                            Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                                var c2t1 : long;
                                var c0 : long;
                                var c2 : long;
                                for (c2t1 = ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long > (Math.round(((-1 + (1 / T1c2_3))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long < (Math.round(((1 / T1c2_3)) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((1 / T1c2_3)) as double)) as long) as long)); ++c2t1) {
                                    for (c0 = ((c0t1 * T1c0_4) > 0 ? ((c0t1 * T1c0_4)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_4) + (T1c0_4 + -1)) < (tsteps + -1) ? (((c0t1 * T1c0_4) + (T1c0_4 + -1))) as long : ((tsteps + -1)) as long)); c0++) {
                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (1) as long)); c2++) {
                                            B(c2,1) = B(c2,1) - A(c2,1) * A(c2,1) / B(c2,1 - 1L);
                                            X(c2,1) = X(c2,1) - X(c2,1 - 1L) * A(c2,1) / B(c2,1 - 1L);
                                        }
                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (1) as long)); c2++) {
                                            X(c2,n - 1L) = X(c2,n - 1L) / B(c2,n - 1L);
                                        }
                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (1) as long)); c2++) {
                                            B(1,c2) = B(1,c2) - A(1,c2) * A(1,c2) / B(1 - 1L,c2);
                                            X(1,c2) = X(1,c2) - X(1 - 1L,c2) * A(1,c2) / B(1 - 1L,c2);
                                        }
                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (1) as long)); c2++) {
                                            X(n - 1L,c2) = X(n - 1L,c2) / B(n - 1L,c2);
                                        }
                                    }
                                }
                            }
);
                        }
                    }
                }
            }
            if ((n == 1)) {
                for (c0 = 0; (c0 <= (tsteps + -1)); c0++) {
                    X(0,n - 1L) = X(0,n - 1L) / B(0,n - 1L);
                    X(n - 1L,0) = X(n - 1L,0) / B(n - 1L,0);
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
