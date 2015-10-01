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
                var c1 : long;
                var c3 : long;
                var c4 : long;
                var c5 : long;
                if ((length >= 3)) {
                    for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                        c(0,0) = 0L;
                        for (c3 = 1; (c3 <= ((2 * length) + -3)); c3++) {
                            {
                                val c3_0 = c3;
                                Foreach.block((0 > ((c3_0 + (-1 * length)) + 1) ? (0) as long : (((c3_0 + (-1 * length)) + 1)) as long),(c3_0 * 2 < 0 ? (2 < 0 ?  -(( -(c3_0) + 2 + 1) / 2) :  -(( -(c3_0) + 2 - 1) / 2)) : c3_0 / 2),(var c4 : long) => {
                                    var c5 : long;
                                    c((c3_0 + (-1 * c4)),c4) = 0L;
                                }
);
                            }
                            {
                                val c3_0 = c3;
                                Foreach.block(((c3_0 + 1) * 2 < 0 ?  -( -((c3_0 + 1)) / 2) : (2 < 0 ? ( -((c3_0 + 1)) +  -(2) - 1) /  -(2) : ((c3_0 + 1) + 2 - 1) / 2)),(c3_0 < (length + -1) ? (c3_0) as long : ((length + -1)) as long),(var c4 : long) => {
                                    var c5 : long;
                                    c((c3_0 + (-1 * c4)),c4) = 0L;
                                    sum_c((c3_0 + (-1 * c4)),c4,(c3_0 + (-1 * c4))) = 0L;
                                }
);
                            }
                        }
                        c((length + -1),(length + -1)) = 0L;
                        c(0,1) = sum_c(0,1,1 - 1L) + W(0,1);
                        for (c3 = 2; (c3 <= ((2 * length) + -4)); c3++) {
                            if ((((c3 + 1) % 2) == 0)) {
                                c(((c3 + -1) / 2),((c3 + 1) / 2)) = sum_c(((c3 + -1) / 2),((c3 + 1) / 2),((c3 + 1) / 2) - 1L) + W(((c3 + -1) / 2),((c3 + 1) / 2));
                            }
                            {
                                val c3_0 = c3;
                                Foreach.block(((c3_0 + 2) * 2 < 0 ?  -( -((c3_0 + 2)) / 2) : (2 < 0 ? ( -((c3_0 + 2)) +  -(2) - 1) /  -(2) : ((c3_0 + 2) + 2 - 1) / 2)),(c3_0 < (length + -1) ? (c3_0) as long : ((length + -1)) as long),(var c4 : long) => {
                                    var c5 : long;
                                    for (c5 = ((c3_0 + (-1 * c4)) + 1); (c5 <= (c4 + -1)); c5++) {
                                        sum_c((c3_0 + (-1 * c4)),c4,c5) = sum_c((c3_0 + (-1 * c4)),c4,c5 - 1L) + c((c3_0 + (-1 * c4)),c5) + c(c5,c4);
                                    }
                                    c((c3_0 + (-1 * c4)),c4) = sum_c((c3_0 + (-1 * c4)),c4,c4 - 1L) + W((c3_0 + (-1 * c4)),c4);
                                }
);
                            }
                        }
                        c((length + -2),(length + -1)) = sum_c((length + -2),(length + -1),(length + -1) - 1L) + W((length + -2),(length + -1));
                        out_l += c(0L,length - 1L);
                    }
                }
                if ((length == 2)) {
                    for (c1 = 0; (c1 <= (tsteps + -1)); c1++) {
                        c(0,0) = 0L;
                        {
                            Foreach.block(0,1,(var c4 : long) => {
                                var c5 : long;
                                c(((-1 * c4) + 1),c4) = 0L;
                            }
);
                        }
                        sum_c(0,1,0) = 0L;
                        c(1,1) = 0L;
                        c(0,1) = sum_c(0,1,1 - 1L) + W(0,1);
                        out_l += c(0L,length - 1L);
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
