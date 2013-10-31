package glb;
/**
 * Class that collects lifeline statistics of GLB
 */
class Logger {
   
	/* workload sent/recieved stat*/
    var tbSentSize:Long = 0;
    var tbReceivedSize:Long = 0;
    var lifelineTbReceivedSize:Long = 0;
    
    /* (random)stealing requests stat*/
    var stealsAttempted:Long = 0;
    var stealsPerpetrated:Long = 0;
    var stealsReceived:Long = 0;
    var stealsSuffered:Long = 0;
    
    /* (lifeline)stealing requests stat*/
    var lifelineStealsAttempted:Long = 0;
    var lifelineStealsPerpetrated:Long = 0;
    var lifelineStealsReceived:Long = 0;
    var lifelineStealsSuffered:Long = 0;
    
    /* timing stat */
    var lastStartStopLiveTimeStamp:Long = -1;
    var timeAlive:Long = 0;
    var timeDead:Long = 0;
    var startTime:Long = 0;
    val timeReference:Long;
    
    /**
     * Constructor
     * @b true prior-calculation; false post-calculation
     * 
     */
    def this(b:Boolean) {
        if (b) x10.util.Team.WORLD.barrier();
        timeReference = System.nanoTime();
    }
    
    /**
     * Timer is started before processing, which includes calculation, distribution and requesting/rejects tasks
     */
    def startLive() {
        val time = System.nanoTime();
        if (startTime == 0) startTime = time;
        if (lastStartStopLiveTimeStamp >= 0) {
            timeDead += time - lastStartStopLiveTimeStamp;
        }
        lastStartStopLiveTimeStamp = time;
    }
    
    /**
     * Timer is stopped when running out of tasks and failing to steal any task
     */
    def stopLive() {
        val time = System.nanoTime();
        timeAlive += time - lastStartStopLiveTimeStamp;
        lastStartStopLiveTimeStamp = time;
    }

    /**
     * Aggregate stats for all places
     * @param logs log from every place
     */
    def collect(logs:Rail[Logger]) {
        for (l in logs) add(l);
    }
    
    /**
     * Sum up stat with another logger
     * @param other another logger to sum up with
     */
    def add(other:Logger) {
    	
    	tbSentSize += other.tbSentSize;
    	tbReceivedSize += other.tbReceivedSize;
    	stealsPerpetrated += other.stealsPerpetrated;
    	lifelineTbReceivedSize += other.lifelineTbReceivedSize;
    	lifelineStealsPerpetrated += other.lifelineStealsPerpetrated;
    }

    /**
     * Print out the actual workload re-distribution by showing the steals that were carried out.
     */
    def stats() {
        Console.OUT.println(tbSentSize + " size of stolen taskbag  = " + tbReceivedSize + " (direct) + " +
        lifelineTbReceivedSize + " (lifeline)."); 
        Console.OUT.println(stealsPerpetrated + " successful direct steals."); 
        Console.OUT.println(lifelineStealsPerpetrated + " successful lifeline steals.");
     
    }

    /**
     * Print out more detailed lifeline stats when verbose flag turned on
     * @param verbose verbose flag true when verbose level == VERBOSE_MAX
     */
    def get(verbose:Boolean) {
        if (verbose) {
            Console.OUT.println("" + Runtime.hereLong() + " -> " +
                sub("" + (timeAlive/1E9), 0n, 6n) + " : " +
                sub("" + (timeDead/1E9), 0n, 6n) + " : " + 
                sub("" + ((timeAlive + timeDead)/1E9), 0n, 6n) + " : " + 
                sub("" + (100.0*timeAlive/(timeAlive+timeDead)), 0n, 6n) + "%" + " :: " +
                sub("" + ((startTime-timeReference)/1E9), 0n, 6n) + " : " +
                sub("" + ((lastStartStopLiveTimeStamp-timeReference)/1E9), 0n, 6n) + " :: " +
                stealsReceived + " : " +
                lifelineStealsReceived + " : " +
                stealsAttempted + " : " +
                lifelineStealsAttempted + " : " +
                (lifelineStealsAttempted - lifelineStealsPerpetrated));
        }
        return this;
    }
    
    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));
}
