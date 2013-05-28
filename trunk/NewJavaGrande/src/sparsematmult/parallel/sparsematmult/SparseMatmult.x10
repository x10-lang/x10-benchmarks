/**************************************************************************
*                                                                         *
*         Java Grande Forum Benchmark Suite - Thread Version 1.0          *
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
*      This version copyright (c) The University of Edinburgh, 2001.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package sparsematmult.parallel.sparsematmult;

import jgfutil.*;

public class SparseMatmult {

	public static val ytotal: Cell[double] = new Cell[double](0.0 as double);

	/* 10 iterations used to make kernel have roughly
	   same granularity as other Scimark kernels. */
	public static def test(val y: DistArray[double], val vall: DistArray[double], val row: DistArray[int], val col: DistArray[int], val x: DistArray[double], val NUM_ITERATIONS: int, val numthreads: int, val lowsum: DistArray[int], val highsum: DistArray[int]): void = {
		val nz: int = vall.region.size();

		JGFInstrumentor.startTimer("Section2:SparseMatmult:Kernel");

		finish for ([id]: Point in 0..(numthreads-1)) async
				for ([reps]: Point in 0..(NUM_ITERATIONS-1)) 
					for ([i]: Point in Region.make(lowsum(id), highsum(id)-1)) 
						y(row(i)) += x(col(i))*vall(i);

		JGFInstrumentor.stopTimer("Section2:SparseMatmult:Kernel");
		for ([i]: Point in 0..(nz-1)) {
			ytotal.value += y(row(i));
		}
	}
}
