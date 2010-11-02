/**
	 * An call that contains a reference to a Double value. The 
	 * reason this is needed is that we need the updates to be atomic.
	 * Since there are currently no atomic increments on arbitray 
	 * Doubles such as Doubles and Floats, we will fake it with locks
	 */
import x10.lang.Lock;
	public final  class LockedDouble {
		private var value:Double;
		private val lock = new Lock();
		private var count:Int=0;
		// Construct the value with the requested initial.
		public def this (init:Double) { value = init; }
		
		// Adjust the value by delta while holding the lock.
		public def adjust (delta:Double) { 
			lock.lock();
			value += delta;
			count++;
			lock.unlock();
		}
		public def count()=count;
		// Define a toString to print out stuff
		public def toString () = "" + value;
	}