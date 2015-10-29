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
public class Jacobi_1d_imper {

  var _PB_TSTEPS : Long;
  var _PB_N : Long;

  def setPBs(tsteps : Long, n : Long) {
    _PB_TSTEPS = tsteps; 
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 A : Rail[Double],
  		 B : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++)
        {
  	A(i) = ((i as Double)+ 2) / n;
  	B(i) = ((i as Double)+ 3) / n;
        }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 A : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      {
        Console.ERR.printf("%0.2lf ", A(i));
        if (i % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_jacobi_1d_imper(tsteps : long, n : long, A : Rail[double], B : Rail[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
        var wPTile : long;
        var c1t1 : long;
        var c0t1 : long;
        var T1c1 : float = (___pace_tile_sizes(1L)) as float;
        var T1c0 : float = (___pace_tile_sizes(0L)) as float;
        var c1 : long;
        var c0 : long;
        if (((n >= 3) && (tsteps >= 1))) {
            for (wPTile = (Math.round(((((-1 + ((1 / T1c1) * 2)) + (((T1c1 + (T1c0 * 2)) / T1c1) * -1)) + ((T1c1 + (T1c0 * 2)) / (T1c0 * T1c1)))) as double)) as long; (wPTile <= (Math.round(((((((n * (1 / T1c1)) + (tsteps * ((T1c1 + (T1c0 * 2)) / (T1c0 * T1c1)))) + ((T1c0 / T1c1) * 2)) + ((1 / T1c1) * -3)) + (((T1c1 + (T1c0 * 2)) / (T1c0 * T1c1)) * -1))) as double)) as long); ++wPTile) {
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = ((Math.round((((((wPTile * (T1c1 / (T1c1 + (T1c0 * 2)))) + ((n * (1 / (T1c1 + (T1c0 * 2)))) * -1)) + ((T1c0 / (T1c1 + (T1c0 * 2))) * -2)) + ((1 / (T1c1 + (T1c0 * 2))) * 3))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((wPTile * (T1c1 / (T1c1 + (T1c0 * 2)))) + ((n * (1 / (T1c1 + (T1c0 * 2)))) * -1)) + ((T1c0 / (T1c1 + (T1c0 * 2))) * -2)) + ((1 / (T1c1 + (T1c0 * 2))) * 3))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                    tmpUb = ((Math.round(((((wPTile * (T1c1 / (T1c1 + (T1c0 * 2)))) + (T1c1 / (T1c1 + (T1c0 * 2)))) + ((1 / (T1c1 + (T1c0 * 2))) * -2))) as double)) as long < (Math.round((((tsteps * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((wPTile * (T1c1 / (T1c1 + (T1c0 * 2)))) + (T1c1 / (T1c1 + (T1c0 * 2)))) + ((1 / (T1c1 + (T1c0 * 2))) * -2))) as double)) as long) as long : ((Math.round((((tsteps * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                    {
                        val T1c1_4 = T1c1;
                        val T1c0_3 = T1c0;
                        val wPTile_2 = wPTile;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                            var c1t1 : long;
                            var c1 : long;
                            var c0 : long;
                            for (c1t1 = ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long > (Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) * 2) + -1) + ((1 / T1c1_4) * 2))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) * 2) + -1) + ((1 / T1c1_4) * 2))) as double)) as long) as long); (c1t1 <= ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long < (Math.round(((((((c0t1 * (T1c0_3 / T1c1_4)) * 2) + (n * (1 / T1c1_4))) + ((T1c0_3 / T1c1_4) * 2)) + ((1 / T1c1_4) * -3))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((((((c0t1 * (T1c0_3 / T1c1_4)) * 2) + (n * (1 / T1c1_4))) + ((T1c0_3 / T1c1_4) * 2)) + ((1 / T1c1_4) * -3))) as double)) as long) as long)); ++c1t1) {
                                for (c0 = ((c0t1 * T1c0_3) > 0 ? ((c0t1 * T1c0_3)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_3) + (T1c0_3 + -1)) < (tsteps + -1) ? (((c0t1 * T1c0_3) + (T1c0_3 + -1))) as long : ((tsteps + -1)) as long)); c0++) {
                                    for (c1 = ((c1t1 * T1c1_4) > (((2 * c0) + 2) - 1) ? ((c1t1 * T1c1_4)) as long : ((((2 * c0) + 2) - 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (((2 * c0) + 2) - 1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((((2 * c0) + 2) - 1)) as long)); c1++) {
                                        B(1) = 0.33333 * (A(1 - 1L) + A(1) + A(1 + 1L));
                                    }
                                    for (c1 = ((c1t1 * T1c1_4) > ((2 * c0) + 2) ? ((c1t1 * T1c1_4)) as long : (((2 * c0) + 2)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (((2 * c0) + n) + -2) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((((2 * c0) + n) + -2)) as long)); c1++) {
                                        B(((-2 * c0) + c1)) = 0.33333 * (A(((-2 * c0) + c1) - 1L) + A(((-2 * c0) + c1)) + A(((-2 * c0) + c1) + 1L));
                                        A((((-2 * c0) + c1) + -1)) = B((((-2 * c0) + c1) + -1));
                                    }
                                    for (c1 = ((c1t1 * T1c1_4) > ((((2 * c0) + n) + -2) + 1) ? ((c1t1 * T1c1_4)) as long : (((((2 * c0) + n) + -2) + 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((((2 * c0) + n) + -2) + 1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((((2 * c0) + n) + -2) + 1)) as long)); c1++) {
                                        A((n + -2)) = B((n + -2));
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
    var TSTEPS : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        TSTEPS = 1000;
        N = 1000000;
    }
    @Ifdef("STANDARD_DATASET") {
        TSTEPS = 100;
        N = 10000;
    }
    @Ifdef("MINI_DATASET") {
        TSTEPS = 2;
        N = 500;
    }
    @Ifdef("SMALL_DATASET") {
        TSTEPS = 10;
        N = 1000;
    }
    @Ifdef("LARGE_DATASET") {
        TSTEPS = 10000;
        N = 100000;
    }
    
    val jacobi_1d_imper = new Jacobi_1d_imper();
    /* Retrieve problem size. */
    var n  : Long= N;
    var tsteps  : Long= TSTEPS;
  
    jacobi_1d_imper.setPBs(tsteps, n);
    /* Variable declaration/allocation. */
    val A = new Rail[Double](n);

    val B = new Rail[Double](n);  
    /* Initialize array(s). */
    jacobi_1d_imper.init_array (n, A, B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    jacobi_1d_imper.kernel_jacobi_1d_imper (tsteps, n, A, B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // jacobi_1d_imper.print_array(n, A);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
