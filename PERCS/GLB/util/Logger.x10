package util;

public final class Logger {
    public var nodesCount:Long = 0;
    public var nodesGiven:Long = 0;

    public var stealsAttempted:Long = 0;
    public var stealsPerpetrated:Long = 0;
    public var stealsReceived:Long = 0;
    public var stealsSuffered:Long = 0;
    public var nodesReceived:Long = 0;

    public var lifelineStealsAttempted:Long = 0;
    public var lifelineStealsPerpetrated:Long = 0;
    public var lifelineStealsReceived:Long = 0;
    public var lifelineStealsSuffered:Long = 0;
    public var lifelineNodesReceived:Long = 0;

    public var lastStartStopLiveTimeStamp:Long = -1;
    public var timeAlive:Long = 0;
    public var timeDead:Long = 0;
    public var startTime:Long = 0;
    public val timeReference:Long;
    
    public def this(b:Boolean) {
        if (b) x10.util.Team.WORLD.barrier();
        timeReference = System.nanoTime();
    }
    

    public def startLive() {
        val time = System.nanoTime();
        if (startTime == 0) startTime = time;
        if (lastStartStopLiveTimeStamp >= 0) {
            timeDead += time - lastStartStopLiveTimeStamp;
        }
        lastStartStopLiveTimeStamp = time;
    }

    public def stopLive() {
        val time = System.nanoTime();
        timeAlive += time - lastStartStopLiveTimeStamp;
        lastStartStopLiveTimeStamp = time;
    }

    public def collect(logs:Rail[Logger]) {
        for (l in logs) add(l);
    }

    public def stats() {
        Console.OUT.println(nodesGiven + " nodes stolen = " + nodesReceived + " (direct) + " +
            lifelineNodesReceived + " (lifeline)."); 
        Console.OUT.println(stealsPerpetrated + " successful direct steals."); 
        Console.OUT.println(lifelineStealsPerpetrated + " successful lifeline steals.");
    }

    public static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    public def add(other:Logger) {
        nodesCount += other.nodesCount;
        nodesGiven += other.nodesGiven;
        nodesReceived += other.nodesReceived;
        stealsPerpetrated += other.stealsPerpetrated;
        lifelineNodesReceived += other.lifelineNodesReceived;
        lifelineStealsPerpetrated += other.lifelineStealsPerpetrated;
    }

    public def get(verbose:Boolean) {
        if (verbose) {
            Console.OUT.println("" + Runtime.hereLong() + " -> " +
                sub("" + (timeAlive/1E9), 0n, 6n) + " : " +
                sub("" + (timeDead/1E9), 0n, 6n) + " : " + 
                sub("" + ((timeAlive + timeDead)/1E9), 0n, 6n) + " : " + 
                sub("" + (100.0*timeAlive/(timeAlive+timeDead)), 0n, 6n) + "%" + " :: " +
                sub("" + ((startTime-timeReference)/1E9), 0n, 6n) + " : " +
                sub("" + ((lastStartStopLiveTimeStamp-timeReference)/1E9), 0n, 6n)  + " :: " +
                nodesCount + " :: " +
                nodesGiven + " : " +
                nodesReceived + " : " +
                lifelineNodesReceived + " :: " +
                stealsReceived + " : " +
                lifelineStealsReceived + " :: " +
                stealsSuffered + " : " +
                lifelineStealsSuffered + " :: " +
                stealsAttempted + " : " +
                (stealsAttempted - stealsPerpetrated) + " :: " +
                lifelineStealsAttempted + " : " +
                (lifelineStealsAttempted - lifelineStealsPerpetrated));
        }
        return this;
    }
}
