import x10.io.Console;

import x10.util.Team;

public class MicroBenchComm {
    public static def main (args : Array[String]) {
        val team = Team.WORLD;
        finish for ([p] in 0..(Place.MAX_PLACES-1)) async at (Place(p)) {
            val payload = new Array[Byte](4*1024*1024);
            team.barrier(here.id);
            val before_x10rt = Runtime.getX10RTMessageStats();
            val before = System.currentTimeMillis();
            for ([iter] in 1..100) {
                finish for ([p2] in 0..(Place.MAX_PLACES-1)) async at (Place(p2)) {
                    val tmp = payload(42);
                }
                team.barrier(here.id);
            }
            val taken = System.currentTimeMillis() - before;
            val taken_x10rt = Runtime.getX10RTMessageStats() - before_x10rt;
            Console.OUT.println("Time taken: "+taken/1000.0/100);
            Console.OUT.println("Messages: "+taken_x10rt);
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

