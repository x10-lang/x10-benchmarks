package uts;

import x10.util.concurrent.Monitor;

import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.util.Random;
import java.util.concurrent.ConcurrentLinkedQueue;

import x10.util.concurrent.AtomicBoolean;
import x10.interop.Java;
import x10.compiler.Native;
import x10.compiler.Uncounted;
import x10.util.resilient.ResilientMap;
import x10.util.resilient.ResilientTransactionalMap;
import x10.util.Map.Entry;

final class Worker {
	static val singletonWorker:Worker = new Worker();

	public static def setTransferModes(newMode:Int) {
		try {
			finish {
				val pl = Place.places();
				for (p in pl) {
					if(p != here) {
						async at(p) {
							Worker.singletonWorker.setTransferMode(newMode);
						}
					}
				}
				if(pl.contains(here)) {
					Worker.singletonWorker.setTransferMode(newMode);
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
	
	/*** TODO: This needs to be put in a polling loop somewhere
	 * that checks if numPlaces has increased from last time we checked.
	 * {
	 * GlobalRuntime.getRuntime().setPlaceFailureHandler(place -> {
	 * if (place.id > 0) {
	 * System.err.println(home + " observes that " + place + " failed!");
	 * }
	 * singletonWorker.handle(place);
	 * });
	 * }
	 */

	//var placesAlreadyKnownDead:PlaceGroup;
	//var placesAlreadyKnown:PlaceGroup;
	
	
/*	def handleDeadPlaces():void {
		var deadPlace:Long = -1;
		sync_lock.lock();
		try {
			if(Place.numDead() != placesAlreadyKnownDead.size()) {
				// the number of dead places has changed
				for(pl in placesAlreadyKnown) {
					if(pl.
					if (!pl.isDead()) {
						addDeadPlace(pl);
						deadPlace = pl.id;
						break;
					}
				}
			}
		} finally {
			sync_lock.unlock();
		}
	}
  
	
	def handle(p:Place):void {
		sync_lock.lock();
		// p is dead, unblock if waiting on p
		if (state == p.id) {
			try {
				
				// attempt to extract loot from store
				val c:Checkpoint = map.get(home) as Checkpoint;
				if (c.bag != null) {
					merge(c.bag);
				}
				state = -1;
			} finally {
				sync_lock.release();
			}
		} else {
			sync_lock.unlock();
		}
	}
	*/
	
	interface Daemon {
		def start():void;
		def stop():void;
	}
	
	def waitingDaemon(f:()=>void):Daemon {
		return new Daemon() {
			val stopped:AtomicBoolean = new AtomicBoolean(false);
			public def start():void {
				@Uncounted async{
					while(! stopped.get()) {
						f();
						System.sleep(1000);
					}
				}
			}
			public def stop():void {
				stopped.set(true);
			}
		};
	}
	
	def unblockIfBlockedOnDeadPlaceDaemon():Daemon {
		return waitingDaemon(() => {unblockIfBlockedOnDeadPlace();});
	}
	
	def unblockIfBlockedOnDeadPlace():void {
		sync_lock.lock();
		// p is dead, unblock if waiting on p
		// TODO: should not allocate a new Place all the time like this
		if (state > 0 && new Place(state).isDead()) {
			try {				
				// attempt to extract loot from store
				val c:Checkpoint = map.get(home) as Checkpoint;
				if (c.bag != null) {
					merge(c.bag);
				}
				state = -1;
			} finally {
				sync_lock.release();
			}
		} else {
			sync_lock.unlock();
		}
	}
		
	public static val TRANSFER_MODE_TRANSACTIONAL:Int = 0n;
	public static val TRANSFER_MODE_ATOMIC:Int = 1n;
		public static val TRANSFER_MODE_ATOMIC_SUBMIT:Int = 2n;
	public static val TRANSFER_MODE_DEFAULT:Int = TRANSFER_MODE_TRANSACTIONAL;

	public def setTransferMode(newMode:Int) {
		this.transfer_mode = newMode;
	}
	
	
	private var transfer_mode:Int = TRANSFER_MODE_TRANSACTIONAL;
	
	val map:ResilientMap[Place,Checkpoint] = ResilientMap.getMap[Place,Checkpoint]("map");

	
	val home:Place = here;
	val places:Long = Place.numPlaces();
	
	val random:Random = new Random();
	val md:MessageDigest = encoder();
	val den:double = Math.log(4.0 / (1.0 + 4.0)); // branching factor: 4.0
	var bag:Bag = new Bag(4096n);
	var count:Long;

	val thieves:ConcurrentLinkedQueue = new ConcurrentLinkedQueue();
	val lifeline:AtomicBoolean = new AtomicBoolean(home.id != places - 1);
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
		map.set(home, new Checkpoint(bag, count));
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
		Console.ERR.println(here + " starting");
		
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
			map.set(home, new Checkpoint(count));
			steal();
		}
		
		sync_lock.lock();
		try {
			state = -2;
		} finally {
			sync_lock.unlock();
		}
		
		lifelinesteal();
		Console.ERR.println(here + " stopping");
		distribute();
	}

	def lifelinesteal():void {
		if (places == 1) {
			return;
		}
		try {
			val victim = Place((here.id + places - 1) % places);
			at (victim) async {
				singletonWorker.lifeline.set(true);
			};
		} catch (e:DeadPlaceException) {
			// TODO should go to next lifeline, but correct as is
		}
	}

	def steal():void {
		if (places == 1) {
			return;
		}
		val from:Place = home;
		var p:Long = random.nextInt((places - 1) as Int) as Long;
		if (p >= from.id) {
			p++;
		}
		val pp = Place(p);
		if (!Place.places().contains(pp)) {
			// TODO should try other place, but ok as is
			return;
		}
		
		sync_lock.lock();
		try {
			state = p;
		} finally {
			sync_lock.unlock();
		}
		
		try {
			at(pp) @Uncounted async {
				singletonWorker.request(from);
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
				val daemon = unblockIfBlockedOnDeadPlaceDaemon();
				daemon.start();
				sync_lock.await();
				daemon.stop();
			}
		} finally {
			sync_lock.unlock();
		}

	}

	def request(p:Place):void {
		sync_lock.lock();
		try {
			if (state == -1) {
				thieves.add(p);
				return;
			}
		} finally {
			sync_lock.unlock();
		}
		try {
			val h:Place = home;
			at(p) @Uncounted async {
				singletonWorker.deal(h, null);
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

	 def deal(p:Place, b:Bag) : void {
		val startTime = stats.startDeal();
		sync_lock.lock();
		try {
			if (state != p.id) {
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

	def transfer(p:Place, b:Bag) : void {
		var startTime:Long = stats.startTransfer();
		while(true) {
			try {
				if(transfer_mode == TRANSFER_MODE_TRANSACTIONAL) {
                    ResilientTransactionalMap.runTransaction("map",
                    (map:ResilientTransactionalMap[Place, Checkpoint]) => {
							map.set(home, new Checkpoint(bag, count));
							val cor:Checkpoint = map.getForUpdate(p) as Checkpoint;
							val n:long = cor == null ? 0 :cor.count;
							map.set(p, new Checkpoint(b, n));
							return null;
						}
					);
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC) {
					// change to use set
					map.set(home, new Checkpoint(bag, count));
					val cor:Checkpoint = map.get(p);
					val n:long = cor == null ? 0 : cor.count;
					map.set(p, new Checkpoint(b, n));
				} else if(transfer_mode == TRANSFER_MODE_ATOMIC_SUBMIT) {
					// change to use set
					map.set(home, new Checkpoint(bag, count));
					finish map.asyncSubmitToKey(p, (e:Entry[Place,Checkpoint]):Any => {
						val cor:Checkpoint = e.getValue();
						val n:long = cor == null ? 0 : cor.count;
						e.setValue(new Checkpoint(b,n));
						return null;
					});
				} else {
					Console.ERR.println("Unknown transfer mode: " + transfer_mode);
					throw new IllegalStateException("Unknown transfer mode: " + transfer_mode);
				}
				                              
				stats.endTransfer(startTime);
				return;
			} catch (t:CheckedThrowable) {
				Console.ERR.println("Exception in transaction at " + here +
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
					val p = Place((here.id + 1) % places);
					lifeline.set(false);
					transfer(p, b);
					try {
						at(p) async {
							singletonWorker.lifelinedeal(b);
						};
					} catch (e:DeadPlaceException) {
						// thief died, nothing to do
					}
				}
			}
			var por : Any;
			while ((por = thieves.poll()) != null) {
				val p = por as Place;
				val b:Bag = split(bag);
				if (b != null) {
					transfer(p, b);
				}
				try {
					val h:Place = home;
					at(p) @Uncounted async {
						singletonWorker.deal(h, b);
					};
				} catch (e:DeadPlaceException) {
					// thief died, nothing to do
				}
			}
		} finally {
			stats.endDistribute(startTime);
		}
	}

	def seq(b:Bag):Long {
		count = 0;
		try {
			bag = b;
			while (bag.size > 0n) {
				expand();
			}
		} catch (e:DigestException) {
		}
		return count;
	}

	public static def getGlobalStats():Stats {
		val stats = new Stats();
		finish {
			val pg =  Place.places();
			for (p in pg) {
				if(p != here) {
					async {
						try {
							val otherStats = at(p) Worker.singletonWorker.stats;
							stats.add(otherStats);
						} catch(de:DeadPlaceException) {
							// do nothing
						}
					}
				}
			}
			if(pg.contains(here)) {
				stats.add(Worker.singletonWorker.stats);
			}
		}
		return stats;
	}
	
}