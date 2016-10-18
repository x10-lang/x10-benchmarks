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

abstract class Store[V]{V haszero} {
  abstract def get(key:Int):V;
  abstract def set(key:Int, value:V):void;
  abstract def set2(key:Int, value:V, place:Place, key2:Int, value2:V):void;
  abstract def clear():void;

  def update(group:PlaceGroup) {}
  def replay() {}

  def getRemote(place:Place, key:Int) = at (place) get(key);
  def setRemote(place:Place, key:Int, value:V) { at(place) set(key, value); }

  static def make[V](name:String, group:PlaceGroup){V haszero} {
    return new HazelcastStore[V](name, group);
  }
}
