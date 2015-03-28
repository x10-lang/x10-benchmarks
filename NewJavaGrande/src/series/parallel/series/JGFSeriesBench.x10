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
*                                                                         *
*      This version copyright (c) The University of Edinburgh, 1999.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package series.parallel.series;

import jgfutil.*;

public class JGFSeriesBench extends SeriesTest implements JGFSection2 {

	private var size: int;

	public def JGFsetsize(var size: int): void {
		this.size = size;
	}

	public def JGFinitialise(): void {
		switch (size) {
			case 0: array_rows = 10000; break;
			case 1: array_rows = 100000; break;
			case 2: array_rows = 1000000; break;
			default: throw new Error();
		}
		buildTestData();
	}

	public def JGFkernel(): void {
		Do();
	}

	public def JGFvalidate(): void {
		var ref: Array[Array[double]] = [ [ 2.8729524964837996, 0.0 ] as Array[Double],
						   [ 1.1161046676147888, -1.8819691893398025 ] ,
						   [ 0.34429060398168704, -1.1645642623320958 ] ,
						   [ 0.15238898702519288, -0.8143461113044298 ] ];
		
		for (var i: int = 0; i < 4; i++) {
			for (var j: int = 0; j < 2; j++) {
				var error: double = Math.abs(testArray(j, i) - ref(i)(j));
				if (error > 1.0e-12) {
					Console.OUT.println("Validation failed for coefficient " + j + "," + i);
					Console.OUT.println("Computed value = " + testArray(j, i));
					Console.OUT.println("Reference value = " + ref(i)(j));
					throw new Error("Validation failed");
				}
			}
		}
	}

	public def JGFtidyup(): void {
		freeTestData();
	}

	public def JGFrun(var size: int): void {
		JGFInstrumentor.addTimer("Section2:Series:Kernel", "coefficients", size);
		JGFsetsize(size);
		JGFinitialise();
		JGFkernel();
		JGFvalidate();
		JGFtidyup();

		JGFInstrumentor.addOpsToTimer("Section2:Series:Kernel", (array_rows * 2 - 1) as double);

		JGFInstrumentor.printTimer("Section2:Series:Kernel");
	}
}
