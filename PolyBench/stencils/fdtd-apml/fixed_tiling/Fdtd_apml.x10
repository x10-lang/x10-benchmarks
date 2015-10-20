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
import x10.compiler.Foreach;
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
  	Console.ERR.printf("%0.2lf ", Bza(i,j,k));
  	Console.ERR.printf("%0.2lf ", Ex(i,j,k));
  	Console.ERR.printf("%0.2lf ", Ey(i,j,k));
  	Console.ERR.printf("%0.2lf ", Hz(i,j,k));
  	if ((i * cxm + j) % 20 == 0) Console.ERR.printf("\n");
        }
    Console.ERR.printf("\n");
  }  

  /* Main computational kernel. The whole function will be timed,
     including the call and return. */
  def kernel_fdtd_apml(cz : long, cxm : long, cym : long, mui : double, ch : double, Ax : Array_2[double], Ry : Array_2[double], clf : Array_2[double], tmp : Array_2[double], Bza : Array_3[double], Ex : Array_3[double], Ey : Array_3[double], Hz : Array_3[double], czm : Rail[double], czp : Rail[double], cxmh : Rail[double], cxph : Rail[double], cymh : Rail[double], cyph : Rail[double])  {
        var c1 : long;
        var c2 : long;
        var c3 : long;
        var c4 : long;
        var c5 : long;
        var c6 : long;
        if (((cym >= 1) && (cz >= 1))) {
            if ((cxm >= 1)) {
                {
                    Foreach.block(0,((cz + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cz + -1)) + 32 + 1) / 32) :  -(( -((cz + -1)) + 32 - 1) / 32)) : (cz + -1) / 32),(var c1 : long) => {
                        var c2 : long;
                        var c3 : long;
                        var c4 : long;
                        var c5 : long;
                        var c6 : long;
                        for (c2 = 0; (c2 <= ((cym + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cym + -1)) + 32 + 1) / 32) :  -(( -((cym + -1)) + 32 - 1) / 32)) : (cym + -1) / 32)); c2++) {
                            for (c3 = 0; (c3 <= ((cxm + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cxm + -1)) + 32 + 1) / 32) :  -(( -((cxm + -1)) + 32 - 1) / 32)) : (cxm + -1) / 32)); c3++) {
                                for (c4 = (32 * c3); (c4 <= (((32 * c3) + 31) < (cxm + -1) ? (((32 * c3) + 31)) as long : ((cxm + -1)) as long)); c4++) {
                                    for (c5 = (32 * c2); (c5 <= (((32 * c2) + 31) < (cym + -1) ? (((32 * c2) + 31)) as long : ((cym + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c6 = (32 * c1); (c6 <= (((32 * c1) + 31) < (cz + -1) ? (((32 * c1) + 31)) as long : ((cz + -1)) as long)); c6++) {
                                            clf(c6,c5) = Ex(c6,c5,c4) - Ex(c6,c5 + 1L,c4) + Ey(c6,c5,c4 + 1L) - Ey(c6,c5,c4);
                                            tmp(c6,c5) = (cymh(c5) / cyph(c5)) * Bza(c6,c5,c4) - (ch / cyph(c5)) * clf(c6,c5);
                                            Hz(c6,c5,c4) = (cxmh(c4) / cxph(c4)) * Hz(c6,c5,c4) + (mui * czp(c6) / cxph(c4)) * tmp(c6,c5) - (mui * czm(c6) / cxph(c4)) * Bza(c6,c5,c4);
                                            Bza(c6,c5,c4) = tmp(c6,c5);
                                        }
                                    }
                                }
                            }
                        }
                    }
);
                }
            }
            {
                Foreach.block(0,((cz + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cz + -1)) + 32 + 1) / 32) :  -(( -((cz + -1)) + 32 - 1) / 32)) : (cz + -1) / 32),(var c1 : long) => {
                    var c2 : long;
                    var c3 : long;
                    var c4 : long;
                    var c5 : long;
                    var c6 : long;
                    for (c2 = 0; (c2 <= ((cym + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cym + -1)) + 32 + 1) / 32) :  -(( -((cym + -1)) + 32 - 1) / 32)) : (cym + -1) / 32)); c2++) {
                        for (c5 = (32 * c2); (c5 <= (((32 * c2) + 31) < (cym + -1) ? (((32 * c2) + 31)) as long : ((cym + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c6 = (32 * c1); (c6 <= (((32 * c1) + 31) < (cz + -1) ? (((32 * c1) + 31)) as long : ((cz + -1)) as long)); c6++) {
                                clf(c6,c5) = Ex(c6,c5,cxm) - Ex(c6,c5 + 1L,cxm) + Ry(c6,c5) - Ey(c6,c5,cxm);
                                tmp(c6,c5) = (cymh(c5) / cyph(c5)) * Bza(c6,c5,cxm) - (ch / cyph(c5)) * clf(c6,c5);
                                Hz(c6,c5,cxm) = (cxmh(cxm) / cxph(cxm)) * Hz(c6,c5,cxm) + (mui * czp(c6) / cxph(cxm)) * tmp(c6,c5) - (mui * czm(c6) / cxph(cxm)) * Bza(c6,c5,cxm);
                                Bza(c6,c5,cxm) = tmp(c6,c5);
                            }
                        }
                    }
                }
);
            }
            if ((cxm >= 1)) {
                {
                    Foreach.block(0,((cz + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cz + -1)) + 32 + 1) / 32) :  -(( -((cz + -1)) + 32 - 1) / 32)) : (cz + -1) / 32),(var c1 : long) => {
                        var c2 : long;
                        var c3 : long;
                        var c4 : long;
                        var c5 : long;
                        var c6 : long;
                        for (c2 = 0; (c2 <= ((cym + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cym + -1)) + 32 + 1) / 32) :  -(( -((cym + -1)) + 32 - 1) / 32)) : (cym + -1) / 32)); c2++) {
                            for (c3 = 0; (c3 <= ((cxm + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cxm + -1)) + 32 + 1) / 32) :  -(( -((cxm + -1)) + 32 - 1) / 32)) : (cxm + -1) / 32)); c3++) {
                                for (c4 = (32 * c3); (c4 <= (((32 * c3) + 31) < (cxm + -1) ? (((32 * c3) + 31)) as long : ((cxm + -1)) as long)); c4++) {
                                    for (c5 = (32 * c2); (c5 <= (((32 * c2) + 31) < (cym + -1) ? (((32 * c2) + 31)) as long : ((cym + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                                        for (c6 = (32 * c1); (c6 <= (((32 * c1) + 31) < (cz + -1) ? (((32 * c1) + 31)) as long : ((cz + -1)) as long)); c6++) {
                                            clf(c6,c5) = Ex(c6,cym,c4) - Ax(c6,c4) + Ey(c6,cym,c4 + 1L) - Ey(c6,cym,c4);
                                            tmp(c6,c5) = (cymh(cym) / cyph(c5)) * Bza(c6,c5,c4) - (ch / cyph(c5)) * clf(c6,c5);
                                            Hz(c6,cym,c4) = (cxmh(c4) / cxph(c4)) * Hz(c6,cym,c4) + (mui * czp(c6) / cxph(c4)) * tmp(c6,c5) - (mui * czm(c6) / cxph(c4)) * Bza(c6,cym,c4);
                                            Bza(c6,cym,c4) = tmp(c6,c5);
                                        }
                                    }
                                }
                            }
                        }
                    }
);
                }
            }
            {
                Foreach.block(0,((cz + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cz + -1)) + 32 + 1) / 32) :  -(( -((cz + -1)) + 32 - 1) / 32)) : (cz + -1) / 32),(var c1 : long) => {
                    var c2 : long;
                    var c3 : long;
                    var c4 : long;
                    var c5 : long;
                    var c6 : long;
                    for (c2 = 0; (c2 <= ((cym + -1) * 32 < 0 ? (32 < 0 ?  -(( -((cym + -1)) + 32 + 1) / 32) :  -(( -((cym + -1)) + 32 - 1) / 32)) : (cym + -1) / 32)); c2++) {
                        for (c5 = (32 * c2); (c5 <= (((32 * c2) + 31) < (cym + -1) ? (((32 * c2) + 31)) as long : ((cym + -1)) as long)); c5++) {
@x10.compiler.Native("c++", "#pragma ivdep"){}
@x10.compiler.Native("c++", "#pragma vector always"){}
@x10.compiler.Native("c++", "#pragma simd"){}
                            for (c6 = (32 * c1); (c6 <= (((32 * c1) + 31) < (cz + -1) ? (((32 * c1) + 31)) as long : ((cz + -1)) as long)); c6++) {
                                clf(c6,c5) = Ex(c6,cym,cxm) - Ax(c6,cxm) + Ry(c6,cym) - Ey(c6,cym,cxm);
                                tmp(c6,c5) = (cymh(cym) / cyph(cym)) * Bza(c6,cym,cxm) - (ch / cyph(cym)) * clf(c6,c5);
                                Hz(c6,cym,cxm) = (cxmh(cxm) / cxph(cxm)) * Hz(c6,cym,cxm) + (mui * czp(c6) / cxph(cxm)) * tmp(c6,c5) - (mui * czm(c6) / cxph(cxm)) * Bza(c6,cym,cxm);
                                Bza(c6,cym,cxm) = tmp(c6,c5);
                            }
                        }
                    }
                }
);
            }
        }
    }  

  public static def main(args : Rail[String])
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
