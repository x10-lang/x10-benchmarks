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
public class Reg_detect {

  var _PB_NITER : Long;
  var _PB_LENGTH : Long;
  var _PB_MAXGRID : Long;  

  def setPBs(niter : Long, length : Long, maxgrid : Long) {
    _PB_NITER = niter; 
    _PB_LENGTH = length; 
    _PB_MAXGRID = maxgrid; 
  }
  def init_array(maxgrid : Long,
  		sum_tang : Array_2[Long],
  		mean : Array_2[Long],
  		path : Array_2[Long])
  {
    for (var i : Long = 0; i < maxgrid; i++)
      for (var j : Long = 0; j < maxgrid; j++) {
        sum_tang(i,j) = (((i+1) as Long) * (j+1));
        mean(i,j) = ((i as Long)-j) / maxgrid;
        path(i,j) = ((i as Long)*(j-1)) / maxgrid;
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(maxgrid : Long,
  		 path : Array_2[Long])
  {
    for (var i : Long = 0; i < maxgrid; i++)
      for (var j : Long = 0; j < maxgrid; j++) {
        Console.ERR.printf("%d ", path(i,j));
        if ((i * maxgrid + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  

  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_reg_detect(niter : long, maxgrid : long, length : long, sum_tang : Array_2[long], mean : Array_2[long], path : Array_2[long], diff : Array_3[long], sum_diff : Array_3[long])  {
        {
            var t : long;
            var j : long;
            var i : long;
            {
                var ___pace_tile_sizes : Rail[long] = new Rail[Long](3L);
                Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,3,1);
                var wPTile : long;
                var c2t1 : long;
                var c0t1 : long;
                var T1c2 : float = (___pace_tile_sizes(2L)) as float; 
                var c1t1 : long;
                var T1c0 : float = (___pace_tile_sizes(0L)) as float;
                var T1c1 : float = (___pace_tile_sizes(1L)) as float;
                var c4 : long;
                var c1 : long;
                var c0 : long;
                var c2 : long;
                if (((maxgrid >= 1) && (niter >= 1))) {
                    if (((length >= 2) && (maxgrid >= 2))) {
                        for (c0 = 0; (c0 <= (niter + -1)); c0++) { 
                            for (c4 = 0; (c4 <= (length + -1)); c4++) {
                                diff(0,0,c4) = sum_tang(0,0); 
                            }
                            sum_diff(0,0,0L) = diff(0,0,0L);
                            for (c4 = 1; (c4 <= (length + -1)); c4++) {
                                sum_diff(0,0,c4) = sum_diff(0,0,c4 - 1L) + diff(0,0,c4);
                            }
                            mean(0,0) = sum_diff(0,0,length - 1L);
                            path(0L,0) = mean(0L,0); 
                            for (c1 = (c0 + 1); (c1 <= ((c0 + maxgrid) + -1)); c1++) { 
                                for (c4 = 0; (c4 <= (length + -1)); c4++) {
                                    diff(0,((-1 * c0) + c1),c4) = sum_tang(0,((-1 * c0) + c1)); 
                                }
                                sum_diff(0,((-1 * c0) + c1),0L) = diff(0,((-1 * c0) + c1),0L);
                                for (c4 = 1; (c4 <= (length + -1)); c4++) { 
                                    sum_diff(0,((-1 * c0) + c1),c4) = sum_diff(0,((-1 * c0) + c1),c4 - 1L) + diff(0,((-1 * c0) + c1),c4);
                                }
                                mean(0,((-1 * c0) + c1)) = sum_diff(0,((-1 * c0) + c1),length - 1L); 
                                path(0L,((-1 * c0) + c1)) = mean(0L,((-1 * c0) + c1));
                                for (c2 = (c0 + 1); (c2 <= c1); c2++) {
                                    for (c4 = 0; (c4 <= (length + -1)); c4++) {
                                        diff(((-1 * c0) + c2),((-1 * c0) + c1),c4) = sum_tang(((-1 * c0) + c2),((-1 * c0) + c1));
                                    }
                                    sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),0L) = diff(((-1 * c0) + c2),((-1 * c0) + c1),0L);
                                    for (c4 = 1; (c4 <= (length + -1)); c4++) {
                                        sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),c4) = sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),c4 - 1L) + diff(((-1 * c0) + c2),((-1 * c0) + c1),c4);
                                    }
                                    mean(((-1 * c0) + c2),((-1 * c0) + c1)) = sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),length - 1L);
                                    path(((-1 * c0) + c2),((-1 * c0) + c1)) = path(((-1 * c0) + c2) - 1L,((-1 * c0) + c1) - 1L) + mean(((-1 * c0) + c2),((-1 * c0) + c1));
                                }
                            }
                        }
                    }
                    if (((length == 1) && (maxgrid >= 2))) {
                        for (wPTile = (Math.round(((((((-1 + (1 / T1c2)) + -1) + (1 / T1c1)) + (((T1c1 + T1c0) / T1c1) * -1)) + ((T1c1 + T1c0) / (T1c0 * T1c1)))) as double)) as long; (wPTile <= (Math.round(((((((((maxgrid * (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + (niter * ((((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)) / ((((T1c0 * T1c1) * T1c2) * T1c2) + (((T1c0 * T1c1) * T1c1) * T1c2))))) + ((((((((((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c1)) / (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c2) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + ((((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c2) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2))) * -1)) + ((((((((((((((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c0 * T1c0) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + ((((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2))) * -2)) + (((((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)) / ((((T1c0 * T1c1) * T1c2) * T1c2) + (((T1c0 * T1c1) * T1c1) * T1c2))) * -1))) as double)) as long); ++wPTile) {
                            {
                                var tmpLb : long;
                                var tmpUb : long;
                                tmpLb = ((Math.round((((((((wPTile * ((((T1c1 * T1c2) * T1c2) + ((T1c1 * T1c1) * T1c2)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((maxgrid * ((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1)))) * -1)) + (((((T1c1 * T1c1) * T1c2) + ((T1c1 * T1c1) * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1))) * -1)) + (((T1c1 * T1c2) + (T1c1 * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((((T1c0 * T1c2) + (T1c0 * T1c1)) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * -1)) + (((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((((wPTile * ((((T1c1 * T1c2) * T1c2) + ((T1c1 * T1c1) * T1c2)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((maxgrid * ((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1)))) * -1)) + (((((T1c1 * T1c1) * T1c2) + ((T1c1 * T1c1) * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1))) * -1)) + (((T1c1 * T1c2) + (T1c1 * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((((T1c0 * T1c2) + (T1c0 * T1c1)) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * -1)) + (((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                                tmpUb = ((Math.round(((((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((T1c1 / ((T1c1 * T1c2) + (T1c0 * T1c2))) * -1)) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long < (Math.round((((niter * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((T1c1 / ((T1c1 * T1c2) + (T1c0 * T1c2))) * -1)) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long) as long : ((Math.round((((niter * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                                {
                                    val T1c0_5 = T1c0;
                                    val T1c1_4 = T1c1;
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
                                        for (c1t1 = ((Math.round((((((wPTile_2 * (T1c2_3 / (T1c2_3 + T1c1_4))) + ((c0t1 * (T1c2_3 / (T1c2_3 + T1c1_4))) * -1)) + ((T1c1_4 / (T1c2_3 + T1c1_4)) * -1)) + (1 / (T1c2_3 + T1c1_4)))) as double)) as long > (Math.round(((((c0t1 * (T1c0_5 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long ? ((Math.round((((((wPTile_2 * (T1c2_3 / (T1c2_3 + T1c1_4))) + ((c0t1 * (T1c2_3 / (T1c2_3 + T1c1_4))) * -1)) + ((T1c1_4 / (T1c2_3 + T1c1_4)) * -1)) + (1 / (T1c2_3 + T1c1_4)))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_5 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long) as long); (c1t1 <= ((Math.round(((((wPTile_2 + (c0t1 * -1)) + 1) + ((1 / T1c2_3) * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_5 / T1c1_4)) + (maxgrid * (1 / T1c1_4))) + (T1c0_5 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long ? ((Math.round(((((wPTile_2 + (c0t1 * -1)) + 1) + ((1 / T1c2_3) * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_5 / T1c1_4)) + (maxgrid * (1 / T1c1_4))) + (T1c0_5 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long) as long)); ++c1t1) {
                                            for (c2t1 = ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long > (Math.round(((-1 + (1 / T1c2_3))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long < (Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long) as long)); ++c2t1) {
                                                for (c0 = ((c0t1 * T1c0_5) > 0 ? ((c0t1 * T1c0_5)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_5) + (T1c0_5 + -1)) < (niter + -1) ? (((c0t1 * T1c0_5) + (T1c0_5 + -1))) as long : ((niter + -1)) as long)); c0++) {
                                                    for (c1 = ((c1t1 * T1c1_4) > ((c0 + 1) - 1) ? ((c1t1 * T1c1_4)) as long : (((c0 + 1) - 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + 1) - 1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + 1) - 1)) as long)); c1++) {
                                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 0 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (0) as long)); c2++) {
                                                            diff(0,0,0) = sum_tang(0,0);
                                                            sum_diff(0,0,0L) = diff(0,0,0L);
                                                            mean(0,0) = sum_diff(0,0,length - 1L);
                                                            path(0L,0) = mean(0L,0);
                                                        }
                                                    }
                                                    for (c1 = ((c1t1 * T1c1_4) > (c0 + 1) ? ((c1t1 * T1c1_4)) as long : ((c0 + 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + maxgrid) + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + maxgrid) + -1)) as long)); c1++) {
                                                        for (c2 = ((c2t1 * T1c2_3) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_3)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                                            diff(0,((-1 * c0) + c1),0) = sum_tang(0,((-1 * c0) + c1));
                                                            sum_diff(0,((-1 * c0) + c1),0L) = diff(0,((-1 * c0) + c1),0L);
                                                            mean(0,((-1 * c0) + c1)) = sum_diff(0,((-1 * c0) + c1),length - 1L);
                                                            path(0L,((-1 * c0) + c1)) = mean(0L,((-1 * c0) + c1));
                                                        }
                                                        for (c2 = ((c2t1 * T1c2_3) > (c0 + 1) ? ((c2t1 * T1c2_3)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < c1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (c1) as long)); c2++) {
                                                            diff(((-1 * c0) + c2),((-1 * c0) + c1),0) = sum_tang(((-1 * c0) + c2),((-1 * c0) + c1));
                                                            sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),0L) = diff(((-1 * c0) + c2),((-1 * c0) + c1),0L);
                                                            mean(((-1 * c0) + c2),((-1 * c0) + c1)) = sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),length - 1L);
                                                            path(((-1 * c0) + c2),((-1 * c0) + c1)) = path(((-1 * c0) + c2) - 1L,((-1 * c0) + c1) - 1L) + mean(((-1 * c0) + c2),((-1 * c0) + c1));
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
                    if (((length == 1) && (maxgrid == 1))) {
                        for (c0 = 0; (c0 <= (niter + -1)); c0++) {
                            diff(0,0,0) = sum_tang(0,0);
                            sum_diff(0,0,0L) = diff(0,0,0L);
                            mean(0,0) = sum_diff(0,0,length - 1L);
                            path(0L,0) = mean(0L,0);
                        }
                    }
                    if (((length <= 0) && (maxgrid >= 2))) {
                        for (wPTile = (Math.round(((((((-1 + (1 / T1c2)) + -1) + (1 / T1c1)) + (((T1c1 + T1c0) / T1c1) * -1)) + ((T1c1 + T1c0) / (T1c0 * T1c1)))) as double)) as long; (wPTile <= (Math.round(((((((((maxgrid * (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + (niter * ((((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)) / ((((T1c0 * T1c1) * T1c2) * T1c2) + (((T1c0 * T1c1) * T1c1) * T1c2))))) + ((((((((((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c1)) / (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c2) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + ((((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c2) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2))) * -1)) + ((((((((((((((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c0 * T1c0) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c2)) + ((((T1c0 * T1c0) * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2)))) + ((((((((((((((((T1c1 * T1c2) * T1c2) * T1c2) + (((T1c0 * T1c2) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c2) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c1 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c2)) + (((T1c0 * T1c1) * T1c1) * T1c1)) / (((((((((T1c1 * T1c1) * T1c2) * T1c2) * T1c2) + ((((T1c1 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c2) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c2) * T1c2)) + ((((T1c0 * T1c1) * T1c1) * T1c1) * T1c2))) * -2)) + (((((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)) / ((((T1c0 * T1c1) * T1c2) * T1c2) + (((T1c0 * T1c1) * T1c1) * T1c2))) * -1))) as double)) as long); ++wPTile) {
                            {
                                var tmpLb : long;
                                var tmpUb : long;
                                tmpLb = ((Math.round((((((((wPTile * ((((T1c1 * T1c2) * T1c2) + ((T1c1 * T1c1) * T1c2)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((maxgrid * ((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1)))) * -1)) + (((((T1c1 * T1c1) * T1c2) + ((T1c1 * T1c1) * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1))) * -1)) + (((T1c1 * T1c2) + (T1c1 * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((((T1c0 * T1c2) + (T1c0 * T1c1)) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * -1)) + (((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((((wPTile * ((((T1c1 * T1c2) * T1c2) + ((T1c1 * T1c1) * T1c2)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((maxgrid * ((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1)))) * -1)) + (((((T1c1 * T1c1) * T1c2) + ((T1c1 * T1c1) * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1))) * -1)) + (((T1c1 * T1c2) + (T1c1 * T1c1)) / (((((((T1c1 * T1c2) * T1c2) + ((T1c0 * T1c2) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c1 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c2)) + ((T1c0 * T1c1) * T1c1)))) + ((((T1c0 * T1c2) + (T1c0 * T1c1)) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * -1)) + (((T1c2 + T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c2)) + (T1c0 * T1c1))) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                                tmpUb = ((Math.round(((((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((T1c1 / ((T1c1 * T1c2) + (T1c0 * T1c2))) * -1)) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long < (Math.round((((niter * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((T1c1 / ((T1c1 * T1c2) + (T1c0 * T1c2))) * -1)) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long) as long : ((Math.round((((niter * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                                {
                                    val T1c0_5 = T1c0;
                                    val T1c1_4 = T1c1;
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
                                        for (c1t1 = ((Math.round((((((wPTile_2 * (T1c2_3 / (T1c2_3 + T1c1_4))) + ((c0t1 * (T1c2_3 / (T1c2_3 + T1c1_4))) * -1)) + ((T1c1_4 / (T1c2_3 + T1c1_4)) * -1)) + (1 / (T1c2_3 + T1c1_4)))) as double)) as long > (Math.round(((((c0t1 * (T1c0_5 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long ? ((Math.round((((((wPTile_2 * (T1c2_3 / (T1c2_3 + T1c1_4))) + ((c0t1 * (T1c2_3 / (T1c2_3 + T1c1_4))) * -1)) + ((T1c1_4 / (T1c2_3 + T1c1_4)) * -1)) + (1 / (T1c2_3 + T1c1_4)))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_5 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long) as long); (c1t1 <= ((Math.round(((((wPTile_2 + (c0t1 * -1)) + 1) + ((1 / T1c2_3) * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_5 / T1c1_4)) + (maxgrid * (1 / T1c1_4))) + (T1c0_5 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long ? ((Math.round(((((wPTile_2 + (c0t1 * -1)) + 1) + ((1 / T1c2_3) * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_5 / T1c1_4)) + (maxgrid * (1 / T1c1_4))) + (T1c0_5 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long) as long)); ++c1t1) {
                                            for (c2t1 = ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long > (Math.round(((-1 + (1 / T1c2_3))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long < (Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((((c1t1 * (T1c1_4 / T1c2_3)) + (T1c1_4 / T1c2_3)) + ((1 / T1c2_3) * -1))) as double)) as long) as long)); ++c2t1) {
                                                for (c0 = ((c0t1 * T1c0_5) > 0 ? ((c0t1 * T1c0_5)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_5) + (T1c0_5 + -1)) < (niter + -1) ? (((c0t1 * T1c0_5) + (T1c0_5 + -1))) as long : ((niter + -1)) as long)); c0++) {
                                                    for (c1 = ((c1t1 * T1c1_4) > ((c0 + 1) - 1) ? ((c1t1 * T1c1_4)) as long : (((c0 + 1) - 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + 1) - 1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + 1) - 1)) as long)); c1++) {
                                                        for (c2 = ((c2t1 * T1c2_3) > 0 ? ((c2t1 * T1c2_3)) as long : (0) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < 0 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (0) as long)); c2++) {
                                                            sum_diff(0,0,0L) = diff(0,0,0L);
                                                            mean(0,0) = sum_diff(0,0,length - 1L);
                                                            path(0L,0) = mean(0L,0);
                                                        }
                                                    }
                                                    for (c1 = ((c1t1 * T1c1_4) > (c0 + 1) ? ((c1t1 * T1c1_4)) as long : ((c0 + 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + maxgrid) + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + maxgrid) + -1)) as long)); c1++) {
                                                        for (c2 = ((c2t1 * T1c2_3) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_3)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                                            sum_diff(0,((-1 * c0) + c1),0L) = diff(0,((-1 * c0) + c1),0L);
                                                            mean(0,((-1 * c0) + c1)) = sum_diff(0,((-1 * c0) + c1),length - 1L);
                                                            path(0L,((-1 * c0) + c1)) = mean(0L,((-1 * c0) + c1));
                                                        }
                                                        for (c2 = ((c2t1 * T1c2_3) > (c0 + 1) ? ((c2t1 * T1c2_3)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < c1 ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (c1) as long)); c2++) {
                                                            sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),0L) = diff(((-1 * c0) + c2),((-1 * c0) + c1),0L);
                                                            mean(((-1 * c0) + c2),((-1 * c0) + c1)) = sum_diff(((-1 * c0) + c2),((-1 * c0) + c1),length - 1L);
                                                            path(((-1 * c0) + c2),((-1 * c0) + c1)) = path(((-1 * c0) + c2) - 1L,((-1 * c0) + c1) - 1L) + mean(((-1 * c0) + c2),((-1 * c0) + c1));
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
                    if (((length <= 0) && (maxgrid == 1))) {
                        for (c0 = 0; (c0 <= (niter + -1)); c0++) {
                            sum_diff(0,0,0L) = diff(0,0,0L);
                            mean(0,0) = sum_diff(0,0,length - 1L);
                            path(0L,0) = mean(0L,0);
                        }
                    }
                }
            }
        }
    }  

  public static def main(args : Rail[String])
  {
    var NITER : Long = 0;
    var LENGTH : Long = 0;
    var MAXGRID : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        NITER = 10000;
        LENGTH = 500;
        MAXGRID = 12;
    }
    @Ifdef("STANDARD_DATASET") {
        NITER = 10000;
        LENGTH = 64;
        MAXGRID = 6;
    }
    @Ifdef("MINI_DATASET") {
        NITER = 10;
        LENGTH = 32;
        MAXGRID = 2;
    }
    @Ifdef("SMALL_DATASET") {
        NITER = 100;
        LENGTH = 50;
        MAXGRID = 6;
    }
    @Ifdef("LARGE_DATASET") {
        NITER = 10000;
        LENGTH = 100;
        MAXGRID = 1000;
    }
    
    val reg_detect = new Reg_detect();
    /* Retrieve problem size. */
    var niter  : Long= NITER;
    var maxgrid  : Long= MAXGRID;
    var length  : Long= LENGTH;
  
    reg_detect.setPBs(niter, length, maxgrid);
    /* Variable declaration/allocation. */
    val sum_tang = new Array_2[Long](maxgrid,maxgrid);

    val mean = new Array_2[Long](maxgrid,maxgrid);

    val path = new Array_2[Long](maxgrid,maxgrid);

    val diff = new Array_3[Long](maxgrid,maxgrid,length);

    val sum_diff = new Array_3[Long](maxgrid,maxgrid,length);    /* Initialize array(s). */
    reg_detect.init_array (maxgrid,
  	      sum_tang,
  	      mean,
  	      path);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    reg_detect.kernel_reg_detect (niter, maxgrid, length,
  		     sum_tang,
  		     mean,
  		     path,
  		     diff,
  		     sum_diff);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // reg_detect.print_array(maxgrid, path);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
