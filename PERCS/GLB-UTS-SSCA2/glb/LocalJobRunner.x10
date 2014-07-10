package glb;
import x10.compiler.Inline;
import x10.util.Random;
import x10.compiler.Ifdef;
import x10.compiler.Uncounted;
import x10.compiler.Pragma;
;

/**
 * The local runner for the GLB framework. An instance of this class runs at each
 * place and provides the context within which user-specified tasks execute and
 * are load balanced across all places.
 * @param <Z> result type
 */
class LocalJobRunner[Z] {
	
	/** Task frame, responsible for crunching numbers */
	private val tf:TaskFrame[Z];
	
	/** Random buddies, a runner first probes its random buddy, only when none of the random buddies responds
	 *  it starts to probe its lifeline buddies */
	private val victims:Rail[Long]; 
	
	/** Lifeline buddies */
	private val lifelines:Rail[Long];
	
	/** The granularity of tasks to run in a batch before starts to probe network to respond to work-stealing 
	 * requests. The smaller n is, the more responsive to the work-stealing requests; on the other hand, less focused
	 * on computation */
	private val n:Int; 
	
	/** Local place id */
	private val h:Long;
	
	/** Read as I am the "lifeline buddy" of my "lifelinethieves" */
	private val lifelineThieves:FixedSizeStack[Long]; 
	
	/** Thieves that send stealing requests*/
	private val thieves:FixedSizeStack[Long];
	
	/** The data structure to keep a key invariant: 
	 * At any time, at most one message has been sent on an
	 * outgoing lifeline (and hence at most one message has
	 * been received on an incoming lifeline).*/
	private val lifelinesActivated:Rail[Boolean];
	
	/** Total number of places */
	private val P = Place.numPlaces();
	
	/** Random number, used when picking a non-lifeline victim/buddy */
	private val random = new Random(Runtime.hereInt()); // on Jan 22,2014, was an issue if using the default seed, appears
                  // everyplace has the same random number sequence
	
	/** Number of random victims to probe before sending requests to lifeline buddy*/
	private val w:Int; 
	
	/** Maximum number of random victims */
	private val m:Int; 
	
	/** Verbose level, for collecting data / debugging purposes*/
	protected val verbose:Int; 
	
	/** Logger to record the work-stealing status */
	protected val logger:Logger; 
	
	val balancedLevel:Int;// added on Nov 11, 2013
	
	/** variables used for synchronization, made sure not to be optimized out by the compiler */ 
	@x10.compiler.Volatile private transient var active:Boolean = false;
	@x10.compiler.Volatile private transient var empty:Boolean = true;
	@x10.compiler.Volatile private transient var waiting:Boolean = false; 
	
	
	/** variables used for lifeline debugging purpose */
	private var last:Long;
	private var phase:Long;
	private var probes:Long;
	
	/**
	 * Class constructor
	 * @param init function closure to init the local taskframe
	 * @param glbParam global lifeline parameters
	 */
	def this(init:()=>TaskFrame[Z],glbParam:GLBParameters, balancedLevel:Int) {
		
		// setup glb parameters and initialize taskfram
		this.n = glbParam.n;
		this.w = glbParam.w;
		this.m = glbParam.m;
		this.verbose = glbParam.v;
		this.tf = init();
		this.h = Runtime.hereLong();
		this.balancedLevel = balancedLevel;
		if(this.balancedLevel == GlobalLoadBalancer.BALANCED_LEVEL_NB){
			this.tf.initTask(h, P); // added on Nov 11, 2013, initialize task
		}
		// initialize random victims
		this.victims = new Rail[Long](m);
		if (P>1) for (var i:Long=0; i<m; i++) {
			while ((victims(i) = random.nextLong(P)) == h);
		}
		
		// initialize lifeline buddies
		this.lifelines = LifelineGenerator.generateHyperCubeLifeLine(h,P, glbParam.l, glbParam.z);
		
		// initialize (lifeline) thieves and related data structures
		lifelineThieves = new FixedSizeStack[Long](lifelines.size+3);
		thieves = new FixedSizeStack[Long](P);
		lifelinesActivated = new Rail[Boolean](P);
		
		// bootstrap the workload distribution by injecting some lifeline stealing requests
		if(this.balancedLevel == GlobalLoadBalancer.BALANCED_LEVEL_NUB){
			if (3*h+1 < P) lifelineThieves.push(3*h+1);
			if (3*h+2 < P) lifelineThieves.push(3*h+2);
			if (3*h+3 < P) lifelineThieves.push(3*h+3);
			if (h > 0) lifelinesActivated((h-1)/3) = true;
		}
		// setup lifeline logger, for statistics collecting purpose
		logger = new Logger(true);		
	}
	
	/**
	 * @return task frame
	 */
	protected def getTF():TaskFrame[Z]=this.tf;
	
	/**
	 * Probe network. 
	 * @param n used for debugging purpose, a debugging id
	 */
	@Inline private def probe(n:Long) {
		if(verbose ==  GLBParameters.VERBOSE_MAX) { if (++probes%(1<<25n) == 0) Runtime.println(Runtime.hereLong() + " PROBING " + n + " (" + (probes>>25n) + ")"); }
		Runtime.probe();
	}
	


    
	/**
	 * added on Dec 13, 2013 yield points
	 */
    public def getYieldPoint(){
        return (st:PlaceLocalHandle[LocalJobRunner[Z]])=>{probe(9999999);distribute(st);reject(st);};
    }

	/**
	 * Main process function of LocalJobRunner. It does 4 things:
	 * (1) execute at most n tasks 
	 * (2) respond to stealing requests
	 * (3) when not worth sharing tasks, reject the stealing requests 
	 * (4) when running out of tasks, steal from others
	 * @param st the place local handle of LJR
	 */
	private final def processStack(st:PlaceLocalHandle[LocalJobRunner[Z]]) { 
		do {
			while (processAtMostN()) {
				probe(9999999);		
				distribute(st); 
				reject(st);
			}
			reject(st); 
		} while (steal(st)); 
		if(verbose == GLBParameters.VERBOSE_MAX) {
			if (tf.getTaskBag().size() > 0) Runtime.println(Runtime.hereLong() + " ERROR taskbag.size>0");
			if (thieves.size() > 0) Runtime.println(Runtime.hereLong() + " ERROR thieves.size>0");
		}
	}
	
	/**
	 * Execute at most n tasks
	 * @return true when successfully executing n tasks
	 *         false when finishing less than n tasks (i.e., running out of tasks) 
	 */
	@Inline private final def processAtMostN():Boolean {	
		val result:Boolean =  this.tf.runAtMostNTasks(this.n); 
		// if(verbose == GLBParameters.VERBOSE_MAX){
		// 	Console.OUT.println("place " + Runtime.hereLong()+ " finished processAtMostN");
		// }
		return result;
	}
	
	/**
	 * Distribute works to (lifeline) thieves by calling the 
	 * {@link #give(PlaceLocalHandle[LocalJobRunner[Z]],TaskBag)} method
	 * @param st place local handle of LJR
	 */
	@Inline private def distribute(st:PlaceLocalHandle[LocalJobRunner[Z]]) {
		var loot:TaskBag;
		while (((thieves.size() > 0) || 
				(lifelineThieves.size() > 0)) && (loot = this.tf.getTaskBag().split()) != null) {			
			give(st, loot);
		}
	}
	
	/**
	 * Send out the workload to thieves. At this point, either thieves or lifelinetheives 
	 * is non-empty (or both are non-empty). Note sending workload to the lifeline thieve
	 * is the only place that uses async (instead of uncounted async as in other places),
	 * which means when only all lifeline requests are responded can the framework be terminated.
	 * @param st place local handle of LJR
	 * @param loot the taskbag(aka workload) to send out
	 */
	@Inline private def give(st:PlaceLocalHandle[LocalJobRunner[Z]], loot:TaskBag) {
		val victim = Runtime.hereLong();
		logger.tbSentSize += loot.size();
		if (thieves.size() > 0) {
			val thief = thieves.pop();
			if (thief >= 0) {
				++logger.lifelineStealsSuffered;
				at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; } 
			} else {
				++logger.stealsSuffered;
				at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
			}
		} else { // lifeline theives are not empty here
			++logger.lifelineStealsSuffered;
			val thief = lifelineThieves.pop();
			at (Place(thief)) async st().deal(st, loot, victim);// ONLY place that uses deal, thief activity is now
			// reactivated
		}
	}
	
	/**
	 * Deal workload to the theif. If the thief is active already, simply merge the taskbag. If the thief is inactive,
	 * the thief gets reactiveated again.
	 * @param st: PLH for LJR
	 * @param loot Task to share
	 * @param source victim id
	 */
	private def deal(st:PlaceLocalHandle[LocalJobRunner[Z]], loot:TaskBag, source:Long) {
		try {
			val lifeline = source >= 0;
			if (lifeline) lifelinesActivated(source) = false; 
			empty = false;
			if (active) {
				processLoot(loot, lifeline);
			} else {
				if(GLBParameters.VERBOSE_MAX == verbose) { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
				active = true;
				logger.startLive();
				processLoot(loot, lifeline);
				processStack(st);
				logger.stopLive();
				active = false;
				if(verbose == GLBParameters.VERBOSE_MAX) { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
				
			}
		} catch (v:CheckedThrowable) {
			error(v);
		}
	}
	
	/**
	 * Merge current LJR's taskbag with incoming task bag.
	 * @param loot task bag to merge
	 * @param lifeline if it is from a lifeline buddy
	 */
	@Inline private final def processLoot(loot:TaskBag, lifeline:Boolean) {
		val n = loot.size();
		if (lifeline) {
			++logger.lifelineStealsPerpetrated;
			logger.lifelineTbReceivedSize += n;
		} else {
			++logger.stealsPerpetrated;
			logger.tbReceivedSize += n;
		}
		this.tf.getTaskBag().merge(loot);
		
	}
	
	/**
	 * Rejecting thieves when no task to share (or worth sharing). Note, never reject lifeline thief,
	 * instead put it into the lifelineThieves stack,
	 */
	@Inline private def reject(st:PlaceLocalHandle[LocalJobRunner[Z]]) {
		while (thieves.size() > 0) {
			val thief = thieves.pop();
			if (thief >= 0) {
				lifelineThieves.push(thief);
				at (Place(thief)) @Uncounted async { st().waiting = false; }
			} else {
				at (Place(-thief-1)) @Uncounted async { st().waiting = false; }
			}
		}
	}
	
	/**
	 * Send out steal requests.
	 * It does following things:
	 * (1) Probes w random victims and send out stealing requests by calling into 
	 * {@link #request(st:PlaceLocalHandle[LocalJobRunner[Z]], thief:Long, lifeline:Boolean)}
	 * (2) If probing random victims fails, resort to lifeline buddies
	 * In both case, it sends out the request and wait on the thieves' response, which either comes from
	 * (i){@link #reject(PlaceLocalHandle[LocalJobRunner[Z]])} when victim has no workload to share
	 * or (ii) {@link #give(PlaceLocalHandle[LocalJobRunner[Z]],TaskBag)} when victim gives the workload
	 * 
	 * @param st PHL for LJR
	 */
	private def steal(st:PlaceLocalHandle[LocalJobRunner[Z]]) {
		if (P == 1) return false;
		val p = Runtime.hereLong(); // the place the thief lives
		empty = true;
		for (var i:Long=0; i < w && empty; ++i) {
			++logger.stealsAttempted;
			waiting = true;
			logger.stopLive();
			val v = victims(random.nextInt(m)); 
			at (Place(v)) @Uncounted async st().request(st, p, false);
			while (waiting) probe(v);
			logger.startLive();
		}
		for (var i:Long=0; (i<lifelines.size) && empty && (0<=lifelines(i)); ++i) {
			val lifeline = lifelines(i);
			if (!lifelinesActivated(lifeline)) {
				++logger.lifelineStealsAttempted;
				lifelinesActivated(lifeline) = true;
				waiting = true;
				logger.stopLive();
				at (Place(lifeline)) @Uncounted async st().request(st, p, true);
				while (waiting) probe(-lifeline);
				logger.startLive();
			}
		}
		return !empty;// Note remote call give() can set empty to be false
	}
	
	/**
	 * Remote thief sending requests to local LJR. When empty or waiting for more work,
	 * reject non-lifeline thief right away. Note, never reject lifeline thief.
	 * @param st PLH for LJR
	 * @param thief place id of thief
	 * @param lifeline if I am the lifeline buddy of the remote thief
	 */
	protected def request(st:PlaceLocalHandle[LocalJobRunner[Z]], thief:Long, lifeline:Boolean) {
		try {
			if (lifeline) ++logger.lifelineStealsReceived; else ++logger.stealsReceived;
			if (empty || waiting) {
				if (lifeline) lifelineThieves.push(thief);
				at (Place(thief)) @Uncounted async { st().waiting = false; }
			} else {
				// use negative number to represent non-lifeline thieve
				if (lifeline) thieves.push(thief); else thieves.push(-thief-1); 
			}
		} catch (v:CheckedThrowable) {
			error(v);
		}
	}
	
	
	
	/**
	 * Entry point of GLB framework. The workflow is terminated when 
	 * (1) No one has work to do
	 * (2) Lifeline steals are responded
	 * @param place local handle for LJR
	 * 
	 */
	protected def main(st:PlaceLocalHandle[LocalJobRunner[Z]] ) {
		if(this.balancedLevel == 1n){ // UTS type
			mainNUB(st);
		}else if(this.balancedLevel == 3n){ // BC type
			mainNB(st);
		}else{
			// left blank
		}
		
	}
	
	/**
	 * UTS kind of natrually unbalanced job, original trickle down implementation
	 */
	protected def mainNUB(st:PlaceLocalHandle[LocalJobRunner[Z]]){
		@Pragma(Pragma.FINISH_DENSE) finish { 
			try {
				if(verbose == GLBParameters.VERBOSE_MAX) { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
				empty = false;
				active = true;
				logger.startLive();	
				this.tf.initTask(); 
				processStack(st);		
				logger.stopLive();
				active = false;
				if(verbose == GLBParameters.VERBOSE_MAX) { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
			} catch (v:CheckedThrowable) {
				error(v);
			}
		} 
	}
	
	
	/**
	 * BC kind of natrually balanced job
	 */
	protected def mainNB(st:PlaceLocalHandle[LocalJobRunner[Z]]){
		@Pragma(Pragma.FINISH_DENSE) finish { 
			try {
				for(i in 0l..(P-1l)){
					at(Place(i)) async {
						st().empty = false;
						st().active = true;
						st().logger.startLive();	
						//st().tf.initTask(i, P);
						st().processStack(st);// Really ?		
						st().logger.stopLive();
						st().active = false;
					}
					
				}
			} catch (v:CheckedThrowable) {
				error(v);
			}
		} 
	}
	
	
	
	/**
	 * print lifeline, for debugging purpose only
	 */
	protected def printLifelines():void{
		Console.OUT.print(Runtime.hereLong() + ":");
		for(li in this.lifelines){
			Console.OUT.print(li+" ");
		}
		Console.OUT.print(" lifeline activatd: ");
		for(lla in lifelinesActivated){
			Console.OUT.print(lla+" ");
		}
		Console.OUT.print(" lifelinethieves: ");
		for (llt in lifelineThieves.data){
			Console.OUT.print(llt+" ");
		}
		Console.OUT.print(" thieves: ");
		for (t in thieves.data){
			Console.OUT.print(t+" ");
		}
		Console.OUT.println();
	}
	
	/**
	 * Print exceptions
	 * @param v exeception
	 */
	private static def error(v:CheckedThrowable) {
		Runtime.println("Exception at " + here);
		v.printStackTrace();
	}
	
	//////////////// below are added on November 08 to support Natuarlly-Balanced workload ///////////
	// protected def mainNB(st:PlaceLocalHandle[LocalJobRunner[Z]]) {
	//     
	//     @Pragma(Pragma.FINISH_DENSE) finish { 
	//         try {
	//             //if(verbose == GLBParameters.VERBOSE_MAX) { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
	//             for(i in 1..P){
	//                 empty = false;
	//                 active = true;
	//                 logger.startLive();	
	//                 this.tf.initTask(); 
	//                 processStack(st);		
	//                 logger.stopLive();
	//                 active = false;
	//             //if(verbose == GLBParameters.VERBOSE_MAX) { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
	//             }
	//         } catch (v:CheckedThrowable) {
	//             error(v);
	//         }
	//         
	//     } 
	// }
	
	
	
	
	
}
