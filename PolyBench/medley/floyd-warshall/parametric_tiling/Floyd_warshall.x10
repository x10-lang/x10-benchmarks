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
public class Floyd_warshall {

  var _PB_N : Long;

  def setPBs(n : Long) {
    _PB_N = n; 
  }
  def init_array(n : Long,
  		 path : Array_2[Double])
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++)
        path(i,j) = (((i+1) as Double) *(j+1)) / n;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(n : Long,
  		 path : Array_2[Double])
  
  {
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < n; j++) {
        Console.ERR.printf("%0.2lf ", path(i,j));
        if ((i * n + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
    def kernel_floyd_warshall(n : long, path : Array_2[double])  {
        var ___pace_tile_sizes : Rail[long] = new Rail[Long](0L);
        Pace_tiling_api.PACETileSizeVectorInit(___pace_tile_sizes,0,2);
        var c1 : long;
        var c0 : long;
        var c2 : long;
        if ((n >= 1)) {
            for (c0 = 0; (c0 <= (n + -1)); c0++) {
                for (c1 = 0; (c1 <= (n + -1)); c1++) {
                    for (c2 = 0; (c2 <= (n + -1)); c2++) {
                        path(c1,c2) = (path(c1,c2) < path(c1,c0) + path(c0,c2) ? path(c1,c2) : path(c1,c0) + path(c0,c2));
                    }
                }
            }
        }
    }  public static def main(args : Rail[String])
  {
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        N = 1024;
    }
    @Ifdef("MINI_DATASET") {
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        N = 128;
    }
    @Ifdef("LARGE_DATASET") {
        N = 2000;
    }
    
    val floyd_warshall = new Floyd_warshall();
    /* Retrieve problem size. */
    var n  : Long= N;
  
    floyd_warshall.setPBs(n);
    /* Variable declaration/allocation. */
    val path = new Array_2[Double](n,n);  
    /* Initialize array(s). */
    floyd_warshall.init_array (n, path);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    floyd_warshall.kernel_floyd_warshall (n, path);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // floyd_warshall.print_array(n, path);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
