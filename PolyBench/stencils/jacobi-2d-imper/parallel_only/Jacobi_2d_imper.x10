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
public class Jacobi_2d_imper {

  var _PB_TSTEPS : Long;
  var _PB_N : Long;

  def setPBs(tsteps : Long, n : Long) {
    _PB_TSTEPS = tsteps; 
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 A : Array_2[Double],
  		 B : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        {
  	A(i,j) = ((i as Double)*(j+2) + 2) / n;
  	B(i,j) = ((i as Double)*(j+3) + 3) / n;
        }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 A : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf ", A(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_jacobi_2d_imper(tsteps : long, n : long, A : Array_2[double], B : Array_2[double])  {
        var c1 : long;
        var c0 : long;
        var c2 : long;
        if (((n >= 3) && (tsteps >= 1))) {
            for (c2 = 1; (c2 <= (n + -2)); c2++) {
                B(1,c2) = 0.2 * (A(1,c2) + A(1,c2 - 1L) + A(1,1L + c2) + A(1L + 1,c2) + A(1 - 1L,c2));
            }
            for (c0 = 2; (c0 <= ((n + (3 * tsteps)) + -5)); c0++) {
                if ((c0 <= ((3 * tsteps) + -2))) {
                    if (((((2 * c0) + 1) % 3) == 0)) {
                        for (c2 = (((2 * c0) + 1) * 3 < 0 ?  -( -(((2 * c0) + 1)) / 3) : (3 < 0 ? ( -(((2 * c0) + 1)) +  -(3) - 1) /  -(3) : (((2 * c0) + 1) + 3 - 1) / 3)); (c2 <= ((((2 * c0) + (3 * n)) + -8) * 3 < 0 ? (3 < 0 ?  -(( -((((2 * c0) + (3 * n)) + -8)) + 3 + 1) / 3) :  -(( -((((2 * c0) + (3 * n)) + -8)) + 3 - 1) / 3)) : (((2 * c0) + (3 * n)) + -8) / 3)); c2++) {
                            B(1,((((-2 * c0) + (3 * c2)) + 2) / 3)) = 0.2 * (A(1,((((-2 * c0) + (3 * c2)) + 2) / 3)) + A(1,((((-2 * c0) + (3 * c2)) + 2) / 3) - 1L) + A(1,1L + ((((-2 * c0) + (3 * c2)) + 2) / 3)) + A(1L + 1,((((-2 * c0) + (3 * c2)) + 2) / 3)) + A(1 - 1L,((((-2 * c0) + (3 * c2)) + 2) / 3)));
                        }
                    }
                }
                {
                    val c0_0 = c0;
                    Foreach.block(((((2 * c0_0) + 2) * 3 < 0 ?  -( -(((2 * c0_0) + 2)) / 3) : (3 < 0 ? ( -(((2 * c0_0) + 2)) +  -(3) - 1) /  -(3) : (((2 * c0_0) + 2) + 3 - 1) / 3)) > ((c0_0 + (-1 * tsteps)) + 1) ? ((((2 * c0_0) + 2) * 3 < 0 ?  -( -(((2 * c0_0) + 2)) / 3) : (3 < 0 ? ( -(((2 * c0_0) + 2)) +  -(3) - 1) /  -(3) : (((2 * c0_0) + 2) + 3 - 1) / 3))) as long : (((c0_0 + (-1 * tsteps)) + 1)) as long),(((((2 * c0_0) + n) + -2) * 3 < 0 ? (3 < 0 ?  -(( -((((2 * c0_0) + n) + -2)) + 3 + 1) / 3) :  -(( -((((2 * c0_0) + n) + -2)) + 3 - 1) / 3)) : (((2 * c0_0) + n) + -2) / 3) < c0_0 ? (((((2 * c0_0) + n) + -2) * 3 < 0 ? (3 < 0 ?  -(( -((((2 * c0_0) + n) + -2)) + 3 + 1) / 3) :  -(( -((((2 * c0_0) + n) + -2)) + 3 - 1) / 3)) : (((2 * c0_0) + n) + -2) / 3)) as long : (c0_0) as long),(var c1 : long) => {
                        var c2 : long;
                        B(((-2 * c0_0) + (3 * c1)),1) = 0.2 * (A(((-2 * c0_0) + (3 * c1)),1) + A(((-2 * c0_0) + (3 * c1)),1 - 1L) + A(((-2 * c0_0) + (3 * c1)),1L + 1) + A(1L + ((-2 * c0_0) + (3 * c1)),1) + A(((-2 * c0_0) + (3 * c1)) - 1L,1));
                        for (c2 = (((2 * c0_0) + (-2 * c1)) + 2); (c2 <= ((((2 * c0_0) + (-2 * c1)) + n) + -2)); c2++) {
                            A((((-2 * c0_0) + (3 * c1)) + -1),((((-2 * c0_0) + (2 * c1)) + c2) + -1)) = B((((-2 * c0_0) + (3 * c1)) + -1),((((-2 * c0_0) + (2 * c1)) + c2) + -1));
                            B(((-2 * c0_0) + (3 * c1)),(((-2 * c0_0) + (2 * c1)) + c2)) = 0.2 * (A(((-2 * c0_0) + (3 * c1)),(((-2 * c0_0) + (2 * c1)) + c2)) + A(((-2 * c0_0) + (3 * c1)),(((-2 * c0_0) + (2 * c1)) + c2) - 1L) + A(((-2 * c0_0) + (3 * c1)),1L + (((-2 * c0_0) + (2 * c1)) + c2)) + A(1L + ((-2 * c0_0) + (3 * c1)),(((-2 * c0_0) + (2 * c1)) + c2)) + A(((-2 * c0_0) + (3 * c1)) - 1L,(((-2 * c0_0) + (2 * c1)) + c2)));
                        }
                        A((((-2 * c0_0) + (3 * c1)) + -1),(n + -2)) = B((((-2 * c0_0) + (3 * c1)) + -1),(n + -2));
                    }
);
                }
                if ((c0 >= (n + -1))) {
                    if ((((((2 * c0) + n) + 2) % 3) == 0)) {
                        for (c2 = ((((2 * c0) + (-2 * n)) + 8) * 3 < 0 ?  -( -((((2 * c0) + (-2 * n)) + 8)) / 3) : (3 < 0 ? ( -((((2 * c0) + (-2 * n)) + 8)) +  -(3) - 1) /  -(3) : ((((2 * c0) + (-2 * n)) + 8) + 3 - 1) / 3)); (c2 <= ((((2 * c0) + n) + -1) * 3 < 0 ? (3 < 0 ?  -(( -((((2 * c0) + n) + -1)) + 3 + 1) / 3) :  -(( -((((2 * c0) + n) + -1)) + 3 - 1) / 3)) : (((2 * c0) + n) + -1) / 3)); c2++) {
                            A((n + -2),(((((-2 * c0) + (3 * c2)) + (2 * n)) + -5) / 3)) = B((n + -2),(((((-2 * c0) + (3 * c2)) + (2 * n)) + -5) / 3));
                        }
                    }
                }
            }
            for (c2 = (2 * tsteps); (c2 <= ((n + (2 * tsteps)) + -3)); c2++) {
                A((n + -2),((c2 + (-2 * tsteps)) + 1)) = B((n + -2),((c2 + (-2 * tsteps)) + 1));
            }
        }
    }  public static def main(args : Rail[String])
  {
    var TSTEPS : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        TSTEPS = 100;
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        TSTEPS = 20;
        N = 1000;
    }
    @Ifdef("MINI_DATASET") {
        TSTEPS = 2;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        TSTEPS = 10;
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        TSTEPS = 200;
        N = 2000;
    }
    
    val jacobi_2d_imper = new Jacobi_2d_imper();
    /* Retrieve problem size. */
    var n  : Long= N;
    var tsteps  : Long= TSTEPS;
  
    jacobi_2d_imper.setPBs(tsteps, n);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](n,n);

    val B = new Array_2[Double](n,n);  
    /* Initialize array(s). */
    jacobi_2d_imper.init_array (n, A, B);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    jacobi_2d_imper.kernel_jacobi_2d_imper (tsteps, n, A, B);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // jacobi_2d_imper.print_array(n, A);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
