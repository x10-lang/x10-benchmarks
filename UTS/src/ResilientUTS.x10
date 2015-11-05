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
  val time0:Long;
  val map:Store;
  val wave:Int;
  val group:PlaceGroup;
  val workers:Rail[Worker];
  val power:Int;
  val mask:Int;
  val resilient:Boolean;
  var failureTime:Long;
  
  static def println(time0:Long, message:String) {
    val time = System.currentTimeMillis();
    val s = "        " + (time - time0);
    val s1 = s.substring(s.length() - 9n, s.length() - 3n);
    val s2 = s.substring(s.length() - 3n, s.length());
    Console.OUT.println(s1 + "." + s2 + ": " + message);
    return time;
  }

  def this(wave:Int, group:PlaceGroup, power:Int, resilient:Boolean, time0:Long, map:Store) {
    this.map = map;
    this.group = group;
    this.wave = wave;
    this.power = power;
    this.resilient = resilient;
    this.time0 = time0;
    mask = (1n << power) - 1n;
    workers = new Rail[Worker](1n << power);
  }
  
  public static def setAndStartKiller(time0:Long, time:Long) {
	  if(time > 0 && ! killer.isStarted()) {
		  killer.setTime0(time0);
		  setKillTime(time);
		  startKiller();
	  }
  }
  
  public static def setKillTime(time:Long) {
	  killer.setKillTime(time);
  }
  
  public static def startKiller() {
	  killer.startKiller();
  }
  
  private static class Killer implements java.lang.Runnable {
	  def this() {
		  this.started = false;
	  }
	  
	  public def setTime0(time0:Long) {
		  this.time0 = time0;
	  }
	  
	  public def startKiller() {
		  if(killDelay > 0) {
			  this.started = true;
			  val t = new java.lang.Thread(this, "Suicide (delayed) thread");
			  t.setDaemon(true);
			  t.start();
			  // we can lose the to reference, since there is no
			  // way to cancel suicide :-
		  }
	  }
	  
	  def setKillTime(newTime:Long) {
		  this.killDelay = newTime;
	  }
	  
	  public def isStarted() {
		  return started;
	  }
	  
	  private var killDelay : Long;
	  private var started : Boolean;
	  private var time0 : Long;
	  
	  public def run():void {
		  if(killDelay <= 0) {
			  return;
		  }
		  val startTime = java.lang.System.nanoTime();

		  val endTime = startTime + killDelay;
		  var curTime : Long;
		  
		  while ((curTime = java.lang.System.nanoTime()) < endTime) {
			  val timeLeftNs = endTime - curTime;
			  val timeLeftMspart = timeLeftNs / 1000;
			  val timeLeftNspart = timeLeftNs % 1000;
			  try {
				  java.lang.Thread.sleep(timeLeftMspart, timeLeftNspart as Int);
			  } catch (iex:java.lang.InterruptedException) {}
		  }
		  // time ran out.  time to commit suicide
		  // NB: do not use -1, since this will be
		  // interpreted by the X10Launcher as ssh failing to start the process
		  println(time0, "Suicide at " + here);
		  java.lang.Runtime.getRuntime().halt(1n);
	  }
  };
  
  private static killer:Killer = new Killer();
  
  
  static def init(plh:PlaceLocalHandle[ResilientUTS], size:Int, ratio:Int, time0:Long, killTime:Long) {
    val me = plh();
    for (i in 0n..me.mask) me.workers(i) = me.new Worker(plh, i, size, ratio);
    System.registerPlaceRemovedHandler((p:Place) => { me.unblock(p); });
    setAndStartKiller(time0, killTime);
  }

  def unblock(p:Place) {
    if (!group.contains(p)) {
      return;
    }
    if (p.id > 0) {
      println(time0, "Observing failure of " + p + " from " + here);
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
    var thread:java.lang.Thread;
    var failed:Long;
    val stack = new CheckedThrowable();
    val cell = GlobalRef[Cell[Boolean]](new Cell[Boolean](false));
    
    def this(plh:PlaceLocalHandle[ResilientUTS], id:Int, size:Int, ratio:Int) {
      this.plh = plh;
      me = (group.indexOf(here.id) as Int << power) + id;
      random = new Random(me);
      prev = (me + (group.size() as Int << power) - 1n) % (group.size() as Int << power);
      next = (me + 1n) % (group.size() as Int << power);
      lifeline = new AtomicBoolean(((next % ratio) != 0n) || ((next / ratio) >= size));
    }

    /* atomic */ def abort() {
      if (state == -3n) {
        throw new DeadPlaceException(here);
      }
    }

    def run() {
      thread = java.lang.Thread.currentThread();
      try {
        atomic {
          abort();
          state = -1n;
        }
        while (bag.size > 0n) {
          while (bag.size > 0n) {
            for (var n:Int = 500n; (n > 0n) && (bag.size > 0n); --n) {
              bag.expand(md);
            }
            atomic { abort(); }
            distribute();
          }
          if (resilient) {
            map.setRemote(me, bag.trim(), cell);
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
        if (state == -3n) atomic {
          val now = println(time0, "Aborting worker " + me); 
          if(now - failed > 1000) stack.printStackTrace();
        }
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
        if (state == -3n) return;
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
      if (state == -3n) return;
      if (loot != null) {
        bag.merge(loot);
      }
      state = -1n;
//    notifyAll();
    }

    atomic def unblock(p:Place) {
      failed = println(time0, "Unblocking " + me);
      @x10.compiler.Native("java", "if (stack != null && thread != null) stack.setStackTrace(thread.getStackTrace());") {}
      state = -3n;
//    notifyAll();
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
          map.transfer(me, bag.trim(), t, loot, cell);
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
            map.transfer(me, bag.trim(), t, loot, cell);
          }
          lifeline.set(false);
          val id = t & mask;
          val plh = this.plh;
          at (group(t >> power)) async plh().workers(id).lifelinedeal(loot);
        }
      }
    }
  }
  
  static def step(bags:ArrayList[Bag], wave:Int, power:Int, resilient:Boolean, time0:Long, killTimes:Rail[Long]) {
    val group = Place.places();
    val surplus = bags.size() - (group.size() << power);
    println(time0, "Surplus " + surplus);
    for (i in 0..(surplus-1n)) {
      val b = bags.removeLast();
      val id = i * (group.size() << power) / surplus;
      bags.get(id).merge(b);
      bags.get(id).count += b.count;
    }
    val s = bags.size() as Int;
    val r = (group.size() as Int << power) / s;
    println(time0, "s " + s);
    println(time0, "r " + r);
    val map = resilient ? Store.make("map" + wave): null;
    val plh = PlaceLocalHandle.make[ResilientUTS](group, () => new ResilientUTS(wave, group, power, resilient, time0, map));
    if (wave >= 0) println(time0, "Wave " + wave + ": PLH init complete");
    // WORKAROUND x10c codegen bug
    // which otherwise hoists the Rail.value
    // before the null check
    val kts = killTimes as Any;
    finish for (p in group) {
    	    val kt:Long;
    	    if(kts == null) {
    	    	  kt = 0;
    	    } else {
    	    	  kt = (kts as Rail[Long])(p.id); 
    	    }
    		at (p) async init(plh, s, r, time0, kt);
    }
    if (wave >= 0) println(time0, "Wave " + wave + ": Workers init complete"); 
    if (resilient) {
      for (i in 0n..(s-1n)) map.set(i * r, bags.get(i));
    }
    if (wave >= 0) println(time0, "Wave " + wave + ": Setup complete"); 
    var failed:Boolean = false;
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
      failed = true;
//      e.printStackTrace();
    }
    if (wave >= 0) println(time0, "Wave " + wave + ": Compute complete"); 
    val bag = new Bag();
    val l = new ArrayList[Bag]();
    if (resilient && failed) {
      for (b in map.values()) {
        if (b.size > 0n) {
          l.add(b);
        } else {
          bag.count += b.count;
        }
      }
      map.clear();
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
    if (wave >= 0) println(time0, "Wave " + wave + ": Collection complete"); 
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
    val time0 = System.currentTimeMillis();
    
    var opt:Options = null;
    try {
    	  opt = new Options(args);
    } catch(ex:IllegalArgumentException) {
    	  val msg = ex.getMessage();
    	  if(! msg.equals("help")) {
    	  	Console.ERR.println(ex.getMessage());
    	  	System.setExitCode(-1n);
    	  }
    	  Options.printUsage();
    	  return;
    }
    
    val maxPlaces = Place.places().size();
    val useHazelcast = "Hazelcast".equalsIgnoreCase(java.lang.System.getProperty("X10RT_DATASTORE", "none"));
    Console.OUT.println("Depth: " + opt.depth + ", Warmup: " + opt.warmupDepth + ", Places: " + maxPlaces
        + ", Workers/P: " + (1n << opt.power) + ", Res mode: " + Runtime.RESILIENT_MODE
        + ", HC: " + useHazelcast);

    val resilient = Runtime.RESILIENT_MODE != 0n;
    val missing = (1n << opt.power) + 1n - Runtime.NTHREADS;
    if (missing > 0) {
      finish for (p in Place.places()) at (p) async {
        for (i in 1..missing) Runtime.increaseParallelism();
      }
    }

    val md = Bag.encoder();

    println(time0, "Warmup...");

    val tmp = new Bag(64n);
    tmp.seed(md, 19n, opt.warmupDepth);
    finish step(explode(tmp), -1n, opt.power, resilient, time0, null);

    println(time0, "Begin");
    val startTime = System.nanoTime();

    val bag = new Bag(64n);
    bag.seed(md, 19n, opt.depth);
    var bags:ArrayList[Bag] = explode(bag);

    var wave:Int = 0n;
    while (bags.get(0).size > 0) {
      val w = wave++;
      println(time0, "Wave " + w + ": Starting");
      try {
        finish bags = ResilientUTS.step(bags, w, opt.power, resilient, time0, opt.killTimes);
      } catch (e:MultipleExceptions) {
        println(time0,  "Wave " + w + ": Failed");
        e.printStackTrace();
      }
      println(time0, "Wave " + w + ": Finished");
    }

    val stopTime = System.nanoTime();
    println(time0, "End");

    val time = stopTime - startTime;

    Console.OUT.println("Depth: " + opt.depth + ", Places: " + maxPlaces
        + ", Workers/P: " + (1n << opt.power) + ", Res mode: " + Runtime.RESILIENT_MODE
        + ", HC: " + useHazelcast
        + ", Places left: " + Place.places().size()
        + ", Waves: " + wave + ", Perf: " + bags.get(0).count + "/"
        + Bag.sub("" + time / 1e9, 0n, 6n) + " = "
        + Bag.sub("" + (bags.get(0).count / (time / 1e3)), 0n, 6n) + "M nodes/s");
  }
  
  static class Options {

	  val depth:Int;
	  val warmupDepth:Int;
	  val power:Int;
	  val killTimes:Rail[Long];
	  
	  def this(args:Rail[String]) {
		  var specifiedDepth:Int = 13n;
		  var specifiedWarmupDepth:Int = -2n;
		  var specifiedWorkers:Int = 1n;
		  // for each place, stores a time to suicide
		  // 0 means that it will not suicide
		  this.killTimes = new Rail[Long](Place.numAllPlaces());
		  
		  for(var curArg:Long = 0; curArg < args.size; curArg++) {
			  val arg = args(curArg);
			  
			  if(arg.equalsIgnoreCase("-help") || arg.equalsIgnoreCase("-usage")) {
				  throw new IllegalArgumentException("help");
			  } else if(arg.equalsIgnoreCase("-workers") || arg.equalsIgnoreCase("-w")) {
				  curArg++;
				  if(curArg >= args.size) {
					  throw new IllegalArgumentException("Illegal " + arg + " argument with no corresponding number");
				  }
				  val arg2 = args(curArg);
				  try {
					  specifiedWorkers = Int.parseInt(arg2);
				  } catch(e:Exception) {
					  throw new IllegalArgumentException("workers argument is not parseable as an integer " + arg2);
				  }
			  } else if(arg.equalsIgnoreCase("-depth") || arg.equalsIgnoreCase("-d")) {
				  curArg++;
				  if(curArg >= args.size) {
					  throw new IllegalArgumentException("Illegal " + arg + " argument with no corresponding depth");
				  }
				  val arg2 = args(curArg);
				  try {
					  specifiedDepth = Int.parseInt(arg2);
				  } catch(e:Exception) {
					  throw new IllegalArgumentException("depth argument is not parseable as an integer " + arg2);
				  }
			  } else if(arg.equalsIgnoreCase("-warmupDepth") || arg.equalsIgnoreCase("-warmup") || arg.equalsIgnoreCase("-wd")) {
				  curArg++;
				  if(curArg >= args.size) {
					  throw new IllegalArgumentException("Illegal " + arg + " argument with no corresponding depth");
				  }
				  val arg2 = args(curArg);
				  try {
					  specifiedWarmupDepth = Int.parseInt(arg2);
				  } catch(e:Exception) {
					  throw new IllegalArgumentException("warmupDepth argument is not parseable as an integer " + arg2);
				  }
			  } else if(arg.equalsIgnoreCase("-kill") || arg.equalsIgnoreCase("-killAfter") || arg.equalsIgnoreCase("-k")) {
				  curArg++;
				  if(curArg >= args.size) {
					  throw new IllegalArgumentException("Illegal " + arg + " argument with no corresponding place:timespan argument");
				  }
				  val arg2 = args(curArg);
				  val sp = arg2.split(":");
				  if(sp.size != 2) {
					  throw new IllegalArgumentException("Malformed " + arg + " argument: '" + arg2 + "' does not have exactly one colon");
				  }

				  val timeString : String = sp(1);
				  var timeToKill : Long;
				  try {
					  timeToKill = getTime(timeString);
				  } catch(e:Exception) {
					  throw new IllegalArgumentException("Malformed " + arg + " argument.  The second part of '" + arg2 + "' is not parseable as a long.  Note that only ns, ms, s, and m, and h are allowed as suffixes");
				  }
				  
				  // allow comma separated list of places which can have ranges
				  val toKillRangeList = sp(0).split(",");
				  for(toKillRange in toKillRangeList) {
					  val range = toKillRange.split("-");
					  if(range.size == 0) {
						  // allow and ignore stray commas
						  continue;
					  } else if(range.size > 2) {
						  throw new IllegalArgumentException("Malformed " + arg + " argument.  The first part of '" 
								  + arg2 + "' has an invalid range specification: '" 
								  + toKillRange + "' (too many - symbols)");
					  }

					  var firstPlaceToKill : Long = -1L;
					  var lastPlaceToKill : Long = -1L;

					  try {
						  firstPlaceToKill = Long.parseLong(range(0));
					  } catch(e:Exception) {
						  throw new IllegalArgumentException("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a place specifier '" +range(0) + "'that is not parseable as a place list");
					  }
					  
					  if(range.size == 2) {
						  try {
							  lastPlaceToKill = Long.parseLong(range(1));
						  } catch(e:Exception) {
							  throw new IllegalArgumentException("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a place specifier '" +range(1) + "'that is not parseable as a place list");
						  }
					  } else {
						  lastPlaceToKill=firstPlaceToKill;
					  }
					  if(firstPlaceToKill < 0 || firstPlaceToKill > lastPlaceToKill) {
						  throw new IllegalArgumentException("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a range specifier '" + toKillRange + "' that is not a valid range.");
					  }
					  
					  if(firstPlaceToKill == 0) {
						  throw new IllegalArgumentException("The " + arg + " argument.  Requested that place 0 die (as part of) '" + arg2 + "', specifically '" +  toKillRange + "'.  We don't currently support killing place 0");
					  }

					  // allow and ignore places that are too large
					  val cappedLastPlaceToKill = Math.min(lastPlaceToKill, Place.numAllPlaces()-1);
					  for(pl in firstPlaceToKill..cappedLastPlaceToKill) {
						  killTimes(pl) = timeToKill;
					  }
					  
				  }
			  } else {
				  try {
					  specifiedDepth = Int.parseInt(arg);
				  } catch(e:Exception) {
					  throw new IllegalArgumentException("Unknown argument " + arg);
				  }
			  }
		  }
		  
		  if(specifiedDepth <= 0) {
			  throw new IllegalArgumentException("depth argument must be greater than zero, not " + specifiedDepth);
		  }

		  if(specifiedWorkers < 0) {
			  throw new IllegalArgumentException("workers argument must be less than zero, not " + specifiedWorkers);
		  }
		  
		  this.depth = specifiedDepth;
		  this.warmupDepth = specifiedWarmupDepth < 0n ? specifiedDepth + specifiedWarmupDepth : specifiedWarmupDepth;
		  this.power = specifiedWorkers;
	  }
	  
	  /**
	   * parses a string and returns the corresponding timespan in nanoseconds
	   */
	  public static def getTime(var timeString:String):Long {
		  val units : Long;

		  if(timeString.endsWith("ns")) {
			  timeString = timeString.substring(0n,(timeString.length()-2n) as Int);
			  units = 1;
		  } else if(timeString.endsWith("ms")) {
			  timeString = timeString.substring(0n,(timeString.length()-2n) as Int);
			  units = 1000;
		  } else if(timeString.endsWith("s")) {
			  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
			  units = 1000*1000;
		  } else if(timeString.endsWith("m")) {
			  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
			  units = 1000*1000*60;
		  } else if(timeString.endsWith("h")) {
			  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
			  units = 1000*1000*60*60;
		  } else {
			  units = 1;
		  }
		  return Long.parseLong(timeString) * units;
	  }
	  
	  static def printUsage() {
		  Console.ERR.println("invoked as ResilientUTS ARGS where ARGS can be from");
		  Console.ERR.println("-help\t\tPrint this usage message and quit");
		  
		  Console.ERR.println("-workers <INT>\t\tSet the base-2 log of the number of workers used (per-place).");
		  Console.ERR.println("-depth <INT>\t\tSet the depth to be used");
		  Console.ERR.println("-d <INT>\t\tSet the depth to be used");
		  Console.ERR.println("<INT>\t\tSet the depth to be used");
		  Console.ERR.println("-warmupDepth <INT>\t\tSet the depth to be used for warmup.  Negative value is relative to depth.  0 omits the warmup. The default is -2");
	
		  Console.ERR.println("-kill <place>:<timespan>\t\tTells the place to kill itself after the allotted timespan (after any warmup)");
		  Console.ERR.println("\t\t <timespan> can be specified, using an optional suffix, in nanoseconds (ns, default), milliseconds (ms), seconds(s), minutes(m), or hours(h)");
		  
	  }
  }
}
