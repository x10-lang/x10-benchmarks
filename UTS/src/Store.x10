/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2015.
 */

abstract class Store {
  abstract def set(key:Int, value:Bag):void;
  abstract def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Int]]):void;
  abstract def clear():void;
  abstract def values():Iterable[Bag];
  abstract def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Int]]):void;

  static def make(name:String) {
    val config = java.lang.System.getProperty("X10RT_DATASTORE", "counted");
    if ("Hazelcast".equalsIgnoreCase(config)) {
      return new HazelcastStore(name);
    } else if ("uncounted".equalsIgnoreCase(config)) {
      return new UncountedStore();
    } else {
      return new CountedStore();
    }
  }
}
