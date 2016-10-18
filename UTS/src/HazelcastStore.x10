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

final class HazelcastStore[V]{V haszero} extends Store[V] {
  static final class LogEntry[V] {
    val value:V;
    val key2:Int;
    val value2:V;

    def this(value:V, key2:Int, value2:V) {
      this.value = value;
      this.key2 = key2;
      this.value2 = value2;
    }
  }

  val map:ResilientMap[Int,V];
  val log:ResilientMap[Int,LogEntry[V]];
  var group:PlaceGroup;

  def this(name:String, group:PlaceGroup) {
    map = ResilientMap.getMap[Int,V]("_map_"+ name);
    log = ResilientMap.getMap[Int,LogEntry[V]]("_log_" + name);
    this.group = group;
  }

  private def k(place:Place, key:Int) = (group.indexOf(place) as Int << 16n) + key;

  def get(key:Int) = getRemote(here, key);

  def set(key:Int, value:V) {
    setRemote(here, key, value);
  }

  def clear() {
    map.clear();
    log.clear();
  }

  def getRemote(place:Place, key:Int) = map.get(k(place, key));

  def setRemote(place:Place, key:Int, value:V) {
    map.set(k(place, key), value);
  }

  def set2(key:Int, value:V, place:Place, key2:Int, value2:V) {
    val k1 = k(here, key);
    val k2 = k(place, key2);
    log.set(k1, new LogEntry(value, k2, value2));
    map.set(k2, value2);
    map.set(k1, value);
    log.remove(k1);
  }

  def update(group:PlaceGroup) {
    this.group = group;
  }

  def replay() {
    for(entry in log.entries()) {
      Console.ERR.println("Replaying transaction log for key " + entry.getKey());
      map.set(entry.getValue().key2, entry.getValue().value2);
      map.set(entry.getKey(), entry.getValue().value);
    }
    log.clear();
  }
}
