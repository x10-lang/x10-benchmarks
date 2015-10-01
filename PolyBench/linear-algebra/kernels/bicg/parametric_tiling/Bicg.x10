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
public class Bicg {

  var _PB_NX : Long;
  var _PB_NY : Long;  

  def setPBs(nx : Long, ny : Long) {
    _PB_NX = nx; 
    _PB_NY = ny; 
  }
  def init_array(nx : Long,
  ny : Long,
  		 A : Array_2[Double],
  		 r : Rail[Double],
  		 p : Rail[Double])
  {
    for (var i : Long = 0; i < ny; i++)
      p(i) = i * Math.PI;
    for (var i : Long = 0; i < nx; i++) {
      r(i) = i * Math.PI;
      for (var j : Long = 0; j < ny; j++)
        A(i,j) = ((i as Double)*(j+1))/nx;
    }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(nx : Long,
  ny : Long,
  		 s : Rail[Double],
  		 q : Rail[Double])
  
  {
    var i : Long;
  
    for (i = 0; i < ny; i++) {
      Console.ERR.printf("%0.2lf ", s(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
    for (i = 0; i < nx; i++) {
      Console.ERR.printf("%0.2lf ", q(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_bicg(nx : long, ny : long, A : Array_2[double], s : Rail[double], q : Rail[double], p : Rail[double], r : Rail[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
        var c2 : long;
        var T1c2 : float = (___pace_tile_sizes(0L)) as float;
        var T1c1 : float = (___pace_tile_sizes(1L)) as float;
        var c2t1 : long;
        var c1t1 : long;
        var c1 : long;
        for (c1 = 0; (c1 <= (nx + -1)); c1++) {
            q(c1) = (0L) as double;
        }
        if ((ny >= 1)) {
            {
                var tmpLb : long;
                var tmpUb : long;
                tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                tmpUb = (Math.round((((nx * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                {
                    val T1c1_3 = T1c1;
                    val T1c2_2 = T1c2;
                    val tmpUb_1 = tmpUb;
                    val tmpLb_0 = tmpLb;
                    Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                        var c2 : long;
                        var c2t1 : long;
                        var c1 : long;
                        for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((ny * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                            for (c1 = ((c1t1 * T1c1_3) > 0 ? ((c1t1 * T1c1_3)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (nx + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((nx + -1)) as long)); c1++) {
                                for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (ny + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((ny + -1)) as long)); c2++) {
                                    q(c1) = q(c1) + A(c1,c2) * p(c2);
                                }
                            }
                        }
                    }
);
                }
            }
        }
        for (c1 = 0; (c1 <= (ny + -1)); c1++) {
            s(c1) = (0L) as double;
        }
        if ((nx >= 1)) {
            {
                var tmpLb : long;
                var tmpUb : long;
                tmpLb = (Math.round(((-1 + (1 / T1c1))) as double)) as long;
                tmpUb = (Math.round((((ny * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long;
                {
                    val T1c1_3 = T1c1;
                    val T1c2_2 = T1c2;
                    val tmpUb_1 = tmpUb;
                    val tmpLb_0 = tmpLb;
                    Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                        var c2 : long;
                        var c2t1 : long;
                        var c1 : long;
                        for (c2t1 = (Math.round(((-1 + (1 / T1c2_2))) as double)) as long; (c2t1 <= (Math.round((((nx * (1 / T1c2_2)) + ((1 / T1c2_2) * -1))) as double)) as long); ++c2t1) {
                            for (c1 = ((c1t1 * T1c1_3) > 0 ? ((c1t1 * T1c1_3)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_3) + (T1c1_3 + -1)) < (ny + -1) ? (((c1t1 * T1c1_3) + (T1c1_3 + -1))) as long : ((ny + -1)) as long)); c1++) {
                                for (c2 = ((c2t1 * T1c2_2) > 0 ? ((c2t1 * T1c2_2)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_2) + (T1c2_2 + -1)) < (nx + -1) ? (((c2t1 * T1c2_2) + (T1c2_2 + -1))) as long : ((nx + -1)) as long)); c2++) {
                                    s(c1) = s(c1) + r(c2) * A(c2,c1);
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
    var NX : Long = 0;
    var NY : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NX = 100000;
        NY = 100000;
    }
    @Ifdef("STANDARD_DATASET") {
        NX = 4000;
        NY = 4000;
    }
    @Ifdef("MINI_DATASET") {
        NX = 32;
        NY = 32;
    }
    @Ifdef("SMALL_DATASET") {
        NX = 500;
        NY = 500;
    }
    @Ifdef("LARGE_DATASET") {
        /*NX = 8000;*/
        /*NY = 8000;*/
        NX = 40000;
        NY = 40000;
    }
    
    val bicg = new Bicg();
    /* Retrieve problem size. */
    var nx  : Long= NX;
    var ny  : Long= NY;
  
    bicg.setPBs(nx, ny);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](nx,ny);

    val s = new Rail[Double](ny);

    val q = new Rail[Double](nx);

    val p = new Rail[Double](ny);

    val r = new Rail[Double](nx);    /* Initialize array(s). */
    bicg.init_array (nx, ny,
  	      A,
  	      r,
  	      p);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    bicg.kernel_bicg (nx, ny,
  	       A,
  	       s,
  	       q,
  	       p,
  	       r);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // bicg.print_array(nx, ny, s, q);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
