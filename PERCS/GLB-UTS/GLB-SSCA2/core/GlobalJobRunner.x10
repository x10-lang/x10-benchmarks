package core;


import x10.compiler.Pragma;
import x10.compiler.Inline;
import x10.util.Random;
import core.LifelineGenerator;
import x10.compiler.Ifdef;
import x10.compiler.Uncounted;

import x10.util.Option;
import x10.util.OptionsParser;
import core.TaskBag;
import core.LocalJobRunner;
public abstract class GlobalJobRunner[T,Z] {
	@Inline static def min(i:Long, j:Long) = i < j ? i : j;
	
	private var resultReducer:Reducible[Z]; // how do i express the fact that resultReducer is not null
	
	abstract public def getResultReducer():Reducible[Z];
	abstract public def setResultReducer(r:Reducible[Z]):void;
		
	public def main(init:()=>LocalJobRunner[T,Z]):Z{
		val P = Place.numPlaces();
		var setupTime:Long = System.nanoTime();
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[T, Z]](Place.places(), init);
		setupTime = System.nanoTime() - setupTime;
		
		Console.OUT.println("Setup time(s): " + (setupTime / 1E9));
		var crunchNumberTime:Long = System.nanoTime();
		st().main(st); // Wei: the main computation is started from here and ended after it is done
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		Console.OUT.println("Crunch time(s): " + (crunchNumberTime / 1E9));
		//results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		var collectResultTime:Long = System.nanoTime();
		
		results: Rail[Z] = collectResults(st);
		result:Z = getFinalResult(results);
		collectResultTime = System.nanoTime() - collectResultTime;
		Console.OUT.println("Reap time(s):" + (collectResultTime / 1E9));
		Console.OUT.println("Process time(C+R)(s):" + ((crunchNumberTime+collectResultTime) / 1E9));
		Console.OUT.println("Process rate(C+R)/(C+R+S): " +((crunchNumberTime+collectResultTime)/1E9)*100.0/((crunchNumberTime+collectResultTime+setupTime)/1E9)+"%");
		@Ifdef("LOG"){
			printLog(st);// added on Oct 27 to print out the log
		}
		return result;
		
		// note: we will need to do more more work on reduction once we have it running on large machines
		// uncomment the below
		// val logs:Rail[Logger];
		// if (P >= 1024) {
		// 	logs = new Rail[Logger](P/32, (i:Long)=>at (Place(i*32)) {
		// 		val h = Runtime.hereLong();
		// 		val n = min(32, P-h);
		// 		val logs = new Rail[Logger](n, (i:Long)=>at (Place(h+i)) st().logger.get(verbose));
		// 		val log = new Logger(false);
		// 		log.collect(logs);
		// 		return log;
		// 	});
		// } else {
		// 	logs = new Rail[Logger](P, (i:Long)=>at (Place(i)) st().logger.get(verbose));
		// }
		// val log = new Logger(false);
		// log.collect(logs);
		// log.stats(time);
		
	}
	
	/**
	 * collect all the results
	 */
	public def collectResults(st:PlaceLocalHandle[LocalJobRunner[T, Z]]):Rail[Z]
	{
		val P = Place.numPlaces();
		if (P >= 1024) {
			collectedResults:Rail[Z] = new Rail[Z](P/32, (i:Long)=>at (Place(i*32)) {
				val h = Runtime.hereLong();
				val n = min(32, P-h);
				val localResults:Rail[Z] = new Rail[Z](n, (i:Long)=>at (Place(h+i)) st().getTF().getResult());
				return getFinalResult(localResults); // reduce loal results 
				
			});
		   return collectedResults;
		} else {
			//logs = new Rail[Logger](P, (i:Long)=>at (Place(i)) st().logger.get(verbose));
			results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		    return results;
		}
	}
	
	
	
	public def getFinalResult(results: Rail[Z]):Z{
		var r : Z = this.getResultReducer().zero();		
		for(p in results){
			r = this.getResultReducer()(r,p);
		}
		return r;
	}
	
	// added on Oct 22, for debugging purpose
	public def dryRun(init:()=>LocalJobRunner[T,Z]):void{
		val P = Place.numPlaces();
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[T, Z]](Place.places(), init);
		for(var ii:Long=0L; ii < P; ii++){
			at(Place(ii)) st().printLifelines();
		}
	}
	
	/**
	 * added on Oct 27 to print the log
	 */
	public def printLog(st:PlaceLocalHandle[LocalJobRunner[T, Z]]):void{
		val P = Place.numPlaces();
		for(var i:Long =0L; i < P; ++i){
			at(Place(i)){
				st().getTF().printLog();
			}
		}
	}
}