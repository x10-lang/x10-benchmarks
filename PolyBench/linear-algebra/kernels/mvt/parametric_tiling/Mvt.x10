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
public class Mvt {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		x1 : Rail[Double],
  		x2 : Rail[Double],
  		y_1 : Rail[Double],
  		y_2 : Rail[Double],
  		A : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        x1(i) = ((i as Double)) / n;
        x2(i) = ((i as Double) + 1) / n;
        y_1(i) = ((i as Double) + 3) / n;
        y_2(i) = ((i as Double) + 4) / n;
        for (var j : Long = 0; j < n; j++)
  	A(i,j) = ((i as Double) *j) / n;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 x1 : Rail[Double],
  		 x2 : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", x1(i));
      Console.ERR.printf("%0.2lf ", x2(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_mvt(n : long, x1 : Rail[double], x2 : Rail[double], y_1 : Rail[double], y_2 : Rail[double], A : Array_2[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
        var T1c2 : float = (___pace_tile_sizes(0L)) as float;
        var c1t1 : long;
        var T1c1 : float = (___pace_tile_sizes(1L)) as float;
        var c2t1 : long;
        var c1 : long;
        var c2 : long;
        if ((n >= 1)) {
            {
                var tmpLb : long;
                var tmpUb : long;
                tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                tmpUb = (Math.round((((n * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
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
                            for (c1 = ((c1t1 * T1c1_3) > 0 ? ((c1t1 * T1c1_3)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (n + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((n + -1)) as long)); c1++) {
                                for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (n + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((n + -1)) as long)); c2++) {
                                    x1(c1) = x1(c1) + A(c1,c2) * y_1(c2);
                                    x2(c1) = x2(c1) + A(c2,c1) * y_2(c2);
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
        /*N = 8000;*/
        N = 28000;
    }
    
    val mvt = new Mvt();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    mvt.setPBs(n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val x1 = new Rail[Double](n);

    val x2 = new Rail[Double](n);

    val y_1 = new Rail[Double](n);

    val y_2 = new Rail[Double](n);  
    /* Initialize array(s). */
    mvt.init_array (n,
  	      x1,
  	      x2,
  	      y_1,
  	      y_2,
  	      A);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    mvt.kernel_mvt (n,
  	      x1,
  	      x2,
  	      y_1,
  	      y_2,
  	      A);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // mvt.print_array(n, x1, x2);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
