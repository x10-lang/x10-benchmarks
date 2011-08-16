/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
package sor.serial.sor;

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

    var gTotal:Double = 0.0D;

    public def SORrun(omega: double, G: Array[Double], NumIter: Int) {
	val M = G.region.max(0);
	val N = G.region.max(1);
	
	val omega_over_four  = omega * 0.25;
	val one_minus_omega = 1.0 - omega;

	 // update interior Points
	 //
	 JGFInstrumentor.startTimer("Section2:SOR:Kernel");

	 for ([p,i,j]:Point in (0..(NumIter-1))*(1..(M-2))*(1..(N-2)))  
	     G(i, j) = omega_over_four * (G(i-1, j) + G(i+1, j) 
					  + G(i, j-1)
					  + G(i, j+1)) + one_minus_omega * G(i, j);

	 JGFInstrumentor.stopTimer("Section2:SOR:Kernel");
	 gTotal = G.reduce((a:double,b:double)=>a+b, 0.0 as double);
    }
}
