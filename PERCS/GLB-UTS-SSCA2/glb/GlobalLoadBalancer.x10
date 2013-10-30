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
public class GlobalLoadBalancer[Z](glbParam:GLBParameters) {
	@Inline static def min(i:Long, j:Long) = i < j ? i : j;
	
	/**
	 * Entry point for user to run GlobalLoadBalancer 
	 * It has three phases (1) setup phase (2) calculation phase (3) result collection phase
	 * @param init function closure to create task frame
	 */
	public def run(init:()=>TaskFrame[Z]):Z{
		
		/*setup phase*/
		val P = Place.MAX_PLACES;
		var setupTime:Long = System.nanoTime();
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[Z]](PlaceGroup.WORLD, 
				()=>new LocalJobRunner(init, this.glbParam));
		
		setupTime = System.nanoTime() - setupTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Setup time S (s): " + (setupTime / 1E9));
		}
		var crunchNumberTime:Long = System.nanoTime();
		
		/*calculation phase*/
		st().main(st); 
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		if(st().verbose >= 1n) Console.OUT.println("Processing time P (s): " + (crunchNumberTime / 1E9));
		
		/*result calculation phase*/
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
	 * Collect results from each place. If place number is greater than 1024, then it devides the places to 32 subgroups
	 * and collect/reduce results
	 * @param st PLH for LJR
	 * @return results for reducer to reduce
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
	
	/**
	 * Reducers results from each place to return a final result
	 * @param results Array that contains result from each place
	 * @param reducer Reducer that can reduce all the local results to a global one
	 */
	protected def reduce(results: Rail[Z], reducer:Reducible[Z]):Z{
		var r : Z = reducer.zero();		
		for(p in results) r = reducer(r,p);
		return r;
	}
	
	
	
	/**
	 * Print logging information on each place if user is interested in collecting computation numbers
	 * @param st PLH for LJR
	 */
	protected def printLog(st:PlaceLocalHandle[LocalJobRunner[Z]]):void{
		val P = Place.MAX_PLACES;
		for(var i:Long =0L; i < P; ++i){
			at(Place(i)){
				st().getTF().printLog();
			}
		}
	}
	
	/**
	 * Create task frame on each place. Used for debugging purpose only.
	 */
	protected def dryRun(init:()=>TaskFrame[Z]):void{
		val P = Place.MAX_PLACES;
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[Z]](PlaceGroup.WORLD, 
				()=>new LocalJobRunner(init, this.glbParam));
		for(var ii:Long=0L; ii < P; ii++){
			at(Place(ii)) st().printLifelines();
		}
	}
}
