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
import x10.util.Collection;
import x10.util.ArrayList;
import x10.util.resilient.ResilientTransactionalMap;

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
	  
	  Console.ERR.println("-kill <place>:<timespan>\t\tTells the place to kill itself after the allotted timespan (after any warmup)");
	  Console.ERR.println("\t\t <timespan> can be specified, using an optional suffix, in nanoseconds (ns, default), milliseconds (ms), seconds(s), minutes(m), or hours(h)");

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
	var specifiedTransferMode:Int = Worker.TRANSFER_MODE_DEFAULT;
	var specifiedRecoveryMode:Int = RECOVERY_MODE_DEFAULT;
	var csv:Boolean = false;
	
	val killTimes = new Rail[Long](Place.numAllPlaces());
	
	
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
				specifiedTransferMode = Worker.TRANSFER_MODE_TRANSACTIONAL;
			} else if(arg2.equalsIgnoreCase("atomic") || arg2.equalsIgnoreCase("atom") || arg2.equalsIgnoreCase("a")) {
				specifiedTransferMode = Worker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("atomic-submit") || arg2.equalsIgnoreCase("atom-submit") || arg2.equalsIgnoreCase("as")) {
				specifiedTransferMode = Worker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("nomap") || arg2.equalsIgnoreCase("nm")) {
				specifiedTransferMode = Worker.TRANSFER_MODE_NOMAP;
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
		} else if(arg.equalsIgnoreCase("-kill") || arg.equalsIgnoreCase("-killAfter") || arg.equalsIgnoreCase("-k")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal " + arg + " argument with no corresponding place:timespan argument");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			val sp = arg2.split(":");
			if(sp.size != 2) {
				Console.ERR.println("Malformed " + arg + " argument: '" + arg2 + "' does not have exactly one colon");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			
			val timeString : String = sp(1);
			var timeToKill : Long;
			try {
				timeToKill = getTime(timeString);
			} catch(e:Exception) {
				Console.ERR.println("Malformed " + arg + " argument.  The second part of '" + arg2 + "' is not parseable as a long.  Note that only ns, ms, s, and m, and h are allowed as suffixes");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			
			// allow comma separated list of places which can have ranges
			val toKillRangeList = sp(0).split(",");
			for(toKillRange in toKillRangeList) {
				val range = toKillRange.split("-");
				if(range.size == 0) {
					// allow and ignore stray commas
					continue;
				} else if(range.size > 2) {
					Console.ERR.println("Malformed " + arg + " argument.  The first part of '" 
							+ arg2 + "' has an invalid range specification: '" 
							+ toKillRange + "' (too many - symbols)");
					printUsage();
					System.setExitCode(-1n);
					return;
				}
				
				var firstPlaceToKill : Long = -1L;
				var lastPlaceToKill : Long = -1L;
				
				try {
					firstPlaceToKill = Long.parseLong(range(0));
				} catch(e:Exception) {
					Console.ERR.println("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a place specifier '" +range(0) + "'that is not parseable as a place list");
					printUsage();
					System.setExitCode(-1n);
					return;
				}
				
				if(range.size == 2) {
					try {
						lastPlaceToKill = Long.parseLong(range(1));
					} catch(e:Exception) {
						Console.ERR.println("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a place specifier '" +range(1) + "'that is not parseable as a place list");
						printUsage();
						System.setExitCode(-1n);
						return;
					}
				} else {
					lastPlaceToKill=firstPlaceToKill;
				}
				if(firstPlaceToKill < 0 || firstPlaceToKill > lastPlaceToKill) {
					Console.ERR.println("Malformed " + arg + " argument.  The first part of '" + arg2 + "' has a range specifier '" + toKillRange + "' that is not a valid range.");
					printUsage();
					System.setExitCode(-1n);
					return;
				}
				
				if(firstPlaceToKill == 0) {
					Console.ERR.println("The " + arg + " argument.  Requested that place 0 die (as part of) '" + arg2 + "', specifically '" +  toKillRange + "'.  We don't currently support killing place 0");
					printUsage();
					System.setExitCode(-1n);
					return;
				}
				
				// allow and ignore places that are too large
				val cappedLastPlaceToKill = Math.min(lastPlaceToKill, Place.numAllPlaces()-1);
				for(pl in firstPlaceToKill..cappedLastPlaceToKill) {
					killTimes(pl) = timeToKill;
				}
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
    val transferMode = isSequential ? Worker.TRANSFER_MODE_NOMAP : specifiedTransferMode;
    val diffThreads = isSequential ? 0n : (specifiedWorkers + 1n - x10.xrx.Runtime.NTHREADS);
    
    val mapPrefix = "utsWave";
    
    //Console.OUT.println("Starting...");
    val startTime:Long = System.nanoTime();
    
    var stillHasWork : Boolean = true;
    var workLeftBag: Bag = null;
    var count:Long = 0;
    var waves:Long = 0;
    var stats:Stats = null;

    while(stillHasWork) {
    	val isFirstWave = workLeftBag == null;
    	val waveStartTime:Long = System.nanoTime();
    	waves++;
    	val mapName = mapPrefix + waves;
    	val pg = isSequential ? new SparsePlaceGroup(here) : Place.places();
    	val kt = isFirstWave ? killTimes : null; 
    	val workers = Worker.make(mapName, diffThreads, pg, numWorkersPerPlace, transferMode, kt);
    	Worker.startAllKillers(pg, numWorkersPerPlace, workers);
    	

		val runSequential : Boolean;
		// first pass
		if(isFirstWave) {
			workers()(0).init(19n, depth);
			runSequential = isSequential;
		} else {
			
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
	    		val cps = getAllCheckpointsFromMap(mapName);
	    		workers()(0).map.clear();
	    		
	    		for (cp in cps) {
	    			if(cp == null) {
	    				continue;
	    			}
	    			val b:Bag = cp.bag;
	    			if (b != null && b.size != 0n) {
	    				if(workLeftBag == null) {
	    					workLeftBag = b;
	    				} else {
	    					workLeftBag = workLeftBag.merge(b);
	    				}
	    			}
	    			count += cp.count;
	    		}
	    		if(workLeftBag != null) {
	    			Console.ERR.println("Recovering bag(s)");
	    		}
	    	} else {
	    		// don't use the resilient map
	    		if(Place.numDead() > 0) {
	    			Console.ERR.println("A place died.  " +
	    					"Recovering from place death is not supported using transfer mode " 
	    					+ transferMode + ".");
	    			System.setExitCode(-1n);
	    			return;
	    		}
	    		count = Worker.getGlobalCount(pg, numWorkersPerPlace, workers);
		    }
	    	stillHasWork = workLeftBag != null;
	    } finally {
	    	val waveEndTime = System.nanoTime();
	    	val waveTime = waveEndTime - waveStartTime;
	    	Console.ERR.println("Ending" + seqString + "wave " + waves + ", which took: " + (waveTime/1e9) + "s");
	    	Console.ERR.println("Current count is: " + count);
	    	val waveStats = Worker.getGlobalStats(pg, numWorkersPerPlace, workers);
	    	if(stats == null) {
	    		stats = waveStats;
	    	} else {
	    		stats.add(waveStats);
	    	}
	    	

	    }
    }
    
    val endTime = System.nanoTime();
    val time = endTime - startTime;
    //Console.OUT.println("Finished.");

    if(stats == null) {
    	stats = new Stats();
    }
    
    if(csv) {
    		printCSV(time, count, waves, stats);    	
    } else {
	    Console.OUT.println("Performance: " + count + "/"
	        + sub("" + time / 1e9, 0n, 6n) + " = "
	        + sub("" + (count / (time / 1e3)), 0n, 6n) + "M nodes/s");
	    
	    stats.print(Console.OUT);
    }
  }
  
  private static def runWave(bags:ArrayList[Bag], wave:Long):ArrayList {
	  
	  return null;
  }
  
  private static def getAllCheckpointsFromMap(mapName:String)
  	: Collection[Checkpoint] {
	  return ResilientTransactionalMap.runTransaction(mapName,
			  (map:ResilientTransactionalMap[Long, Checkpoint]) => {
				  return map.values();
			  }
	  );
  }
  
  /**
   * parses a string and returns the corresponding timespan in nanoseconds
   */
  public static def getTime(var timeString:String):Long {
	  val units : Long;

	  if(timeString.endsWith("ns")) {
		  timeString = timeString.substring(0n,(timeString.length()-2n) as Int);
		  units = 1;
	  } else if(timeString.endsWith("ms")) {
		  timeString = timeString.substring(0n,(timeString.length()-2n) as Int);
		  units = 1000;
	  } else if(timeString.endsWith("s")) {
		  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
		  units = 1000*1000;
	  } else if(timeString.endsWith("m")) {
		  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
		  units = 1000*1000*60;
	  } else if(timeString.endsWith("h")) {
		  timeString = timeString.substring(0n,(timeString.length()-1n) as Int);
		  units = 1000*1000*60*60;
	  } else {
		  units = 1;
	  }
	  return Long.parseLong(timeString) * units;
  }
}
