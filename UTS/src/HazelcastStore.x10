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

import x10.util.resilient.ResilientMap;
import x10.util.resilient.ResilientTransactionalMap;
import x10.util.ArrayList;

final class HazelcastStore extends Store {
  val name:String;
  val map:ResilientMap[Int,Bag];

  def this(name:String) {
    this.name = name;
    map = ResilientMap.getMap[Int,Bag](name);
  }
  
  def set(key:Int, value:Bag) {
    map.set(key, value);
  }

  def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Int]]) {
    map.set(key, value);
  }

  def clear() {
    map.clear();
  }

  def values():Iterable[Bag] {
    return ResilientTransactionalMap.runLocalTransaction(name,
        (map:ResilientTransactionalMap[Int,Bag]) => map.values());
  }

  def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Int]]) {
    ResilientTransactionalMap.runTransaction(name, (map:ResilientTransactionalMap[Int,Bag]) => {
      map.set(src, bag);
      val old = map.getForUpdate(dst);
      if (old != null) loot.count = old.count;
      map.set(dst, loot);
      return null;
    });
  }
}
