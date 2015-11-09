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
import x10.util.ArrayList;

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

  def setRemote(key:Int, value:Bag, flag:GlobalRef[Cell[Int]]) {
    val f = flag.getLocalOrCopy();
    atomic {
      if (f() != -1n) f() = 1n;
    }
    at (map) @Uncounted async {
      lock().lock();
      map().put(key, value);
      lock().unlock();
      at (flag) @Uncounted async atomic if (flag()() != -1n) flag()() = 0n;
    }
    when(f() <= 0n);
  }

  def clear() {
    map.getLocalOrCopy().clear();
  }

  def values():Iterable[Bag] {
    lock.getLocalOrCopy().lock();
    val values = convert[Bag](map.getLocalOrCopy().values());
    lock.getLocalOrCopy().unlock();
    return values;
  }

  def transfer(src:Int, bag:Bag, dst:Int, loot:Bag, flag:GlobalRef[Cell[Int]]) {
    val f = flag.getLocalOrCopy();
    atomic {
      if (f() == -1n) throw new DeadPlaceException(here);
      f() = 1n;
    }
    at (map) @Uncounted async {
      lock().lock();
      map().put(src, bag);
      val old = map().get(dst) as Bag;
      if (old != null) loot.count = old.count;
      map().put(dst, loot);
      lock().unlock();
      at (flag) @Uncounted async atomic if (flag()() != -1n) flag()() = 0n;
    }
    when(f() <= 0n);
  }
}
