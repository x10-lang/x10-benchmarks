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
		val P = Place.MAX_PLACES;
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[T, Z]](PlaceGroup.WORLD, init);
		Console.OUT.println("Starting...");
		//var time:Long = System.nanoTime();
		st().main(st); // Wei: the main computation is started from here and ended after it is done
		//time = System.nanoTime() - time;
		//Console.OUT.println("Wei's studio.");
		results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		result:Z = getFinalResult(results);
		//Console.OUT.println("Finished.");
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
	
	public def getFinalResult(results: Rail[Z]):Z{
		var r : Z = this.getResultReducer().zero();		
		for(p in results){
			r = this.getResultReducer()(r,p);
		}
		return r;
	}
}