/**************************************************************************
*                                                                         *
*             Java Grande Forum Benchmark Suite - Version 2.0             *
*                                                                         *
*                            produced by                                  *
*                                                                         *
*                  Java Grande Benchmarking Project                       *
*                                                                         *
*                                at                                       *
*                                                                         *
*                Edinburgh Parallel Computing Centre                      *
*                                                                         *
*                email: epcc-javagrande@epcc.ed.ac.uk                     *
*                                                                         *
*      adapted from SciMark 2.0, author Roldan Pozo (pozo@cam.nist.gov)   *
*                                                                         *
*      This version copyright (c) The University of Edinburgh, 1999.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package sparsematmult.serial.sparsematmult;

import jgfutil.*;

public class SparseMatmult {

	public static val ytotal: Double = 0.0 as double;

	/* 10 iterations used to make kernel have roughly
	   same granulairty as other Scimark kernels. */
	public static def test(var y: Array[double], var vall: Array[double], var row: Array[int], var col: Array[int], var x: Array[double], var NUM_ITERATIONS: int): void = {
		val nz: int = vall.size;

		JGFInstrumentor.startTimer("Section2:SparseMatmult:Kernel");

		for (var reps: int = 0; reps<NUM_ITERATIONS; reps++)
		{
			for (var i: int = 0; i<nz; i++)
			{
				y(row(i)) += x(col(i)) * vall(i);
			}
		}

		JGFInstrumentor.stopTimer("Section2:SparseMatmult:Kernel");

		for ([i]: Point in 0..(nz-1)) {
			ytotal += y(row(i));
		}
	}
}
