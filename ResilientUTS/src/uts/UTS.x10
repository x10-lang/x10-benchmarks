/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2015.
 */

package uts;

import java.security.DigestException;
import x10.util.concurrent.AtomicLong;

final class UTS {

  static def sub(str:String, start:int, end:int):String {
    return str.substring(start, Math.min(end, str.length()));
  }

  public static def printUsage() {
	  Console.ERR.println("invoked as uts.UTS ARGS where ARGS can be from");
	  Console.ERR.println("-help\t\tPrint this usage message and quit");
	  Console.ERR.println("-statsHeader csv\tPrint header for CSV format and exit");
	  Console.ERR.println("-statsFormat csv\tPrint final stats in CSV format");
	  Console.ERR.println("-statsFormat human\tPrint final stats in human readable format");
	  
	  Console.ERR.println("-transferMode transact\tUse a transaction to transfer data (default)");
	  Console.ERR.println("-transferMode atomic\tUse atomic operations to transfer data (not-resilient)");
	  Console.ERR.println("-transferMode atomic-submit\tUse atomic operations to transfer data (not-resilient), and use key submission");
	  Console.ERR.println("-transferMode nomap\tDon't use a resilient map to transfer data");

	  Console.ERR.println("-recoveryMode wave\t Recover in waves  (default)");
	  Console.ERR.println("-recoveryMode sequential\t Recover sequentially ");
	  
	  Console.ERR.println("-workers <INT>\t\tSet the number of workers used (per-place).  If this is set to 0, a special sequential version is run");
	  Console.ERR.println("-depth <INT>\t\tSet the depth to be used");
	  Console.ERR.println("-d <INT>\t\tSet the depth to be used");
	  Console.ERR.println("<INT>\t\tSet the depth to be used");
  }
  
  public static val RECOVERY_MODE_SEQUENTIAL = 0n;
  public static val RECOVERY_MODE_WAVES = 1n;
  public static val RECOVERY_MODE_DEFAULT:Int = RECOVERY_MODE_WAVES;


  private static def printCSV(time:Long, count:Long, waves:Long, stats:Stats) {
	  val str = "CSV" 
		  + ", " + time 
		  + ", " + count 
		  + ", " + waves 
		  + ", " + stats.asCSV();
	  Console.OUT.println(str);
  }

  private static def printCSVHeader() {
	  val str = "CSV" 
		  + ", " + "time (ns)" 
		  + ", " + "count (nodes)" 
		  + ", " + "waves" 
		  + ", " + Stats.csvHeader();
	  
	  Console.OUT.println(str);
  }

  
  public static def main(args:Rail[String]) throws DigestException : void {

	var specifiedDepth:Int = 13n;
	var specifiedWorkers:Int = 1n;
	var specifiedTransferMode:Int = UTSWorker.TRANSFER_MODE_DEFAULT;
	var specifiedRecoveryMode:Int = RECOVERY_MODE_DEFAULT;
	var csv:Boolean = false;
	
	for(var curArg:Long = 0; curArg < args.size; curArg++) {
		val arg = args(curArg);
		
		if(arg.equalsIgnoreCase("-help") || arg.equalsIgnoreCase("-usage")) {
			printUsage();
			return;
		} else if(arg.equalsIgnoreCase("-statsHeader")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal -statsHeader argument with no corresponding format");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			if(arg2.equalsIgnoreCase("csv")) {
				printCSVHeader();
			} else if(arg2.equalsIgnoreCase("human")) {
				
			} else {
				Console.ERR.println("-statsHeader with illegal format " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}

			return;
		}	
		else if(arg.equalsIgnoreCase("-statsFormat")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal -statsFormat argument with no corresponding format");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			if(arg2.equalsIgnoreCase("csv")) {
				csv = true;
			} else if(arg2.equalsIgnoreCase("human")) {
				
			} else {
				Console.ERR.println("-statsFormat with illegal format " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		} else if(arg.equalsIgnoreCase("-csv")) {
			csv = true;
		} else if(arg.equalsIgnoreCase("-transferMode")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal -transferMode argument with no corresponding mode");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			if(arg2.equalsIgnoreCase("transact") || arg2.equalsIgnoreCase("transactional") || arg2.equalsIgnoreCase("t")) {
				specifiedTransferMode = UTSWorker.TRANSFER_MODE_TRANSACTIONAL;
			} else if(arg2.equalsIgnoreCase("atomic") || arg2.equalsIgnoreCase("atom") || arg2.equalsIgnoreCase("a")) {
				specifiedTransferMode = UTSWorker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("atomic-submit") || arg2.equalsIgnoreCase("atom-submit") || arg2.equalsIgnoreCase("as")) {
				specifiedTransferMode = UTSWorker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("nomap") || arg2.equalsIgnoreCase("nm")) {
				specifiedTransferMode = UTSWorker.TRANSFER_MODE_NOMAP;
			} else {
				Console.ERR.println("transferMode argument is not valid " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}

		} else if(arg.equalsIgnoreCase("-recoveryMode")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal -recoveryMode argument with no corresponding mode");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			if(arg2.equalsIgnoreCase("seq") || arg2.equalsIgnoreCase("sequential") || arg2.equalsIgnoreCase("s")) {
				specifiedRecoveryMode = RECOVERY_MODE_SEQUENTIAL;
			} else if(arg2.equalsIgnoreCase("wave") || arg2.equalsIgnoreCase("waves") || arg2.equalsIgnoreCase("w")) {
				specifiedRecoveryMode = RECOVERY_MODE_WAVES;
			} else {
				Console.ERR.println("recoveryMode argument is not valid " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}

		} else if(arg.equalsIgnoreCase("-workers") || arg.equalsIgnoreCase("-w")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal " + arg + " argument with no corresponding number");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			try {
				specifiedWorkers = Int.parseInt(arg2);
			} catch(e:Exception) {
				Console.ERR.println("workers argument is not parseable as an integer " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		} else if(arg.equalsIgnoreCase("-depth") || arg.equalsIgnoreCase("-d")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal " + arg + " argument with no corresponding depth");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			try {
				specifiedDepth = Int.parseInt(arg2);
			} catch(e:Exception) {
				Console.ERR.println("depth argument is not parseable as an integer " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		} else {
			try {
				specifiedDepth = Int.parseInt(arg);
			} catch(e:Exception) {
				Console.ERR.println("Unknown argument " + arg);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		}
	}
	
	if(specifiedDepth <= 0) {
		Console.ERR.println("depth argument must be greater than zero, not " + specifiedDepth);
		printUsage();
		System.setExitCode(-1n);
		return;
	}

	if(specifiedWorkers < 0) {
		Console.ERR.println("workers argument must be less than zero, not " + specifiedWorkers);
		printUsage();
		System.setExitCode(-1n);
		return;
	}

    val depth:int = specifiedDepth;
    val isSequential = specifiedWorkers == 0n;
    val isRecoverySequential : Boolean = specifiedRecoveryMode == RECOVERY_MODE_SEQUENTIAL;
    val numWorkersPerPlace:Long = isSequential ? 1 : specifiedWorkers as Long;
    
    // If we are running sequentially, we do not want to use Hazelcast
    val transferMode = isSequential ? UTSWorker.TRANSFER_MODE_NOMAP : specifiedTransferMode;
    val diffThreads = isSequential ? 0n : (specifiedWorkers + 1n - x10.xrx.Runtime.NTHREADS);
    
    val pg = isSequential ? new SparsePlaceGroup(here) : Place.places();
    val workers = UTSWorker.make(diffThreads, pg, numWorkersPerPlace, transferMode);
    
    //Console.OUT.println("Starting...");
    val startTime:Long = System.nanoTime();
    
    var stillHasWork : Boolean = true;
    var workLeftBag: Bag = null;
    var count:Long = 0;
    var waves:Long = 0;

    while(stillHasWork) {
    	val waveStartTime:Long = System.nanoTime();
    	waves++;
		val runSequential : Boolean;
		// first pass
		if(workLeftBag == null) {
			workers()(0).init(19n, depth);
			runSequential = isSequential;
		} else {
			UTSWorker.resetAllWorkers(pg, numWorkersPerPlace, workers);
			workers()(0).init(workLeftBag);
			runSequential = isSequential || isRecoverySequential;
		}
		val seqString = runSequential ? " (sequential) " : " ";
		Console.ERR.println("Starting" + seqString + "wave " + waves);
		workLeftBag = null;
		try {
			if(runSequential) {
				count += workers()(0).seq();
				break;
			} 
			
	    	try {
	    		finish {    			
	    			workers()(0).run();
	    		};
	    	} catch(me:MultipleExceptions) {
	    		val me2 = me.filterExceptionsOfType[DeadPlaceException](true);
	    		if(me2 != null) {
	    			throw me;
	    		} else {
	    			// Just DeadPlaceExceptions, which can be safely ignored
	    		}
	    	}
	    	
	    	// if places have died, gather up the remaining bags
	    	// and merge them together so we can finish computation
	    	if(workers()(0).useMap()) {
	    		for (e in workers()(0).map.entrySet()) {
	    			val b:Bag = e.getValue().bag;
	    			if (b != null && b.size != 0n) {
	    				Console.ERR.println("Recovering " + workers()(0).getLocationString(e.getKey()));
	    				if(workLeftBag == null) {
	    					workLeftBag = b;
	    				} else {
	    					workLeftBag = workLeftBag.merge(b);
	    				}
	    			}
	    		}
	    		
	    		// collect all counts
	    		for (c in workers()(0).map.values()) {
	    			count += c.count;
	    		}
	    		workers()(0).map.clear();
	    		
	    	} else {
	    		// don't use the resilient map
	    		if(Place.numDead() > 0) {
	    			Console.ERR.println("A place died.  " +
	    					"Recovering from place death is not supported using transfer mode " 
	    					+ transferMode + ".");
	    			System.setExitCode(-1n);
	    			return;
	    		}
	    		count = UTSWorker.getGlobalCount(pg, numWorkersPerPlace, workers);
		    }
	    	stillHasWork = workLeftBag != null;
	    } finally {
	    	val waveEndTime = System.nanoTime();
	    	val waveTime = waveEndTime - waveStartTime;
	    	Console.ERR.println("Ending" + seqString + "wave " + waves + ", which took: " + (waveTime/1e9) + "s");
	    	Console.ERR.println("Current count is: " + count);
	    }
    }

    val endTime = System.nanoTime();
    val time = endTime - startTime;
    //Console.OUT.println("Finished.");

    val stats = UTSWorker.getGlobalStats(pg, numWorkersPerPlace, workers);
    
    if(csv) {
    		printCSV(time, count, waves, stats);    	
    } else {
	    Console.OUT.println("Performance: " + count + "/"
	        + sub("" + time / 1e9, 0n, 6n) + " = "
	        + sub("" + (count / (time / 1e3)), 0n, 6n) + "M nodes/s");
	    
	    stats.print(Console.OUT);
    }
  }
}
