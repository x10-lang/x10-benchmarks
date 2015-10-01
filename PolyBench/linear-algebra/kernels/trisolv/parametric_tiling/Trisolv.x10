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
public class Trisolv {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		A : Array_2[Double],
  		x : Rail[Double],
  		c : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        c(i) = x(i) = ((i as Double)) / n;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = ((i as Double) *j) / n;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 x : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", x(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_trisolv(n : long, A : Array_2[double], x : Rail[double], c : Rail[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
        var c2t1 : long;
        var c1t1 : long;
        var T1c2 : float = (___pace_tile_sizes(1L)) as float;
        var T1c1 : float = (___pace_tile_sizes(0L)) as float;
        var c2 : long;
        var wPTile : long;
        var c1 : long;
        if ((n >= 1)) {
            for (c1 = 0; (c1 <= (n + -1)); c1++) {
                x(c1) = c(c1);
            }
            x(0) = x(0) / A(0,0);
            for (wPTile = (Math.round(((((-1 + (1 / T1c2)) + -1) + ((1 / T1c1) * 2))) as double)) as long; (wPTile <= (Math.round((((((n * ((T1c2 + T1c1) / (T1c1 * T1c2))) + (T1c1 / T1c2)) + ((1 / T1c2) * -1)) + (((T1c2 + T1c1) / (T1c1 * T1c2)) * -1))) as double)) as long); ++wPTile) {
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = ((Math.round(((((wPTile * (T1c2 / (T1c2 + T1c1))) + ((T1c1 / (T1c2 + T1c1)) * -1)) + (1 / (T1c2 + T1c1)))) as double)) as long > (Math.round(((-1 + ((1 / T1c1) * 2))) as double)) as long ? ((Math.round(((((wPTile * (T1c2 / (T1c2 + T1c1))) + ((T1c1 / (T1c2 + T1c1)) * -1)) + (1 / (T1c2 + T1c1)))) as double)) as long) as long : ((Math.round(((-1 + ((1 / T1c1) * 2))) as double)) as long) as long);
                    tmpUb = ((Math.round((((wPTile + 1) + ((1 / T1c2) * -1))) as double)) as long < (Math.round((((n * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long ? ((Math.round((((wPTile + 1) + ((1 / T1c2) * -1))) as double)) as long) as long : ((Math.round((((n * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long) as long);
                    {
                        val T1c1_4 = T1c1;
                        val T1c2_3 = T1c2;
                        val wPTile_2 = wPTile;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                            var c2t1 : long;
                            var c2 : long;
                            var c1 : long;
                            for (c2t1 = ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long > (Math.round(((-1 + (1 / T1c2_3))) as double)) as long ? ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long < (Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long ? ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long) as long)); ++c2t1) {
                                for (c1 = ((c1t1 * T1c1_4) > 1 ? ((c1t1 * T1c1_4)) as long : (1) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (n + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((n + -1)) as long)); c1++) {
                                    for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < (c1 + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : ((c1 + -1)) as long)); c2++) {
                                        x(c1) = x(c1) - A(c1,c2) * x(c2);
                                    }
                                    for (c2 = ((c2t1 * T1c2_3) > ((c1 + -1) + 1) ? ((c2t1 * T1c2_3)) as long : (((c1 + -1) + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c1 + -1) + 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c1 + -1) + 1)) as long)); c2++) {
                                        x(c1) = x(c1) / A(c1,c1);
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
        N = 8000;
    }
    
    val trisolv = new Trisolv();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    trisolv.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val x = new Rail[Double](n);

    val c = new Rail[Double](n);  
    /* Initialize array(s). */
    trisolv.init_array (n, A, x, c);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    trisolv.kernel_trisolv (n, A, x, c);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // trisolv.print_array(n, x);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
