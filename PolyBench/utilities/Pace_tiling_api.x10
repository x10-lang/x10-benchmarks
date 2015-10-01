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

class Pace_tiling_api {
    static val __PACE_MAX_NB_TILE_SIZES  = 42;

    public static def PACETileSizeVectorAlloc(size : Long) : Rail[Long] {
        val ret = new Rail[Long](size);
        for (var i : Long = 0; i < __PACE_MAX_NB_TILE_SIZES; ++i)
            ret(i) = 32;
        return ret;
    }    public static def PACETileSizeVectorInit(pace_tile_sizes : Rail[Long], nestedLoops : Long, scopId : Long) {
        for (var i : Long = 0; i < nestedLoops; ++i)
            pace_tile_sizes(i) = 5;
    }    public static def PACETileSizeVectorFree(tile_sizes : Rail[Long]) {
        // do nothing. X10 has GC.
    }
}
