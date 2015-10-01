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
public class Durbin {

  var _PB_N : Long;  

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 y : Array_2[Double],
  		 sum : Array_2[Double],
  		 alpha : Rail[Double],
  		 beta : Rail[Double],
  		 r : Rail[Double])
  {
    for (var i : Long = 0; i < n; i++)
      {
        alpha(i) = i;
        beta(i) = (i+1)/n/2.0;
        r(i) = (i+1)/n/4.0;
        for (var j : Long = 0; j < n; j++) {
  	y(i,j) = ((i as Double) *j) / n;
  	sum(i,j) = ((i as Double) *j) / n;
        }
      }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 out : Rail[Double])
  
  {
    for (var i : Long = 0; i < n; i++) {
      Console.ERR.printf("%0.2lf ", out(i));
      if (i % 20 == 0) Console.ERR.printf("\n");
    }
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_durbin(n : long, y : Array_2[double], sum : Array_2[double], alpha : Rail[double], beta : Rail[double], r : Rail[double], out : Rail[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](0L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,0,2);
        var c1 : long;
        var c2 : long;
        y(0L,0L) = r(0L);
        beta(0L) = (1L) as double;
        alpha(0L) = r(0L);
        for (c1 = 1; (c1 <= (n + -1)); c1++) {
            sum(0L,c1) = r(c1);
        }
        for (c1 = 1; (c1 <= (n + -1)); c1++) {
            sum(0 + 1L,c1) = sum(0,c1) + r(c1 - 0 - 1L) * y(0,c1 - 1L);
            beta(c1) = beta(c1 - 1L) - alpha(c1 - 1L) * alpha(c1 - 1L) * beta(c1 - 1L);
            for (c2 = 1; (c2 <= (c1 + -1)); c2++) {
                sum(c2 + 1L,c1) = sum(c2,c1) + r(c1 - c2 - 1L) * y(c2,c1 - 1L);
            }
            alpha(c1) =  -(sum(c1,c1)) * beta(c1);
            y(c1,c1) = alpha(c1);
            for (c2 = c1; (c2 <= ((2 * c1) + -1)); c2++) {
                y(((-1 * c1) + c2),c1) = y(((-1 * c1) + c2),c1 - 1L) + alpha(c1) * y(c1 - ((-1 * c1) + c2) - 1L,c1 - 1L);
            }
        }
        for (c1 = 0; (c1 <= (n + -1)); c1++) {
            out(c1) = y(c1,n - 1L);
        }
    }  public static def main(args : Rail[String])
  {
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 100000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 4000;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        /*N = 8000;*/
        N = 14000;
    }
    
    val durbin = new Durbin();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    durbin.setPBs(n);
    /* Variable declaration/allocation. */
    val y = new Array_2[Double](n,n);

    val sum = new Array_2[Double](n,n);

    val alpha = new Rail[Double](n);

    val beta = new Rail[Double](n);

    val r = new Rail[Double](n);

    val out = new Rail[Double](n);  
    /* Initialize array(s). */
    durbin.init_array (n,
  	      y,
  	      sum,
  	      alpha,
  	      beta,
  	      r);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    durbin.kernel_durbin (n,
  		 y,
  		 sum,
  		 alpha,
  		 beta,
  		 r,
  		 out);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // durbin.print_array(n, out);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
