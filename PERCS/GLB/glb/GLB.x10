package glb;
import x10.util.Team;
import util.Logger;
import x10.compiler.Inline;
public final class GLB[Queue]{Queue<:TaskQueue[Queue]} {
	private val P = Place.MAX_PLACES;
	private val plh:PlaceLocalHandle[Worker[Queue]];
	var setupTime:Long;
	var crunchNumberTime:Long;
	var collectResultTime:Long;
	
	@Inline static def min(i:Long, j:Long) = i < j ? i : j;
	// public def this(init:()=>Queue, n:Int, w:Int, l:Int, z:Int, m:Int, tree:Boolean) {
	// 	plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, ()=>new Worker[Queue](init, n, w, l, z, m, tree));
	// 	Worker.initContexts[Queue](plh);
	// }
	var glbParams:GLBParameters;
	public def this(init:()=>Queue, glbParams:GLBParameters, tree:Boolean) {
		this.glbParams = glbParams;
		setupTime = System.nanoTime();
		plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, 
				()=>new Worker[Queue](init, glbParams.n, glbParams.w, glbParams.l, glbParams.z, glbParams.m, tree));
		Worker.initContexts[Queue](plh);
		setupTime = System.nanoTime() - setupTime;
	}
	
	
	public def taskQueue() = plh().queue;
	
	public def run(start:()=>void):GLBResult {
		crunchNumberTime = System.nanoTime();
		plh().main(plh, start);
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		r:GLBResult = collectResults();
		end(r);
		return r;
	}
	
	public def runParallel() : GLBResult{
		crunchNumberTime = System.nanoTime();
		Worker.broadcast[Queue](plh);
		crunchNumberTime = System.nanoTime() - crunchNumberTime;
		r:GLBResult = collectResults();
		end(r);
		return r;
	}
	
	private def end(r:GLBResult):void{
		if((glbParams.v & GLBParameters.SHOW_RESULT_FLAG) != 0n){ // print result
			r.display();
		}
		if((glbParams.v & GLBParameters.SHOW_TIMING_FLAG) != 0n ){ // print overall timing information
			Console.OUT.println("Reap time R (s):" + (collectResultTime / 1E9));
			Console.OUT.println("Process time(P+R) (s):" + ((crunchNumberTime+collectResultTime) / 1E9));
			Console.OUT.println("Process rate(P+R)/(P+R+S) (s): " 
					+ ((crunchNumberTime+collectResultTime)/1E9)*100.0/
					((crunchNumberTime+collectResultTime+setupTime)/1E9)+"%");
		}
		
		
		
		if((glbParams.v & GLBParameters.SHOW_TASKFRAME_LOG_FLAG) != 0n){ // print log
			 printLog(plh);	
		}
		if((glbParams.v & GLBParameters.SHOW_GLB_FLAG) != 0n){ // collect glb statistics and print it out
			collectLifelineStatus(plh);	
		}
	}
	
	private def collectLifelineStatus(st:PlaceLocalHandle[Worker[Queue]]):void{
		val logs:Rail[Logger];
		//val groupSize:Long = 128l;
		if (P >= 1024) {
			logs = new Rail[Logger](P/32, (i:Long)=>at (Place(i*32)) {
				val h = Runtime.hereLong();
				val n = min(32, P-h);
				val logs = new Rail[Logger](n, (i:Long)=>at (Place(h+i)) st().logger.get((this.glbParams.v & GLBParameters.SHOW_GLB_FLAG)!=0n));
				val log = new Logger(false);
				log.collect(logs);
				return log;
			});
		} else {
			logs = new Rail[Logger](P, (i:Long)=>at (Place(i)) st().logger.get((this.glbParams.v & GLBParameters.SHOW_GLB_FLAG)!=0n));
		}
		val log = new Logger(false);
		log.collect(logs);
		log.stats();
	}
	
	/**
	 * Feb 3, 2014
	 */
	public def collectResults():GLBResult{
		collectResultTime = System.nanoTime();
		PlaceGroup.WORLD.broadcastFlat(()=>{
			glbR: GLBResult = plh().queue.getResult(); 
		    switch(glbR.getType()){
		    case GLBResult.RESULT_LONG_TYPE:
		    	Team.WORLD.allreduce(glbR.getLongResult(), // Source buffer.
		    			0, // Offset into the source buffer.
		    			glbR.getLongResult(), // Destination buffer.
		    			0, // Offset into the destination buffer.
		    			glbR.getLongResult().size, // Number of elements.
		    			glbR.getReduceOperator()); // Operation to be performed.
		    	
		    	break;
		    case GLBResult.RESULT_DOUBLE_TYPE:
		    	Team.WORLD.allreduce(glbR.getDoubleResult(), // Source buffer.
		    			0, // Offset into the source buffer.
		    			glbR.getDoubleResult(), // Destination buffer.
		    			0, // Offset into the destination buffer.
		    			glbR.getDoubleResult().size, // Number of elements.
		    			glbR.getReduceOperator()); // Operation to be performed.
		    	break;
		    default:
		    	Console.OUT.println("Result Reduction is not implemented.!");
		    	break;
		    }
		
		
		});
		collectResultTime = System.nanoTime() - collectResultTime;
		return plh().queue.getResult();
	}
	
	public def stats(verbose:Boolean):Long = Worker.stats[Queue](plh, verbose);
	
	/**
	 * Print logging information on each place if user is interested in collecting computation numbers
	 * @param st PLH for LJR
	 */
	private def printLog(st:PlaceLocalHandle[Worker[Queue]]):void{
		val P = Place.MAX_PLACES;
		for(var i:Long =0L; i < P; ++i){
			at(Place(i)){
				st().queue.printLog();
			}
		}
	}
}
