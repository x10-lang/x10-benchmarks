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

// a collection of resilient stores, one per place in a place group
abstract class Store[V]{V haszero} {
  // get the value for the given key in the local store
  abstract def get(key:Int):V;

  // set the value for the given key in the local store
  abstract def set(key:Int, value:V):void;

  // get the value for the given key at the specified place
  def getRemote(place:Place, key:Int) = at (place) get(key);

  // set the value for the given key at the specified place
  def setRemote(place:Place, key:Int, value:V) { at(place) set(key, value); }

  // clear all the stores in the collection
  abstract def clear():void;

  // update the place group for the store
  // the new place group should have the same size as the old place group
  // after the call the nth place in the new place group owns the store
  // of the nth place in the old place group before the call
  def update(group:PlaceGroup) {}

  // set the value of a local and a remote key
  abstract def set2(key:Int, value:V, place:Place, key2:Int, value2:V):void;

  // retry incomplete invocations of set2 for all the stores in the collection
  def replay() {}

  // instantiate a resilient store with the given name and initial place group
  static def make[V](name:String, group:PlaceGroup){V haszero} {
    return new HazelcastStore[V](name, group);
  }
}
