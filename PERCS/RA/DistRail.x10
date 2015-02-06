/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2014.
 */

import x10.compiler.Inline;
import x10.compiler.TransientInitExpr;
import x10.compiler.NonEscaping;
import x10.compiler.NativeCPPInclude;
import x10.compiler.Native;

import x10.xrx.Runtime;

/**
 * A specialized version of x10.array.DistArray_Block_1 that
 * <ul>
 *   <li>optionally supports using congruent memory to
 *       allocate the backing Rail.</li>
 *   <li>exposes remote element operations on the backing Rail.</li>
 * </ul>
 */
@NativeCPPInclude("x10/lang/RemoteOps.h")
public final class DistRail {
    val pg:PlaceGroup;
    val congruent:Boolean;
    val localData:PlaceLocalHandle[Rail[Long]];
    val rails:PlaceLocalHandle[Rail[GlobalRail[Long]]];

    @TransientInitExpr(reloadCachedLocalData())
    transient val cachedLocalData:Rail[Long]{self!=null};
    @NonEscaping private final def reloadCachedLocalData():Rail[Long]{self!=null} {
      val r = localData();
      return r != null ? r as Rail[Long]{self!=null} : new Rail[Long]();
    }

    @TransientInitExpr(reloadCachedRails())
    transient val cachedRails:Rail[GlobalRail[Long]];
    @NonEscaping private final def reloadCachedRails() = rails();

    public def this(pg:PlaceGroup, localSize:Long, congruent:boolean, 
                    hugePages:boolean, init:(Long)=>Long) {
	this.pg = pg;
	this.congruent = congruent;

        val ld = PlaceLocalHandle.makeFlat[Rail[Long]](pg, () => {
            if (hugePages || congruent ) {
                val alloc = Runtime.MemoryAllocator.requireAllocator(hugePages, congruent);
	        val r:Rail[Long] = new Rail[Long](localSize, alloc);
                for (i in r.range()) {
                    r(i) = init(i);
                }
                return r;
            } else {
                val r = new Rail[Long](localSize, init);
                @Native("c++", "x10::lang::RemoteOps::registerForRemoteOps(r);") { }
                return r;
            }
        });
	localData = ld;
	cachedLocalData = reloadCachedLocalData();

	if (congruent) {
	    rails = PlaceLocalHandle.makeFlat[Rail[GlobalRail[Long]]](pg, ()=>null);
        } else {
	    val grs:Rail[GlobalRail[Long]] = Unsafe.allocRailUninitialized[GlobalRail[Long]](pg.size());
	    finish for (p in pg) {
                async grs(p.id) = at (p) GlobalRail[Long](ld() as Rail[Long]{self!=null});
	    }
	    rails = PlaceLocalHandle.makeFlat[Rail[GlobalRail[Long]]](pg, ()=>{ grs });
        } 
	cachedRails = reloadCachedRails();
    }

    public @Inline operator this(index:Long):Long = cachedLocalData(index);

    public @Inline operator this(index:Long)=(v:Long):Long{self==v} {
        cachedLocalData(index) = v;
        return v;
    }

    @Native("c++", "x10::lang::RemoteOps::remoteXor(#placeId, #cld, #index, #update)")
    private static @Inline def congruent_xor(placeId:Long, cld:Rail[Long]{self!=null}, index:Long, update:Long):void {
        val target = Unsafe.getCongruentSibling(cld, Place(placeId));
        GlobalRail.remoteXor(target, index, update);
    }

    public @Inline def xor(placeId:Long, index:Long, update:Long):void {
        if (placeId == Runtime.hereLong()) {
            cachedLocalData(index) ^= update;
        } else {
	    if (congruent) {
	        congruent_xor(placeId, cachedLocalData, index, update);
            } else {
                GlobalRail.remoteXor(cachedRails(placeId), index, update);
            }
        }
    }

    public def printAll() {
        for (p in pg) {
            at (p) Console.OUT.println(here+": "+localData());
        }    
    }
}
