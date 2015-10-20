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
            var t : long;
            var j : long;
            var i : long;
            {
                var c7 : long;
                var c1 : long;
                var c5 : long;
                var c3 : long;
                var c2 : long;
                var c0 : long;
                var c4 : long;
                if (((maxgrid >= 1) && (niter >= 1))) {
                    for (c0 = 0; (c0 <= (((maxgrid + (2 * niter)) + -3) * 32 < 0 ? (32 < 0 ?  -(( -(((maxgrid + (2 * niter)) + -3)) + 32 + 1) / 32) :  -(( -(((maxgrid + (2 * niter)) + -3)) + 32 - 1) / 32)) : ((maxgrid + (2 * niter)) + -3) / 32)); c0++) {
                        {
                            val c0_0 = c0;
                            Foreach.block(((c0_0 * 2 < 0 ?  -( -(c0_0) / 2) : (2 < 0 ? ( -(c0_0) +  -(2) - 1) /  -(2) : (c0_0 + 2 - 1) / 2)) > ((((32 * c0_0) + (-1 * niter)) + 1) * 32 < 0 ?  -( -((((32 * c0_0) + (-1 * niter)) + 1)) / 32) : (32 < 0 ? ( -((((32 * c0_0) + (-1 * niter)) + 1)) +  -(32) - 1) /  -(32) : ((((32 * c0_0) + (-1 * niter)) + 1) + 32 - 1) / 32)) ? ((c0_0 * 2 < 0 ?  -( -(c0_0) / 2) : (2 < 0 ? ( -(c0_0) +  -(2) - 1) /  -(2) : (c0_0 + 2 - 1) / 2))) as long : (((((32 * c0_0) + (-1 * niter)) + 1) * 32 < 0 ?  -( -((((32 * c0_0) + (-1 * niter)) + 1)) / 32) : (32 < 0 ? ( -((((32 * c0_0) + (-1 * niter)) + 1)) +  -(32) - 1) /  -(32) : ((((32 * c0_0) + (-1 * niter)) + 1) + 32 - 1) / 32))) as long),(((((maxgrid + niter) + -2) * 32 < 0 ? (32 < 0 ?  -(( -(((maxgrid + niter) + -2)) + 32 + 1) / 32) :  -(( -(((maxgrid + niter) + -2)) + 32 - 1) / 32)) : ((maxgrid + niter) + -2) / 32) < ((((32 * c0_0) + maxgrid) + 30) * 64 < 0 ? (64 < 0 ?  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 + 1) / 64) :  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 - 1) / 64)) : (((32 * c0_0) + maxgrid) + 30) / 64) ? ((((maxgrid + niter) + -2) * 32 < 0 ? (32 < 0 ?  -(( -(((maxgrid + niter) + -2)) + 32 + 1) / 32) :  -(( -(((maxgrid + niter) + -2)) + 32 - 1) / 32)) : ((maxgrid + niter) + -2) / 32)) as long : (((((32 * c0_0) + maxgrid) + 30) * 64 < 0 ? (64 < 0 ?  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 + 1) / 64) :  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 - 1) / 64)) : (((32 * c0_0) + maxgrid) + 30) / 64)) as long) < c0_0 ? (((((maxgrid + niter) + -2) * 32 < 0 ? (32 < 0 ?  -(( -(((maxgrid + niter) + -2)) + 32 + 1) / 32) :  -(( -(((maxgrid + niter) + -2)) + 32 - 1) / 32)) : ((maxgrid + niter) + -2) / 32) < ((((32 * c0_0) + maxgrid) + 30) * 64 < 0 ? (64 < 0 ?  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 + 1) / 64) :  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 - 1) / 64)) : (((32 * c0_0) + maxgrid) + 30) / 64) ? ((((maxgrid + niter) + -2) * 32 < 0 ? (32 < 0 ?  -(( -(((maxgrid + niter) + -2)) + 32 + 1) / 32) :  -(( -(((maxgrid + niter) + -2)) + 32 - 1) / 32)) : ((maxgrid + niter) + -2) / 32)) as long : (((((32 * c0_0) + maxgrid) + 30) * 64 < 0 ? (64 < 0 ?  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 + 1) / 64) :  -(( -((((32 * c0_0) + maxgrid) + 30)) + 64 - 1) / 64)) : (((32 * c0_0) + maxgrid) + 30) / 64)) as long)) as long : (c0_0) as long),(var c1 : long) => {
                                var c7 : long;
                                var c5 : long;
                                var c3 : long;
                                var c2 : long;
                                var c4 : long;
                                for (c2 = (c0_0 + (-1 * c1)); (c2 <= c1); c2++) {
                                    if ((((c0_0 == (c1 + c2)) && (length >= 2)) && (maxgrid >= 2))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 30) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 30)) as long)); c3++) {
                                            if ((c0_0 == (2 * c1))) {
                                                if (((c0_0 % 2) == 0)) {
                                                    diff(0,0,0) = sum_tang(0,0);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    sum_diff(0,0,0L) = diff(0,0,0L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    mean(0,0) = sum_diff(0,0,length - 1L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    path(0L,0) = mean(0L,0);
                                                }
                                                for (c5 = 1; (c5 <= (length + -1)); c5++) {
                                                    if (((c0_0 % 2) == 0)) {
                                                        diff(0,0,c5) = sum_tang(0,0);
                                                    }
                                                    if (((c0_0 % 2) == 0)) {
                                                        sum_diff(0,0,c5) = sum_diff(0,0,c5 - 1L) + diff(0,0,c5);
                                                    }
                                                }
                                            }
                                            for (c4 = ((32 * c1) > (c3 + 1) ? ((32 * c1)) as long : ((c3 + 1)) as long); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    diff(((-1 * c3) + c7),((-1 * c3) + c4),0) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
                                                mean(0,((-1 * c3) + c4)) = sum_diff(0,((-1 * c3) + c4),length - 1L);
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (c3 + 1); (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
                                                path(0L,((-1 * c3) + c4)) = mean(0L,((-1 * c3) + c4));
                                                for (c5 = 1; (c5 <= (length + -1)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                    for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                        diff(((-1 * c3) + c7),((-1 * c3) + c4),c5) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                    }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                    for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                        sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),c5) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),c5 - 1L) + diff(((-1 * c3) + c7),((-1 * c3) + c4),c5);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (((((c0_0 == (c1 + c2)) && (c0_0 <= ((((32 * c1) + niter) + -32) * 32 < 0 ? (32 < 0 ?  -(( -((((32 * c1) + niter) + -32)) + 32 + 1) / 32) :  -(( -((((32 * c1) + niter) + -32)) + 32 - 1) / 32)) : (((32 * c1) + niter) + -32) / 32))) && (length >= 2)) && (maxgrid >= 2))) {
                                        for (c4 = ((32 * c1) > (((32 * c0_0) + (-32 * c1)) + 31) ? ((32 * c1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long); (c4 <= (((32 * c1) + 31) < ((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30) ? (((32 * c1) + 31)) as long : (((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30)) as long)); c4++) {
                                            diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0) = sum_tang(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                            sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L) = diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L);
                                            mean(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),length - 1L);
                                            path(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = mean(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                            for (c5 = 1; (c5 <= (length + -1)); c5++) {
                                                diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),c5) = sum_tang(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                                sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),c5) = sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),c5 - 1L) + diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),c5);
                                            }
                                        }
                                    }
                                    if (((((c0_0 == (2 * c1)) && (c0_0 == (2 * c2))) && (length >= 2)) && (maxgrid == 1))) {
                                        for (c3 = (16 * c0_0); (c3 <= (((16 * c0_0) + 31) < (niter + -1) ? (((16 * c0_0) + 31)) as long : ((niter + -1)) as long)); c3++) {
                                            if (((c0_0 % 2) == 0)) {
                                                diff(0,0,0) = sum_tang(0,0);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                sum_diff(0,0,0L) = diff(0,0,0L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                mean(0,0) = sum_diff(0,0,length - 1L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                path(0L,0) = mean(0L,0);
                                            }
                                            for (c5 = 1; (c5 <= (length + -1)); c5++) {
                                                if (((c0_0 % 2) == 0)) {
                                                    diff(0,0,c5) = sum_tang(0,0);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    sum_diff(0,0,c5) = sum_diff(0,0,c5 - 1L) + diff(0,0,c5);
                                                }
                                            }
                                        }
                                    }
                                    if (((c0_0 <= ((c1 + c2) + -1)) && (length >= 2))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 31) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c3++) {
                                            for (c4 = (32 * c1); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    diff(((-1 * c3) + c7),((-1 * c3) + c4),0) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
                                                for (c5 = 1; (c5 <= (length + -1)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                    for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                        diff(((-1 * c3) + c7),((-1 * c3) + c4),c5) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                    }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                    for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                        sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),c5) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),c5 - 1L) + diff(((-1 * c3) + c7),((-1 * c3) + c4),c5);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if ((((c0_0 == (c1 + c2)) && (length == 1)) && (maxgrid >= 2))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 30) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 30)) as long)); c3++) {
                                            if ((c0_0 == (2 * c1))) {
                                                if (((c0_0 % 2) == 0)) {
                                                    diff(0,0,0) = sum_tang(0,0);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    sum_diff(0,0,0L) = diff(0,0,0L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    mean(0,0) = sum_diff(0,0,length - 1L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    path(0L,0) = mean(0L,0);
                                                }
                                            }
                                            for (c4 = ((32 * c1) > (c3 + 1) ? ((32 * c1)) as long : ((c3 + 1)) as long); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    diff(((-1 * c3) + c7),((-1 * c3) + c4),0) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
                                                mean(0,((-1 * c3) + c4)) = sum_diff(0,((-1 * c3) + c4),length - 1L);
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (c3 + 1); (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
                                                path(0L,((-1 * c3) + c4)) = mean(0L,((-1 * c3) + c4));
                                            }
                                        }
                                    }
                                    if (((((c0_0 == (c1 + c2)) && (c0_0 <= ((((32 * c1) + niter) + -32) * 32 < 0 ? (32 < 0 ?  -(( -((((32 * c1) + niter) + -32)) + 32 + 1) / 32) :  -(( -((((32 * c1) + niter) + -32)) + 32 - 1) / 32)) : (((32 * c1) + niter) + -32) / 32))) && (length == 1)) && (maxgrid >= 2))) {
                                        for (c4 = ((32 * c1) > (((32 * c0_0) + (-32 * c1)) + 31) ? ((32 * c1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long); (c4 <= (((32 * c1) + 31) < ((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30) ? (((32 * c1) + 31)) as long : (((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30)) as long)); c4++) {
                                            diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0) = sum_tang(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                            sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L) = diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L);
                                            mean(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),length - 1L);
                                            path(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = mean(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                        }
                                    }
                                    if (((((c0_0 == (2 * c1)) && (c0_0 == (2 * c2))) && (length == 1)) && (maxgrid == 1))) {
                                        for (c3 = (16 * c0_0); (c3 <= (((16 * c0_0) + 31) < (niter + -1) ? (((16 * c0_0) + 31)) as long : ((niter + -1)) as long)); c3++) {
                                            if (((c0_0 % 2) == 0)) {
                                                diff(0,0,0) = sum_tang(0,0);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                sum_diff(0,0,0L) = diff(0,0,0L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                mean(0,0) = sum_diff(0,0,length - 1L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                path(0L,0) = mean(0L,0);
                                            }
                                        }
                                    }
                                    if (((c0_0 <= ((c1 + c2) + -1)) && (length == 1))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 31) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c3++) {
                                            for (c4 = (32 * c1); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    diff(((-1 * c3) + c7),((-1 * c3) + c4),0) = sum_tang(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
                                            }
                                        }
                                    }
                                    if ((((c0_0 == (c1 + c2)) && (length <= 0)) && (maxgrid >= 2))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 30) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 30)) as long)); c3++) {
                                            if ((c0_0 == (2 * c1))) {
                                                if (((c0_0 % 2) == 0)) {
                                                    sum_diff(0,0,0L) = diff(0,0,0L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    mean(0,0) = sum_diff(0,0,length - 1L);
                                                }
                                                if (((c0_0 % 2) == 0)) {
                                                    path(0L,0) = mean(0L,0);
                                                }
                                            }
                                            for (c4 = ((32 * c1) > (c3 + 1) ? ((32 * c1)) as long : ((c3 + 1)) as long); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = c3; (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
                                                mean(0,((-1 * c3) + c4)) = sum_diff(0,((-1 * c3) + c4),length - 1L);
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (c3 + 1); (c7 <= (c4 < (((32 * c0_0) + (-32 * c1)) + 31) ? (c4) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
                                                }
                                                path(0L,((-1 * c3) + c4)) = mean(0L,((-1 * c3) + c4));
                                            }
                                        }
                                    }
                                    if (((((c0_0 == (c1 + c2)) && (c0_0 <= ((((32 * c1) + niter) + -32) * 32 < 0 ? (32 < 0 ?  -(( -((((32 * c1) + niter) + -32)) + 32 + 1) / 32) :  -(( -((((32 * c1) + niter) + -32)) + 32 - 1) / 32)) : (((32 * c1) + niter) + -32) / 32))) && (length <= 0)) && (maxgrid >= 2))) {
                                        for (c4 = ((32 * c1) > (((32 * c0_0) + (-32 * c1)) + 31) ? ((32 * c1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long); (c4 <= (((32 * c1) + 31) < ((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30) ? (((32 * c1) + 31)) as long : (((((32 * c0_0) + (-32 * c1)) + maxgrid) + 30)) as long)); c4++) {
                                            sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L) = diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),0L);
                                            mean(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = sum_diff(0,((((-32 * c0_0) + (32 * c1)) + c4) + -31),length - 1L);
                                            path(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31)) = mean(0L,((((-32 * c0_0) + (32 * c1)) + c4) + -31));
                                        }
                                    }
                                    if (((((c0_0 == (2 * c1)) && (c0_0 == (2 * c2))) && (length <= 0)) && (maxgrid == 1))) {
                                        for (c3 = (16 * c0_0); (c3 <= (((16 * c0_0) + 31) < (niter + -1) ? (((16 * c0_0) + 31)) as long : ((niter + -1)) as long)); c3++) {
                                            if (((c0_0 % 2) == 0)) {
                                                sum_diff(0,0,0L) = diff(0,0,0L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                mean(0,0) = sum_diff(0,0,length - 1L);
                                            }
                                            if (((c0_0 % 2) == 0)) {
                                                path(0L,0) = mean(0L,0);
                                            }
                                        }
                                    }
                                    if (((c0_0 <= ((c1 + c2) + -1)) && (length <= 0))) {
                                        for (c3 = (((32 * c0_0) + (-32 * c1)) > (((32 * c1) + (-1 * maxgrid)) + 1) ? (((32 * c0_0) + (-32 * c1))) as long : ((((32 * c1) + (-1 * maxgrid)) + 1)) as long); (c3 <= ((niter + -1) < (((32 * c0_0) + (-32 * c1)) + 31) ? ((niter + -1)) as long : ((((32 * c0_0) + (-32 * c1)) + 31)) as long)); c3++) {
                                            for (c4 = (32 * c1); (c4 <= (((32 * c1) + 31) < ((c3 + maxgrid) + -1) ? (((32 * c1) + 31)) as long : (((c3 + maxgrid) + -1)) as long)); c4++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),0L) = diff(((-1 * c3) + c7),((-1 * c3) + c4),0L);
                                                }
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                                for (c7 = (32 * c2); (c7 <= (c4 < ((32 * c2) + 31) ? (c4) as long : (((32 * c2) + 31)) as long)); c7++) {
                                                    mean(((-1 * c3) + c7),((-1 * c3) + c4)) = sum_diff(((-1 * c3) + c7),((-1 * c3) + c4),length - 1L);
                                                    path(((-1 * c3) + c7),((-1 * c3) + c4)) = path(((-1 * c3) + c7) - 1L,((-1 * c3) + c4) - 1L) + mean(((-1 * c3) + c7),((-1 * c3) + c4));
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
        NITER = 1000;
        LENGTH = 500;
        MAXGRID = 12;
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
