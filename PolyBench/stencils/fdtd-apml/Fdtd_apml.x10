/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2015.
 * 
 *
 *  @author HUANG RUOCHEN (hrc706@gmail.com)
 */

import x10.compiler.Ifdef;
import x10.array.Array_2;
import x10.array.Array_3;
public class Fdtd_apml {

  var _PB_CZ : Long;
  var _PB_CXM : Long;
  var _PB_CYM : Long;

  def setPBs(cz : Long, cxm : Long, cym : Long) {
    _PB_CZ = cz; 
    _PB_CXM = cxm; 
    _PB_CYM = cym; 
  }
  def init_array(cz : Long,
  		 cxm : Long,
  		 cym : Long,
  		 mui : Rail[Double],
  		 ch : Rail[Double],
  		 Ax : Array_2[Double],
  		 Ry : Array_2[Double],
  		 Ex : Array_3[Double],
  		 Ey : Array_3[Double],
  		 Hz : Array_3[Double],
  		 czm : Rail[Double],
  		 czp : Rail[Double],
  		 cxmh : Rail[Double],
  		 cxph : Rail[Double],
  		 cymh : Rail[Double],
  		 cyph : Rail[Double])
  {
    mui(0) = 2341;
    ch(0) = 42;
    for (var i : Long = 0; i <= cz; i++)
      {
        czm(i) = ((i as Double) + 1) / cxm;
        czp(i) = ((i as Double) + 2) / cxm;
      }
    for (var i : Long = 0; i <= cxm; i++)
      {
        cxmh(i) = ((i as Double) + 3) / cxm;
        cxph(i) = ((i as Double) + 4) / cxm;
      }
    for (var i : Long = 0; i <= cym; i++)
      {
        cymh(i) = ((i as Double) + 5) / cxm;
        cyph(i) = ((i as Double) + 6) / cxm;
      }
  
    for (var i : Long = 0; i <= cz; i++)
      for (var j : Long = 0; j <= cym; j++)
        {
  	Ry(i,j) = ((i as Double)*(j+1) + 10) / cym;
  	Ax(i,j) = ((i as Double)*(j+2) + 11) / cym;
  	for (var k : Long = 0; k <= cxm; k++)
  	  {
  	    Ex(i,j,k) = ((i as Double)*(j+3) + k + 1) / cxm;
  	    Ey(i,j,k) = ((i as Double)*(j+4) + k + 2) / cym;
  	    Hz(i,j,k) = ((i as Double)*(j+5) + k + 3) / cz;
  	  }
        }
  }  /* DCE code. Must scan the entire live-out data.
     Can be used also to ch(0)eck the correctness of the output. */
  def print_array(cz : Long,
  		 cxm : Long,
  		 cym : Long,
  		 Bza : Array_3[Double],
  		 Ex : Array_3[Double],
  		 Ey : Array_3[Double],
  		 Hz : Array_3[Double])
  {
    for (var i : Long = 0; i <= cz; i++)
      for (var j : Long = 0; j <= cym; j++)
        for (var k : Long = 0; k <= cxm; k++) {
  	Console.ERR.printf("%0.2lf", Bza(i,j,k));
  	Console.ERR.printf("%0.2lf", Ex(i,j,k));
  	Console.ERR.printf("%0.2lf", Ey(i,j,k));
  	Console.ERR.printf("%0.2lf", Hz(i,j,k));
  	if ((i * cxm + j) % 20 == 0) Console.ERR.printf("\n");
        }
    Console.ERR.printf("\n");
  }  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_fdtd_apml(cz : Long,
  		      cxm : Long,
  		      cym : Long,
  		      mui : Double,
  		      ch : Double,
  		      Ax : Array_2[Double],
  		      Ry : Array_2[Double],
  		      clf : Array_2[Double],
  		      tmp : Array_2[Double],
  		      Bza : Array_3[Double],
  		      Ex : Array_3[Double],
  		      Ey : Array_3[Double],
  		      Hz : Array_3[Double],
  		      czm : Rail[Double],
  		      czp : Rail[Double],
  		      cxmh : Rail[Double],
  		      cxph : Rail[Double],
  		      cymh : Rail[Double],
  		      cyph : Rail[Double])
  {
  // #pragma scop
    for (var iz : Long = 0; iz < cz; iz++)
      {
        for (var iy : Long = 0; iy < cym; iy++)
  	{
  	  for (var ix : Long = 0; ix < cxm; ix++)
  	    {
  	      clf(iz,iy) = Ex(iz,iy,ix) - Ex(iz,iy+1,ix) + Ey(iz,iy,ix+1) - Ey(iz,iy,ix);
  	      tmp(iz,iy) = (cymh(iy) / cyph(iy)) * Bza(iz,iy,ix) - (ch / cyph(iy)) * clf(iz,iy);
  	      Hz(iz,iy,ix) = (cxmh(ix) /cxph(ix)) * Hz(iz,iy,ix)
  		+ (mui * czp(iz) / cxph(ix)) * tmp(iz,iy)
  		- (mui * czm(iz) / cxph(ix)) * Bza(iz,iy,ix);
  	      Bza(iz,iy,ix) = tmp(iz,iy);
  	    }
  	  clf(iz,iy) = Ex(iz,iy,cxm) - Ex(iz,iy+1,cxm) + Ry(iz,iy) - Ey(iz,iy,cxm);
  	  tmp(iz,iy) = (cymh(iy) / cyph(iy)) * Bza(iz,iy,_PB_CXM) - (ch / cyph(iy)) * clf(iz,iy);
  	  Hz(iz,iy,cxm)=(cxmh(cxm) / cxph(cxm)) * Hz(iz,iy,cxm)
  	    + (mui * czp(iz) / cxph(cxm)) * tmp(iz,iy)
  	    - (mui * czm(iz) / cxph(cxm)) * Bza(iz,iy,cxm);
  	  Bza(iz,iy,cxm) = tmp(iz,iy);
  	  for (var ix : Long = 0; ix < cxm; ix++)
  	    {
  	      clf(iz,iy) = Ex(iz,cym,ix) - Ax(iz,ix) + Ey(iz,cym,ix+1) - Ey(iz,cym,ix);
  	      tmp(iz,iy) = (cymh(cym) / cyph(iy)) * Bza(iz,iy,ix) - (ch / cyph(iy)) * clf(iz,iy);
  	      Hz(iz,cym,ix) = (cxmh(ix) / cxph(ix)) * Hz(iz,cym,ix)
  		+ (mui * czp(iz) / cxph(ix)) * tmp(iz,iy)
  		- (mui * czm(iz) / cxph(ix)) * Bza(iz,cym,ix);
  	      Bza(iz,cym,ix) = tmp(iz,iy);
  	    }
  	  clf(iz,iy) = Ex(iz,cym,cxm) - Ax(iz,cxm) + Ry(iz,cym) - Ey(iz,cym,cxm);
  	  tmp(iz,iy) = (cymh(cym) / cyph(cym)) * Bza(iz,cym,cxm) - (ch / cyph(cym)) * clf(iz,iy);
  	  Hz(iz,cym,cxm) = (cxmh(cxm) / cxph(cxm)) * Hz(iz,cym,cxm)
  	    + (mui * czp(iz) / cxph(cxm)) * tmp(iz,iy)
  	    - (mui * czm(iz) / cxph(cxm)) * Bza(iz,cym,cxm);
  	  Bza(iz,cym,cxm) = tmp(iz,iy);
  	}
      }
  // #pragma endscop
  
  }  public static def main(args : Rail[String])
  {
    var CZ : Long = 0;
    var CXM : Long = 0;
    var CYM : Long = 0;
    
    @Ifdef("EXTRALARGE_DATASET") {
        CZ = 1000;
        CXM = 1000;
        CYM = 1000;
    }
    @Ifdef("STANDARD_DATASET") {
        CZ = 256;
        CXM = 256;
        CYM = 256;
    }
    @Ifdef("MINI_DATASET") {
        CZ = 32;
        CXM = 32;
        CYM = 32;
    }
    @Ifdef("SMALL_DATASET") {
        CZ = 64;
        CXM = 64;
        CYM = 64;
    }
    @Ifdef("LARGE_DATASET") {
        CZ = 512;
        CXM = 512;
        CYM = 512;
    }
    
    val fdtd_apml = new Fdtd_apml();
    /* Retrieve problem size. */
    var cz  : Long= CZ;
    var cym  : Long= CYM;
    var cxm  : Long= CXM;
  
    fdtd_apml.setPBs(cz, cxm, cym);
    /* Variable declaration/allocation. */
    val mui = new Rail[Double](1);
    val ch = new Rail[Double](1);
    val Ax = new Array_2[Double](cz+1,cym+1);

    val Ry = new Array_2[Double](cz+1,cym+1);

    val clf = new Array_2[Double](cym+1,cxm+1);

    val tmp = new Array_2[Double](cym+1,cxm+1);

    val Bza = new Array_3[Double](cz+1,cym+1,cxm+1);

    val Ex = new Array_3[Double](cz+1,cym+1,cxm+1);

    val Ey = new Array_3[Double](cz+1,cym+1,cxm+1);

    val Hz = new Array_3[Double](cz+1,cym+1,cxm+1);

    val czm = new Rail[Double](cz+1);

    val czp = new Rail[Double](cz+1);

    val cxmh = new Rail[Double](cxm+1);

    val cxph = new Rail[Double](cxm+1);

    val cymh = new Rail[Double](cym+1);

    val cyph = new Rail[Double](cym+1);    /* Initialize array(s). */
    fdtd_apml.init_array (cz, cxm, cym, mui, ch,
    	      Ax,
    	      Ry,
    	      Ex,
    	      Ey,
    	      Hz,
    	      czm,
    	      czp,
    	      cxmh,
    	      cxph,
    	      cymh,
    	      cyph);
  
    /* Start timer. */
    val t1 = System.currentTimeMillis();
  
    /* Run kernel. */
    fdtd_apml.kernel_fdtd_apml (cz, cxm, cym, mui(0), ch(0),
    		    Ax,
    		    Ry,
    		    clf,
    		    tmp,
    		    Bza,
    		    Ex,
    		    Ey,
    		    Hz,
    		    czm,
    		    czp,
    		    cxmh,
    		    cxph,
    		    cymh,
    		    cyph);
  
    /* Stop and prvar timer : Long. */
    val t2 = System.currentTimeMillis();
    Console.OUT.printf("Elapsed time= " + (t2 - t1) + " (ms)");
    // fdtd_apml.print_array(cz, cxm, cym, Bza, Ex, Ey, Hz);
  
    /* Prevent dead-code elimination. All live-out data must be printed
       by the function call in argument. */
  
    /* Be clean. */
  
  }
  
}
