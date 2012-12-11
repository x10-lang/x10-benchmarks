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
package raytracer.parallel.raytracer;

import x10.util.*;
//ok

public class Scene {
	public val lights: ArrayList[Light];
	public val objects: ArrayList[Primitive];
	private val view: View;

	public def this(var v: View): Scene = {
		lights = new ArrayList[Light] ();
		objects = new ArrayList[Primitive] ();
		view = v;
	}

	public def addLight(var l: Light): void = {
		this.lights.add(l);
	}

	public def addObject(var object: Primitive): void = {
		this.objects.add(object);
	}

	public def getView(): View = {
		return this.view;
	}

	public def getLight(var number: int): Light = {
		return this.lights.get(number) as Light;
	}

	public def getObject(var number: int): Primitive = {
		return objects.get(number) as Primitive;
	}

	public def getLights(): int = {
		return this.lights.size();
	}

	public def getObjects(): int = {
		return this.objects.size();
	}

	public def setObject(var object: Primitive, var pos: int): void = {
		this.objects.set(object, pos);
	}
}
