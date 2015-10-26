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
public class Correlation {

  var _PB_M : Long;
  var _PB_N : Long;  

  def setPBs(m : Long, n : Long) {
    _PB_M = m; 
    _PB_N = n; 
  }
  def init_array(m : Long,
  		 n : Long,
  		 float_n : Rail[Double],
  		 data : Array_2[Double])
  {
    float_n(0) = 1.2;
  
    for (var i : Long = 0; i < m; i++)
      for (var j : Long = 0; j < n; j++)
        data(i,j) = ((i as Double) *j) / m;
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to check the correctness of the output. */
  def print_array(m : Long,
  		 symmat : Array_2[Double])
  
  {
    var i : Long;
var  j : Long;
  
    for (i = 0; i < m; i++)
      for (j = 0; j < m; j++) {
        Console.ERR.printf("%0.2lf", symmat(i,j));
        if ((i * m + j) % 20 == 0) Console.ERR.printf("\n");
      }
    Console.ERR.printf("\n");
  }

  def sqrt_of_array_cell(x : Rail[Double], j : Long)
  {
    return Math.sqrt(x(j));
  }
  
  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_correlation(m : Long,
  n : Long,
  			float_n : Double,
  			data : Array_2[Double],
  			symmat : Array_2[Double],
  			mean : Rail[Double],
  			stddev : Rail[Double])
  {
    var eps  : Double= 0.1f;
  
  // #pragma scop
    /* Determine mean of column vectors of input data matrix */
    for (var j : Long = 0; j < m; j++)
      {
        mean(j) = 0.0;
        for (var i : Long = 0; i < n; i++)
  	         mean(j) += data(i,j);
        mean(j) /= float_n;
      }
  
    /* Determine standard deviations of column vectors of data matrix. */
    for (var j : Long = 0; j < m; j++)
      {
        stddev(j) = 0.0;
        for (var i : Long = 0; i < n; i++)
  	         stddev(j) += (data(i,j) - mean(j)) * (data(i,j) - mean(j));
        stddev(j) /= float_n;
        stddev(j) = sqrt_of_array_cell(stddev, j);
        /* The following in an inelegant but usual way to handle
  	 near-zero std. dev. values, which below would cause a zero-
  	 divide. */
        stddev(j) = stddev(j) <= eps ? 1.0 : stddev(j);
      }
  
    /* Center and reduce the column vectors. */
    for (var i : Long = 0; i < n; i++)
      for (var j : Long = 0; j < m; j++)
        {
  	data(i,j) -= mean(j);
  	data(i,j) /= Math.sqrt(float_n) * stddev(j);
        }
  
    /* Calculate the m * m correlation matrix. */
    for (var j1 : Long = 0; j1 < m-1; j1++)
      {
        symmat(j1,j1) = 1.0;
        for (var j2 : Long = j1+1; j2 < m; j2++)
  	{
  	  symmat(j1,j2) = 0.0;
  	  for (var i : Long = 0; i < n; i++)
  	    symmat(j1,j2) += (data(i,j1) * data(i,j2));
  	  symmat(j2,j1) = symmat(j1,j2);
  	}
      }
    symmat(m-1,m-1) = 1.0;
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var M : Long = 0;
    var N : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        M = 4000;
        N = 4000;
    }
    @Ifdef("STANDARD_DATASET") {
        M = 1000;
        N = 1000;
    }
    @Ifdef("MINI_DATASET") {
        M = 32;
        N = 32;
    }
    @Ifdef("SMALL_DATASET") {
        M = 500;
        N = 500;
    }
    @Ifdef("LARGE_DATASET") {
        M = 4000;
        N = 4000;
    }
    
    val correlation = new Correlation();
    /* Retrieve problem size. */
    var n  : Long= N;
    var m  : Long= M;
  
    correlation.setPBs(m, n);
    /* Variable declaration/allocation. */
    val float_n = new Rail[Double](1);
    val data = new Array_2[Double](m,n);

    val symmat = new Array_2[Double](m,m);

    val mean = new Rail[Double](m);

    val stddev = new Rail[Double](m);    /* Initialize array(s). */
    correlation.init_array (m, n, float_n, data);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    correlation.kernel_correlation (m, n, float_n(0),
  		      data,
  		      symmat,
  		      mean,
  		      stddev);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // correlation.print_array(m, symmat);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
}
