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
package raytracer.parallel.raytracer;

import jgfutil.*;;

public class JGFRayTracerBench extends RayTracer implements JGFSection3 {

	public def JGFsetsize(var size: int): void = {
		this.size = size;
	}

	public def JGFinitialise(): void = {
		JGFInstrumentor.startTimer("Section3:RayTracer:Init");

		// set image size
		width = height = datasizes(size);

		// create the objects to be rendered
		scene = createScene();

		// get lights, objects etc. from scene.
		setScene(scene);

		numobjects = scene.getObjects();

		JGFInstrumentor.stopTimer("Section3:RayTracer:Init");
	}

	public def JGFapplication(): void = {
		JGFInstrumentor.startTimer("Section3:RayTracer:Run");

		// Set interval to be rendered to the whole picture
		// (overkill, but will be useful to retain this for parallel versions)
		var interval: Interval = new Interval(0, width, height, 0, height, 1);

		// Do the business!
		render(interval);

		JGFInstrumentor.stopTimer("Section3:RayTracer:Run");
	}

	public def JGFvalidate(): void = {
		//long refval[] = { 2676692, 29827635 };
		var refval: Array[long] = [ 51398 as long, 29827635 as long ]; // reduced data size
		var dev: long = checksum - refval(size);
		if (dev != 0 as long) {
			Console.OUT.println("Validation failed");
			Console.OUT.println("Pixel checksum = " + checksum);
			Console.OUT.println("Reference value = " + refval(size));
			throw new Error("Validation failed");
		}
	}

	public def JGFtidyup(): void = {
		/*
		scene = null;
		lights = null;
		prim = null;
		tRay = null;
		inter = null;
		*/
		//System.gc();
	}

	public def JGFrun(var size: int): void = {
		JGFInstrumentor.addTimer("Section3:RayTracer:Total", "Solutions", size);
		JGFInstrumentor.addTimer("Section3:RayTracer:Init", "Objects", size);
		JGFInstrumentor.addTimer("Section3:RayTracer:Run", "Pixels", size);

		JGFsetsize(size);

		JGFInstrumentor.startTimer("Section3:RayTracer:Total");

		JGFinitialise();
		JGFapplication();
		JGFvalidate();
		JGFtidyup();

		JGFInstrumentor.stopTimer("Section3:RayTracer:Total");

		JGFInstrumentor.addOpsToTimer("Section3:RayTracer:Init", numobjects as double);
		JGFInstrumentor.addOpsToTimer("Section3:RayTracer:Run", (width*height) as double);
		JGFInstrumentor.addOpsToTimer("Section3:RayTracer:Total", 1);

		JGFInstrumentor.printTimer("Section3:RayTracer:Init");
		JGFInstrumentor.printTimer("Section3:RayTracer:Run");
		JGFInstrumentor.printTimer("Section3:RayTracer:Total");
	}
}
