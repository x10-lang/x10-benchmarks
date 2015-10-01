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
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](3L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,3,2);
        var wPTile : long;
        var c2t1 : long;
        var c1t1 : long;
        var c0t1 : long;
        var T1c2 : float = (___pace_tile_sizes(2L)) as float;
        var T1c0 : float = (___pace_tile_sizes(0L)) as float;
        var T1c1 : float = (___pace_tile_sizes(1L)) as float;
        var c1 : long;
        var c0 : long;
        var c2 : long;
        if ((n >= 2)) {
            for (wPTile = (Math.round(((((((-1 + (1 / T1c2)) + -1) + ((1 / T1c1) * 2)) + (((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / (T1c1 * T1c2)) * -1)) + ((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / ((T1c0 * T1c1) * T1c2)))) as double)) as long; (wPTile <= (Math.round((((((n * ((((T1c0 * T1c1) + (T1c0 * T1c2)) + (T1c1 * T1c2)) / ((T1c0 * T1c1) * T1c2))) + ((1 / T1c2) * -1)) + ((1 / T1c1) * -1)) + ((1 / T1c0) * -2))) as double)) as long); ++wPTile) {
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = ((Math.round(((((wPTile + ((n * ((T1c1 + T1c2) / (T1c1 * T1c2))) * -1)) + (1 / T1c2)) + (1 / T1c1))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round(((((wPTile + ((n * ((T1c1 + T1c2) / (T1c1 * T1c2))) * -1)) + (1 / T1c2)) + (1 / T1c1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                    tmpUb = ((Math.round(((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -2))) as double)) as long < (Math.round((((n * (1 / T1c0)) + ((1 / T1c0) * -2))) as double)) as long ? ((Math.round(((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -2))) as double)) as long) as long : ((Math.round((((n * (1 / T1c0)) + ((1 / T1c0) * -2))) as double)) as long) as long);
                    {
                        val T1c1_5 = T1c1;
                        val T1c0_4 = T1c0;
                        val T1c2_3 = T1c2;
                        val wPTile_2 = wPTile;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                            var c2t1 : long;
                            var c1t1 : long;
                            var c1 : long;
                            var c0 : long;
                            var c2 : long;
                            for (c1t1 = ((Math.round(((((wPTile_2 + (c0t1 * -1)) + ((n * (1 / T1c2_3)) * -1)) + (1 / T1c2_3))) as double)) as long > (Math.round(((((c0t1 * (T1c0_4 / T1c1_5)) + -1) + ((1 / T1c1_5) * 2))) as double)) as long ? ((Math.round(((((wPTile_2 + (c0t1 * -1)) + ((n * (1 / T1c2_3)) * -1)) + (1 / T1c2_3))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_4 / T1c1_5)) + -1) + ((1 / T1c1_5) * 2))) as double)) as long) as long); (c1t1 <= ((Math.round(((((wPTile_2 + (c0t1 * (((T1c2_3 * -1) + (T1c0_4 * -1)) / T1c2_3))) + 1) + ((1 / T1c2_3) * -1))) as double)) as long < (Math.round((((n * (1 / T1c1_5)) + ((1 / T1c1_5) * -1))) as double)) as long ? ((Math.round(((((wPTile_2 + (c0t1 * (((T1c2_3 * -1) + (T1c0_4 * -1)) / T1c2_3))) + 1) + ((1 / T1c2_3) * -1))) as double)) as long) as long : ((Math.round((((n * (1 / T1c1_5)) + ((1 / T1c1_5) * -1))) as double)) as long) as long)); ++c1t1) {
                                for (c2t1 = ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long > (Math.round(((((c0t1 * (T1c0_4 / T1c2_3)) + -1) + (1 / T1c2_3))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_4 / T1c2_3)) + -1) + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long < (Math.round((((n * (1 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round((((n * (1 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long) as long)); ++c2t1) {
                                    for (c0 = ((c0t1 * T1c0_4) > 0 ? ((c0t1 * T1c0_4)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_4) + (T1c0_4 + -1)) < (n + -2) ? (((c0t1 * T1c0_4) + (T1c0_4 + -1))) as long : ((n + -2)) as long)); c0++) {
                                        for (c1 = ((c1t1 * T1c1_5) > (c0 + 1) ? ((c1t1 * T1c1_5)) as long : ((c0 + 1)) as long); (c1 <= (((c1t1 * T1c1_5) + (T1c1_5 + -1)) < (n + -1) ? (((c1t1 * T1c1_5) + (T1c1_5 + -1))) as long : ((n + -1)) as long)); c1++) {
                                            for (c2 = ((c2t1 * T1c2_3) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_3)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                                A(c0,c1) = A(c0,c1) / A(c0,c0);
                                            }
                                            for (c2 = ((c2t1 * T1c2_3) > (c0 + 1) ? ((c2t1 * T1c2_3)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < (n + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : ((n + -1)) as long)); c2++) {
                                                A(c2,c1) = A(c2,c1) - A(c2,c0) * A(c0,c1);
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
