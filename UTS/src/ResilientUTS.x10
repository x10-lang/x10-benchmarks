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

import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import java.util.concurrent.ConcurrentLinkedQueue;

import x10.compiler.Uncounted;
import x10.interop.Java;
import x10.io.Unserializable;
import x10.util.concurrent.AtomicBoolean;
import x10.util.resilient.ResilientMap;
import x10.util.resilient.ResilientTransactionalMap;
import x10.util.ArrayList;
import x10.util.Collection;
import x10.util.Map.Entry;
import x10.xrx.Runtime;

final class ResilientUTS implements Unserializable {
  val map:ResilientMap[Int,Bag];
  val wave:Int;
  val group:PlaceGroup;
  val workers:Rail[Worker];
  val power:Int;
  val mask:Int;
  val resilient:Boolean;

  def this(wave:Int, group:PlaceGroup, power:Int, resilient:Boolean) {
    map = resilient ? ResilientMap.getMap[Int,Bag]("map" + wave) : null;
    this.group = group;
    this.wave = wave;
    this.power = power;
    this.resilient = resilient;
    mask = (1n << power) - 1n;
    workers = new Rail[Worker](1n << power);
  }
  
  static def init(plh:PlaceLocalHandle[ResilientUTS], size:Int, ratio:Int) {
    val me = plh();
    for (i in 0n..me.mask) me.workers(i) = me.new Worker(plh, i, size, ratio);
    System.registerPlaceRemovedHandler((p:Place) => { me.unblock(p); });
  }

  def unblock(p:Place) {
    if (!group.contains(p)) {
      return;
    }
    if (p.id > 0) {
      Console.ERR.println("Observing failure of " + p + " from " + here);
    }
    for (i in 0n..mask) workers(i).unblock(p);
  }

  final class Worker implements Unserializable {
    val plh:PlaceLocalHandle[ResilientUTS];
    val me:Int;
    val prev:Int;
    val next:Int;
    val random:Random;
    val md = Bag.encoder();
    val bag = new Bag(64n);
    val thieves:ConcurrentLinkedQueue = new ConcurrentLinkedQueue();
    val lifeline:AtomicBoolean;
    var state:Int;
    
    def this(plh:PlaceLocalHandle[ResilientUTS], id:Int, size:Int, ratio:Int) {
      this.plh = plh;
      me = (group.indexOf(here.id) as Int << power) + id;
      random = new Random(me);
      prev = (me + (group.size() as Int << power) - 1n) % (group.size() as Int << power);
      next = (me + 1n) % (group.size() as Int << power);
      lifeline = new AtomicBoolean(((next % ratio) != 0n) || ((next / ratio) >= size));
    }

    atomic def abort() {
      if (state == -3n) {
        throw new DeadPlaceException(here);
      }
    }
    
    def run() {
      try {
        Console.ERR.println(me + " starting");
        atomic {
          abort();
          state = -1n;
        }
        while (bag.size > 0n) {
          while (bag.size > 0n) {
            for (var n:Int = 500n; (n > 0n) && (bag.size > 0n); --n) {
              bag.expand(md);
            }
            abort();
            distribute();
          }
          if (resilient) {
            map.set(me, bag.trim());
          }
          steal();
        }
        atomic {
          abort();
          state = -2n;
        }
        distribute();
        lifelinesteal();
      } catch (DigestException) {
      } finally {
        Console.ERR.println(me + " stopping");
      }
    }

    def lifelinesteal() {
      if (group.size() == 1 && power == 0n) {
        return;
      }
      val id = prev & mask;
      val plh = this.plh;
      at (group(prev >> power)) @Uncounted async plh().workers(id).lifeline.set(true);
    }

    def steal() {
      if (group.size() == 1 && power == 0n) {
        return;
      }
      val me = this.me;
      var p:Int = random.nextInt((group.size() as Int << power) - 1n);
      if (p >= me) {
        p++;
      }
      atomic {
        abort();
        state = p;
      }
      val id = p & mask;
      val plh = this.plh;
      at (group(p >> power)) @Uncounted async plh().workers(id).request(me);
      when(state < 0n);
    }

    def request(thief:Int) {
      atomic {
        if (state == -3n) {
          return;
        }
        if (state == -1n) {
          thieves.add(thief);
          return;
        }
      }
      val id = thief & mask;
      val plh = this.plh;
      at (group(thief >> power)) @Uncounted async plh().workers(id).deal(null);
    }
    
    def lifelinedeal(b:Bag) {
      bag.merge(b);
      run();
    }

    atomic def deal(loot:Bag) {
      if (state == -3n) {
        return;
      }
      if (loot != null) {
        bag.merge(loot);
      }
      state = -1n;
//    notifyAll();
    }

    atomic def unblock(p:Place) {
      state = -3n;
//    notifyAll();
    }

    def transfer(thief:Int, loot:Bag) {
      val bag = this.bag.trim();
      val me = this.me;
      ResilientTransactionalMap.runTransaction("map" + wave, (map:ResilientTransactionalMap[Int,Bag]) => {
        map.set(me, bag);
        val old = map.getForUpdate(thief);
        loot.count = old == null ? 0 : old.count;
        map.set(thief, loot);
        return null;
      });
    }

    def distribute() {
      if (group.size() == 1 && power == 0n) {
        return;
      }
      var thief:Any;
      while ((thief = thieves.poll()) != null) {
        val t = thief as Int;
        val loot = bag.split();
        if (loot != null && resilient) {
          transfer(t, loot);
        }
        val id = t & mask;
        val plh = this.plh;
        at (group(t >> power)) @Uncounted async plh().workers(id).deal(loot);
      }
      if (bag.size > 0n && lifeline.get()) {
        val loot = bag.split();
        if (loot != null) {
          val t = next;
          if (resilient) {
            transfer(t, loot);
          }
          lifeline.set(false);
          val id = t & mask;
          val plh = this.plh;
          at (group(t >> power)) async plh().workers(id).lifelinedeal(loot);
        }
      }
    }
  }
  
  static def step(bags:ArrayList[Bag], wave:Int, power:Int, resilient:Boolean) {
    val group = Place.places();
    while (bags.size() > (group.size() << power)) {
      val b = bags.removeLast();
      bags.get(0).merge(b);
      bags.get(0).count += b.count;
    }
    val s = bags.size() as Int;
    val r = (group.size() as Int << power) / s;
    val plh = PlaceLocalHandle.make[ResilientUTS](group, () => new ResilientUTS(wave, group, power, resilient));
    finish for (p in group) at (p) async init(plh, s, r);
    if (resilient) {
      for (i in 0n..(s-1n)) plh().map.set(i * r, bags.get(i));
    }
    try {
      finish {
        for (i in 1n..(s-1n)) {
          val bag = bags.get(i);
          val id = (i * r) & plh().mask;
          at (group((i * r) >> power)) async {
            plh().workers(id).bag.count = bag.count;
            plh().workers(id).lifelinedeal(bag);
          }
        }
        plh().workers(0).bag.count = bags.get(0).count;
        plh().workers(0).lifelinedeal(bags.get(0));
      }
    } catch (e:MultipleExceptions) {
      e.printStackTrace();
    }
    val bag = new Bag();
    val l = new ArrayList[Bag]();
    if (resilient) {
      val values:Collection[Bag] = ResilientTransactionalMap.runTransaction("map" + wave,
          (map:ResilientTransactionalMap[Int,Bag]) => {
            // return map.values();
            @x10.compiler.Native("java", "return map.values();") { return null as Collection[Bag]; }
          });
      for (b in values) {
        if (b.size > 0n) {
          l.add(b);
        } else {
          bag.count += b.count;
        }
      }
    } else {
      val ref = new GlobalRef(bag);
      finish for (p in group) {
        at (p) async {
          var count:Long = 0;
          for (i in 0n..((1n << power) - 1n)) count += plh().workers(i).bag.count;
          val c = count;
          at (ref) async ref().count += c;
        }
      }
      ref.forget();
    }
    if (!l.isEmpty()) {
      l.get(0).count += bag.count;
    } else {
      l.add(bag);
    }
    return l;
  }

  static def explode(bag:Bag) {
    val bags = new ArrayList[Bag]();
    for (i in 0n..(bag.upper(0)-1n)) {
      val b = new Bag(64n);
      b.merge(bag);
      if (i == 0n) {
        b.count = 1;
      }
      b.lower(0) = i;
      b.upper(0) = i + 1n;
      bags.add(b);
    }
    return bags;
  }

  public static def main(args:Rail[String]) {
    var depth:Int = 13n;
    try {
      depth = Int.parse(args(0));
    } catch (Exception) {}
    var power:Int = 1n;
    try {
      power = Int.parse(args(1));
    } catch (Exception) {}
    val resilient = Runtime.RESILIENT_MODE != 0n;
    val missing = (1n << power) + 1n - Runtime.NTHREADS;
    if (missing > 0) {
      finish for (p in Place.places()) at (p) async {
        for (i in 1..missing) Runtime.increaseParallelism();
      }
    }
    val maxPlaces = Place.places().size();

    val md = Bag.encoder();

    Console.OUT.println("Warmup...");

    val tmp = new Bag(64n);
    tmp.seed(md, 19n, depth - 2n);
    finish step(explode(tmp), -1n, power, resilient);

    Console.OUT.println("Starting...");
    var time:Long = -System.nanoTime();

    val bag = new Bag(64n);
    bag.seed(md, 19n, depth);
    var bags:ArrayList[Bag] = explode(bag);

    var wave:Int = 0n;
    while (bags.get(0).size > 0) {
      val w = wave++;
      Console.OUT.println("Wave: " + w);
      try {
        finish bags = ResilientUTS.step(bags, w, power, resilient);
      } catch (e:MultipleExceptions) {
        e.printStackTrace();
      }
    }

    time += System.nanoTime();
    Console.OUT.println("Finished.");

    Console.OUT.println("Depth: " + depth + ", Places: " + maxPlaces
        + ", Waves: " + wave + ", Performance: " + bags.get(0).count + "/"
        + Bag.sub("" + time / 1e9, 0n, 6n) + " = "
        + Bag.sub("" + (bags.get(0).count / (time / 1e3)), 0n, 6n) + "M nodes/s");
  }
}
