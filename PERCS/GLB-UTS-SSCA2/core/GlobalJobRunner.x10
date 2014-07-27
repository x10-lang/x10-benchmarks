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
public class GlobalJobRunner[T,Z] {
	@Inline static def min(i:Long, j:Long) = i < j ? i : j;
	
	private val resultReducer:Reducible[Z]; // how do i express the fact that resultReducer is not null
	private val glbParam:GLBParameters;
	// abstract public def getResultReducer():Reducible[Z];
	// abstract public def setResultReducer(r:Reducible[Z]):void;
	
	public def this(glbParam:GLBParameters, resultReducer:Reducible[Z]){
		this.glbParam = glbParam;
		this.resultReducer = resultReducer;
	}
	
	public def main(init:()=>TaskFrame[T,Z]):Z{
		val P = Place.numPlaces();
		var setupTime:Long = System.nanoTime();
		val st = PlaceLocalHandle.makeFlat[LocalJobRunner[T, Z]](Place.places(), ()=>new LocalJobRunner(init, this.glbParam));
		
		setupTime = System.nanoTime() - setupTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Setup time(s): " + (setupTime / 1E9));
		}
		var crunchNumberTime:Long = System.nanoTime();
		st().main(st); // Wei: the main computation is started from here and ended after it is done
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Crunch time(s): " + (crunchNumberTime / 1E9));
		}
		//results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		var collectResultTime:Long = System.nanoTime();
		
		results: Rail[Z] = collectResults(st);
		result:Z = getFinalResult(results);
		collectResultTime = System.nanoTime() - collectResultTime;
		if(st().verbose >= 1n){
			Console.OUT.println("Reap time(s):" + (collectResultTime / 1E9));
			Console.OUT.println("Process time(C+R)(s):" + ((crunchNumberTime+collectResultTime) / 1E9));
			Console.OUT.println("Process rate(C+R)/(C+R+S): " +((crunchNumberTime+collectResultTime)/1E9)*100.0/((crunchNumberTime+collectResultTime+setupTime)/1E9)+"%");
		}
		if(st().verbose >= 3n){
			printLog(st);// added on Oct 27 to print out the log
		}
		return result;
		
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
			results: Rail[Z] = new Rail[Z](P, (i:Long)=>at (Place(i)) st().getTF().getResult());
		return results;
		}
	}
	
	
	
	public def getFinalResult(results: Rail[Z]):Z{
		var r : Z = this.resultReducer.zero();		
		for(p in results){
			r = this.resultReducer(r,p);
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