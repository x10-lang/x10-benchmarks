/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */

import harness.x10Test;
import x10.util.*;
import x10.array.*;
import x10.util.concurrent.*;
//import x10.io.*;
/**
 * Version of the JGF SparseMatmult benchmark with
 * mostly values and no async operations (differs in
 * terms of how data is distributed from JGF).
 *
 * This version also uses the Random number generator
 * differently and does not iterate, hence the different
 * final result.
 *
 * @author Christian Grothoff
 */
public class SparseMatmultAllValuesClean extends x10Test {

	static val RANDOM_SEED: long = 10101010;
	static val size: int = 0;
	static val datasizes_M <: Array[int](1) = [ 500, 100000, 500000 ];
	static val datasizes_N <: Array[int](1) = [ 500, 100000, 500000 ];
	static val datasizes_nz <: Array[int](1) = [ 2500, 500000, 2500000 ];
	static val R: Random = new Random(RANDOM_SEED);

	public def this(): SparseMatmultAllValuesClean = { }

	public static def main(var args: Rail[String]): void = {
		new SparseMatmultAllValuesClean().execute();
	}

	var pos: int; // X10 hack (local variable of run that must be modified in inner class)

	public def run(): boolean = {
		val nthreads: int = Place.MAX_PLACES;
		val d_places: Dist = Dist.makeUnique(PlaceGroup.WORLD);
		val r_N: Region = 0..datasizes_N(size-1);
		val r_M: Region = 0..datasizes_M(size-1);
		val r_nz: Region(1) = 0..datasizes_nz(size-1);
		val r_nthreads: Region(1) = 0..nthreads-1;
		val d_N: Dist = Dist.makeBlock(r_N, 0, PlaceGroup.WORLD);
		val d_M: Dist = Dist.makeBlock(r_M, 0, PlaceGroup.WORLD);
		val d_nz: Dist = Dist.makeBlock(r_nz, 0, PlaceGroup.WORLD);
		val d_nthreads: Dist = Dist.makeUnique(PlaceGroup.WORLD);

		val temp1 = Dist.makeConstant(r_nz, here);
		val temp2 = ([i]: Point(1)): int => {
			return Math.abs(R.nextInt()) % datasizes_M(size);
		};

		val row: DistArray[int] = DistArray.make[int](temp1, temp2);
		

		val col: DistArray[int] = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {
			return Math.abs(R.nextInt()) % datasizes_N(size);
		});

		// val is the representation of the sparse MxN matrix;
		// val[i,j] corresponds to matrix[row[i],col[j]]
		val vall: DistArray[double] = DistArray.make[double](Dist.makeConstant(r_nz, here), ([i]: Point): double => {
			return R.nextDouble();
		});

		// reorder arrays for parallel decomposition
		// reorders the matrix to group entries that will
		// be processed at the same place.

		val rowt: DistArray[int] = DistArray.make[int](Dist.makeConstant(r_nz, here));
		val colt: DistArray[int] = DistArray.make[int](Dist.makeConstant(r_nz, here));
		val valt: DistArray[double] = DistArray.make[double](Dist.makeConstant(r_nz, here));

		pos = 0;
		val workranges: DistArray[Region] = DistArray.make[Region](Dist.makeConstant(r_nthreads, here), ([j]: Point): Region => {
			var yrange: Region = (d_M | d_places(j)).region;
			var low: int = pos;
			var high: int = low-1;
			for (var i: int = 0; i < datasizes_nz(size); i++) {
				if (! yrange.contains(Point.make(row(i))))
					continue;
				high++;
				rowt(high) = row(i);
				colt(high) = col(i);
				valt(high) = vall(i);
			}
			pos = high + 1;
			return low..high;
		});
		//assert (pos == datasizes_nz[size]);

		if (pos != datasizes_nz(size)) throw new Error();

		// convert to values
		val Vrow: DistArray[int] = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {
			return rowt(i);
		});
		val Vcol: DistArray[int] = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {
			return colt(i);
		});
		val Vval: DistArray[double] = DistArray.make[double](Dist.makeConstant(r_nz, here), ([i]: Point): double => {
			return valt(i);
		});

		// "x" value with which matrix is going to be multiplied
		val x = RandomVector(d_N);

		// "y" is the vector with which is supposed to become y : = mat(val) * x
		val y: DistArray[double] = DistArray.make[double](d_M);

		// do parallel multiplication
		finish ateach ([i] in d_places) mul(Vval, x, y, Vrow, Vcol, workranges(i));

		// validate
		var ytotal: double = 0.0;
		for ([p]: Point in y.region) ytotal += Future.make(() => at (y.dist(p)) y(p)).force();

		var refval: Array[double](1) = [ 6.195840478801247E-4, 0.1249404059302216, 0.0 ];
		var dev: double = Math.abs(ytotal - refval(size));
		if (dev > 1.0e-10) {
			Console.OUT.println("Validation failed");
			Console.OUT.println("ytotal = " + ytotal + "  " + dev + "  " + size);
			throw new Error("Validation failed");
		} else {
			Console.OUT.println("Validation succeeded");
		}
		return true;
	}

	private static def mul(var vall: DistArray[double], var x: DistArray[double], var yt: DistArray[double], var row: DistArray[int], var col: DistArray[int], var sumrange: Region): void = {
		for ([i]: Point in sumrange) {
			val rowi: int = row(i);
			yt(rowi) = yt(rowi) + x(col(i)) * vall(i);
		}
	}

	// trivial helper
	private static def RandomVector(var d: Dist(1)): DistArray[double] = {
		return DistArray.make[double](d, ([i]: Point): double => {
			return R.nextDouble() * 1e-6;
		});
	}
}

