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

final class UTSWorker(numWorkersPerPlace:Long) implements Unserializable {
	private static val DEBUG=false;
	
	static type LocalWorkers(n:Long) = Rail[UTSWorker{numWorkersPerPlace==n}]{self.size==n};
	static type Workers(n:Long) = PlaceLocalHandle[LocalWorkers(n)];

	public static def make(diffThreads:Int, pg:PlaceGroup, numWorkersPerPlace:Long, transfer_mode:Int):Workers(numWorkersPerPlace) {
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
		initAllWorkers(diffThreads, pg, numWorkersPerPlace, workers);
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

	val thieves:ConcurrentLinkedQueue = new ConcurrentLinkedQueue();
	// the place that set the lifeline
	// -1 means that the lifeline is not set
	val lifeline:AtomicLong;
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
						Console.ERR.println(getLocationString(location) + ": lifeline set by the farther: " + getLocationString(thief_location) + ", replacing " + getLocationString(oldThief));
						return;
					}
					// otherwise, there was a race condition, so try again
					Console.ERR.println(getLocationString(location) + ": race while trying set a lifeline from: " + getLocationString(thief_location));
				} else {
					Console.ERR.println(getLocationString(location) + ": lifeline attemptted to be set by: " + getLocationString(thief_location) + ", but it was an outdated (too close) request");
					return;
				}
			}
		}
	}

	def lifelinesteal():void {
		if (numLocations == 1) {
			return;
		}

		var victim:Long = location;
		while(true) {
			try {
				victim = (victim + numLocations - 1) % numLocations;
				if(victim == location) {
					// there is no one left to lifeline on
					if(DEBUG) {
						Console.ERR.println(getLocationString(location) + ": nobody left to set a lifeline with");
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
				// fall through and try the next place
				if(DEBUG) {
					Console.ERR.println(getLocationString(location) + ": failed to set a lifeline at " + getLocationString(victim) + ".  will try the next in line");
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
		
		sync_lock.lock();
		try {
			state = victim;
		} finally {
			sync_lock.unlock();
		}
		if(DEBUG) {
			Console.ERR.println(getLocationString(location) + ": STATE=" + getLocationString(victim) + " (steal)");
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
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-1" + " (steal/dpe)");
			}
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
			this.bag = bag.merge(b);
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
			 val s = b == null ? ", null" : "";
			 Console.ERR.println(getLocationString(location) + ": deal(" + getLocationString(victim) + s + "): initiated");
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
			if(DEBUG) {
				Console.ERR.println(getLocationString(location) + ": STATE=-1 (deal)");
			}
		} finally {
			sync_lock.release();
			stats.endDeal(startTime);

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
	  */
	def transfer(thief:Long, b:Bag) : Boolean {
		var startTime:Long = stats.startTransfer();
		while(true) {
			try {
				if(transfer_mode == TRANSFER_MODE_TRANSACTIONAL) {
					val success = ResilientTransactionalMap.runTransaction("map",
							(map:ResilientTransactionalMap[Long, Checkpoint]) => {
								val cor:Checkpoint = map.getForUpdate(thief) as Checkpoint;
								if(cor != null && cor.bag != null && cor.bag.size > 0) {
									// the thief bag is non-empty.
									// This is a possible race condition
									// (because they could be processing their non-empty bag)
									// so we abort
									return false;
								}
								val n:long = cor == null ? 0 :cor.count;
								map.set(location, new Checkpoint(bag, count));
								map.set(thief, new Checkpoint(b, n));
								return true;
							}
					);
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
					if(transferSuccess) {
						try {
							val thief_worker = workerOfLocation(llThief);
							val thief_place = placeOfLocation(llThief);
	
							val wplh = workers;
							at(thief_place) async {
								wplh()(thief_worker).lifelinedeal(b);
							};
						} catch (e:DeadPlaceException) {
							// thief died, nothing to do
						}
					} else {
						// since we did not succeed in transferring the bag,
						// we need to merge it back in
                        Console.ERR.println(getLocationString(location) + ": attempt to lifeline transfer to " + getLocationString(llThief) + " failed");
						merge(b);
					}
				}
			}
			
			val victim:Long = location;
			val wplh = workers;

			var thief_boxed : Any;
			var b:Bag = null;
			while ((thief_boxed = thieves.poll()) != null) {
				val thief = thief_boxed as Long;
				if(b != null) {
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
						at(thief_place) @Uncounted async {
							wplh()(thief_worker).deal(victim, null);
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
