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

final class Worker(numWorkersPerPlace:Long) implements Unserializable {
	private static val DEBUG=false;
	
	static type LocalWorkers(n:Long) = Rail[Worker{numWorkersPerPlace==n}]{self.size==n};
	static type Workers(n:Long) = PlaceLocalHandle[LocalWorkers(n)];

	public static def make(diffThreads:Int, pg:PlaceGroup, numWorkersPerPlace:Long, transfer_mode:Int):Workers(numWorkersPerPlace) {
		val numPlaces = pg.size();
		val numLocations = numPlaces * numWorkersPerPlace;
		val workers = PlaceLocalHandle.make(pg,
				(p:Place) => pg.indexOf(p),
				(placeIndex:Long) => {
					val baseLocation = placeIndex*numWorkersPerPlace;
					return new Rail[Worker{self.numWorkersPerPlace==numWorkersPerPlace}](numWorkersPerPlace, 
						(i:Long) => 
							new Worker(baseLocation+i, numLocations, numWorkersPerPlace, transfer_mode) as Worker{self.numWorkersPerPlace==numWorkersPerPlace})
							as LocalWorkers(numWorkersPerPlace);
				});
		initAllWorkers(diffThreads, pg, numWorkersPerPlace, workers);
		return workers;
	}
	
	def this(globalLocation:Long, locations:Long, numWorkersPerPlace:Long, transfer_mode:Int)
	:Worker{self.numWorkersPerPlace==numWorkersPerPlace} {
		property(numWorkersPerPlace);

		this.transfer_mode = transfer_mode;
		if(useMap()) {
			this.map = ResilientMap.getMap[Long,Checkpoint]("map");
		}
		this.location = globalLocation;
		this.numLocations = locations;
		this.lifeline = new AtomicBoolean(globalLocation != locations - 1);
	}	

	var pg:PlaceGroup;
	var workers:Workers(numWorkersPerPlace);

	private def initWorkers(pg:PlaceGroup, new_workers:Workers(numWorkersPerPlace)) {
		this.pg = pg;
		this.workers = new_workers;
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
	
	public static def initAllWorkers(diffThreads:Int, pg:PlaceGroup, numWorkersPerPlace:Long, workers:Workers(numWorkersPerPlace)) {
		try {
			finish {
				val pl = pg;
				for (p in pl) {
					if(p != here) {
						val wplh = workers;
						async at(p) {
							adjustThreads(diffThreads);
							registerPlaceDeadHandler(numWorkersPerPlace, wplh());
							for(w in wplh()) {
								w.initWorkers(pg, workers);
							}
						}
					}
				}
				if(pl.contains(here)) {
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
		
	private def handle(p:Place):void {
		sync_lock.lock();
		// p is dead, unblock if waiting on p
		if(state >= 0) {
			val statePlace = placeOfLocation(state);
			if (statePlace == p) {
				try {
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": handle(" + p + "): unblocking");
					}
					// attempt to extract loot from store
					val c:Checkpoint = map.get(location) as Checkpoint;
					if (c.bag != null) {
						merge(c.bag);
					}
					state = -1;
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

	val thieves:ConcurrentLinkedQueue = new ConcurrentLinkedQueue();
	val lifeline:AtomicBoolean;
	var state:Long = -2; // -2: inactive, -1: running, p: stealing from p

	var stats:Stats = new Stats();
	
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

	def init(seed:Int, depth:Int) throws DigestException : void {
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
		if(useMap()) {
			map.set(location, new Checkpoint(bag, count));
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
		
		sync_lock.lock();
	    try {
			state = -1;
		} finally {
			sync_lock.unlock();
	  	}
		
		while (bag.size > 0n) {
			while (bag.size > 0n) {
				for (var n:int = 500n; (n > 0n) && (bag.size > 0n); --n) {
					expand();
				}
				distribute();
			}
			if(useMap()) {
				map.set(location, new Checkpoint(count));
			}
			steal();
		}
		
		sync_lock.lock();
		try {
			state = -2;
		} finally {
			sync_lock.unlock();
		}
		
		lifelinesteal();
		if(DEBUG) {
			Console.ERR.println(getLocationString(location) + ": run() stopping");
		}
		distribute();
	}

	public def workerOfLocation(loc:Long):Long { 
		return loc % numWorkersPerPlace;
	}

	public def placeOfLocation(loc:Long):Place { 
		return pg(loc / numWorkersPerPlace);
	}
	
	
	def getLocationString(location:Long) {
		return 
		location + "=" + placeOfLocation(location).id + 
		"[" + workerOfLocation(location) + "]"; 
	}


	def lifelinesteal():void {
		if (numLocations == 1) {
			return;
		}
		try {
			val victim = (location + numLocations - 1) % numLocations;
			val victim_worker = workerOfLocation(victim);
			val victim_place = placeOfLocation(victim);
			
			val wplh = workers;
			at(victim_place) async {
				wplh()(victim_worker).lifeline.set(true);
			};
		} catch (e:DeadPlaceException) {
			// TODO should go to next lifeline, but correct as is
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
		
		sync_lock.lock();
		try {
			state = victim;
		} finally {
			sync_lock.unlock();
		}
		
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
		}
		
		sync_lock.lock();
		try {
			while (state >= 0) {
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
				Console.ERR.println(getLocationString(location) + ": request(" + getLocationString(thief) + ") being dealt");
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
			while (bag.size + b.size > bag.depth.size as Int) {
				grow();
			}
			bag.merge(b);
		} finally {
			stats.endMerge(startTime);
		}
	}
	
	def lifelinedeal(b:Bag) throws DigestException : void {
		val startTime = stats.startLifelineDeal();
		try {
			merge(b);
			run();
		} finally {
			stats.endLifelineDeal(startTime);
		}
	}

	 def deal(victim:Long, b:Bag) : void {
		 if(DEBUG) {
			 Console.ERR.println(getLocationString(location) + ": deal(" + getLocationString(victim) + "): initiated");
		 }

		val startTime = stats.startDeal();
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
		} finally {
			sync_lock.release();
			stats.endDeal(startTime);

		}
	}

	def transfer(thief:Long, b:Bag) : void {
		var startTime:Long = stats.startTransfer();
		while(true) {
			try {
				if(transfer_mode == TRANSFER_MODE_TRANSACTIONAL) {
                    ResilientTransactionalMap.runTransaction("map",
                    (map:ResilientTransactionalMap[Long, Checkpoint]) => {
							map.set(location, new Checkpoint(bag, count));
							val cor:Checkpoint = map.getForUpdate(thief) as Checkpoint;
							val n:long = cor == null ? 0 :cor.count;
							map.set(thief, new Checkpoint(b, n));
							return null;
						}
					);
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC) {
					// change to use set
					map.set(location, new Checkpoint(bag, count));
					val cor:Checkpoint = map.get(thief);
					val n:long = cor == null ? 0 : cor.count;
					map.set(thief, new Checkpoint(b, n));
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC_SUBMIT) {
					// change to use set
					map.set(location, new Checkpoint(bag, count));
					finish map.asyncSubmitToKey(thief, (e:Entry[Long,Checkpoint]):Any => {
						val cor:Checkpoint = e.getValue();
						val n:long = cor == null ? 0 : cor.count;
						e.setValue(new Checkpoint(b,n));
						return null;
					});
				} else if(transfer_mode == TRANSFER_MODE_NOMAP) {
					// don't do anything
				} else {
					Console.ERR.println("Unknown transfer mode: " + transfer_mode);
					throw new IllegalStateException("Unknown transfer mode: " + transfer_mode);
				}
				                              
				stats.endTransfer(startTime);
				return;
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
			if (lifeline.get()) {
				val b:Bag = split(bag);
				if (b != null) {
					val thief = ((location + 1) % numLocations);
					lifeline.set(false);
					transfer(thief, b);
					try {
						val thief_worker = workerOfLocation(thief);
						val thief_place = placeOfLocation(thief);

						val wplh = workers;
						at(thief_place) async {
							wplh()(thief_worker).lifelinedeal(b);
						};
					} catch (e:DeadPlaceException) {
						// thief died, nothing to do
					}
				}
			}
			var thief_boxed : Any;
			while ((thief_boxed = thieves.poll()) != null) {
				val thief = thief_boxed as Long;
				val b:Bag = split(bag);
				if (b != null) {
					transfer(thief, b);
				}
				try {
					val victim:Long = location;
					val thief_worker = workerOfLocation(thief);
					val thief_place = placeOfLocation(thief);
					val wplh = workers;

					at(thief_place) @Uncounted async {
						wplh()(thief_worker).deal(victim, b);
					};
				} catch (e:DeadPlaceException) {
					// thief died, nothing to do
				}
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
