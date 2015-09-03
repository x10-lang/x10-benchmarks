package uts;

import x10.util.concurrent.Monitor;

import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.util.Random;
import java.util.concurrent.ConcurrentLinkedQueue;

import x10.util.concurrent.AtomicBoolean;
import x10.util.concurrent.AtomicLong;

import x10.interop.Java;
import x10.compiler.Native;
import x10.compiler.Uncounted;
import x10.io.Unserializable;
import x10.util.resilient.ResilientMap;
import x10.util.resilient.ResilientTransactionalMap;
import x10.util.Map.Entry;
import x10.util.Set;
import x10.util.HashSet;
import x10.util.Pair;

import x10.util.StringBuilder;

/**
 * Worker class to compute UTS.
 * For the resilient version, the computation uses the resilient map to checkpoint
 * the state of the computation.
 * It keeps as an: sum_{checkpoints in map} UTS(Checkpoint).
 * Where UTS(cp)=cp.count+UTS.seq(cp.bag).
 * The goal is to get cp.bag==0 for all the bags (so they have all finished working)
 * and to reduce things to having a single checkpoint (so that it is easy to read the answer out).
 * All map operations (in full transactional mode) are careful to preserve this 
 * invariant, ensuring that the answer (if computed) is correct.
 * 
 */
final class UTSWorker(numWorkersPerPlace:Long) implements Unserializable {
	private static val DEBUG=false;
	
	static type LocalWorkers(n:Long) = Rail[UTSWorker{numWorkersPerPlace==n}]{self.size==n};
	static type Workers(n:Long) = PlaceLocalHandle[LocalWorkers(n)];

	public static def make(diffThreads:Int, pg:PlaceGroup, numWorkersPerPlace:Long, transfer_mode:Int, killTimes:Rail[Long]):Workers(numWorkersPerPlace) {
		val numPlaces = pg.size();
		val numLocations = numPlaces * numWorkersPerPlace;
		val workers = PlaceLocalHandle.make(pg,
				(p:Place) => pg.indexOf(p),
				(placeIndex:Long) => {
					val baseLocation = placeIndex*numWorkersPerPlace;
					return new Rail[UTSWorker{self.numWorkersPerPlace==numWorkersPerPlace}](numWorkersPerPlace, 
						(i:Long) => 
							new UTSWorker(baseLocation+i, numLocations, numWorkersPerPlace, transfer_mode) as UTSWorker{self.numWorkersPerPlace==numWorkersPerPlace})
							as LocalWorkers(numWorkersPerPlace);
				});
		initAllWorkers(diffThreads, pg, numWorkersPerPlace, workers, killTimes);
		return workers;
	}
	
	def this(globalLocation:Long, locations:Long, numWorkersPerPlace:Long, transfer_mode:Int)
	:UTSWorker{self.numWorkersPerPlace==numWorkersPerPlace} {
		property(numWorkersPerPlace);

		this.transfer_mode = transfer_mode;
		if(useMap()) {
			this.map = ResilientMap.getMap[Long,Checkpoint]("map");
		}
		this.location = globalLocation;
		this.numLocations = locations;
		val lastLocation = locations - 1;
		// Warning: I am not confident that initialization is resilient
		// Note: we don't have to worry about overflow,
		val llfrom = globalLocation == lastLocation ? -1 : globalLocation+1; 
		this.lifeline = new AtomicLong(llfrom);
		this.harvestedVictims = new HashSet[Long]();
		
		val nextLocation = (globalLocation + numLocations - 1) % numLocations;
		this.nextLocationInLifelineGraph = new AtomicLong(nextLocation);
	}	

	var pg:PlaceGroup;
	var workers:Workers(numWorkersPerPlace);

	private def initWorkers(pg:PlaceGroup, new_workers:Workers(numWorkersPerPlace)) {
		this.pg = pg;
		this.workers = new_workers;
		if(Stats.IS_TRACE()) {
			this.stats = new Stats(" " + getLocationString(location));
		} else {
			this.stats = new Stats();			
		}
	}
	
	private static def adjustThreads(diffThreads:Int) {
		if(diffThreads > 0n) {
			for(var i:Int = 0n; i < diffThreads; i++) {
				x10.xrx.Runtime.increaseParallelism();
			}
		} else if(diffThreads < 0n) {
			x10.xrx.Runtime.decreaseParallelism(-diffThreads);
		}
	}
	
	private def resetWorker() {
		this.bag = new Bag(4096n);
		this.count = 0;
	}
	
	public static def resetAllWorkers(pg:PlaceGroup, numWorkersPerPlace:Long, workers:Workers(numWorkersPerPlace)) {
		try {
			finish {
				val pl = pg;
				for (p in pl) {
					if(p != here) {
						val wplh = workers;
						async at(p) {
							for(w in wplh()) {
								w.resetWorker();
							}
						}
					}
				}
				if(pl.contains(here)) {
					for(w in workers()) {
						w.resetWorker();
					}
				}
			}
		} catch(me:MultipleExceptions) {
			val me2 = me.filterExceptionsOfType[DeadPlaceException](true);
			if(me2 != null) {
				throw me;
			} else {
				// Just DeadPlaceExceptions, which can be safely ignored
			}
		}
	}
	
	public static def setKillTime(time:Long) {
		killer.setKillTime(time);
	}
	
	public static def startKiller() {
		killer.startKiller();
	}
	
	private static class Killer implements java.lang.Runnable {
		def this() { }
		
		public def startKiller() {
			if(killDelay > 0) {
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
		
		private var killDelay : Long;
		
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
			java.lang.System.exit(1n);
		}
	};
	
	private static killer:Killer = new Killer();
	
	public static def startAllKillers(
			pg:PlaceGroup, 			
			numWorkersPerPlace:Long, 
			workers:Workers(numWorkersPerPlace)) { 
		try {
			finish {
				val pl = pg;
				for (p in pl) {
					if(p != here) {
						val wplh = workers;
						async at(p) {
							startKiller();
						}
					}
				}
			}
		} catch(me:MultipleExceptions) {
			val me2 = me.filterExceptionsOfType[DeadPlaceException](true);
			if(me2 != null) {
				throw me;
			} else {
				// Just DeadPlaceExceptions, which can be safely ignored
			}
		}
	}
			
	public static def initAllWorkers(
			diffThreads:Int,
			pg:PlaceGroup, 
			numWorkersPerPlace:Long, 
			workers:Workers(numWorkersPerPlace), 
			killTimes:Rail[Long]) {
		try {
			finish {
				val pl = pg;
				for (p in pl) {
					if(p != here) {
						val wplh = workers;
						val killTime = killTimes(p.id);
						async at(p) {
							setKillTime(killTime);
							adjustThreads(diffThreads);
							registerPlaceDeadHandler(numWorkersPerPlace, wplh());
							for(w in wplh()) {
								w.initWorkers(pg, workers);
							}
						}
					}
				}
				if(pl.contains(here)) {
					val killTime = killTimes(here.id);
					setKillTime(killTime);
					adjustThreads(diffThreads);
					registerPlaceDeadHandler(numWorkersPerPlace, workers());
					for(w in workers()) {
						w.initWorkers(pg, workers);
					}
				}
			}
		} catch(me:MultipleExceptions) {
			val me2 = me.filterExceptionsOfType[DeadPlaceException](true);
			if(me2 != null) {
				throw me;
			} else {
				// Just DeadPlaceExceptions, which can be safely ignored
			}
		}
	}
	
	static def encoder():MessageDigest {
		try {
			return MessageDigest.getInstance("SHA-1");
		} catch (val e:NoSuchAlgorithmException) {
			Console.ERR.println("Could not initialize a MessageDigest for the \"SHA-1\" algorithm");
			e.printStackTrace();
		}
		return null;
	}
	
	val sync_lock:Monitor = new Monitor();	
	
	private static def registerPlaceDeadHandler(numWorkersPerPlace:Long, workers:LocalWorkers(numWorkersPerPlace)) {
		System.registerPlaceRemovedHandler((place:Place) => {
			if(place.id > 0) {
				Console.ERR.println(here + " observes that " + place + " failed!");
			}
			for(worker in workers) {
				worker.handle(place);
			}
		});
	}
		
	// TODO: think about and fix the handler
	private def handle(p:Place):void {
		sync_lock.lock();
		if(DEBUG) {
			Console.ERR.println(getLocationString(location) + " has STATE=" + state + " and observes that " + p + " failed!");
		}
		if(state == -2) { // if we are sleeping (lifelined)
			try {
				val lloc = nextLocationInLifelineGraph.get();
				val lplace = placeOfLocation(lloc);
				// and the dead place had our lifeline,
				// we need to re-establish it with the next location.
				if(p == lplace) {
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": handle(" + p + "): unblocking our lifeline on " + getLocationString(lloc));
					}

					// we had a lifeline established at this place.
					// so we need to try again
					val nextLocation = (lloc + numLocations - numWorkersPerPlace) % numLocations;
					val newLifeline:Long;
					if(nextLocationInLifelineGraph.compareAndSet(lloc, nextLocation)) {
						newLifeline = nextLocation;
					} else {
						newLifeline = nextLocationInLifelineGraph.get();
					}
					lifelinesteal();
					return;
				}
			} finally {
				sync_lock.unlock();
			}
		} else if(state >= 0) { // p is dead, unblock if waiting on p
			val statePlace = placeOfLocation(state);
			if (statePlace == p) {
				try {
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": handle(" + p + "): unblocking our stealing attempt from " + getLocationString(state));
					}
					// if we are sleeping, we should not have any work to do
					assert this.bag == null || this.bag.size == 0n : "Sleeping (in handle) with non-empty bag";
					// don't bother extracting loot, since there is a race condition here anyway
					// attempt to extract loot from store
					// val c:Checkpoint = map.get(location) as Checkpoint;
					// if (c.bag != null) {
					// 	merge(c.bag);
					// }
					state = -1;
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": STATE=-1 (handle(" + p.id + "))");
					}
				} finally {
					sync_lock.release();
				}
			}
		} else {
			sync_lock.unlock();
		}
	}
	
	final def useMap() {
		return TRANSFER_MODE_NOMAP != transfer_mode;
	}
		
	public static val TRANSFER_MODE_TRANSACTIONAL:Int = 0n;
	public static val TRANSFER_MODE_ATOMIC:Int = 1n;
	public static val TRANSFER_MODE_ATOMIC_SUBMIT:Int = 2n;
	public static val TRANSFER_MODE_NOMAP:Int = 3n;
	public static val TRANSFER_MODE_DEFAULT:Int = TRANSFER_MODE_TRANSACTIONAL;

	private val transfer_mode:Int;
	
	var map:ResilientMap[Long,Checkpoint];

	val location:Long;
	val numLocations:Long;
	
	val random:Random = new Random();
	val md:MessageDigest = encoder();
	val den:double = Math.log(4.0 / (1.0 + 4.0)); // branching factor: 4.0
	var bag:Bag = new Bag(4096n);
	var count:Long;
	
	// a list of victims that are known to be dead and 
	// "harvested" -- we checked, and they don't appear 
	// to have any work to do
	val harvestedVictims:Set[Long];
	
	val thieves:ConcurrentLinkedQueue = new ConcurrentLinkedQueue();
	
	// the place that set the lifeline
	// -1 means that the lifeline is not set
	val lifeline:AtomicLong;
	
	// the next place in the lifeline graph.
	// This is the place we go to when we need to *set* a lifeline
	// with no failures, it would just be location - 1. 
	val nextLocationInLifelineGraph:AtomicLong;
	var state:Long = -2; // -2: inactive, -1: running, p: stealing from p

	var stats:Stats;
	
	def digest() throws DigestException : Int {
		if (bag.size >= bag.depth.size as Int) {
			grow();
		}
		val offset:Int = bag.size * 20n;
		md.digest(Java.convert(bag.hash), offset, 20n);
		++count;
		val v:Int = ((0x7fn & bag.hash(offset + 16n)) << 24n)
		| ((0xffn & bag.hash(offset + 17n)) << 16n)
		| ((0xffn & bag.hash(offset + 18n)) << 8n)
		| (0xffn & bag.hash(offset + 19n));
		return (Math.log(1.0 - v / 2147483648.0) / den) as Int;
	}

	/**
	 * used to reset the bag and get ready for another round.
	 * Should only be called when a round has completed.
	 */
	def init(bag:Bag) {
		this.bag = bag;
		init();
	}
		
	def init(seed:Int, depth:Int) throws DigestException : void {
		initBag(seed, depth);
		init();
	}
	
	private def initBag(seed:Int, depth:Int) throws DigestException : void {
		bag.hash(16) = (seed >> 24n) as Byte;
		bag.hash(17) = (seed >> 16n) as Byte;
		bag.hash(18) = (seed >> 8n) as Byte;
		bag.hash(19) = seed as Byte;
		md.update(Java.convert(bag.hash), 0n, 20n);
		val v:Int = digest();
		if (v > 0n) {
			bag.depth(0) = depth;
			bag.upper(0) = v;
			bag.size = 1n;
		}
	}
	
	
	
	private def init() {
		if(useMap()) {
			map.set(location, new Checkpoint(this.bag, this.count));
		}
	}

	def expand() throws DigestException : void {
		val top:int = bag.size - 1n;
		val d:int = bag.depth(top);
		val l:int = bag.lower(top);
		val u:int = bag.upper(top) - 1n;
		if (d > 1n) {
			if (u == l) {
				--bag.size;
			} else {
				bag.upper(top) = u;
			}
			val offset:int = top * 20n;
			bag.hash(offset + 20n) = (u >> 24n) as Byte;
			bag.hash(offset + 21n) = (u >> 16n) as Byte;
			bag.hash(offset + 22n) = (u >> 8n) as Byte;
			bag.hash(offset + 23n) = u as Byte;
			md.update(Java.convert(bag.hash), offset, 24n);
			val v:int = digest();
			if (v > 0n) {
				bag.depth(bag.size) = d - 1n;
				bag.lower(bag.size) = 0n;
				bag.upper(bag.size++) = v;
			}
		} else {
			--bag.size;
			count += 1 + u - l;
		}
	}
	 
	def grow():void {
		val b:Bag = new Bag((bag.depth.size * 2) as Int);
		Rail.copy(bag.hash, 0, b.hash, 0, bag.size * 20);
		Rail.copy(bag.depth, 0, b.depth, 0, bag.size as Long);
		Rail.copy(bag.lower, 0, b.lower, 0, bag.size as Long);
		Rail.copy(bag.upper, 0, b.upper, 0, bag.size as Long);
		b.size = bag.size;
		bag = b;
	}

	def run() throws DigestException : void {
		if(DEBUG) {
			Console.ERR.println(getLocationString(location) + ": run() starting");
		}
		try {
			sync_lock.lock();
		    try {
				state = -1;
			} finally {
				sync_lock.unlock();
		  	}
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-1 (run)");
			}
			
			while (bag != null && bag.size > 0n) {
				while (bag != null && bag.size > 0n) {
					for (var n:int = 500n; (n > 0n) && (bag.size > 0n); --n) {
						expand();
					}
					distribute();
				}
				if(useMap()) {
					val newCheckpoint = new Checkpoint(bag, count);
					if(map.replace(location, newCheckpoint) == null) {
						// since we ran, the bag can't have originally been empty.
						// so this means that the replacement failed
						// because our location was removed from the map
						// which happens only when we are harvested.
						// if we were harvested, someone believes us to be (X10) dead
						// and that believe will propagate, so there is nothing left for us to do
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": run checkpoint replacement failed.  We have been harvested!");
						}
						// since we have been harvested, we can die.
						// we probably don't really need to change states.
						sync_lock.lock();
						try {
							state = -2;
						} finally {
							sync_lock.unlock();
						}
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": STATE=-2 (run after being harvested)");
						}
						return;
					}
				}
				steal();
			}
			
			sync_lock.lock();
			try {
				state = -2;
			} finally {
				sync_lock.unlock();
			}
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-2 (run)");
			}
			
			distribute();
			lifelinesteal();
		} finally {
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": run() stopping");
			}
		}
	}

	public def workerOfLocation(loc:Long):Long { 
		return workerOfLocation(pg, numWorkersPerPlace, loc);
	}
	
	public static def workerOfLocation(pg:PlaceGroup, numWorkersPerPlace:Long, loc:Long):Long { 
		return loc % numWorkersPerPlace;
	}

	public def placeOfLocation(loc:Long):Place { 
		return placeOfLocation(pg, numWorkersPerPlace, loc);
	}

	public static def placeOfLocation(pg:PlaceGroup, numWorkersPerPlace:Long, location:Long):Place { 
		return pg(location / numWorkersPerPlace);
	}

	def getLocationString(loc:Long) {
		return getLocationString(pg, numWorkersPerPlace, loc);
	}
	
	static def getLocationString(pg:PlaceGroup, numWorkersPerPlace:Long, location:Long) {
		return 
		location + "=" + placeOfLocation(pg, numWorkersPerPlace, location).id + 
		"[" + workerOfLocation(pg, numWorkersPerPlace, location) + "]"; 
	}

	/**
	 * Returns true if the first thief is "farther" to us then the second thief.
	 * Here farther is defined as per the lifeline graph (from the thief's perspective)
	 */
	// our current lifeline graph is a cycle, where lifelines are established
	// with our closest "backwards" (modular negative) neighbor
	private def fartherThief(thief1:Long, thief2:Long) {
		val thief1Before = thief1 <= this.location;
		val thief2Before = thief2 <= this.location;
		if(thief1Before == thief2Before) {
			// they are both on the same side of us,
			// so the larger one is "farther" away
			return thief1 > thief2;
		} else {
			// they are on opposite sides of us
			// so the one to our "left" is farther away then
			// the one to our "right".
			// since the "left" one is smaller then the right "one",
			// the smaller one must be farther away
			return thief1 < thief2;
		}
	}
	
	private def setLifeline(thief_location:Long) {
		// if there is no current lifeline, set the new one
		val success = this.lifeline.compareAndSet(-1, thief_location);
		if(success) {
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": lifeline set by: " + getLocationString(thief_location));
			}
		} else {
			// there is already a lifeline, so we need to see who will win
			// we always pick the "farthest" thief.
			// This is because that thief would only have requested a lifeline if
			// it believed that the closer place was dead.
			while(true) {
				val oldThief = this.lifeline.get();
				if(fartherThief(thief_location, oldThief)) {
					val success2 = this.lifeline.compareAndSet(oldThief, thief_location);
					if(success2) {
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": lifeline set by the farther: " + getLocationString(thief_location) + ", replacing " + getLocationString(oldThief));
						}
						return;
					}
					// otherwise, there was a race condition, so try again
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": race while trying set a lifeline from: " + getLocationString(thief_location));
					}
				} else {
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": lifeline attemptted to be set by: " + getLocationString(thief_location) + ", but it was an outdated (too close) request");
					}
					return;
				}
			}
		}
	}

	
	
	def lifelinesteal():void {
		if (numLocations == 1) {
			return;
		}

		var victim:Long = nextLocationInLifelineGraph.get();
		while(true) {
			try {
				if(victim == location) {
					// there is no one left to lifeline on
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": nobody left to set a lifeline with :-(");
					}
					return;
				}
				val victim_worker = workerOfLocation(victim);
				val victim_place = placeOfLocation(victim);
				
				val wplh = workers;
				val thief_location = location;
				at(victim_place) async {
					wplh()(victim_worker).setLifeline(thief_location);
				};
				// if we did not get a DPE, we assume success.
				// the handler will take care of matters in that case
				break;
			} catch (e:DeadPlaceException) {
				if(DEBUG) {
					Console.ERR.println(getLocationString(location) + ": failed to set a lifeline at " + getLocationString(victim) + ".  will try the next in line");
				}
				// we retarget to the same worker as before, but at the previous place.
				// we do not want to overwhelm the last worker at the previous place.
				val nextLocation = (victim + numLocations - numWorkersPerPlace) % numLocations;
				if(nextLocationInLifelineGraph.compareAndSet(victim, nextLocation)) {
					victim = nextLocation;
				} else {
					victim = nextLocationInLifelineGraph.get();
				}
			}
		}
	}

	def steal():void {
		if (numLocations == 1) {
			return;
		}
		val thief = location;
		
		var victim:Long = random.nextInt((numLocations - 1) as Int) as Long;
		if (victim >= thief) {
			victim++;
		}
		if(victim >= numLocations) {
			return;
		}
		val victim_place = placeOfLocation(victim);
		if (!pg.contains(victim_place)) {
			// TODO should try other place, but ok as is
			return;
		}
		
		if(victim_place.isDead()) {
			// the victim place is already dead
			if(harvestedVictims.contains(victim)) {
				// the victim is already dead and probably does not contain
				// any work
				// just return for now (could optionally try again)
				return;
			} else {
				// we are done irrespective of success
				harvest(victim);
			}
		}
		
		sync_lock.lock();
		try {
			state = victim;
		} finally {
			sync_lock.unlock();
		}
		if(DEBUG) {
			Console.ERR.println(getLocationString(location) + ": STATE=" + getLocationString(victim) + " (steal)");
		}
		// since we are stealing, that means we have nothing to give thieves
		// so if there are any thieves, we want to wake them up
		// any new incoming thief requests will be immediately rejected since STATE!=-1
		distribute();
		
		try {
			val wplh = workers;
			val victim_worker = workerOfLocation(victim);
			at(victim_place) @Uncounted async {
				wplh()(victim_worker).request(thief);
			};
		} catch (e:DeadPlaceException) {
			// pretend stealing failed
			// TODO should try other place, but ok as is
			sync_lock.lock();
			try {	
				state = -1;
			} finally {
				sync_lock.unlock();
			}
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-1" + " (steal/dpe)");
			}
			return;
		}
		
		sync_lock.lock();
		try {
			while (state >= 0) {
				if(DEBUG) {
					Console.ERR.println(getLocationString(location) + ": STATE=" + state + " (awaiting)");
				}
				sync_lock.await();
			}
		} finally {
			sync_lock.unlock();
		}
	}

	def request(thief:Long):void {
		sync_lock.lock();
		try {
			if (state == -1) {
				if(DEBUG) {
					Console.ERR.println(getLocationString(location) + ": request(" + getLocationString(thief) + ") being queued");
				}
				thieves.add(thief);
				return;
			}
		} finally {
			sync_lock.unlock();
		}
		try {
			val victim:Long = location;
			val thief_worker = workerOfLocation(thief);
			val thief_place = placeOfLocation(thief);
			val wplh = workers;
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": request(" + getLocationString(thief) + ") being rejected");
			}

			at(thief_place) @Uncounted async {
				wplh()(thief_worker).deal(victim, null);
			};
		} catch (e:DeadPlaceException) {
			// place is dead, nothing to do
		}
	}

	def merge(b:Bag):void {
		val startTime = stats.startMerge();
		try {
			if(this.bag == null) {
				this.bag = b;
			} else {
				this.bag = bag.merge(b);
			}
		} finally {
			stats.endMerge(startTime);
		}
	}
	
	def lifelinedeal_helper(b:Bag) throws DigestException : void {
		if(b != null) {
			merge(b);
		}
		run();
	}
	
	def lifelinedeal(b:Bag) throws DigestException : void {
		val startTime = stats.startLifelineDeal();
		try {
			lifelinedeal_helper(b);
		} finally {
			stats.endLifelineDeal(startTime);
		}
	}
	
	def lifelinedeal() throws DigestException : void {
		val startTime = stats.startLifelineDeal();
		try {
			val cp = map.get(location) as Checkpoint;
			if(cp != null) {
				lifelinedeal_helper(cp.bag);
			}
		} finally {
			stats.endLifelineDeal(startTime);
		}
	}

	 def deal_helper(victim:Long, b:Bag) : void {
		 if(DEBUG) {
			 val s = b == null ? ", null" : "";
			 Console.ERR.println(getLocationString(location) + ": deal(" + getLocationString(victim) + s + "): initiated");
		 }

		sync_lock.lock();
		try {
			if (state != victim) {
				if(DEBUG) {
					Console.ERR.println(getLocationString(location) + ": deal(" + getLocationString(victim) + "): dead victim");
				}

				// victim is dead, ignore late distribution
				return;
			}
			if (b != null) {
				merge(b);
			}
			state = -1;
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-1 (deal)");
			}
		} finally {
			sync_lock.release();
		}
	}
	 
	 def deal(victim:Long, b:Bag) : void {
		 val startTime = stats.startDeal();
		 try {
			 deal_helper(victim, b);
		 } finally {
			 stats.endDeal(startTime);
		 }
	 }
	 
	 def deal(victim:Long) : void {
		 val startTime = stats.startDeal();
		 try {
			 val cp = map.get(location) as Checkpoint;
			 if(cp != null) {
				 deal_helper(victim, cp.bag);
			 }
		 } finally {
			 stats.endDeal(startTime);
		 }
	 }

	 /**
	  * This "harvest": steals from another place's map.
	  * While always safe (thanks to our global map invariant)
	  * this should be done only if we believe that the victim is already
	  * dead.
	  * @return If we harvested anything
	  */
	 // TODO: get this to work with non-transactional transfer moe
	 def harvest(victim:Long) : Boolean {
		 var startTime:Long = stats.startHarvest();
		 // since we are trying to steal from it
		 // we mark it as harvested
		 harvestedVictims.add(victim);
		 val victimCheckpoint = map.get(victim) as Checkpoint;
		 if(victimCheckpoint == null || victimCheckpoint.bag == null) {
			 return false;
		 }
		 if(DEBUG) {
			 Console.ERR.println(getLocationString(location) + ": trying to harvest from: " + getLocationString(victim));								
		 }
		 assert(this.bag == null || this.bag.size == 0n) : "harvest called with a non-empty local bag";
		 if(transfer_mode == TRANSFER_MODE_TRANSACTIONAL) {
			 try {
				 val ourLocation = location;
				 
				 val newCheckpoint = ResilientTransactionalMap.runTransaction("map",
						 (map:ResilientTransactionalMap[Long, Checkpoint]) => {
							 
							 val victimCheckpoint:Checkpoint = map.getForUpdate(victim) as Checkpoint;
							 if(victimCheckpoint == null || victimCheckpoint.bag == null || victimCheckpoint.bag.size == 0n) {
								 // there is nothing to steal
								 return null;
							 }	

							 val ourCheckpoint:Checkpoint = map.getForUpdate(ourLocation) as Checkpoint;
							 if(ourCheckpoint == null || ourCheckpoint.bag == null || ourCheckpoint.bag.size == 0n) {
								 val newCheckpoint = new Checkpoint(victimCheckpoint.bag, victimCheckpoint.count + ourCheckpoint.count);
								 // since they have data, and we don't, we can take theirs
								 map.set(ourLocation, newCheckpoint);
								 // we stole the bag and count
								 // we need to delete the key from the map
								 // since the run() method of the victim may try to update
								 // it with replace()
								 map.deleteVoid(victim);
								 return newCheckpoint;
							 } else {
								 // we are not empty.  This is a race condition, so we need to abort
							 	return null;
							 }
						 }
				 );
				 val success = newCheckpoint != null;
				 if(success) {
					 this.bag = newCheckpoint.bag;
					 this.count = newCheckpoint.count;
					 if(DEBUG) {
						 Console.ERR.println(getLocationString(location) + ": successfully harvested from: " + getLocationString(victim));								
					 }
				 }
				 stats.endHarvest(startTime, success);
				 return success;
			 } catch (t:CheckedThrowable) {
				 Console.ERR.println(getLocationString(location) + ": Exception in harvest(" + getLocationString(victim) + ") transaction");
				 t.printStackTrace();
				 stats.endHarvest(startTime, false);
				 return false;
			 }
		 } else {
			 return false;
		 }
	 }
	 
	/** Records in the backing map that bag b now belongs to the thief
	  * and our bag is {@code this.bag}.  If the thief already has a non-empty bag
	  * then this operation will fail.
	  * @param thief The lucky recipient of the bag b
	  * @param the bag to give the thief
	  * @return If the transfer succeeded.  If it did not,
	  * the backing map will be unmodified.  The caller is responsible
	  * for restoring {@code this.bag @}
	  * 
	  * transfer is called only when the local bag is originally non-empty
	  * 
	  */
	def transfer(thief:Long, b:Bag) : Boolean {
		var startTime:Long = stats.startTransfer();
		while(true) {
			try {
				if(transfer_mode == TRANSFER_MODE_TRANSACTIONAL) {
					val ourCheckpoint = new Checkpoint(bag, count);
					val ourLocation = location;
					val errCode = ResilientTransactionalMap.runTransaction("map",
							(map:ResilientTransactionalMap[Long, Checkpoint]) => {
								val thiefCheckpoint:Checkpoint = map.getForUpdate(thief) as Checkpoint;
								if(thiefCheckpoint != null && thiefCheckpoint.bag != null && thiefCheckpoint.bag.size > 0) {
									// the thief bag is non-empty.
									// This is a possible race condition
									// (because they could be processing their non-empty bag)
									// so we abort
									return -1;
								}
								val n:long = thiefCheckpoint == null ? 0 : thiefCheckpoint.count;
								//map.set(ourLocation, ourCheckpoint);
								map.set(ourLocation, ourCheckpoint);
								map.set(thief, new Checkpoint(b, n));
								return 0;
							}
					);
					val success = errCode == 0;
					if(! success) {
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": failed transfer to " + getLocationString(location) + " with errCode " + errCode);
						}
					}
					stats.endTransfer(startTime, success);
					return success;
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC) {
					// change to use set
					val cor:Checkpoint = map.get(thief);
					if(cor != null && cor.bag != null && cor.bag.size > 0) {
						// the thief bag is non-empty.
						// This is a possible race condition
						// (because they could be processing their non-empty bag)
						// so we abort
						stats.endTransfer(startTime, false);
					}
					val n:long = cor == null ? 0 : cor.count;
					map.set(location, new Checkpoint(bag, count));
					map.set(thief, new Checkpoint(b, n));
					stats.endTransfer(startTime, true);
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC_SUBMIT) {
					// change to use set
					val success = map.submitToKey(thief, (e:Entry[Long,Checkpoint]):Any => {
						val cor:Checkpoint = e.getValue();
						if(cor != null && cor.bag != null && cor.bag.size > 0) {
							// the thief bag is non-empty.
							// This is a possible race condition
							// (because they could be processing their non-empty bag)
							// so we abort
							return false;
						}
						val n:long = cor == null ? 0 : cor.count;
						e.setValue(new Checkpoint(b,n));
						return true;
					}) as Boolean;
					if(success) {
						map.set(location, new Checkpoint(bag, count));
					}
					stats.endTransfer(startTime, success);
					return success;
				} else if(transfer_mode == TRANSFER_MODE_NOMAP) {
					// don't do anything
					// note that this seems unsafe
					// since the thief could get a bag even if its
					// current bag is non-empty
					// However, this can happen only due to a race condition
					// caused by place failure, and TRANSFER_MODE_NOMAP is
					// is not resilient to place failure anyway

					stats.endTransfer(startTime, true);
					return true;
				} else {
					Console.ERR.println("Unknown transfer mode: " + transfer_mode);
					stats.endTransfer(startTime, false);
					throw new IllegalStateException("Unknown transfer mode: " + transfer_mode);
				}
			} catch (t:CheckedThrowable) {
				
				Console.ERR.println(getLocationString(location) + ": Exception in transaction" +
				" ... retrying");
				t.printStackTrace();
				startTime = stats.retryTransfer(startTime);
			}
		}
	}

	private def split(bag:Bag) {
		val startTime = stats.startSplit();
		try {
			return bag.split();
		} finally {
			stats.endSplit(startTime);
		}
	}
	
	def distribute():void {
		val startTime:Long = stats.startDistribute();
		try {	
			val llThief = lifeline.get();
			if (llThief != -1) {
				val b:Bag = split(bag);
				if (b != null) {
					val transferSuccess:Boolean;
					if(lifeline.compareAndSet(llThief, -1)) {
                        if(DEBUG) {
                        	Console.ERR.println(getLocationString(location) + ": lifeline reset (old: " + getLocationString(llThief) + ")");
                        }
						transferSuccess = transfer(llThief, b);
					} else {
						transferSuccess = false;						
					}
					
					val thief_worker = workerOfLocation(llThief);
					val thief_place = placeOfLocation(llThief);

					val wplh = workers;

					if(transferSuccess) {
						try {
							at(thief_place) async {
								wplh()(thief_worker).lifelinedeal(b);
							};
						} catch (e:DeadPlaceException) {
							// thief died, nothing to do
						}
					} else {
						// since we did not succeed in transferring the bag,
						// we need to merge it back in
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": attempt to lifeline transfer to " + getLocationString(llThief) + " failed");
						}
						merge(b);
						// even if the transfer fails, we still "wake up" our lifeline
						// so that it can process
						try {
							at(thief_place) async {
								wplh()(thief_worker).lifelinedeal();
							};
						} catch (e:DeadPlaceException) {
							// thief died, nothing to do
						}
					}
					
					
				}
			}
			
			val victim:Long = location;
			val wplh = workers;

			var thief_boxed : Any;
			var b:Bag = null;
			while ((thief_boxed = thieves.poll()) != null) {
				val thief = thief_boxed as Long;
				if(b == null) {
					b = split(bag);
				}
				val thief_worker = workerOfLocation(thief);
				val thief_place = placeOfLocation(thief);
				
				if (b == null) {
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": no work for thief: " + getLocationString(thief));								
					}
					at(thief_place) @Uncounted async {
						wplh()(thief_worker).deal(victim, null);
					};
				} else {
					val transferSuccess = transfer(thief, b);
					if(transferSuccess) {
						try {
							val bagToGiveThem = b;
							b = null;
							if(DEBUG) {
								Console.ERR.println(getLocationString(location) + ": dealing to thief: " + getLocationString(thief));
							}
							at(thief_place) @Uncounted async {
								wplh()(thief_worker).deal(victim, bagToGiveThem);
							};
						} catch (e:DeadPlaceException) {
							// thief died, nothing to do
						}
					} else {
						if(DEBUG) {
							Console.ERR.println(getLocationString(location) + ": failed to give work to thief: " + getLocationString(thief));
						}
						// tell it that it should look at its own map entry
						// since that is probably why the transfer failed
						at(thief_place) @Uncounted async {
							wplh()(thief_worker).deal(victim);
						};
					// if the transfer failed, keep the split bag
					// around for the next thief
					}
				}
			}
			// if we still have a bag that we split for a thief
			// but did not transfer to them (or any subsequent thieves)
			// then we need to merge it back in
			if(b != null) {
				merge(b);
			}
		} finally {
			stats.endDistribute(startTime);
		}
	}

	def seq():Long {
		count = 0;
		try {
			while (bag.size > 0n) {
				expand();
			}
		} catch (e:DigestException) {
		}
		return count;
	}
	
	def seq(b:Bag):Long {
		bag = b;
		return seq();
	}
	
	public static def getLocalCount(numWorkersPerPlace:Long, workers:LocalWorkers(numWorkersPerPlace)):Long {
		var count:Long = 0;
		for(worker in workers) {
			count += worker.count;
		}
		return count; 
	}
	
	public static def getGlobalCount(pg:PlaceGroup, numWorkersPerPlace:Long, workers:Workers(numWorkersPerPlace)):Long {
		val counter = new AtomicLong(0L);
		finish {
			for (p in pg) {
				if(p != here) {
					async counter.addAndGet(at(p) getLocalCount(numWorkersPerPlace, workers()));
				}
			}
			if(pg.contains(here)) {
				counter.addAndGet(getLocalCount(numWorkersPerPlace, workers()));
			}
		}
		return counter.get();
	}
	
	def printCurrentLocalState() {
		sync_lock.lock();
		val s = new StringBuilder();
		try {
			val lloc = nextLocationInLifelineGraph.get();
			s.add("|-\t");
			s.add(getLocationString(location));
			s.add("(->");
			s.add(getLocationString(lloc));
			s.add("): STATE=");
			if(state == -2) {
				s.add("SLEEPING");
			} else if(state == -1) {
				s.add("RUNNING");
			} else {
				s.add("STEALING from ");
				s.add(getLocationString(state));
			}
			if(! thieves.isEmpty()) {
				var isFirst : Boolean = true;
				s.add("; thieves: ");
				val iter = thieves.iterator();
				while(iter.hasNext()) {
					val thief_boxed = iter.next();
					if (thief_boxed != null) {
						val thief = thief_boxed as Long;
						if(isFirst) {
							isFirst = false;
						} else {
							s.add(", ");
						}
						s.add(getLocationString(thief));
					}
				}
			}
		} finally {
			sync_lock.unlock();
		}
		Console.ERR.println(s.toString());
	}
	
	public static def printCurrentLocalState(numWorkersPerPlace:Long, workers:LocalWorkers(numWorkersPerPlace)):void {
		for(worker in workers) {
			worker.printCurrentLocalState();
		}
	}
	
	public static def printCurrentState(pg:PlaceGroup, numWorkersPerPlace:Long, workers:Workers(numWorkersPerPlace)):void {
		Console.ERR.println("|| Current state of the world:");
		finish {
			for (p in pg) {
				try {
					at(p) {
						printCurrentLocalState(numWorkersPerPlace, workers());
					}
				} catch(ex:DeadPlaceException) {
					val startIndex = pg.indexOf(p) * numWorkersPerPlace;
					for(i in 0..(numWorkersPerPlace-1)) {
						val loc = startIndex + i;
						Console.ERR.println("|-\t" + getLocationString(pg, numWorkersPerPlace, loc) + ": DEAD");
					}
				}
			}
		}
	}

	public static def getLocalStats(numWorkersPerPlace:Long, workers:LocalWorkers(numWorkersPerPlace)):Stats {
		val stats = new Stats();
		for(worker in workers) {
			stats.add(worker.stats);
		}
		return stats;
	}
	
	public static def getGlobalStats(pg:PlaceGroup, numWorkersPerPlace:Long, workers:Workers(numWorkersPerPlace)):Stats {
		val stats = new Stats();
		finish {
			for (p in pg) {
				if(p != here) {
					async {
						try {
							val otherStats = at(p) getLocalStats(numWorkersPerPlace, workers());
							stats.add(otherStats);
						} catch(de:DeadPlaceException) {
							// do nothing
						}
					}
				}
			}
			if(pg.contains(here)) {
				stats.add(getLocalStats(numWorkersPerPlace, workers()));
			}
		}
		return stats;
	}
}
