package glb;

import x10.compiler.Pragma;
import x10.compiler.Inline;
import x10.util.Random;

import x10.compiler.Ifdef;
import x10.compiler.Uncounted;

import x10.util.Option;
import x10.util.OptionsParser;

/**
 * The top level class of the Global Load Balancing (GLB) framework.
 * 
 */
public class GlobalJobRunner[Z](glbParam:GLBParameters) {
	@Inline static def min(i:Long, j:Long) = i < j ? i : j;

	public def main(init:()=>TaskFrame[Z]):Z{
		val P = Place.MAX_PLACES;
		var setupTime:Long = System.nanoTime();
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[Z]](PlaceGroup.WORLD, 
		        ()=>new LocalJobRunner(init, this.glbParam));
		
		setupTime = System.nanoTime() - setupTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Setup time S (s): " + (setupTime / 1E9));
		}
		var crunchNumberTime:Long = System.nanoTime();
		
		// start the main computation.
		st().main(st); 
		
		// the computation is over. collect result, print statistics
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		if(st().verbose >= 1n) Console.OUT.println("Processing time P (s): " + (crunchNumberTime / 1E9));
		
		var collectResultTime:Long = System.nanoTime();
		results: Rail[Z] = collectResults(st);
		result:Z = reduce(results, st().getTF().getReducer());
		collectResultTime = System.nanoTime() - collectResultTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Reap time R (s):" + (collectResultTime / 1E9));
			Console.OUT.println("Process time(P+R) (s):" + ((crunchNumberTime+collectResultTime) / 1E9));
			Console.OUT.println("Process rate(P+R)/(P+R+S) (s): " 
			        + ((crunchNumberTime+collectResultTime)/1E9)*100.0/
			        ((crunchNumberTime+collectResultTime+setupTime)/1E9)+"%");
		}
		if(st().verbose >= 2n) printLog(st);
		
		return result;
	}
	
	/**
	 * collect all the results
	 */
	protected def collectResults(st:PlaceLocalHandle[LocalJobRunner[Z]]):Rail[Z]
	{
		val P = Place.MAX_PLACES;
		if (P >= 1024) {
			collectedResults:Rail[Z] = new Rail[Z](P/32, (i:Long)=>at (Place(i*32)) {
				val h = Runtime.hereLong();
				val n = min(32, P-h);
				val localResults:Rail[Z] = new Rail[Z](n, (i:Long)=>at (Place(h+i)) st().getTF().getResult());
				return reduce(localResults,st().getTF().getReducer()); // reduce loal results 
			});
		return collectedResults;
		} else {
			results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		    return results;
		}
	}
	
	protected def reduce(results: Rail[Z], reducer:Reducible[Z]):Z{
		var r : Z = reducer.zero();		
		for(p in results) r = reducer(r,p);
		return r;
	}
	
	// added on Oct 22, for debugging purpose
	protected def dryRun(init:()=>LocalJobRunner[Z]):void{
		val P = Place.MAX_PLACES;
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[Z]](PlaceGroup.WORLD, init);
		for(var ii:Long=0L; ii < P; ii++){
			at(Place(ii)) st().printLifelines();
		}
	}
	
	/**
	 * added on Oct 27 to print the log
	 */
	protected def printLog(st:PlaceLocalHandle[LocalJobRunner[Z]]):void{
		val P = Place.MAX_PLACES;
		for(var i:Long =0L; i < P; ++i){
			at(Place(i)){
				st().getTF().printLog();
			}
		}
	}
}
