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
        var c1 : long;
        var c0 : long;
        var c3 : long;
        var c2 : long;
        if (((n >= 3) && (tsteps >= 1))) {
            for (c0 = 0; (c0 <= (((n + (3 * tsteps)) + -4) * 256 < 0 ? (256 < 0 ?  -(( -(((n + (3 * tsteps)) + -4)) + 256 + 1) / 256) :  -(( -(((n + (3 * tsteps)) + -4)) + 256 - 1) / 256)) : ((n + (3 * tsteps)) + -4) / 256)); c0++) {
                {
                    val c0_0 = c0;
                    Foreach.block((((2 * c0_0) * 3 < 0 ?  -( -((2 * c0_0)) / 3) : (3 < 0 ? ( -((2 * c0_0)) +  -(3) - 1) /  -(3) : ((2 * c0_0) + 3 - 1) / 3)) > ((((256 * c0_0) + (-1 * tsteps)) + 1) * 256 < 0 ?  -( -((((256 * c0_0) + (-1 * tsteps)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c0_0) + (-1 * tsteps)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c0_0) + (-1 * tsteps)) + 1) + 256 - 1) / 256)) ? (((2 * c0_0) * 3 < 0 ?  -( -((2 * c0_0)) / 3) : (3 < 0 ? ( -((2 * c0_0)) +  -(3) - 1) /  -(3) : ((2 * c0_0) + 3 - 1) / 3))) as long : (((((256 * c0_0) + (-1 * tsteps)) + 1) * 256 < 0 ?  -( -((((256 * c0_0) + (-1 * tsteps)) + 1)) / 256) : (256 < 0 ? ( -((((256 * c0_0) + (-1 * tsteps)) + 1)) +  -(256) - 1) /  -(256) : ((((256 * c0_0) + (-1 * tsteps)) + 1) + 256 - 1) / 256))) as long),(((((n + (2 * tsteps)) + -3) * 256 < 0 ? (256 < 0 ?  -(( -(((n + (2 * tsteps)) + -3)) + 256 + 1) / 256) :  -(( -(((n + (2 * tsteps)) + -3)) + 256 - 1) / 256)) : ((n + (2 * tsteps)) + -3) / 256) < ((((64 * c0_0) + n) + 61) * 96 < 0 ? (96 < 0 ?  -(( -((((64 * c0_0) + n) + 61)) + 96 + 1) / 96) :  -(( -((((64 * c0_0) + n) + 61)) + 96 - 1) / 96)) : (((64 * c0_0) + n) + 61) / 96) ? ((((n + (2 * tsteps)) + -3) * 256 < 0 ? (256 < 0 ?  -(( -(((n + (2 * tsteps)) + -3)) + 256 + 1) / 256) :  -(( -(((n + (2 * tsteps)) + -3)) + 256 - 1) / 256)) : ((n + (2 * tsteps)) + -3) / 256)) as long : (((((64 * c0_0) + n) + 61) * 96 < 0 ? (96 < 0 ?  -(( -((((64 * c0_0) + n) + 61)) + 96 + 1) / 96) :  -(( -((((64 * c0_0) + n) + 61)) + 96 - 1) / 96)) : (((64 * c0_0) + n) + 61) / 96)) as long) < c0_0 ? (((((n + (2 * tsteps)) + -3) * 256 < 0 ? (256 < 0 ?  -(( -(((n + (2 * tsteps)) + -3)) + 256 + 1) / 256) :  -(( -(((n + (2 * tsteps)) + -3)) + 256 - 1) / 256)) : ((n + (2 * tsteps)) + -3) / 256) < ((((64 * c0_0) + n) + 61) * 96 < 0 ? (96 < 0 ?  -(( -((((64 * c0_0) + n) + 61)) + 96 + 1) / 96) :  -(( -((((64 * c0_0) + n) + 61)) + 96 - 1) / 96)) : (((64 * c0_0) + n) + 61) / 96) ? ((((n + (2 * tsteps)) + -3) * 256 < 0 ? (256 < 0 ?  -(( -(((n + (2 * tsteps)) + -3)) + 256 + 1) / 256) :  -(( -(((n + (2 * tsteps)) + -3)) + 256 - 1) / 256)) : ((n + (2 * tsteps)) + -3) / 256)) as long : (((((64 * c0_0) + n) + 61) * 96 < 0 ? (96 < 0 ?  -(( -((((64 * c0_0) + n) + 61)) + 96 + 1) / 96) :  -(( -((((64 * c0_0) + n) + 61)) + 96 - 1) / 96)) : (((64 * c0_0) + n) + 61) / 96)) as long)) as long : (c0_0) as long),(var c1 : long) => {
                        var c3 : long;
                        var c2 : long;
                        if ((c0_0 <= ((((96 * c1) + (-1 * n)) + 1) * 64 < 0 ? (64 < 0 ?  -(( -((((96 * c1) + (-1 * n)) + 1)) + 64 + 1) / 64) :  -(( -((((96 * c1) + (-1 * n)) + 1)) + 64 - 1) / 64)) : (((96 * c1) + (-1 * n)) + 1) / 64))) {
                            if ((((n + 1) % 2) == 0)) {
                                A((n + -2)) = B((n + -2));
                            }
                        }
                        for (c2 = (((((256 * c1) + (-1 * n)) + 2) * 2 < 0 ?  -( -((((256 * c1) + (-1 * n)) + 2)) / 2) : (2 < 0 ? ( -((((256 * c1) + (-1 * n)) + 2)) +  -(2) - 1) /  -(2) : ((((256 * c1) + (-1 * n)) + 2) + 2 - 1) / 2)) > ((256 * c0_0) + (-256 * c1)) ? (((((256 * c1) + (-1 * n)) + 2) * 2 < 0 ?  -( -((((256 * c1) + (-1 * n)) + 2)) / 2) : (2 < 0 ? ( -((((256 * c1) + (-1 * n)) + 2)) +  -(2) - 1) /  -(2) : ((((256 * c1) + (-1 * n)) + 2) + 2 - 1) / 2))) as long : (((256 * c0_0) + (-256 * c1))) as long); (c2 <= ((((16 * c1) + 14) < (tsteps + -1) ? (((16 * c1) + 14)) as long : ((tsteps + -1)) as long) < (((256 * c0_0) + (-256 * c1)) + 255) ? ((((16 * c1) + 14) < (tsteps + -1) ? (((16 * c1) + 14)) as long : ((tsteps + -1)) as long)) as long : ((((256 * c0_0) + (-256 * c1)) + 255)) as long)); c2++) {
                            if ((c1 <= (c2 * 16 < 0 ? (16 < 0 ?  -(( -(c2) + 16 + 1) / 16) :  -(( -(c2) + 16 - 1) / 16)) : c2 / 16))) {
                                B(1) = 0.33333 * (A(1 - 1L) + A(1) + A(1 + 1L));
                            }
                            for (c3 = ((256 * c1) > ((2 * c2) + 2) ? ((256 * c1)) as long : (((2 * c2) + 2)) as long); (c3 <= (((256 * c1) + 255) < (((2 * c2) + n) + -2) ? (((256 * c1) + 255)) as long : ((((2 * c2) + n) + -2)) as long)); c3++) {
                                B(((-2 * c2) + c3)) = 0.33333 * (A(((-2 * c2) + c3) - 1L) + A(((-2 * c2) + c3)) + A(((-2 * c2) + c3) + 1L));
                                A((((-2 * c2) + c3) + -1)) = B((((-2 * c2) + c3) + -1));
                            }
                            if ((c1 >= ((((2 * c2) + n) + -256) * 256 < 0 ?  -( -((((2 * c2) + n) + -256)) / 256) : (256 < 0 ? ( -((((2 * c2) + n) + -256)) +  -(256) - 1) /  -(256) : ((((2 * c2) + n) + -256) + 256 - 1) / 256)))) {
                                A((n + -2)) = B((n + -2));
                            }
                        }
                        if (((c0_0 >= (((3 * c1) + -1) * 2 < 0 ?  -( -(((3 * c1) + -1)) / 2) : (2 < 0 ? ( -(((3 * c1) + -1)) +  -(2) - 1) /  -(2) : (((3 * c1) + -1) + 2 - 1) / 2))) && (c1 <= ((tsteps + -16) * 16 < 0 ? (16 < 0 ?  -(( -((tsteps + -16)) + 16 + 1) / 16) :  -(( -((tsteps + -16)) + 16 - 1) / 16)) : (tsteps + -16) / 16)))) {
                            B(1) = 0.33333 * (A(1 - 1L) + A(1) + A(1 + 1L));
                        }
                    }
);
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
