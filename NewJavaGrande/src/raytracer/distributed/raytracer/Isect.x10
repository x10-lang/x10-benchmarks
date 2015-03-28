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
*                 Original version of this code by                        *
*            Florian Doyon (Florian.Doyon@sophia.inria.fr)                *
*              and  Wilfried Klauser (wklauser@acm.org)                   *
*                                                                         *
*      This version copyright (c) The University of Edinburgh, 1999.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package raytracer.distributed.raytracer;

public class Isect {
	public var t: double;
	public var enter: int;
	public var prim: Primitive;
	public var surf: Surface;
	public def this(): Isect {
		t = 0.0;
		enter = 0;
		prim = null;
		surf = null;
	}
	public def this(var t_: double, var enter_: int, var prim_: Primitive, var surf_: Surface): Isect {
		t = t_;
		enter = enter_;
		prim = prim_;
		surf = surf_;
	}
}
