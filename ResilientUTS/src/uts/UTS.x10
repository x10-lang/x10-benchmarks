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

	  Console.ERR.println("-depth <INT>\t\tSet the depth to be used");
	  Console.ERR.println("-d <INT>\t\tSet the depth to be used");
	  Console.ERR.println("<INT>\t\tSet the depth to be used");
  }

  private static def printCSV(time:Long, count:Long, stats:Stats) {
	  val str = "CSV" 
		  + ", " + time 
		  + ", " + count 
		  + ", " + stats.asCSV();
	  Console.OUT.println(str);
  }

  private static def printCSVHeader() {
	  val str = "CSV" 
		  + ", " + "time (ns)" 
		  + ", " + "count (nodes)" 
		  + ", " + Stats.csvHeader();
	  
	  Console.OUT.println(str);
  }

  
  public static def main(args:Rail[String]) throws DigestException : void {
    // if (System.getProperty(Configuration.APGAS_PLACES) == null) {
    //   System.setProperty(Configuration.APGAS_PLACES, "4");
    // }
    // System.setProperty(Configuration.APGAS_SERIALIZATION_EXCEPTION, "true");
    // System.setProperty(Configuration.APGAS_RESILIENT, "true");
    // GlobalRuntime.getRuntime(); // force init

	var d:Int = 13n;
	var transferMode:Int = Worker.TRANSFER_MODE_DEFAULT;
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
				transferMode = Worker.TRANSFER_MODE_TRANSACTIONAL;
			} else if(arg2.equalsIgnoreCase("atomic") || arg2.equalsIgnoreCase("atom") || arg2.equalsIgnoreCase("a")) {
				transferMode = Worker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("atomic-submit") || arg2.equalsIgnoreCase("atom-submit") || arg2.equalsIgnoreCase("as")) {
				transferMode = Worker.TRANSFER_MODE_ATOMIC;
			} else if(arg2.equalsIgnoreCase("nomap") || arg2.equalsIgnoreCase("nm")) {
				transferMode = Worker.TRANSFER_MODE_NOMAP;
			} else {
				Console.ERR.println("transferMode argument is not valid " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}

		} else if(arg.equalsIgnoreCase("-depth") || arg.equalsIgnoreCase("-d")) {
			curArg++;
			if(curArg >= args.size) {
				Console.ERR.println("Illegal -d argument with no corresponding depth");
				printUsage();
				System.setExitCode(-1n);
				return;
			}
			val arg2 = args(curArg);
			try {
				d = Int.parseInt(arg2);
			} catch(e:Exception) {
				Console.ERR.println("depth argument is not parseable as an integer " + arg2);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		} else {
			try {
				d = Int.parseInt(arg);
			} catch(e:Exception) {
				Console.ERR.println("Unknown argument " + arg);
				printUsage();
				System.setExitCode(-1n);
				return;
			}
		}
	}
	
	
    val depth:int = d;

    val pg = Place.places();
    val workers = Worker.make(pg, transferMode);
    
    //Console.OUT.println("Starting...");
    val startTime:Long = System.nanoTime();

    try {
    	finish {
	      workers().init(19n, depth);
	      workers().run();
	    };
    } catch(me:MultipleExceptions) {
    	val me2 = me.filterExceptionsOfType[DeadPlaceException](true);
    	if(me2 != null) {
    		throw me;
    	} else {
    		// Just DeadPlaceExceptions, which can be safely ignored
    	}
    }

    var count:Long = 0;
    // if places have died, process remaning nodes seqentially at place 0
    if(workers().useMap()) {
	    for (e in workers().map.entrySet()) {
	      val b:Bag = e.getValue().bag;
	      if (b != null && b.size != 0n) {
	        Console.ERR.println("Recovering " + e.getKey());
	        count += workers().seq(b);
	      }
	    }
	
	    // collect all counts
	    for (c in workers().map.values()) {
	    	count += c.count;
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
    	    val counter = new AtomicLong(0L);
    	    finish {
	    	    	for (p in pg) {
	    	    		if(p != here) {
	    	    			async counter.addAndGet(at(p) workers().count);
	    	    		}
	    	    	}
	    	    	if(pg.contains(here)) {
	    	    		counter.addAndGet(workers().count);
	    	    	}
    	    }
    	    count = counter.get();
    }

    val endTime = System.nanoTime();
    val time = endTime - startTime;
    //Console.OUT.println("Finished.");

    val stats = Worker.getGlobalStats(pg, workers);

    if(csv) {
    		printCSV(time, count, stats);    	
    } else {
	    Console.OUT.println("Performance: " + count + "/"
	        + sub("" + time / 1e9, 0n, 6n) + " = "
	        + sub("" + (count / (time / 1e3)), 0n, 6n) + "M nodes/s");
	    
	    stats.print(Console.OUT);
    }
  }
}
