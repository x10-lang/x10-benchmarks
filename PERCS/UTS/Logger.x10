public class Logger {
    var nodesCount:Long = 0;
    var nodesGiven:Long = 0;

    var stealsAttempted:Long = 0;
    var stealsPerpetrated:Long = 0;
    var stealsReceived:Long = 0;
    var stealsSuffered:Long = 0;
    var nodesReceived:Long = 0;

    var lifelineStealsAttempted:Long = 0;
    var lifelineStealsPerpetrated:Long = 0;
    var lifelineStealsReceived:Long = 0;
    var lifelineStealsSuffered:Long = 0;
    var lifelineNodesReceived:Long = 0;

    var lastStartStopLiveTimeStamp:Long = -1;
    var timeAlive:Long = 0;
    var timeDead:Long = 0;
    var startTime:Long = 0;
    val timeReference:Long;
    
    def this(b:Boolean) {
        if (b) x10.util.Team.WORLD.barrier();
        timeReference = System.nanoTime();
    }
    

    def startLive() {
        val time = System.nanoTime();
        if (startTime == 0) startTime = time;
        if (lastStartStopLiveTimeStamp >= 0) {
            timeDead += time - lastStartStopLiveTimeStamp;
        }
        lastStartStopLiveTimeStamp = time;
    }

    def stopLive() {
        val time = System.nanoTime();
        timeAlive += time - lastStartStopLiveTimeStamp;
        lastStartStopLiveTimeStamp = time;
    }

    def collect(logs:Rail[Logger]) {
        for (l in logs) add(l);
    }

    def stats(time:Long) {
        Console.OUT.println(nodesGiven + " nodes stolen = " + nodesReceived + " (direct) + " +
            lifelineNodesReceived + " (lifeline)."); 
        Console.OUT.println(stealsPerpetrated + " successful direct steals."); 
        Console.OUT.println(lifelineStealsPerpetrated + " successful lifeline steals.");
        Console.OUT.println("Performance: " + nodesCount + "/" + sub("" + (time/1E9), 0n, 6n) +
            " = " + sub("" + (nodesCount/(time/1E3)), 0n, 6n) + "M nodes/s");
    }

    private static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    def add(other:Logger) {
        nodesCount += other.nodesCount;
        nodesGiven += other.nodesGiven;
        nodesReceived += other.nodesReceived;
        stealsPerpetrated += other.stealsPerpetrated;
        lifelineNodesReceived += other.lifelineNodesReceived;
        lifelineStealsPerpetrated += other.lifelineStealsPerpetrated;
    }

    def get(verbose:Boolean) {
        if (verbose) {
            Console.OUT.println("" + here.id + " -> " +
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
