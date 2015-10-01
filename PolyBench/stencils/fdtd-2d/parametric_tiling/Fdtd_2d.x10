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
public class Fdtd_2d {

    var _PB_NX : Long;
    var _PB_NY : Long;
    var _PB_TMAX : Long;    def init_array (tmax : Long, nx : Long, ny : Long,
                    ex : Array_2[Double],
                    ey : Array_2[Double],
                    hz : Array_2[Double],
                    _fict_ : Rail[Double]) {
        for (var i : Long = 0; i < tmax; i++)
            _fict_(i) = i as Double;
        for (var i : Long = 0; i < nx; i++)
            for (var j : Long = 0; j < ny; j++) {
                ex(i,j) = ((i as Double)*(j+1)) / nx;
                ey(i,j) = ((i as Double)*(j+2)) / ny;
                hz(i,j) = ((i as Double)*(j+3)) / nx;
            }
    }    /* DCE code. Must scan the entire live-out data.
      Can be used also to check the correctness of the output. */
    def print_array(nx : Long, ny : Long,
                   ex : Array_2[Double],
                   ey : Array_2[Double],
                   hz : Array_2[Double]) {
        for (var i : Long = 0; i < nx; i++)
            for (var j : Long = 0; j < ny; j++) {
                Console.ERR.printf("%0.2lf ", ex(i,j));
                Console.ERR.printf("%0.2lf ", ey(i,j));
                Console.ERR.printf("%0.2lf ", hz(i,j));
                if ((i * nx + j) % 20 == 0) Console.ERR.printf ("\n");
            }
        Console.ERR.printf ("\n");
    }

    /* Main computational kernel. The whole function will be timed,
       including the call and return. */
    def kernel_fdtd_2d(tmax : long, nx : long, ny : long, ex : Array_2[double], ey : Array_2[double], hz : Array_2[double], _fict_ : Rail[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](3L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,3,2);
        var wPTile : long;
        var c2t1 : long;
        var c1t1 : long;
        var c0t1 : long;
        var T1c2 : float = (___pace_tile_sizes(2L)) as float;
        var T1c0 : float = (___pace_tile_sizes(0L)) as float;
        var T1c1 : float = (___pace_tile_sizes(1L)) as float;
        var c2 : long;
        var c0 : long;
        var c1 : long;
        if (((ny >= 1) && (tmax >= 1))) {
            if (((nx >= 2) && (ny >= 2))) {
                for (wPTile = (Math.round(((((((-1 + (1 / T1c2)) + -1) + (1 / T1c1)) + (((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / (T1c1 * T1c2)) * -1)) + ((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / ((T1c0 * T1c1) * T1c2)))) as double)) as long; (wPTile <= (Math.round((((((((((ny * (1 / T1c1)) + (tmax * ((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / ((T1c0 * T1c1) * T1c2)))) + (nx * (1 / T1c2))) + (T1c0 / T1c2)) + ((1 / T1c2) * -2)) + (T1c0 / T1c1)) + ((1 / T1c1) * -2)) + (((((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)) / ((T1c0 * T1c1) * T1c2)) * -1))) as double)) as long); ++wPTile) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = ((Math.round(((((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((ny * (T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) * -1)) + ((nx * (T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) * -1)) + (((T1c0 * T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * 2)) + (((T1c0 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round(((((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((ny * (T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) * -1)) + ((nx * (T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) * -1)) + (((T1c0 * T1c1) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * 2)) + (((T1c0 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                        tmpUb = ((Math.round(((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1))) as double)) as long < (Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((((wPTile * ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c1 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1)) + ((T1c1 * T1c2) / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2)))) + ((T1c2 / (((T1c1 * T1c2) + (T1c0 * T1c1)) + (T1c0 * T1c2))) * -1))) as double)) as long) as long : ((Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
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
                                var c2 : long;
                                var c0 : long;
                                var c1 : long;
                                for (c1t1 = ((Math.round((((((wPTile_2 + ((c0t1 * ((T1c2_3 + T1c0_4) / T1c2_3)) * -1)) + ((nx * (1 / T1c2_3)) * -1)) + ((T1c0_4 / T1c2_3) * -1)) + ((1 / T1c2_3) * 2))) as double)) as long > (Math.round(((((c0t1 * (T1c0_4 / T1c1_5)) + -1) + (1 / T1c1_5))) as double)) as long ? ((Math.round((((((wPTile_2 + ((c0t1 * ((T1c2_3 + T1c0_4) / T1c2_3)) * -1)) + ((nx * (1 / T1c2_3)) * -1)) + ((T1c0_4 / T1c2_3) * -1)) + ((1 / T1c2_3) * 2))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_4 / T1c1_5)) + -1) + (1 / T1c1_5))) as double)) as long) as long); (c1t1 <= ((Math.round(((((wPTile_2 + (c0t1 * (((T1c2_3 * -1) + (T1c0_4 * -1)) / T1c2_3))) + 1) + ((1 / T1c2_3) * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_4 / T1c1_5)) + (ny * (1 / T1c1_5))) + (T1c0_4 / T1c1_5)) + ((1 / T1c1_5) * -2))) as double)) as long ? ((Math.round(((((wPTile_2 + (c0t1 * (((T1c2_3 * -1) + (T1c0_4 * -1)) / T1c2_3))) + 1) + ((1 / T1c2_3) * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_4 / T1c1_5)) + (ny * (1 / T1c1_5))) + (T1c0_4 / T1c1_5)) + ((1 / T1c1_5) * -2))) as double)) as long) as long)); ++c1t1) {
                                    for (c2t1 = ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long > (Math.round(((((c0t1 * (T1c0_4 / T1c2_3)) + -1) + (1 / T1c2_3))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_4 / T1c2_3)) + -1) + (1 / T1c2_3))) as double)) as long) as long); (c2t1 <= ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_4 / T1c2_3)) + (nx * (1 / T1c2_3))) + (T1c0_4 / T1c2_3)) + ((1 / T1c2_3) * -2))) as double)) as long ? ((Math.round((((wPTile_2 + (c0t1 * -1)) + (c1t1 * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_4 / T1c2_3)) + (nx * (1 / T1c2_3))) + (T1c0_4 / T1c2_3)) + ((1 / T1c2_3) * -2))) as double)) as long) as long)); ++c2t1) {
                                        for (c0 = ((c0t1 * T1c0_4) > 0 ? ((c0t1 * T1c0_4)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_4) + (T1c0_4 + -1)) < (tmax + -1) ? (((c0t1 * T1c0_4) + (T1c0_4 + -1))) as long : ((tmax + -1)) as long)); c0++) {
                                            for (c1 = ((c1t1 * T1c1_5) > ((c0 + 1) - 1) ? ((c1t1 * T1c1_5)) as long : (((c0 + 1) - 1)) as long); (c1 <= (((c1t1 * T1c1_5) + (T1c1_5 + -1)) < ((c0 + 1) - 1) ? (((c1t1 * T1c1_5) + (T1c1_5 + -1))) as long : (((c0 + 1) - 1)) as long)); c1++) {
                                                for (c2 = ((c2t1 * T1c2_3) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_3)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                                    ey(0L,0) = _fict_(c0);
                                                }
                                                for (c2 = ((c2t1 * T1c2_3) > (c0 + 1) ? ((c2t1 * T1c2_3)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + nx) + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + nx) + -1)) as long)); c2++) {
                                                    ey(((-1 * c0) + c2),0) = ey(((-1 * c0) + c2),0) - 0.5 * (hz(((-1 * c0) + c2),0) - hz(((-1 * c0) + c2) - 1L,0));
                                                }
                                            }
                                            for (c1 = ((c1t1 * T1c1_5) > (c0 + 1) ? ((c1t1 * T1c1_5)) as long : ((c0 + 1)) as long); (c1 <= (((c1t1 * T1c1_5) + (T1c1_5 + -1)) < ((c0 + ny) + -1) ? (((c1t1 * T1c1_5) + (T1c1_5 + -1))) as long : (((c0 + ny) + -1)) as long)); c1++) {
                                                for (c2 = ((c2t1 * T1c2_3) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_3)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                                    ex(0,((-1 * c0) + c1)) = ex(0,((-1 * c0) + c1)) - 0.5 * (hz(0,((-1 * c0) + c1)) - hz(0,((-1 * c0) + c1) - 1L));
                                                    ey(0L,((-1 * c0) + c1)) = _fict_(c0);
                                                }
                                                for (c2 = ((c2t1 * T1c2_3) > (c0 + 1) ? ((c2t1 * T1c2_3)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_3) + (T1c2_3 + -1)) < ((c0 + nx) + -1) ? (((c2t1 * T1c2_3) + (T1c2_3 + -1))) as long : (((c0 + nx) + -1)) as long)); c2++) {
                                                    hz((((-1 * c0) + c2) + -1),(((-1 * c0) + c1) + -1)) = hz((((-1 * c0) + c2) + -1),(((-1 * c0) + c1) + -1)) - 0.7 * (ex((((-1 * c0) + c2) + -1),(((-1 * c0) + c1) + -1) + 1L) - ex((((-1 * c0) + c2) + -1),(((-1 * c0) + c1) + -1)) + ey((((-1 * c0) + c2) + -1) + 1L,(((-1 * c0) + c1) + -1)) - ey((((-1 * c0) + c2) + -1),(((-1 * c0) + c1) + -1)));
                                                    ey(((-1 * c0) + c2),((-1 * c0) + c1)) = ey(((-1 * c0) + c2),((-1 * c0) + c1)) - 0.5 * (hz(((-1 * c0) + c2),((-1 * c0) + c1)) - hz(((-1 * c0) + c2) - 1L,((-1 * c0) + c1)));
                                                    ex(((-1 * c0) + c2),((-1 * c0) + c1)) = ex(((-1 * c0) + c2),((-1 * c0) + c1)) - 0.5 * (hz(((-1 * c0) + c2),((-1 * c0) + c1)) - hz(((-1 * c0) + c2),((-1 * c0) + c1) - 1L));
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
            if (((nx >= 2) && (ny == 1))) {
                for (wPTile = (Math.round(((((-1 + (1 / T1c2)) + (((T1c2 + T1c0) / T1c2) * -1)) + ((T1c2 + T1c0) / (T1c0 * T1c2)))) as double)) as long; (wPTile <= (Math.round(((((((tmax * ((T1c2 + T1c0) / (T1c0 * T1c2))) + (nx * (1 / T1c2))) + (T1c0 / T1c2)) + ((1 / T1c2) * -2)) + (((T1c2 + T1c0) / (T1c0 * T1c2)) * -1))) as double)) as long); ++wPTile) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = ((Math.round((((((wPTile * (T1c2 / (T1c2 + T1c0))) + ((nx * (1 / (T1c2 + T1c0))) * -1)) + ((T1c0 / (T1c2 + T1c0)) * -1)) + ((1 / (T1c2 + T1c0)) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((wPTile * (T1c2 / (T1c2 + T1c0))) + ((nx * (1 / (T1c2 + T1c0))) * -1)) + ((T1c0 / (T1c2 + T1c0)) * -1)) + ((1 / (T1c2 + T1c0)) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                        tmpUb = ((Math.round(((((wPTile * (T1c2 / (T1c2 + T1c0))) + (T1c2 / (T1c2 + T1c0))) + ((1 / (T1c2 + T1c0)) * -1))) as double)) as long < (Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((wPTile * (T1c2 / (T1c2 + T1c0))) + (T1c2 / (T1c2 + T1c0))) + ((1 / (T1c2 + T1c0)) * -1))) as double)) as long) as long : ((Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                        {
                            val T1c2_4 = T1c2;
                            val T1c0_3 = T1c0;
                            val wPTile_2 = wPTile;
                            val tmpUb_1 = tmpUb;
                            val tmpLb_0 = tmpLb;
                            Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                                var c2t1 : long;
                                var c1t1 : long;
                                var c2 : long;
                                var c0 : long;
                                var c1 : long;
                                for (c2t1 = ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long > (Math.round(((((c0t1 * (T1c0_3 / T1c2_4)) + -1) + (1 / T1c2_4))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_3 / T1c2_4)) + -1) + (1 / T1c2_4))) as double)) as long) as long); (c2t1 <= ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_3 / T1c2_4)) + (nx * (1 / T1c2_4))) + (T1c0_3 / T1c2_4)) + ((1 / T1c2_4) * -2))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_3 / T1c2_4)) + (nx * (1 / T1c2_4))) + (T1c0_3 / T1c2_4)) + ((1 / T1c2_4) * -2))) as double)) as long) as long)); ++c2t1) {
                                    for (c0 = ((c0t1 * T1c0_3) > 0 ? ((c0t1 * T1c0_3)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_3) + (T1c0_3 + -1)) < (tmax + -1) ? (((c0t1 * T1c0_3) + (T1c0_3 + -1))) as long : ((tmax + -1)) as long)); c0++) {
                                        for (c2 = ((c2t1 * T1c2_4) > ((c0 + 1) - 1) ? ((c2t1 * T1c2_4)) as long : (((c0 + 1) - 1)) as long); (c2 <= (((c2t1 * T1c2_4) + (T1c2_4 + -1)) < ((c0 + 1) - 1) ? (((c2t1 * T1c2_4) + (T1c2_4 + -1))) as long : (((c0 + 1) - 1)) as long)); c2++) {
                                            ey(0L,0) = _fict_(c0);
                                        }
                                        for (c2 = ((c2t1 * T1c2_4) > (c0 + 1) ? ((c2t1 * T1c2_4)) as long : ((c0 + 1)) as long); (c2 <= (((c2t1 * T1c2_4) + (T1c2_4 + -1)) < ((c0 + nx) + -1) ? (((c2t1 * T1c2_4) + (T1c2_4 + -1))) as long : (((c0 + nx) + -1)) as long)); c2++) {
                                            ey(((-1 * c0) + c2),0) = ey(((-1 * c0) + c2),0) - 0.5 * (hz(((-1 * c0) + c2),0) - hz(((-1 * c0) + c2) - 1L,0));
                                        }
                                    }
                                }
                            }
);
                        }
                    }
                }
            }
            if (((nx == 1) && (ny >= 2))) {
                for (wPTile = (Math.round(((((-1 + (1 / T1c1)) + (((T1c1 + T1c0) / T1c1) * -1)) + ((T1c1 + T1c0) / (T1c0 * T1c1)))) as double)) as long; (wPTile <= (Math.round(((((((ny * (1 / T1c1)) + (tmax * ((T1c1 + T1c0) / (T1c0 * T1c1)))) + (T1c0 / T1c1)) + ((1 / T1c1) * -2)) + (((T1c1 + T1c0) / (T1c0 * T1c1)) * -1))) as double)) as long); ++wPTile) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = ((Math.round((((((wPTile * (T1c1 / (T1c1 + T1c0))) + ((ny * (1 / (T1c1 + T1c0))) * -1)) + ((T1c0 / (T1c1 + T1c0)) * -1)) + ((1 / (T1c1 + T1c0)) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((wPTile * (T1c1 / (T1c1 + T1c0))) + ((ny * (1 / (T1c1 + T1c0))) * -1)) + ((T1c0 / (T1c1 + T1c0)) * -1)) + ((1 / (T1c1 + T1c0)) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                        tmpUb = ((Math.round(((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long < (Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long) as long : ((Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                        {
                            val T1c1_4 = T1c1;
                            val T1c0_3 = T1c0;
                            val wPTile_2 = wPTile;
                            val tmpUb_1 = tmpUb;
                            val tmpLb_0 = tmpLb;
                            Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                                var c2t1 : long;
                                var c1t1 : long;
                                var c2 : long;
                                var c0 : long;
                                var c1 : long;
                                for (c1t1 = ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long > (Math.round(((((c0t1 * (T1c0_3 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_3 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long) as long); (c1t1 <= ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) + (ny * (1 / T1c1_4))) + (T1c0_3 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) + (ny * (1 / T1c1_4))) + (T1c0_3 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long) as long)); ++c1t1) {
                                    for (c0 = ((c0t1 * T1c0_3) > 0 ? ((c0t1 * T1c0_3)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_3) + (T1c0_3 + -1)) < (tmax + -1) ? (((c0t1 * T1c0_3) + (T1c0_3 + -1))) as long : ((tmax + -1)) as long)); c0++) {
                                        for (c1 = ((c1t1 * T1c1_4) > ((c0 + 1) - 1) ? ((c1t1 * T1c1_4)) as long : (((c0 + 1) - 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + 1) - 1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + 1) - 1)) as long)); c1++) {
                                            ey(0L,0) = _fict_(c0);
                                        }
                                        for (c1 = ((c1t1 * T1c1_4) > (c0 + 1) ? ((c1t1 * T1c1_4)) as long : ((c0 + 1)) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + ny) + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + ny) + -1)) as long)); c1++) {
                                            ex(0,((-1 * c0) + c1)) = ex(0,((-1 * c0) + c1)) - 0.5 * (hz(0,((-1 * c0) + c1)) - hz(0,((-1 * c0) + c1) - 1L));
                                            ey(0L,((-1 * c0) + c1)) = _fict_(c0);
                                        }
                                    }
                                }
                            }
);
                        }
                    }
                }
            }
            if (((nx <= 0) && (ny >= 2))) {
                for (wPTile = (Math.round(((((-1 + (1 / T1c1)) + (((T1c1 + T1c0) / T1c1) * -1)) + ((T1c1 + T1c0) / (T1c0 * T1c1)))) as double)) as long; (wPTile <= (Math.round(((((((ny * (1 / T1c1)) + (tmax * ((T1c1 + T1c0) / (T1c0 * T1c1)))) + (T1c0 / T1c1)) + ((1 / T1c1) * -2)) + (((T1c1 + T1c0) / (T1c0 * T1c1)) * -1))) as double)) as long); ++wPTile) {
                    {
                        var tmpLb : long;
                        var tmpUb : long;
                        tmpLb = ((Math.round((((((wPTile * (T1c1 / (T1c1 + T1c0))) + ((ny * (1 / (T1c1 + T1c0))) * -1)) + ((T1c0 / (T1c1 + T1c0)) * -1)) + ((1 / (T1c1 + T1c0)) * 2))) as double)) as long > (Math.round(((-1 + (1 / T1c0))) as double)) as long ? ((Math.round((((((wPTile * (T1c1 / (T1c1 + T1c0))) + ((ny * (1 / (T1c1 + T1c0))) * -1)) + ((T1c0 / (T1c1 + T1c0)) * -1)) + ((1 / (T1c1 + T1c0)) * 2))) as double)) as long) as long : ((Math.round(((-1 + (1 / T1c0))) as double)) as long) as long);
                        tmpUb = ((Math.round(((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long < (Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long ? ((Math.round(((((wPTile * (T1c1 / (T1c1 + T1c0))) + (T1c1 / (T1c1 + T1c0))) + ((1 / (T1c1 + T1c0)) * -1))) as double)) as long) as long : ((Math.round((((tmax * (1 / T1c0)) + ((1 / T1c0) * -1))) as double)) as long) as long);
                        {
                            val T1c1_4 = T1c1;
                            val T1c0_3 = T1c0;
                            val wPTile_2 = wPTile;
                            val tmpUb_1 = tmpUb;
                            val tmpLb_0 = tmpLb;
                            Foreach.block(tmpLb_0,tmpUb_1,(var c0t1 : long) => {
                                var c2t1 : long;
                                var c1t1 : long;
                                var c2 : long;
                                var c0 : long;
                                var c1 : long;
                                for (c1t1 = ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long > (Math.round(((((c0t1 * (T1c0_3 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round(((((c0t1 * (T1c0_3 / T1c1_4)) + -1) + (1 / T1c1_4))) as double)) as long) as long); (c1t1 <= ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long < (Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) + (ny * (1 / T1c1_4))) + (T1c0_3 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long ? ((Math.round(((wPTile_2 + (c0t1 * -1))) as double)) as long) as long : ((Math.round((((((c0t1 * (T1c0_3 / T1c1_4)) + (ny * (1 / T1c1_4))) + (T1c0_3 / T1c1_4)) + ((1 / T1c1_4) * -2))) as double)) as long) as long)); ++c1t1) {
                                    for (c0 = ((c0t1 * T1c0_3) > 0 ? ((c0t1 * T1c0_3)) as long : (0) as long); (c0 <= (((c0t1 * T1c0_3) + (T1c0_3 + -1)) < (tmax + -1) ? (((c0t1 * T1c0_3) + (T1c0_3 + -1))) as long : ((tmax + -1)) as long)); c0++) {
                                        for (c1 = ((c1t1 * T1c1_4) > c0 ? ((c1t1 * T1c1_4)) as long : (c0) as long); (c1 <= (((c1t1 * T1c1_4) + (T1c1_4 + -1)) < ((c0 + ny) + -1) ? (((c1t1 * T1c1_4) + (T1c1_4 + -1))) as long : (((c0 + ny) + -1)) as long)); c1++) {
                                            ey(0L,((-1 * c0) + c1)) = _fict_(c0);
                                        }
                                    }
                                }
                            }
);
                        }
                    }
                }
            }
            if (((nx <= 1) && (ny == 1))) {
                for (c0 = 0; (c0 <= (tmax + -1)); c0++) {
                    ey(0L,0) = _fict_(c0);
                }
            }
        }
    }

    def setPBs(nx : Long, ny : Long, tmax : Long) {
        _PB_NX = nx;
        _PB_NY = ny;
        _PB_TMAX = tmax;
    }    public static def main(args : Rail[String]) {
        var TMAX : Long = 0;
        var NX : Long = 0;
        var NY : Long = 0;
        val dataset = args.size == 0 ?  "STANDARD_DATASET" : args(0);

        @Ifdef("MINI_DATASET") {
            TMAX = 2;
            NX = 32;
            NY = 32;
        }
        @Ifdef("SMALL_DATASET") {
            TMAX = 10;
            NX = 500;
            NY = 500;
        }
        @Ifdef("STANDARD_DATASET") {
            TMAX = 50;
            NX = 1000;
            NY = 1000;
        }
        @Ifdef("LARGE_DATASET") {
            TMAX = 50;
            NX = 2000;
            NY = 2000;
        }
        @Ifdef("EXTRALARGE_DATASET") {
            TMAX = 100;
            NX = 4000;
            NY = 4000;
        }

        val fdtd_2d = new Fdtd_2d();

        /* Retrieve problem size. */
        var nx : Long = NX;
        var ny : Long = NY;
        var tmax : Long = TMAX;
        fdtd_2d.setPBs(nx, ny, tmax);

        /* Variable declaration/allocation. */
        val ex  = new Array_2[Double](nx,ny); 

        val ey  = new Array_2[Double](nx,ny); 

        val hz  = new Array_2[Double](nx,ny); 
        val _fict_ = new Rail[Double](tmax);        /* Initialize array(s). */
        fdtd_2d.init_array (tmax, nx, ny, ex, ey, hz, _fict_);

        /* Start timer. */
        val t1 = System.currentTimeMillis();

        /* Run kernel. */
        fdtd_2d.kernel_fdtd_2d (tmax, nx, ny, ex, ey, hz, _fict_);

        /* Stop and print timer. */
        val t2 = System.currentTimeMillis();

        Console.OUT.printf ("Elapsed time= " + (t2 - t1) + " (ms)\n");
     // fdtd_2d.print_array(nx, ny, ex, ey, hz);       
    }
}
