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
public class Dynprog {

  var _PB_LENGTH : Long;
  var _PB_TSTEPS : Long;  

  def setPBs(length : Long, tsteps : Long) {
    _PB_LENGTH = length; 
    _PB_TSTEPS = tsteps; 
  }
  def init_array(length : Long,
  		c : Array_2[Long],
  		W : Array_2[Long])
  {
    for (var i : Long = 0; i < length; i++)
      for (var j : Long = 0; j < length; j++) {
        c(i,j) = i *j % 2;
        W(i,j) = ((i as Long)-j) / length;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(out : Long)
  {
    Console.ERR.printf("%d ", out);
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_dynprog(tsteps : long, length : long, c : Array_2[long], W : Array_2[long], sum_c : Array_3[long], out : Rail[long])  {
        {
            var out_l : long = 0L;
            {
                var ___pace_tile_sizes : Rail[long] = new Rail[Long](2L);
                Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,2,2);
                var wPTile : long;
                var c4t1 : long;
                var c1t1 : long;
                var T1c1 : float = (___pace_tile_sizes(1L)) as float;
                var T1c4 : float = (___pace_tile_sizes(0L)) as float;
                var c3 : long;
                var c5 : long;
                var c1 : long;
                var c4 : long;
                if ((length >= 3)) {
                    for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                        for (c3 = 0; (c3 <= (length + -2)); c3++) {
                            for (c4 = 0; (c4 <= c3); c4++) {
                                c(c3,c4) = 0L;
                            }
                            for (c4 = (c3 + 1); (c4 <= (length + -1)); c4++) {
                                c(c3,c4) = 0L;
                                sum_c(c3,c4,c3) = 0L;
                            }
                        }
                        for (c4 = 0; (c4 <= (length + -1)); c4++) {
                            c((length + -1),c4) = 0L;
                        }
                        for (c3 = 0; (c3 <= (length + -3)); c3++) {
                            c(c3,(c3 + 1)) = sum_c(c3,(c3 + 1),(c3 + 1) - 1L) + W(c3,(c3 + 1));
                            for (c4 = (c3 + 2); (c4 <= (length + -1)); c4++) {
                                for (c5 = (c3 + 1); (c5 <= (c4 + -1)); c5++) {
                                    sum_c(c3,c4,c5) = sum_c(c3,c4,c5 - 1L) + c(c3,c5) + c(c5,c4);
                                }
                                c(c3,c4) = sum_c(c3,c4,c4 - 1L) + W(c3,c4);
                            }
                        }
                        c((length + -2),(length + -1)) = sum_c((length + -2),(length + -1),(length + -1) - 1L) + W((length + -2),(length + -1));
                        out_l += c(0L,length - 1L);
                    }
                }
                if ((length == 2)) {
                    for (wPTile = (Math.round((((-1 + -1) + (1 / T1c1))) as double)) as long; (wPTile <= (Math.round(((((tsteps * (1 / T1c1)) + ((1 / T1c4) * 2)) + ((1 / T1c1) * -1))) as double)) as long); ++wPTile) {
                        {
                            var tmpLb : long;
                            var tmpUb : long;
                            tmpLb = ((Math.round(((wPTile + ((1 / T1c4) * -2))) as double)) as long > (Math.round(((-1 + (1 / T1c1))) as double)) as long ? ((Math.round(((wPTile + ((1 / T1c4) * -2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c1))) as double)) as long) as long);
                            tmpUb = ((Math.round(((wPTile + 1)) as double)) as long < (Math.round((((tsteps * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long ? ((Math.round(((wPTile + 1)) as double)) as long) as long : ((Math.round((((tsteps * (1 / T1c1)) + ((1 / T1c1) * -1))) as double)) as long) as long);
                            {
                                val out_l_5 = new Rail[long](1);
                                out_l_5(0) = out_l;
                                val T1c1_4 = T1c1;
                                val T1c4_3 = T1c4;
                                val wPTile_2 = wPTile;
                                val tmpUb_1 = tmpUb;
                                val tmpLb_0 = tmpLb;
                                Foreach.block(tmpLb_0,tmpUb_1,(var c1t1 : long) => {
                                    var c4t1 : long;
                                    var c1 : long;
                                    var c4 : long;
                                    for (c4t1 = ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long > (Math.round((-1) as double)) as long ? ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long) as long : ((Math.round((-1) as double)) as long) as long); (c4t1 <= ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long < (Math.round((((1 / T1c4_3) * 2)) as double)) as long ? ((Math.round(((wPTile_2 + (c1t1 * -1))) as double)) as long) as long : ((Math.round((((1 / T1c4_3) * 2)) as double)) as long) as long)); ++c4t1) {
                                        for (c1 = ((c1t1 * T1c1_4) > 0 ? ((c1t1 * T1c1_4)) as long : (0) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < (tsteps + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : ((tsteps + -1)) as long)); c1++) {
                                            for (c4 = ((c4t1 * T1c4_3) > 0 ? ((c4t1 * T1c4_3)) as long : (0) as long); (c4 <= (((c4t1 * T1c4_3) + (T1c4_3 + -1)) < 1 ? (((c4t1 * T1c4_3) + (T1c4_3 + -1))) as long : (1) as long)); c4++) {
                                                c(0,c4) = 0L;
                                            }
                                            for (c4 = ((c4t1 * T1c4_3) > (0 - 1) ? ((c4t1 * T1c4_3)) as long : ((0 - 1)) as long); (c4 <= (((c4t1 * T1c4_3) + (T1c4_3 + -1)) < (0 - 1) ? (((c4t1 * T1c4_3) + (T1c4_3 + -1))) as long : ((0 - 1)) as long)); c4++) {
                                                sum_c(0,1,0) = 0L;
                                            }
                                            for (c4 = ((c4t1 * T1c4_3) > 0 ? ((c4t1 * T1c4_3)) as long : (0) as long); (c4 <= (((c4t1 * T1c4_3) + (T1c4_3 + -1)) < 1 ? (((c4t1 * T1c4_3) + (T1c4_3 + -1))) as long : (1) as long)); c4++) {
                                                c(1,c4) = 0L;
                                            }
                                            for (c4 = ((c4t1 * T1c4_3) > (1 + 1) ? ((c4t1 * T1c4_3)) as long : ((1 + 1)) as long); (c4 <= (((c4t1 * T1c4_3) + (T1c4_3 + -1)) < (1 + 1) ? (((c4t1 * T1c4_3) + (T1c4_3 + -1))) as long : ((1 + 1)) as long)); c4++) {
                                                c(0,1) = sum_c(0,1,1 - 1L) + W(0,1);
                                                out_l_5(0) += c(0L,length - 1L);
                                            }
                                        }
                                    }
                                }
);
out_l = out_l_5(0);
                            }
                        }
                    }
                }
                if ((length == 1)) {
                    for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                        c(0,0) = 0L;
                        out_l += c(0L,length - 1L);
                    }
                }
                if ((length <= 0)) {
                    for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                        out_l += c(0L,length - 1L);
                    }
                }
                out(0L) = out_l;
            }
        }
    }  public static def main(args : Rail[String])
  {
    var LENGTH : Long = 0;
    var TSTEPS : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        LENGTH = 500;
        TSTEPS = 10000;
    }
    @Ifdef("STANDARD_DATASET") {
        LENGTH = 50;
        TSTEPS = 10000;
    }
    @Ifdef("MINI_DATASET") {
        LENGTH = 32;
        TSTEPS = 10;
    }
    @Ifdef("SMALL_DATASET") {
        LENGTH = 50;
        TSTEPS = 100;
    }
    @Ifdef("LARGE_DATASET") {
        LENGTH = 500;
        TSTEPS = 1000;
    }
    
    val dynprog = new Dynprog();
    /* Retrieve problem size. */
    var length  : Long= LENGTH;
    var tsteps  : Long= TSTEPS;
  
    dynprog.setPBs(length, tsteps);
    /* Variable declaration/allocation. */
    val out = new Rail[Long](1);
    val sum_c = new Array_3[Long](length,length,length);

    val c = new Array_2[Long](length,length);

    val W = new Array_2[Long](length,length);    /* Initialize array(s). */
    dynprog.init_array (length, c, W);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    dynprog.kernel_dynprog (tsteps, length,
  		  c,
  		  W,
  		  sum_c,
  		  out);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // dynprog.print_array(out(0));
  
    /* Prevent dead-code elimination. All live-out(0) data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
