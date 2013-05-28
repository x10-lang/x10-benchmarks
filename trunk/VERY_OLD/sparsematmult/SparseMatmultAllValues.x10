/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
import harness.*;
import x10.util.* ;
import x10.lang.* ;
import x10.util.concurrent.*;

/**
 * Version of the JGF SparseMatmult benchmark with
 * mostly values and no async operations (differs in
 * terms of how data is distributed from JGF).
 *
 * @author Christian Grothoff
 */
public class SparseMatmultAllValues extends x10Test {

	// DRIVER
	static val RANDOM_SEED: long = 10101010;
	static val size: int = 1;
	static val datasizes_M: Array[int](1) = [ 500, 100000, 500000 ];		// create 3 arrays with some values
	static val datasizes_N: Array[int](1) = [ 500, 100000, 500000 ];
	static val datasizes_nz: Array[int](1) = [ 2500, 500000, 2500000 ];
	static val SPARSE_NUM_ITER: int = 200;
	static val R: Random = new Random(RANDOM_SEED);

	public static def main(Array[String]) {
		Console.OUT.println( "start" ) ;
		new SparseMatmultAllValues().execute();
		Console.OUT.println( "end" ) ;
	}

	public def this(): SparseMatmultAllValues = { }

	var pos: int; // hack

	public def run(): boolean = {
		Console.OUT.println( "start run" ) ;
		val nthreads: int = Place.MAX_PLACES;
		val d_places: Dist = Dist.makeUnique(PlaceGroup.WORLD);
		Console.OUT.println( "1.1" ) ;
		val r_N: Region = 0..datasizes_N(size);//-1);
		Console.OUT.println( "1.1.1" ) ;
		val r_M: Region = 0..datasizes_M(size);//-1);
		Console.OUT.println( "1.2" ) ;
		val r_nz = 0..datasizes_nz(size);//-1);
		val r_nthreads = 0..nthreads-1;
		Console.OUT.println( "1.3" ) ;
		val d_N: Dist = Dist.makeBlock(r_N, 0, PlaceGroup.WORLD);
		val d_M: Dist = Dist.makeBlock(r_M, 0, PlaceGroup.WORLD);
		Console.OUT.println( "1.4" ) ;
		val d_nz: Dist = Dist.makeBlock(r_nz, 0, PlaceGroup.WORLD);
		val d_nthreads: Dist = Dist.makeUnique(PlaceGroup.WORLD);
		
		Console.OUT.println( "1.5" ) ;
		
		val row = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {return 0;});
		val col = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {return 0;});
		
		// val is the representation of the sparse MxN matrix;
		// val[i,j] corresponds to matrix[row[i],col[j]]
		val vall = DistArray.make[double](Dist.makeConstant(r_nz, here), ([i]: Point): double => {return 0.0;});

		Console.OUT.println( "2" ) ;
		
		// yucky original initialization code (also partially wrong -- % ds_M vs % ds_N for col!)

		// I would init and define x much later (but we must do it in order
		// given by JGF)
		// "x" value with which matrix is going to be multiplied
		val x = RandomVector(d_N);

		Console.OUT.println( "2.1" ) ;
		
		for (var i: int = 0; i < datasizes_nz(size); i++) {
			//Console.OUT.println( "2.1." + i + ":" + datasizes_nz(size) ) ;
			val ds_M: int = datasizes_M(size);
			//Console.OUT.println( "2.2." + i + ":" + ds_M ) ;
			val random_1: int = R.nextInt();	// generate random row index (0, M-1)
			val random_2: int = R.nextInt(); // generate random column index (0, N-1)
			val random_3: double = R.nextDouble();
			//Console.OUT.println( "2.3." + i ) ;
			val i_final: int = i;
			//Console.OUT.println( "2.4." + i + ":" + row ) ;
			row(i_final) = Math.abs(random_1) % ds_M;
			//Console.OUT.println( "2.5." + i + ":" + col ) ;
			col(i_final) = Math.abs(random_2) % ds_M;
			//Console.OUT.println( "2.6." + i + ":" + vall ) ;
			vall(i_final) = random_3;
			//Console.OUT.println( "2.7." + i ) ;
		}
		Console.OUT.println( "3" ) ;

		// reorder arrays for parallel decomposition
		// reorders the matrix to group entries that will
		// be processed at the same place.

		val rowt = DistArray.make[int](Dist.makeConstant(r_nz, here));
		val colt = DistArray.make[int](Dist.makeConstant(r_nz, here));
		val valt = DistArray.make[double](Dist.makeConstant(r_nz, here));

		Console.OUT.println( "4" ) ;
		
		pos = 0;
		val workranges = DistArray.make[Region](Dist.makeConstant(r_nthreads, here), ([j]: Point): Region => {
			Console.OUT.println( "4.1" + ":" + d_M ) ;
			Console.OUT.println( "4.1" + ":" + j ) ;
			Console.OUT.println( "4.1" + ":" + d_places(j) ) ; // crashes because j is -1
			Console.OUT.println( "4.1" + ":" + (d_M | d_places(j)) ) ;
			var yrange: Region = (d_M | d_places(j)).region;
			Console.OUT.println( "4.2" ) ;
			var low: int = pos;
			Console.OUT.println( "4.3" ) ;
			var high: int = low-1;
			Console.OUT.println( "4.4" ) ;
			for (var i: int = 0; i < datasizes_nz(size); i++) {
				Console.OUT.println( "4.5" ) ;
				if (! yrange.contains(/*point.factory.point(*/row(i)))
					continue;
				Console.OUT.println( "4.6" ) ;
				high++;
				Console.OUT.println( "4.7" ) ;
				rowt(high) = row(i);
				Console.OUT.println( "4.8" ) ;
				colt(high) = col(i);
				Console.OUT.println( "4.9" ) ;
				valt(high) = vall(i);
				Console.OUT.println( "4.10" ) ;
			}
			pos = high + 1;
			Console.OUT.println( "4.11" ) ;
			return low..high;
		});
		Console.OUT.println( "5" ) ;
		//assert (pos == datasizes_nz[size]);
		if (pos != datasizes_nz(size)) throw new Error();

		// convert to values
		val Vrow = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {
				return rowt(i);
			});
		val Vcol = DistArray.make[int](Dist.makeConstant(r_nz, here), ([i]: Point): int => {
				return colt(i);
			});
		val Vval = DistArray.make[double](Dist.makeConstant(r_nz, here), ([i]: Point): double => {
				return valt(i);
			});

		// "y" is the vector with which is supposed to become y : = mat(val) * x
		val y = DistArray.make[double](d_M);

		Console.OUT.println( "6" ) ;
		
		finish ateach (Point[i] in d_places) mul(Vval, x, y, Vrow, Vcol, SPARSE_NUM_ITER, workranges(i));

		Console.OUT.println( "7" ) ;
		
		// validate
		var ytotal: double = 0.0;
		for (p in y.region) {
			// CG-style: //    ytotal += (future (y.dist[p]) { y[p] }).force();
		}
		
		Console.OUT.println( "8" ) ;
		
		for (p[i] in rowt.region) {
			// JGF-style:
			val i_final: int = i;
			val row_i: int = Future.make(() => at (rowt.dist(i)) rowt(i_final)).force();
			ytotal += Future.make(() => at (y.dist(row_i)) y(row_i)).force();
		}
		
		Console.OUT.println( "9" ) ;
		
		var refval: Array[double](1) = [ 0.7379886692958086, 150.0130719633895, 749.5245870753752 ];
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

	private static def mul(vall: DistArray[double], x: DistArray[double], yt: DistArray[double], var row: DistArray[int], var col: DistArray[int], var num_ITERATIONS: int, var sumrange: Region): void = {
		for (var reps: int = 0; reps < num_ITERATIONS; reps++)
			for (i in sumrange) {
				val rowi: int = row(i);
				yt(rowi) = yt(rowi) + x(col(i)) * vall(i);
			}
	}

	// trivial helper
	private static def RandomVector(d: Dist): DistArray[double] = {
		val rand: double = R.nextDouble();
		val pointy = ([i]: Point): double => {
			return R.nextDouble() * 1e-6;
		};
		return DistArray.make[double](d.makeUnique(), pointy); // added makeUnique to get rank 1 
	}
}
