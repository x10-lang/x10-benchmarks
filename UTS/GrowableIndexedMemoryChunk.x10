/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2010.
 */

import x10.compiler.Inline;
import x10.io.CustomSerialization;
import x10.io.SerialData;
import x10.util.IndexedMemoryChunk;

/**
 * A GrowableIndexedMemoryChunk provides the abstraction of 
 * a variable size IndexedMemoryChunk.  It is implemented 
 * by wrapping a backing IndexedMemoryChunk and automatically 
 * growing the backing store as needed to support the requested
 * insertion operations. 
 * 
 * @See ArrayList, which provides a similar abstraction of a 
 *      Growable Array. Like Array, ArrayList is type safe.
 */
public final class GrowableIndexedMemoryChunk[T] {
    private var imc:IndexedMemoryChunk[T];

   /**
    * Elements 0..length-1 have valid entries of type T.
    * Elements length..imc.length-1 may not be valid 
    * values of type T.  
    * It is an invariant of this class, that such elements
    * will never be accessed.
    */
    private var length:int;

    /** 
     * Create a GrowableIndexedMemoryChunk with an initial 
     * capacity of cap.
     */
    public def this(cap:Int) {
        imc = IndexedMemoryChunk.allocateUninitialized[T](cap);
        length = 0;
    }

    /**
     * Store v as the length element, growing the backing store if needed.
     */
    @Inline public def add(v:T):void {
        if (length+1 > capacity()) grow(length+1);
        imc(length++) = v;
    }

    @Inline public operator this(idx:Int):T {
        return imc(idx);
    }        

    /** 
     * Get the current length; indices from 0..length-1 are currently valid 
     * values of type T and may be accessed.
     */
    @Inline public def length():Int = length;

    /**
     * What is the current capacity (size of backing storage)
     */
    @Inline public def capacity():Int = imc.length();

    /** 
     * Remove the last element. May shrink backing storage.
     */
    @Inline public def removeLast():void {
        length--;
    }

    /**
     * Transfer elements between i and j (inclusive) into a new IMC,
     * in the order in which they appear in this rail.  The elements
     * following element j are shifted over to position i.
     * (j-i+1) must be no greater than s, the size of the rail.
     * On return the rail has s-(j-i+1) elements.
     * May shrink backing storage.
     */
    public def moveSectionToIndexedMemoryChunk(i:Int):IndexedMemoryChunk[T] {
        val tmp = IndexedMemoryChunk.allocateUninitialized[T](i);
        IndexedMemoryChunk.copy(imc, length-i, tmp, 0, i);
        length-=i;
        return tmp;
    }

    private def grow(var newCapacity:int):void {
        var oldCapacity:int = capacity();
        if (newCapacity < oldCapacity*2) {
            newCapacity = oldCapacity*2;
        } 
        if (newCapacity < 8) {
            newCapacity = 8;
        }
        val tmp = IndexedMemoryChunk.allocateUninitialized[T](newCapacity);
        IndexedMemoryChunk.copy(imc, 0, tmp, 0, length);
        imc.deallocate();
        imc = tmp;
    }
}

