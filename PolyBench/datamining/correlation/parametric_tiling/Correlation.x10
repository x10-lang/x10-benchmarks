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
public class Correlation {

  var _PB_M : Long;
  var _PB_N : Long;  

  def setPBs(m : Long, n : Long) {
    _PB_M = m; 
    _PB_N = n; 
  }
  def init_array(m : Long,
  		 n : Long,
  		 float_n : Rail[Double],
  		 data : Array_2[Double])
  {
    float_n(0) = 1.2;
  
    for (var i : Long = 0; i < m; i++)
      for (var j : Long = 0; j < n; j++)
        data(i,j) = ((i as Double) *j) / m;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(m : Long,
  		 symmat : Array_2[Double])
  
  {
    var i : Long;
var  j : Long;
  
    for (i = 0; i < m; i++)
      for (j = 0; j < m; j++) {
        Console.ERR.printf("%0.2lf ", symmat(i,j));
        if ((i * m + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }

  def sqrt_of_array_cell(x : Rail[Double], j : Long)
  {
    return Math.sqrt(x(j));
  }
  
  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_correlation(m : long, n : long, float_n : double, data : Array_2[double], symmat : Array_2[double], mean : Rail[double], stddev : Rail[double])  {
        {
            var eps : double = (0.10000000149011612) as double;
            {
                var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
                Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,3);
                var T1c2 : float = (___pace_tile_sizes(0L)) as float;
                var T1c1 : float = (___pace_tile_sizes(1L)) as float;
                var c2t1 : long;
                var c1t1 : long;
                var c1 : long;
                var c2 : long;
                if ((m >= 1)) {
                    for (c1 = 0; (c1 <= (m + -1)); c1++) {
                        mean(c1) = 0.0;
                    }
                    if ((n >= 1)) {
                        {
                            var tmpLb : long;
                            var tmpUb : long;
                            tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                            tmpUb = (Math.round((((m * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                            {
                                val T1c1_3 = T1c1;
                                val T1c2_2 = T1c2;
                                val tmpUb_1 = tmpUb;
                                val tmpLb_0 = tmpLb;
                                Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                                    var c2t1 : long;
                                    var c1 : long;
                                    var c2 : long;
                                    for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((n * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                                        for (c1 = ((c1t1 * T1c1_3) > 0 ? ((c1t1 * T1c1_3)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (m + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((m + -1)) as long)); c1++) {
                                            for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (n + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((n + -1)) as long)); c2++) {
                                                mean(c1) += data(c2,c1);
                                            }
                                        }
                                    }
                                }
);
                            }
                        }
                    }
                    for (c1 = 0; (c1 <= (m + -1)); c1++) {
                        mean(c1) /= float_n;
                    }
                }
            }
            for (var j : long = 0L; j < m; j++) {
                {
                    var ___pace_tile_sizes : Rail[long] = new Rail[Long](0L);
                    Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,0,2);
                    var c3 : long;
                    stddev(j) = 0.0;
                    for (c3 = 0; (c3 <= (n + -1)); c3++) {
                        stddev(j) += (data(c3,j) - mean(j)) * (data(c3,j) - mean(j));
                    }
                    stddev(j) /= float_n;
                }
                stddev(j) = Correlation.this.sqrt_of_array_cell(stddev,j);
                {
                    stddev(j) = (stddev(j) <= eps ? 1.0 : stddev(j));
                }
            }
            for (var i : long = 0L; i < n; i++) {
                for (var j : long = 0L; j < m; j++) {
                    data(i,j) -= mean(j);
                    data(i,j) /= x10.lang.Math.sqrt(float_n) * stddev(j);
                }
            }
            {
                var ___pace_tile_sizes : Rail[long] = new Rail[Long](3L);
                Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,3,4);
                var c3 : long;
                var T1c2 : float = (___pace_tile_sizes(1L)) as float;
                var c2t1 : long;
                var c1t1 : long;
                var T1c3 : float = (___pace_tile_sizes(0L)) as float;
                var c3t1 : long;
                var c2 : long;
                var c1 : long;
                var T1c1 : float = (___pace_tile_sizes(2L)) as float;
                symmat(m - 1L,m - 1L) = 1.0;
                {
                    var tmpLb : long;
                    var tmpUb : long;
                    tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                    tmpUb = (Math.round((((m * (1 / T1c1)) + ((1 / T1c1) * -2))) as double)) as long;
                    {
                        val T1c2_3 = T1c2;
                        val T1c1_2 = T1c1;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                            var c2t1 : long;
                            var c2 : long;
                            var c1 : long;
                            for (c2t1 = (Math.round(((((c1t1 * (T1c1_2 / T1c2_3)) + -1) + ((1 / T1c2_3) * 2))) as double)) as long; (c2t1 <= (Math.round((((m * (1 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long); ++c2t1) {
                                for (c1 = ((c1t1 * T1c1_2) > 0 ? ((c1t1 * T1c1_2)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_2) + (T1c1_2 + -1)) < (m + -2) ? (((c1t1 * T1c1_2) + (T1c1_2 + -1))) as long : ((m + -2)) as long)); c1++) {
                                    for (c2 = ((c2t1 * T1c2_3) > (c1 + 1) ? ((c2t1 * T1c2_3)) as long : ((c1 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < (m + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : ((m + -1)) as long)); c2++) {
                                        symmat(c1,c2) = 0.0;
                                    }
                                }
                            }
                        }
);
                    }
                }
                if ((n >= 1)) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                        tmpUb = (Math.round((((m * (1 / T1c1)) + ((1 / T1c1) * -2))) as double)) as long;
                        {
                            val T1c3_4 = T1c3;
                            val T1c2_3 = T1c2;
                            val T1c1_2 = T1c1;
                            val tmpUb_1 = tmpUb;
                            val tmpLb_0 = tmpLb;
                            Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                                var c3 : long;
                                var c2t1 : long;
                                var c3t1 : long;
                                var c2 : long;
                                var c1 : long;
                                for (c2t1 = (Math.round(((((c1t1 * (T1c1_2 / T1c2_3)) + -1) + ((1 / T1c2_3) * 2))) as double)) as long; (c2t1 <= (Math.round((((m * (1 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long); ++c2t1) {
                                    for (c3t1 = (Math.round(((-1 + (1 / T1c3_4))) as double)) as long; (c3t1 <= (Math.round((((n * (1 / T1c3_4)) + ((1 / T1c3_4) * -1))) as double)) as long); ++c3t1) {
                                        for (c1 = ((c1t1 * T1c1_2) > 0 ? ((c1t1 * T1c1_2)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_2) + (T1c1_2 + -1)) < (m + -2) ? (((c1t1 * T1c1_2) + (T1c1_2 + -1))) as long : ((m + -2)) as long)); c1++) {
                                            for (c2 = ((c2t1 * T1c2_3) > (c1 + 1) ? ((c2t1 * T1c2_3)) as long : ((c1 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < (m + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : ((m + -1)) as long)); c2++) {
                                                for (c3 = ((c3t1 * T1c3_4) > 0 ? ((c3t1 * T1c3_4)) as long : (0) as long); (c3 <= (((c3t1 * T1c3_4) + (T1c3_4 + -1)) < (n + -1) ? (((c3t1 * T1c3_4) + (T1c3_4 + -1))) as long : ((n + -1)) as long)); c3++) {
                                                    symmat(c1,c2) += (data(c3,c1) * data(c3,c2));
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
                    tmpUb = (Math.round((((m * (1 / T1c1)) + ((1 / T1c1) * -2))) as double)) as long;
                    {
                        val T1c2_3 = T1c2;
                        val T1c1_2 = T1c1;
                        val tmpUb_1 = tmpUb;
                        val tmpLb_0 = tmpLb;
                        Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                            var c3 : long;
                            var c2t1 : long;
                            var c3t1 : long;
                            var c2 : long;
                            var c1 : long;
                            for (c2t1 = (Math.round(((((c1t1 * (T1c1_2 / T1c2_3)) + -1) + ((1 / T1c2_3) * 2))) as double)) as long; (c2t1 <= (Math.round((((m * (1 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long); ++c2t1) {
                                for (c1 = ((c1t1 * T1c1_2) > 0 ? ((c1t1 * T1c1_2)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_2) + (T1c1_2 + -1)) < (m + -2) ? (((c1t1 * T1c1_2) + (T1c1_2 + -1))) as long : ((m + -2)) as long)); c1++) {
                                    for (c2 = ((c2t1 * T1c2_3) > (c1 + 1) ? ((c2t1 * T1c2_3)) as long : ((c1 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < (m + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : ((m + -1)) as long)); c2++) {
                                        symmat(c2,c1) = symmat(c1,c2);
                                    }
                                }
                            }
                        }
);
                    }
                }
                for (c1 = 0; (c1 <= (m + -2)); c1++) {
                    symmat(c1,c1) = 1.0;
                }
            }
        }
    }  public static def main(args : Rail[String])
  {
    var M : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        M = 4000;
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        M = 1000;
        N = 1000;
    }
    @Ifdef("MINI_DATASET") {
        M = 32;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        M = 500;
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        M = 2000;
        N = 2000;
    }
    
    val correlation = new Correlation();
    /* Retrieve problem size. */
    var n  : Long= N;
    var m  : Long= M;
  
    correlation.setPBs(m, n);
    /* Variable declaration/allocation. */
    val float_n = new Rail[Double](1);
    val data = new Array_2[Double](m,n);

    val symmat = new Array_2[Double](m,m);

    val mean = new Rail[Double](m);

    val stddev = new Rail[Double](m);    /* Initialize array(s). */
    correlation.init_array (m, n, float_n, data);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    correlation.kernel_correlation (m, n, float_n(0),
  		      data,
  		      symmat,
  		      mean,
  		      stddev);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // correlation.print_array(m, symmat);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
