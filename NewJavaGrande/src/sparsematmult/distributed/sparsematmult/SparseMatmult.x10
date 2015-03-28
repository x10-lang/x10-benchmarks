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
package sparsematmult.distributed.sparsematmult;

import x10.util.concurrent.*;
import jgfutil.*;

public class SparseMatmult {

	// final checksum -- cvp
	public static val ytotal: Cell[double] = new Cell[double]( 0.0 as double);

	/* 10 iterations used to make kernel have roughly
	   same granulairty as other Scimark kernels. */
	public static def test(val y: DistArray[double], val vall: DistArray[double], val row: DistArray[int], val col: DistArray[int], val x: DistArray[double], val NUM_ITERATIONS: int, val lowsum: DistArray[int], val highsum: DistArray[int]): void {
		val nz: int = vall.region.size();

		JGFInstrumentor.startTimer("Section2:SparseMatmult:Kernel");

		finish for ([id]: Point in Dist.makeUnique(PlaceGroup.WORLD)) async
			for ([reps]: Point in 0..(NUM_ITERATIONS-1)) 
				for ([i]: Point in Region.make(lowsum(id), highsum(id)-1)) 
					finish async at (y.dist(row(i))) { y(row(i)) += x(col(i))*vall(i); }

		JGFInstrumentor.stopTimer("Section2:SparseMatmult:Kernel");
		for ([i]: Point in 0..(nz-1)) {
			//Future.make(() => at (rowt.dist(i)) rowt(i_final)).force();
			ytotal.value += Future.make(() => at (y.dist(row(i))) y(row(i)) ).force();
		}
	}
}
