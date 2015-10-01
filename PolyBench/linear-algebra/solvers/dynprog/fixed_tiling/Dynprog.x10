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
                var c7 : long;
                var c5 : long;
                var c8 : long;
                var c1 : long;
                var c6 : long;
                var c3 : long;
                var c4 : long;
                for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                    for (c3 = 0; (c3 <= ((length + -2) * 16 < 0 ? (16 < 0 ?  -(( -((length + -2)) + 16 + 1) / 16) :  -(( -((length + -2)) + 16 - 1) / 16)) : (length + -2) / 16)); c3++) {
                        {
                            val c3_0 = c3;
                            Foreach.block((0 > ((((256 * c3_0) + (-1 * length)) + 1) * 256 < 0 ?  -( -((((256 * c3_0) + (-1 * length)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c3_0) + (-1 * length)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c3_0) + (-1 * length)) + 1) + 256 - 1) / 256)) ? (0) as long : (((((256 * c3_0) + (-1 * length)) + 1) * 256 < 0 ?  -( -((((256 * c3_0) + (-1 * length)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c3_0) + (-1 * length)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c3_0) + (-1 * length)) + 1) + 256 - 1) / 256))) as long),((c3_0 + -1) * 2 < 0 ? (2 < 0 ?  -(( -((c3_0 + -1)) + 2 + 1) / 2) :  -(( -((c3_0 + -1)) + 2 - 1) / 2)) : (c3_0 + -1) / 2),(var c4 : long) => {
                                var c7 : long;
                                var c5 : long;
                                var c8 : long;
                                var c6 : long;
                                for (c6 = ((256 * c3_0) + (-256 * c4)); (c6 <= ((length + -1) < (((256 * c3_0) + (-256 * c4)) + 255) ? ((length + -1)) as long : ((((256 * c3_0) + (-256 * c4)) + 255)) as long)); c6++) {
                                    for (c7 = (256 * c4); (c7 <= ((256 * c4) + 255)); c7++) {
                                        c(c6,c7) = 0L;
                                    }
                                }
                            }
);
                        }
                        {
                            val c3_0 = c3;
                            Foreach.block((c3_0 * 2 < 0 ?  -( -(c3_0) / 2) : (2 < 0 ? ( -(c3_0) +  -(2) - 1) /  -(2) : (c3_0 + 2 - 1) / 2)),(((length + -1) * 256 < 0 ? (256 < 0 ?  -(( -((length + -1)) + 256 + 1) / 256) :  -(( -((length + -1)) + 256 - 1) / 256)) : (length + -1) / 256) < c3_0 ? (((length + -1) * 256 < 0 ? (256 < 0 ?  -(( -((length + -1)) + 256 + 1) / 256) :  -(( -((length + -1)) + 256 - 1) / 256)) : (length + -1) / 256)) as long : (c3_0) as long),(var c4 : long) => {
                                var c7 : long;
                                var c5 : long;
                                var c8 : long;
                                var c6 : long;
                                for (c6 = ((256 * c3_0) + (-256 * c4)); (c6 <= ((((256 * c4) + 30) < (length + -2) ? (((256 * c4) + 30)) as long : ((length + -2)) as long) < (((256 * c3_0) + (-256 * c4)) + 255) ? ((((256 * c4) + 30) < (length + -2) ? (((256 * c4) + 30)) as long : ((length + -2)) as long)) as long : ((((256 * c3_0) + (-256 * c4)) + 255)) as long)); c6++) {
                                    if ((c3_0 == (2 * c4))) {
                                        for (c7 = (16 * c3_0); (c7 <= c6); c7++) {
                                            if (((c3_0 % 2) == 0)) {
                                                c(c6,c7) = 0L;
                                            }
                                        }
                                    }
                                    for (c7 = ((256 * c4) > (c6 + 1) ? ((256 * c4)) as long : ((c6 + 1)) as long); (c7 <= (((256 * c4) + 255) < (length + -1) ? (((256 * c4) + 255)) as long : ((length + -1)) as long)); c7++) {
                                        c(c6,c7) = 0L;
                                        sum_c(c6,c7,c6) = 0L;
                                    }
                                }
                                if (((c3_0 == (2 * c4)) && (c3_0 <= ((length + -33) * 16 < 0 ? (16 < 0 ?  -(( -((length + -33)) + 16 + 1) / 16) :  -(( -((length + -33)) + 16 - 1) / 16)) : (length + -33) / 16)))) {
                                    for (c7 = (16 * c3_0); (c7 <= ((16 * c3_0) + 255)); c7++) {
                                        if (((c3_0 % 2) == 0)) {
                                            c(((16 * c3_0) + 255),c7) = 0L;
                                        }
                                    }
                                }
                                if (((c3_0 == (2 * c4)) && (c3_0 >= ((length + -256) * 16 < 0 ?  -( -((length + -256)) / 16) : (16 < 0 ? ( -((length + -256)) +  -(16) - 1) /  -(16) : ((length + -256) + 16 - 1) / 16))))) {
                                    for (c7 = (16 * c3_0); (c7 <= (length + -1)); c7++) {
                                        if (((c3_0 % 2) == 0)) {
                                            c((length + -1),c7) = 0L;
                                        }
                                    }
                                }
                            }
);
                        }
                    }
                    if ((length >= 1)) {
                        if ((((length + 15) % 16) == 0)) {
                            if ((((length + 255) % 256) == 0)) {
                                c((length + -1),(length + -1)) = 0L;
                            }
                        }
                    }
                    if ((length >= 3)) {
                        for (c3 = 0; (c3 <= ((length + -2) * 16 < 0 ? (16 < 0 ?  -(( -((length + -2)) + 16 + 1) / 16) :  -(( -((length + -2)) + 16 - 1) / 16)) : (length + -2) / 16)); c3++) {
                            if (((16 * c3) == (length + -2))) {
                                if ((((length + 30) % 256) == 0)) {
                                    c((length + -2),(length + -1)) = sum_c((length + -2),(length + -1),(length + -1) - 1L) + W((length + -2),(length + -1));
                                }
                            }
                            {
                                val c3_0 = c3;
                                Foreach.block(((c3_0 * 2 < 0 ?  -( -(c3_0) / 2) : (2 < 0 ? ( -(c3_0) +  -(2) - 1) /  -(2) : (c3_0 + 2 - 1) / 2)) > ((((256 * c3_0) + (-1 * length)) + 3) * 256 < 0 ?  -( -((((256 * c3_0) + (-1 * length)) + 3)) / 256) : (256 < 0 ? ( -((((256 * c3_0) + (-1 * length)) + 3)) +  -(256) - 1) /  -(256) : ((((256 * c3_0) + (-1 * length)) + 3) + 256 - 1) / 256)) ? ((c3_0 * 2 < 0 ?  -( -(c3_0) / 2) : (2 < 0 ? ( -(c3_0) +  -(2) - 1) /  -(2) : (c3_0 + 2 - 1) / 2))) as long : (((((256 * c3_0) + (-1 * length)) + 3) * 256 < 0 ?  -( -((((256 * c3_0) + (-1 * length)) + 3)) / 256) : (256 < 0 ? ( -((((256 * c3_0) + (-1 * length)) + 3)) +  -(256) - 1) /  -(256) : ((((256 * c3_0) + (-1 * length)) + 3) + 256 - 1) / 256))) as long),(((length + -1) * 256 < 0 ? (256 < 0 ?  -(( -((length + -1)) + 256 + 1) / 256) :  -(( -((length + -1)) + 256 - 1) / 256)) : (length + -1) / 256) < c3_0 ? (((length + -1) * 256 < 0 ? (256 < 0 ?  -(( -((length + -1)) + 256 + 1) / 256) :  -(( -((length + -1)) + 256 - 1) / 256)) : (length + -1) / 256)) as long : (c3_0) as long),(var c4 : long) => {
                                    var c7 : long;
                                    var c5 : long;
                                    var c8 : long;
                                    var c6 : long;
                                    for (c5 = (c3_0 + (-1 * c4)); (c5 <= (c4 + -1)); c5++) {
                                        for (c6 = ((256 * c3_0) + (-256 * c4)); (c6 <= (((256 * c5) + 30) < (((256 * c3_0) + (-256 * c4)) + 255) ? (((256 * c5) + 30)) as long : ((((256 * c3_0) + (-256 * c4)) + 255)) as long)); c6++) {
                                            for (c7 = (256 * c4); (c7 <= (((256 * c4) + 255) < (length + -1) ? (((256 * c4) + 255)) as long : ((length + -1)) as long)); c7++) {
                                                for (c8 = ((256 * c5) > (c6 + 1) ? ((256 * c5)) as long : ((c6 + 1)) as long); (c8 <= ((256 * c5) + 255)); c8++) {
                                                    sum_c(c6,c7,c8) = sum_c(c6,c7,c8 - 1L) + c(c6,c8) + c(c8,c7);
                                                }
                                            }
                                        }
                                    }
                                    if (((256 * c4) == (length + -1))) {
                                        if ((((length + 255) % 256) == 0)) {
                                            for (c6 = (((256 * c3_0) + (-1 * length)) + 1); (c6 <= (((256 * c3_0) + (-1 * length)) + 256)); c6++) {
                                                c(c6,(length + -1)) = sum_c(c6,(length + -1),(length + -1) - 1L) + W(c6,(length + -1));
                                            }
                                        }
                                    }
                                    if ((c4 <= ((length + -2) * 256 < 0 ? (256 < 0 ?  -(( -((length + -2)) + 256 + 1) / 256) :  -(( -((length + -2)) + 256 - 1) / 256)) : (length + -2) / 256))) {
                                        for (c6 = ((256 * c3_0) + (-256 * c4)); (c6 <= ((((256 * c4) + 29) < (length + -3) ? (((256 * c4) + 29)) as long : ((length + -3)) as long) < (((256 * c3_0) + (-256 * c4)) + 255) ? ((((256 * c4) + 29) < (length + -3) ? (((256 * c4) + 29)) as long : ((length + -3)) as long)) as long : ((((256 * c3_0) + (-256 * c4)) + 255)) as long)); c6++) {
                                            if ((c3_0 == (2 * c4))) {
                                                if (((c3_0 % 2) == 0)) {
                                                    c(c6,(c6 + 1)) = sum_c(c6,(c6 + 1),(c6 + 1) - 1L) + W(c6,(c6 + 1));
                                                }
                                            }
                                            if ((c4 >= ((c6 + 1) * 256 < 0 ?  -( -((c6 + 1)) / 256) : (256 < 0 ? ( -((c6 + 1)) +  -(256) - 1) /  -(256) : ((c6 + 1) + 256 - 1) / 256)))) {
                                                c(c6,(256 * c4)) = sum_c(c6,(256 * c4),(256 * c4) - 1L) + W(c6,(256 * c4));
                                            }
                                            for (c7 = (((256 * c4) + 1) > (c6 + 2) ? (((256 * c4) + 1)) as long : ((c6 + 2)) as long); (c7 <= (((256 * c4) + 255) < (length + -1) ? (((256 * c4) + 255)) as long : ((length + -1)) as long)); c7++) {
                                                for (c8 = ((256 * c4) > (c6 + 1) ? ((256 * c4)) as long : ((c6 + 1)) as long); (c8 <= (c7 + -1)); c8++) {
                                                    sum_c(c6,c7,c8) = sum_c(c6,c7,c8 - 1L) + c(c6,c8) + c(c8,c7);
                                                }
                                                c(c6,c7) = sum_c(c6,c7,c7 - 1L) + W(c6,c7);
                                            }
                                        }
                                        if (((c3_0 == (2 * c4)) && (c3_0 <= ((length + -33) * 16 < 0 ? (16 < 0 ?  -(( -((length + -33)) + 16 + 1) / 16) :  -(( -((length + -33)) + 16 - 1) / 16)) : (length + -33) / 16)))) {
                                            if (((c3_0 % 2) == 0)) {
                                                c(((16 * c3_0) + 30),((16 * c3_0) + 255)) = sum_c(((16 * c3_0) + 30),((16 * c3_0) + 255),((16 * c3_0) + 255) - 1L) + W(((16 * c3_0) + 30),((16 * c3_0) + 255));
                                            }
                                        }
                                        if (((c3_0 == (2 * c4)) && (c3_0 >= ((length + -256) * 16 < 0 ?  -( -((length + -256)) / 16) : (16 < 0 ? ( -((length + -256)) +  -(16) - 1) /  -(16) : ((length + -256) + 16 - 1) / 16))))) {
                                            if (((c3_0 % 2) == 0)) {
                                                c((length + -2),(length + -1)) = sum_c((length + -2),(length + -1),(length + -1) - 1L) + W((length + -2),(length + -1));
                                            }
                                        }
                                    }
                                }
);
                            }
                        }
                    }
                    if ((length == 2)) {
                        c(0,1) = sum_c(0,1,1 - 1L) + W(0,1);
                    }
                    out_l += c(0L,length - 1L);
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
