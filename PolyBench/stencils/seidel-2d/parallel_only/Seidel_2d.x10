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
public class Seidel_2d {
  var _PB_N : Long;
  var _PB_TSTEPS : Long;

  def init_array (n : Long, A : Array_2[Double]) {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        A(i,j) = ((i as Double) * (j+2) + 2) / n;
      }
  }

  def print_array(n : Long, A : Array_2[Double]) {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf ", A(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }

    def kernel_seidel_2d(tsteps : long, n : long, A : Array_2[double])  {
        var c0 : long;
        var c2 : long;
        var c1 : long;
        if (((n >= 3) && (tsteps >= 1))) {
            for (c0 = 1; (c0 <= ((n + (2 * tsteps)) + -4)); c0++) {
                {
                    val c0_0 = c0;
                    Foreach.block((((c0_0 + 1) * 2 < 0 ?  -( -((c0_0 + 1)) / 2) : (2 < 0 ? ( -((c0_0 + 1)) +  -(2) - 1) /  -(2) : ((c0_0 + 1) + 2 - 1) / 2)) > ((c0_0 + (-1 * tsteps)) + 1) ? (((c0_0 + 1) * 2 < 0 ?  -( -((c0_0 + 1)) / 2) : (2 < 0 ? ( -((c0_0 + 1)) +  -(2) - 1) /  -(2) : ((c0_0 + 1) + 2 - 1) / 2))) as long : (((c0_0 + (-1 * tsteps)) + 1)) as long),((((c0_0 + n) + -2) * 2 < 0 ? (2 < 0 ?  -(( -(((c0_0 + n) + -2)) + 2 + 1) / 2) :  -(( -(((c0_0 + n) + -2)) + 2 - 1) / 2)) : ((c0_0 + n) + -2) / 2) < c0_0 ? ((((c0_0 + n) + -2) * 2 < 0 ? (2 < 0 ?  -(( -(((c0_0 + n) + -2)) + 2 + 1) / 2) :  -(( -(((c0_0 + n) + -2)) + 2 - 1) / 2)) : ((c0_0 + n) + -2) / 2)) as long : (c0_0) as long),(var c1 : long) => {
                        var c2 : long;
                        for (c2 = (c0_0 + 1); (c2 <= ((c0_0 + n) + -2)); c2++) {
                            A(((-1 * c0_0) + (2 * c1)),((-1 * c0_0) + c2)) = (A(((-1 * c0_0) + (2 * c1)) - 1L,((-1 * c0_0) + c2) - 1L) + A(((-1 * c0_0) + (2 * c1)) - 1L,((-1 * c0_0) + c2)) + A(((-1 * c0_0) + (2 * c1)) - 1L,((-1 * c0_0) + c2) + 1L) + A(((-1 * c0_0) + (2 * c1)),((-1 * c0_0) + c2) - 1L) + A(((-1 * c0_0) + (2 * c1)),((-1 * c0_0) + c2)) + A(((-1 * c0_0) + (2 * c1)),((-1 * c0_0) + c2) + 1L) + A(((-1 * c0_0) + (2 * c1)) + 1L,((-1 * c0_0) + c2) - 1L) + A(((-1 * c0_0) + (2 * c1)) + 1L,((-1 * c0_0) + c2)) + A(((-1 * c0_0) + (2 * c1)) + 1L,((-1 * c0_0) + c2) + 1L)) / 9.0;
                        }
                    }
);
                }
            }
        }
    }

  def setPBs(n : Long, tsteps : Long) {
    _PB_N = n;
    _PB_TSTEPS = tsteps;
  }

  public static def main(args : Rail[String]) {
    var N : Long = 0;
    var TSTEPS : Long = 0;

    @Ifdef("MINI_DATASET") {
        TSTEPS = 2;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        TSTEPS = 10;
        N = 500;
    }
    @Ifdef("STANDARD_DATASET") {
        TSTEPS = 20;
        N = 1000;
    }
    @Ifdef("LARGE_DATASET") {
        TSTEPS = 20;
        N = 2000;
    }
    @Ifdef("EXTRALARGE_DATASET") {
        TSTEPS = 100;
        N = 4000;
    }

    val seidel_2d = new Seidel_2d();

    var n : Long = N;
    var tsteps : Long = TSTEPS;
    seidel_2d.setPBs(n, tsteps);

    val A = new Array_2[Double](n,n);
    seidel_2d.init_array(n, A);

    val t1 = System.currentTimeMillis();

    seidel_2d.kernel_seidel_2d(tsteps, n, A);

    val t2 = System.currentTimeMillis();

    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)\n");
//     seidel_2d.print_array(n, A);
  }
}
