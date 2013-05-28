public class Logger {
    var nodesCount:Long = 0L;
    var nodesGiven:Long = 0L;

    var stealsAttempted:Long = 0L;
    var stealsPerpetrated:Long = 0L;
    var stealsReceived:Long = 0L;
    var stealsSuffered:Long = 0L;
    var nodesReceived:Long = 0L;

    var lifelineStealsAttempted:Long = 0L;
    var lifelineStealsPerpetrated:Long = 0L;
    var lifelineStealsReceived:Long = 0L;
    var lifelineStealsSuffered:Long = 0L;
    var lifelineNodesReceived:Long = 0L;

    var lastStartStopLiveTimeStamp:Long = -1L;
    var timeAlive:Long = 0L;
    var timeDead:Long = 0L;

    def startLive() {
        val time = System.nanoTime();
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

    def stats(logs:Rail[Logger], time:Long, verbose:Boolean) {
        for (l in logs.values()) add(l);

        Console.OUT.println(nodesGiven + " nodes stolen = " + nodesReceived + " (direct) + " +
                lifelineNodesReceived + " (lifeline)."); 
        Console.OUT.println(stealsPerpetrated + " successful direct steals."); 
        Console.OUT.println(lifelineStealsPerpetrated + " successful lifeline steals.");
        Console.OUT.println("Performance: " + nodesCount + "/" + sub("" + (time/1E9), 0, 6) +
                " = " + sub("" + (nodesCount/(time/1E3)), 0, 6) + "M nodes/s");
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
}
