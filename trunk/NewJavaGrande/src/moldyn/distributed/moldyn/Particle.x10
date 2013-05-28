/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
package moldyn.distributed.moldyn;

public class Particle {

	public var xcoord: double;public var ycoord: double;public var zcoord: double;
	public var xvelocity: double;public var yvelocity: double;public var zvelocity: double;
	public var xforce: double;public var yforce: double;public var zforce: double;

	public def this(var xcoord: double, var ycoord: double, var zcoord: double, var xvelocity: double, var yvelocity: double, var zvelocity: double, var xforce: double, var yforce: double, var zforce: double): Particle = {
		this.xcoord = xcoord;
		this.ycoord = ycoord;
		this.zcoord = zcoord;
		this.xvelocity = xvelocity;
		this.yvelocity = yvelocity;
		this.zvelocity = zvelocity;
		this.xforce = xforce;
		this.yforce = yforce;
		this.zforce = zforce;
	}

	public def domove(var side: double): void = {
		xcoord = xcoord + xvelocity + xforce;
		ycoord = ycoord + yvelocity + yforce;
		zcoord = zcoord + zvelocity + zforce;

		if (xcoord < 0) { xcoord = xcoord + side; }
		if (xcoord > side) { xcoord = xcoord - side; }
		if (ycoord < 0) { ycoord = ycoord + side; }
		if (ycoord > side) { ycoord = ycoord - side; }
		if (zcoord < 0) { zcoord = zcoord + side; }
		if (zcoord > side) { zcoord = zcoord - side; }

		xvelocity = xvelocity + xforce;
		yvelocity = yvelocity + yforce;
		zvelocity = zvelocity + zforce;

		xforce = 0.0;
		yforce = 0.0;
		zforce = 0.0;
	}

	public def force(var side: double, var rcoff: double, var mdsize: int, var x: int, var md1: md): void = {
		var sideh: double;
		var rcoffs: double;

		var xx: double;var yy: double;var zz: double;var xi: double;var yi: double;var zi: double;var fxi: double;var fyi: double;var fzi: double;
		var rd: double;var rrd: double;var rrd2: double;var rrd3: double;var rrd4: double;var rrd6: double;var rrd7: double;var r148: double;
		var forcex: double;var forcey: double;var forcez: double;

		var i: int;

		sideh = 0.5*side;
		rcoffs = rcoff*rcoff;

		xi = xcoord;
		yi = ycoord;
		zi = zcoord;
		fxi = 0.0;
		fyi = 0.0;
		fzi = 0.0;

		for (i = x + 1; i < mdsize; i++) {
			xx = xi - md1.one(i).xcoord;
			yy = yi - md1.one(i).ycoord;
			zz = zi - md1.one(i).zcoord;

			if (xx < (-sideh)) { xx = xx + side; }
			if (xx > (sideh))  { xx = xx - side; }
			if (yy < (-sideh)) { yy = yy + side; }
			if (yy > (sideh))  { yy = yy - side; }
			if (zz < (-sideh)) { zz = zz + side; }
			if (zz > (sideh))  { zz = zz - side; }

			rd = xx*xx + yy*yy + zz*zz;

			if (rd <= rcoffs) {
				rrd = 1.0/rd;
				rrd2 = rrd*rrd;
				rrd3 = rrd2*rrd;
				rrd4 = rrd2*rrd2;
				rrd6 = rrd2*rrd4;
				rrd7 = rrd6*rrd;
				md1.epot = md1.epot + (rrd6 - rrd3);
				r148 = rrd7 - 0.5*rrd4;
				md1.vir = md1.vir - rd*r148;
				forcex = xx * r148;
				fxi = fxi + forcex;
				md1.one(i).xforce = md1.one(i).xforce - forcex;
				forcey = yy * r148;
				fyi = fyi + forcey;
				md1.one(i).yforce = md1.one(i).yforce - forcey;
				forcez = zz * r148;
				fzi = fzi + forcez;
				md1.one(i).zforce = md1.one(i).zforce - forcez;
				md1.interactions++;
			}
		}

		xforce = xforce + fxi;
		yforce = yforce + fyi;
		zforce = zforce + fzi;
	}

	public def mkekin(var hsq2: double): double = {
		var sumt: double = 0.0;

		xforce = xforce * hsq2;
		yforce = yforce * hsq2;
		zforce = zforce * hsq2;

		xvelocity = xvelocity + xforce;
		yvelocity = yvelocity + yforce;
		zvelocity = zvelocity + zforce;

		sumt = (xvelocity*xvelocity)+(yvelocity*yvelocity)+(zvelocity*zvelocity);
		return sumt;
	}

	public def velavg(var vaverh: double, var h: double, var md1: md): double = {
		var velt: double;
		var sq: double;

		sq = Math.sqrt(xvelocity*xvelocity + yvelocity*yvelocity +
				zvelocity*zvelocity);

		if (sq > vaverh) { md1.count = md1.count + 1.0; }

		velt = sq;
		return velt;
	}

	public def dscal(var sc: double, var incx: int): void = {
		xvelocity = xvelocity * sc;
		yvelocity = yvelocity * sc;
		zvelocity = zvelocity * sc;
	}
}
