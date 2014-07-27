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
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[T, Z]](Place.places(), init);
		
		Console.OUT.println("Starting...");
	
		st().main(st); // Wei: the main computation is started from here and ended after it is done
	
		//results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		results: Rail[Z] = collectResults(st);
		result:Z = getFinalResult(results);
		
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
}