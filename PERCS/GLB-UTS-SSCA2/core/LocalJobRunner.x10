package core;
import x10.compiler.Inline;
import x10.util.Random;
import core.LifelineGenerator;
import x10.compiler.Ifdef;
import x10.compiler.Uncounted;
import x10.compiler.Pragma;
import x10.util.Option;
import x10.util.OptionsParser;
import core.TaskBag;
public class LocalJobRunner[T,Z] {
	
	val tf:TaskFrame[T,Z];
	
	val victims:Rail[Long]; // random buddies
	val lifelines:Rail[Long];// lifeline buddies
	val n:Int; // at most N tasks to run in a batch
	val h:Long; // here id
	val logger:Logger; // for debugging purpose
	val lifelineThieves:FixedSizeStack[Long]; // read as I am the lifeline of the thieves
	val thieves:FixedSizeStack[Long];
	val lifelinesActivated:Rail[Boolean];
	val P = Place.numPlaces();
	val random = new Random();// two places use random: (1) pick a random thief to steal from
	val w:Int; // random thieves
	val m:Int; // maximal thieves number
	
	val verbose:Int; // verbose level, added on 10/28
	
	// sync variable
	@x10.compiler.Volatile transient var active:Boolean = false;
	@x10.compiler.Volatile transient var empty:Boolean = true;
	@x10.compiler.Volatile transient var waiting:Boolean = false; // Wei: Condition variable flag ? while flag type of sync ?
	
	
	// debug
	var last:Long;
	var phase:Long;
	var probes:Long;
	
	public def this(init:()=>TaskFrame[T,Z],glbParam:GLBParameters) {
		 this.n = glbParam.n;
		this.w = glbParam.w;
		 this.m = glbParam.m;
		 this.verbose = glbParam.v;
		 //this.tf = new UTSTaskFrame(b,r,d);// WA 10/20/13, specific to UTSTaskFrame
		 this.tf = init();
		 
		 
	
		
		
		this.h = Runtime.hereLong();
		
		this.victims = new Rail[Long](m);
		if (P>1) for (var i:Long=0; i<m; i++) {
			while ((victims(i) = random.nextLong(P)) == h);
		}
		
		// lifelines Wei on 10/17
		this.lifelines = LifelineGenerator.generateHyperCubeLifeLine(h,P, glbParam.l, glbParam.z);
		
		
		lifelineThieves = new FixedSizeStack[Long](lifelines.size+3);//Wei: why the magic number +3
		thieves = new FixedSizeStack[Long](P);
		lifelinesActivated = new Rail[Boolean](P);
		
		// 1st wave
		if (3*h+1 < P) lifelineThieves.push(3*h+1);
		if (3*h+2 < P) lifelineThieves.push(3*h+2);
		if (3*h+3 < P) lifelineThieves.push(3*h+3);
		if (h > 0) lifelinesActivated((h-1)/3) = true;
		
		logger = new Logger(true);
		// @Ifdef("LOG"){
		// 	Console.OUT.println("Place "+h+" LocalJobRunner created.");
		// }
		
	}
	

	
	@Inline def probe(n:Long) {
		@Ifdef("LOG") { if (++probes%(1<<25n) == 0) Runtime.println(Runtime.hereLong() + " PROBING " + n + " (" + (probes>>25n) + ")"); }
		Runtime.probe();
	}
	
	final def processStack(st:PlaceLocalHandle[LocalJobRunner[T,Z]]) { // Wei: process() method in the slides
		do {
			while (processAtMostN()) {
				probe(9999999);
				
				distribute(st); // Wei: Contains deal()
				
				reject(st);
			}
			reject(st); // Wei: why reject here ?
		} while (steal(st)); // if finished, more work, a guy is cloned
		@Ifdef("LOG") {
			if (tf.getTaskBag().size() > 0) Runtime.println(Runtime.hereLong() + " ERROR queue.size>0");
			if (thieves.size() > 0) Runtime.println(Runtime.hereLong() + " ERROR thieves.size>0");
		}
	}
	
	@Inline protected final def processAtMostN():Boolean {
		
		val result:Boolean =  this.tf.runAtMostNTask(this.n); // WA
		
		return result;
	}
	
	@Inline protected def distribute(st:PlaceLocalHandle[LocalJobRunner[T,Z]]) {
		var loot:TaskBag[T];
		while (((thieves.size() > 0) || (lifelineThieves.size() > 0)) && (loot = this.tf.getTaskBag().split()) != null) {
			
			give(st, loot);
		}
	}
	
	/**
	 * at this point, either thieves or lifelinetheives is non-empty (or both are non-empty)
	 */
	@Inline private def give(st:PlaceLocalHandle[LocalJobRunner[T,Z]], loot:TaskBag[T]) {
		val victim = Runtime.hereLong();
		logger.nodesGiven += loot.size();
		if (thieves.size() > 0) {
			val thief = thieves.pop();
			if (thief >= 0) {
				++logger.lifelineStealsSuffered;
				at (Place(thief)) @Uncounted async { st().deal(st, loot, victim); st().waiting = false; } // Wei: who is st?
			} else {
				++logger.stealsSuffered;
				at (Place(-thief-1)) @Uncounted async { st().deal(st, loot, -1); st().waiting = false; }
			}
		} else { // here must be lifeline theives are not empty
			++logger.lifelineStealsSuffered;
			val thief = lifelineThieves.pop();
			at (Place(thief)) async st().deal(st, loot, victim);// ONLY place that uses deal, b/c activity is now
			// reactivated
		}
	}
	
	def deal(st:PlaceLocalHandle[LocalJobRunner[T,Z]], loot:TaskBag[T], source:Long) {
		try {
			val lifeline = source >= 0;
			if (lifeline) lifelinesActivated(source) = false; // in the slides, there was a bug, it should be source as in this code, not thief as in the slides
			empty = false;
			if (active) {
				processLoot(loot, lifeline);
			} else {
				@Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
				active = true;
				logger.startLive();
				processLoot(loot, lifeline);
				//distribute(st);
				processStack(st);
				logger.stopLive();
				active = false;
				@Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
				//logger.nodesCount = queue.getCount(); // WA 10/18/13
				//logger.nodesCount = tf.getResult(); // WA 10/20/13
			}
		} catch (v:CheckedThrowable) {
			error(v);
		}
	}
	
	@Inline final def processLoot(loot:TaskBag[T], lifeline:Boolean) {
		val n = loot.size();
		if (lifeline) {
			++logger.lifelineStealsPerpetrated;
			logger.lifelineNodesReceived += n;
		} else {
			++logger.stealsPerpetrated;
			logger.nodesReceived += n;
		}
		this.tf.getTaskBag().merge(loot);
		//loot.push(queue);// Wei: loot pushes queue actually grows queue
	}
	
	@Inline def reject(st:PlaceLocalHandle[LocalJobRunner[T,Z]]) {
		while (thieves.size() > 0) {
			val thief = thieves.pop();
			if (thief >= 0) {
				lifelineThieves.push(thief);
				at (Place(thief)) @Uncounted async { st().waiting = false; }
			} else {
				at (Place(-thief-1)) @Uncounted async { st().waiting = false; }// Uncounted async doesn't have to match a finish
			}
		}
	}
	
	def steal(st:PlaceLocalHandle[LocalJobRunner[T,Z]]) {
		if (P == 1) return false;
		val p = Runtime.hereLong();
		empty = true;
		for (var i:Long=0; i < w && empty; ++i) {
			++logger.stealsAttempted;
			waiting = true;
			logger.stopLive();
			val v = victims(random.nextInt(m)); // Wei: 10/13, why this way of doing random selecting a victim?
			at (Place(v)) @Uncounted async st().request(st, p, false);// Wei: p:here of thief
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
				at (Place(lifeline)) @Uncounted async st().request(st, p, true);// Wei: What is Uncounted? p is thief id
				while (waiting) probe(-lifeline);
				logger.startLive();
			}
		}
		return !empty;// Wei: always return false ?
	}
	
	// request: thief requests stuff from me @pure_sync_method
	def request(st:PlaceLocalHandle[LocalJobRunner[T,Z]], thief:Long, lifeline:Boolean) {
		try {
			if (lifeline) ++logger.lifelineStealsReceived; else ++logger.stealsReceived;
			if (empty || waiting) {
				if (lifeline) lifelineThieves.push(thief);
				at (Place(thief)) @Uncounted async { st().waiting = false; }
			} else {
				if (lifeline) thieves.push(thief); else thieves.push(-thief-1); // Wei: what is this -theif-1?
			}
		} catch (v:CheckedThrowable) {
			error(v);
		}
	}
	static def error(v:CheckedThrowable) {
		Runtime.println("Exception at " + here);
		v.printStackTrace();
	}
	
	public def main(st:PlaceLocalHandle[LocalJobRunner[T,Z]]) {
		@Pragma(Pragma.FINISH_DENSE) finish { // Wei: one of the distributed termination pattern
			try {
				@Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " LIVE (" + (phase++) + ")"); }
				empty = false;
				active = true;
				logger.startLive();
				
				this.tf.initTask(); // Wei: init at one place ? Yes, there was no async, so init at master place
			
				processStack(st);
				
				logger.stopLive();
				active = false;
				@Ifdef("LOG") { Runtime.println("" + Runtime.hereLong() + " DEAD (" + (phase++) + ")"); }
				//logger.nodesCount = queue.getCount(); // WA 10/18/13
				//logger.nodesCount = tf.getResult(); // WA 10/20/13
			} catch (v:CheckedThrowable) {
				error(v);
			}
		} 
	}
	
	
	public def getTF():TaskFrame[T,Z]{
		return this.tf;
	}
	
	
	// added by Wei Oct 22
	public def printLifelines():void{
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

}