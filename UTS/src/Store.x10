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

import x10.compiler.Uncounted;
import x10.util.concurrent.Lock;
import x10.util.resilient.ResilientMap;
import x10.util.resilient.ResilientTransactionalMap;
import x10.util.ArrayList;

abstract class Store {
  abstract def set(key:Int, value:Bag):void;
  abstract def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Boolean]]):void;
  abstract def clear():void;
  abstract def values():Iterable[Bag];
  abstract def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Boolean]]):void;

  static def make(name:String) { 
    if ("Hazelcast".equalsIgnoreCase(java.lang.System.getProperty("X10RT_DATASTORE", "none"))) {
      return new HazelcastStore(name);
    } else {
      return new UncountedStore();
    }
  }
}

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

  def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Boolean]]) {
    map.set(key, value);
  }

  def clear() {
    map.clear();
  }

  def values():Iterable[Bag] {
    return ResilientTransactionalMap.runLocalTransaction(name,
        (map:ResilientTransactionalMap[Int,Bag]) => map.values());
  }

  def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Boolean]]) {
    ResilientTransactionalMap.runTransaction(name, (map:ResilientTransactionalMap[Int,Bag]) => {
      map.set(src, bag);
      val old = map.getForUpdate(dst);
      if (old != null) loot.count = old.count;
      map.set(dst, loot);
      return null;
    });
  }
}

final class UncountedStore extends Store {
  static def convert[T](iter:java.util.Iterator):Iterator[T] {
    return new Iterator[T]() {
      public def hasNext():Boolean = iter.hasNext();
      public def next():T = iter.next() as T;
    };
  }

  static def convert[T](coll:java.lang.Iterable):Iterable[T] {
    return new Iterable[T]() {
      public def iterator(): Iterator[T] = convert[T](coll.iterator());
    };
  }
    
  val map = GlobalRef[java.util.HashMap](new java.util.HashMap());
  val lock = GlobalRef[Lock](new Lock());

  def set(key:Int, value:Bag) {
    map.getLocalOrCopy().put(key, value);
  }

  def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Boolean]]) {
    flag.getLocalOrCopy()() = false;
    at (map) @Uncounted async {
      lock().lock();
      map().put(key, value);
      lock().unlock();
      at (flag) @Uncounted async atomic flag()() = true;
    }
    when(flag.getLocalOrCopy()());
  }

  def clear() {
    map.getLocalOrCopy().clear();
  }

  def values():Iterable[Bag] {
    lock.getLocalOrCopy().lock();
    val list = new ArrayList[Bag]();
    for (b in convert[Bag](map.getLocalOrCopy().values())) list.add(b);
    lock.getLocalOrCopy().unlock();
    return list;
  }

  def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Boolean]]) {
    flag.getLocalOrCopy()() = false;
    at (map) @Uncounted async {
      lock().lock();
      map().put(src, bag);
      val old = map().get(dst) as Bag;
      if (old != null) loot.count = old.count;
      map().put(dst, loot);
      lock().unlock();
      at (flag) @Uncounted async atomic flag()() = true;
    }
    when(flag.getLocalOrCopy()());
  }
}
