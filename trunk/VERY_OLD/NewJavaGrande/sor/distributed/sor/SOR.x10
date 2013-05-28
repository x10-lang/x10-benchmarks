/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
package sor.distributed.sor;

import jgfutil.*;

/**
 * X10 port of sor benchmark from Section 2 of Java Grande Forum Benchmark Suite.
 *
 *  SERIAL VERSION
 *
 * @author Vivek Sarkar (vsarkar@us.ibm.com)
 *
 * Porting issues identified:
 * 1) Replace Java multidimensional array by X10 Multidimensional array
 *    FIXME: This is no longer a problem.
 */
public class SOR {

    static val gTotal:Double = 0.0 as double;

    public static def read(G: DistArray[Double], i: int, j: Int) {
	return at (G.dist(i, j)) { G(i, j) };
    }

	public static def SORrun(omega: Double, G: Array[Double], numIter: Int) {
	    val M = G.region.max(0);
	    val N = G.region.max(1);

	    val omega_over_four = omega * 0.25;
	    val one_minus_omega = 1.0 - omega;

	    // update interior points
	    //
	    val Mm1: int = M-1;
	    val Nm1: int = N-1;

		JGFInstrumentor.startTimer("Section2:SOR:Kernel");

		for ([p]: Point in 0..(num_iterations-1)) 
		    for ([o]: Point in 0..1) 
			finish for ([ii]: Point in 0..(((Mm1-1-(1+o))/2))) {
			val i: int = 2 * ii + 1 + o;
			finish async at (G.dist(i, 1))
			    for ([j]: Point in 1..(Nm1-1)) 
				G(i, j) = omega_over_four * (read(G, i-1, j) + read(G, i+1, j) 
							     + G(i, j-1)
							     + G(i, j+1)) + one_minus_omega * G(i, j);
		    }
		JGFInstrumentor.stopTimer("Section2:SOR:Kernel");
		gTotal = G.reduce((a:double, b:double)=>a+b,0.0 as double);
	}
}
