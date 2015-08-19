package uts;
import x10.io.Printer;
import x10.util.concurrent.AtomicLong;

public class Stats {
	
	static val TRACE=false;
	static val TRACE_DISTRIBUTE=false;
	
	static def IS_TRACE() = TRACE || TRACE_DISTRIBUTE;
	
	val trace_string : String;
	// TRANSFERS
	
	// number of successfull transfers
	private val transfers:AtomicLong = new AtomicLong(0L);
	// number of transfer retries
	private val retriedTransfers:AtomicLong = new AtomicLong(0L);
	// number of failed retries
	private val failedTransfers:AtomicLong = new AtomicLong(0L);
	
	// how long we took transferring stuff (not including failures)
	private val transferTime:AtomicLong = new AtomicLong(0L);
	// how long we wasted on transfers that were retried
	private val retriedTransferTime:AtomicLong = new AtomicLong(0L);

	// how long we took failing transfers
	// how long we wasted on transfers that were retried
	private val failedTransferTime:AtomicLong = new AtomicLong(0L);

	
	// how long it took to distribute stuff
	private val distributeTime:AtomicLong = new AtomicLong(0L);
	// how many times distribute was run
	private val distributes:AtomicLong = new AtomicLong(0L);	

	// how long it took to "deal"
	private val dealTime:AtomicLong = new AtomicLong(0L);
	// how many times work was "dealt"
	private val deals:AtomicLong = new AtomicLong(0L);	

	// how long it took to "lifeline deal"
	private val lifelineDealTime:AtomicLong = new AtomicLong(0L);
	// how many times work was "lifeline dealt"
	private val lifelineDeals:AtomicLong = new AtomicLong(0L);	

	// how long it took to merge a bag
	private val merges:AtomicLong = new AtomicLong(0L);
	// how many times bags were merged
	private val mergeTime:AtomicLong = new AtomicLong(0L);	

	// how long it took to split a bag
	private val splits:AtomicLong = new AtomicLong(0L);
	// how many times bags were split
	private val splitTime:AtomicLong = new AtomicLong(0L);	

	
	public def this() {
		this.trace_string = null;
	}

	public def this(trace_string:String) {
		this.trace_string = trace_string;
	}

	private static def time() = System.nanoTime();

	/**
	 * Starts a transfer operation
	 * @return the start time
	 */
	public def startTransfer():Long {
		val t = time();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " startTransfer: " + t);
		}

		return t;
	}
	
	/**
	 * Marks a retry a transfer
	 * @param startTime The start time of the transfer
	 * @return the new start time, to be used for subsequent operations
	 */
	public def retryTransfer(startTime:Long):Long {
		val t = time();
		retriedTransfers.incrementAndGet();
		val elapsed = t-startTime;
		retriedTransferTime.addAndGet(elapsed);
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " retryTransfer: " + t + "-" + startTime + "=" + elapsed);
		}
		return t;
	}
	
	/**
	 * Marks a failed transfer
	 * @param startTime The start time of the transfer
	 * @return the new start time, to be used for subsequent operations
	 */
	private def failTransfer(startTime:Long):void {
		val t = time();
		failedTransfers.incrementAndGet();
		val elapsed = t-startTime;
		failedTransferTime.addAndGet(elapsed);
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " failTransfer: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	/**
	 * Marks the end of a transfer
	 * @param startTime the start time of the transfer
	 */
	private def completeTransfer(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		transferTime.addAndGet(elapsed);
		transfers.incrementAndGet();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " completeTransfer: " + t + "-" + startTime + "=" + elapsed);
		}

	}
	
	/**
	 * Marks the end of a transfer, either succes or failed
	 * @param startTime the start time of the transfer
	 */
	public def endTransfer(startTime:Long, success:Boolean) {
		if(success) {
			completeTransfer(startTime);
		} else {
			failTransfer(startTime);
		}
	}
	
	public def startDistribute():Long {
		val t = time();
		if(TRACE_DISTRIBUTE) {
			Console.ERR.println("TRACE" + trace_string + " startDistribute: " + t);
		}
		return t;
	}
	
	public def endDistribute(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		distributeTime.addAndGet(elapsed);
		distributes.incrementAndGet();
		if(TRACE_DISTRIBUTE) {
			Console.ERR.println("TRACE" + trace_string + " endDistribute: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	public def startDeal():Long  {
		val t = time();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " startDeal: " + t);
		}
		return t;
	}

	public def endDeal(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		dealTime.addAndGet(elapsed);
		deals.incrementAndGet();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " endDeal: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	public def startLifelineDeal():Long  {
		val t = time();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " startLifelineDeal: " + t);
		}
		return t;
	}

	public def endLifelineDeal(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		lifelineDealTime.addAndGet(elapsed);
		lifelineDeals.incrementAndGet();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " endLifelineDeal: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	public def startMerge():Long  {
		val t = time();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " startMerge: " + t);
		}
		return t;
	}

	public def endMerge(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		mergeTime.addAndGet(elapsed);
		merges.incrementAndGet();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " endMerge: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	public def startSplit():Long  {
		val t = time();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " startSplit: " + t);
		}
		return t;
	}
	public def endSplit(startTime:Long) {
		val t = time();
		val elapsed = t - startTime;
		splitTime.addAndGet(elapsed);
		splits.incrementAndGet();
		if(TRACE) {
			Console.ERR.println("TRACE" + trace_string + " endSplit: " + t + "-" + startTime + "=" + elapsed);
		}
	}

	public def add(other:Stats) {
		transfers.addAndGet(other.transfers.get());
		transferTime.addAndGet(other.transferTime.get());
		retriedTransfers.addAndGet(other.retriedTransfers.get());
		retriedTransferTime.addAndGet(other.retriedTransferTime.get());
		distributes.addAndGet(other.distributes.get());
		distributeTime.addAndGet(other.distributeTime.get());
		 deals.addAndGet(other.deals.get());
		 dealTime.addAndGet(other.dealTime.get());	
		 lifelineDeals.addAndGet(other.lifelineDeals.get());
		 lifelineDealTime.addAndGet(other.lifelineDealTime.get());	
		 merges.addAndGet(other.merges.get());
		 mergeTime.addAndGet(other.mergeTime.get());
		 splits.addAndGet(other.splits.get());
		 splitTime.addAndGet(other.splitTime.get());
	}
	
	public def print(out:Printer):void {
		val totalTransferAttempts = transfers.get()+retriedTransfers.get();
		val wastedTransferPercent = totalTransferAttempts == 0L ? 0L : ((retriedTransfers.get() as Double)/totalTransferAttempts)*100.0d;
		out.println("Completed Transfers: " + transfers 
				+ ", Failed transfers: " + retriedTransfers 
				+ ", Percentage wasted attempts: " + wastedTransferPercent);
		
		val totalTransferTime = transferTime.get()+retriedTransferTime.get();
		val wastedTransferTimePercent = totalTransferAttempts == 0L ? 0L : ((retriedTransferTime.get() as Double)/totalTransferTime)*100.0d;
		out.println("Completed Transfer time: " + asSeconds(transferTime)
				+ ", Failed transfer time: " + asSeconds(retriedTransferTime) 
				+ ", Percentage time wasted: " + wastedTransferTimePercent);
		
	}
	
	public static def csvHeader():String {
		return 
		"transfers"
		+ ", " + "transferTime"
		+ ", " + "retriedTransfers"
		+ ", " + "retriedTransferTime"
		+ ", " + "failedTransfers"
		+ ", " + "failedTransferTime"
		+ ", " + "distributes"
		+ ", " + "distributeTime"
		+ ", " + "deals"
		+ ", " + "dealTime"
		+ ", " + "lifelineDeals"
		+ ", " + "lifelineDealTime"
		+ ", " + "merges"
		+ ", " + "mergeTime"
		+ ", " + "splits"
		+ ", " + "splitTime";
	}
	
	public def asCSV():String {
		return "" + transfers.get() 
   		+ ", " + transferTime.get()
   		+ ", " + retriedTransfers.get()
   		+ ", " + retriedTransferTime.get()
   		+ ", " + failedTransfers.get()
   		+ ", " + failedTransferTime.get()
		+ ", " + distributes.get()
 		+ ", " + distributeTime.get()
 		+ ", " + deals.get()
 		+ ", " + dealTime.get()	
 		+ ", " + lifelineDeals.get()	
 		+ ", " + lifelineDealTime.get()	
		+ ", " + merges.get()	
		+ ", " + mergeTime.get()
		+ ", " + splits.get()	
		+ ", " + splitTime.get();
	}
	
	public static def asSeconds(timeInNanos:AtomicLong):String {
		return asSeconds(timeInNanos.get());
	}

	public static def asSeconds(timeInNanos:Long):String {
		val seconds = (timeInNanos as Double) / 1E9;
		return String.format("%.2fs", [seconds as Any]);
	}

}