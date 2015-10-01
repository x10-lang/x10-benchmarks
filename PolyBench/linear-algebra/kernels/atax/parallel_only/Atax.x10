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
public class Atax {

  var _PB_NX : Long;
  var _PB_NY : Long;  

  def setPBs(nx : Long, ny : Long) {
    _PB_NX = nx; 
    _PB_NY = ny; 
  }
  def init_array(nx : Long,
  ny : Long,
  		 A : Array_2[Double],
  		 x : Rail[Double])
  {
    for (var i : Long = 0; i < ny; i++)
        x(i) = i * Math.PI;
    for (var i : Long = 0; i < nx; i++)
      for (var j : Long = 0; j < ny; j++)
        A(i,j) = ((i as Double)*(j+1)) / nx;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(nx : Long,
  		 y : Rail[Double])
  
  {
    for (var i : Long = 0; i < nx; i++) {
      Console.ERR.printf("%0.2lf ", y(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_atax(nx : long, ny : long, A : Array_2[double], x : Rail[double], y : Rail[double], tmp : Rail[double])  {
        var c1 : long;
        var c2 : long;
        {
            Foreach.block(0,(nx + -1),(var c1 : long) => {
                var c2 : long;
                tmp(c1) = (0L) as double;
            }
);
        }
        if ((ny >= 1)) {
            {
                Foreach.block(0,(nx + -1),(var c1 : long) => {
                    var c2 : long;
                    for (c2 = 0; (c2 <= (ny + -1)); c2++) {
                        tmp(c1) = tmp(c1) + A(c1,c2) * x(c2);
                    }
                }
);
            }
        }
        {
            Foreach.block(0,(ny + -1),(var c1 : long) => {
                var c2 : long;
                y(c1) = (0L) as double;
            }
);
        }
        if ((nx >= 1)) {
            {
                Foreach.block(0,(ny + -1),(var c1 : long) => {
                    var c2 : long;
                    for (c2 = 0; (c2 <= (nx + -1)); c2++) {
                        y(c1) = y(c1) + A(c2,c1) * tmp(c2);
                    }
                }
);
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
    
    val atax = new Atax();
    /* Retrieve problem size. */
    var nx  : Long= NX;
    var ny  : Long= NY;
  
    atax.setPBs(nx, ny);
    /* Variable declaration/allocation. */
    val A = new Array_2[Double](nx,ny);

    val x = new Rail[Double](ny);

    val y = new Rail[Double](ny);

    val tmp = new Rail[Double](nx);    /* Initialize array(s). */
    atax.init_array (nx, ny, A, x);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    atax.kernel_atax (nx, ny,
  	       A,
  	       x,
  	       y,
  	       tmp);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // atax.print_array(nx, y);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
