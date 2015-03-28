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
*                                                                         *
*      This version copyright (c) The University of Edinburgh, 2001.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package sparsematmult.parallel.sparsematmult;

import jgfutil.*;
import x10.util.*;

public class JGFSparseMatmultBench extends SparseMatmult implements JGFSection2 {

	public var nthreads: int;

	private var size: int;
	private static val RANDOM_SEED: long = 10101010;

	// reduced data sizes for test suite
	//private static final int[] datasizes_M = { 50000, 100000, 500000 };
	private static val datasizes_M: Array[int] = [ 100, 100000, 500000 ];
	//private static final int[] datasizes_N = { 50000, 100000, 500000 };
	private static val datasizes_N: Array[int] = [ 100, 100000, 500000 ];
	//private static final int[] datasizes_nz = { 250000, 500000, 2500000 };
	private static val datasizes_nz: Array[int] = [ 500, 500000, 2500000 ];
	private static val SPARSE_NUM_ITER: int = 200;

	val R: Random = new Random(RANDOM_SEED);

	var x: DistArray[double];
	var vall: DistArray[double];
	var col: DistArray[int];
	var row: DistArray[int];
	var lowsum: DistArray[int];
	var highsum: DistArray[int];

	var y: DistArray[double];

	public def this(): JGFSparseMatmultBench {
		this.nthreads = Place.MAX_PLACES;
	}

	public def JGFsetsize(var size: int): void {
		this.size = size;
	}

	public def JGFinitialise(): void {
		val ds_N: int = datasizes_N(size);
		val ds_M: int = datasizes_M(size);
		val ds_nz: int = datasizes_nz(size);
		val r_nz: Region = 0..(ds_nz-1);
		val r_nthreads: Region = 0..(nthreads-1);
		//	final dist d_M = distmakeBlock([0 : ds_M-1), place.places);
		val d_M: Dist = Dist.makeConstant(0..(ds_M-1), here);

		val xin: Array[double] = init(new Array[double](ds_N), R);
		x = DistArray.make[double](Dist.makeConstant(0..(xin.size-1), here), ([i]: Point): double => { return xin(i); });
		//x = doubleArray.factory.doubleValueArray(xin); // value array.
		y = DistArray.make[double](d_M);      // distributed -- cvp

		var ilow: Array[int] = new Array[int](nthreads);
		var iup: Array[int] = new Array[int](nthreads);
		var sum: Array[int] = new Array[int](nthreads+1);
		val rowt: Array[int] = new Array[int](ds_nz);
		val colt: Array[int] = new Array[int](ds_nz);
		val valt: Array[double] = new Array[double](ds_nz);
		var sect: int = (ds_M + nthreads-1)/nthreads;

		var rowin: Array[int] = new Array[int](ds_nz);
		var colin: Array[int] = new Array[int](ds_nz);
		var valin: Array[double] = new Array[double](ds_nz);
		val lowsumin: Array[int] = new Array[int](nthreads);
		val highsumin: Array[int] = new Array[int](nthreads);

		for ([i]: Point in 0..(ds_nz-1)) {
			rowin(i) = Math.abs(R.nextInt()) % ds_M;
			colin(i) = Math.abs(R.nextInt()) % ds_N;
			valin(i) = R.nextDouble();
		}

		// reorder arrays for parallel decomposition

		for ([i]: Point in r_nthreads) {
			ilow(i) = i*sect;
			iup(i) = ((i+1)*sect)-1;
			if (iup(i) > ds_M) iup(i) = ds_M;
		}

		for ([i]: Point in r_nz) 
			for ([j]: Point in r_nthreads) 
				if ((rowin(i) >= ilow(j)) && (rowin(i) <= iup(j)))
					sum(j+1)++;

		for ([j]: Point in r_nthreads) 
			for ([i]: Point in 0..j) {
				lowsumin(j) +=  sum(j-i);
				highsumin(j) +=  sum(j-i);
			}

		for ([i]: Point in r_nz) 
			for ([j]: Point in r_nthreads) 
				if ((rowin(i) >= ilow(j)) && (rowin(i) <= iup(j))) {
					rowt(highsumin(j)) = rowin(i);
					colt(highsumin(j)) = colin(i);
					valt(highsumin(j)) = valin(i);
					highsumin(j)++;
				}

		row = DistArray.make[int](Dist.makeConstant(0..(rowt.size-1), here), ([i]: Point): int => { return rowt(i); });
		col = DistArray.make[int](Dist.makeConstant(0..(colt.size-1), here), ([i]: Point): int => { return colt(i); });
		vall = DistArray.make[double](0..(valt.size-1)->here, ([i]: Point): double => { return valt(i); });
		lowsum = DistArray.make[int](Dist.makeConstant(0..(lowsumin.size-1), here), ([i]: Point): int => { return lowsumin(i); });
		highsum = DistArray.make[int](Dist.makeConstant(0..(highsumin.size-1), here), ([i]: Point): int => { return highsumin(i); });
		//row = intArray.factory.intValueArray(rowt);
		//col = intArray.factory.intValueArray(colt);
		//val = doubleArray.factory.doubleValueArray(valt);
		//lowsum = intArray.factory.intValueArray(lowsumin);
		//highsum = intArray.factory.intValueArray(highsumin);
	}

	public def JGFkernel(): void {
		SparseMatmult.test(y, vall, row, col, x, SPARSE_NUM_ITER, nthreads, lowsum, highsum);
	}

	public def JGFvalidate(): void {
		//double refval[] = { 75.02484945753453, 150.0130719633895, 749.5245870753752 };
		var refval: Array[double] = [ 0.1436496372119012, 150.0130719633895, 749.5245870753752 ];
		var dev: double = Math.abs(ytotal.value - refval(size));
		if (dev > 1.0e-10) {
			Console.OUT.println("Validation failed");
			Console.OUT.println("ytotal = " + ytotal.value + "  " + dev + "  " + size);
			throw new Error("Validation failed");
		}
	}

	public def JGFtidyup(): void {
		//System.gc();
	}

	public def JGFrun(var size: int): void {
		JGFInstrumentor.addTimer("Section2:SparseMatmult:Kernel", "Iterations", size);

		JGFsetsize(size);
		JGFinitialise();
		JGFkernel();
		JGFvalidate();
		JGFtidyup();

		JGFInstrumentor.addOpsToTimer("Section2:SparseMatmult:Kernel", (SPARSE_NUM_ITER) as double);

		JGFInstrumentor.printTimer("Section2:SparseMatmult:Kernel");
	}

	private static def init(var a: Array[double], var R: Random): Array[double] {
		for ([i]: Point in 0..(a.size-1)) 
			a(i) = R.nextDouble() * 1e-6;
		return a;
	}
}
