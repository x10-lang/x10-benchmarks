package fib;

import glb.TaskBag;
import glb.TaskFrame;
import glb.GlobalLoadBalancer;
import glb.ArrayListTaskBag;
import glb.GLBParameters;

/**
 * An illustration of the use of the GLB framework. 
 * The state of a Fib task is represented by a Long. 
 * Each Task Frame maintains its task bag in an array list.
 */
public class Fib(n:Long) {
    class FibFrame extends TaskFrame[Long] {
        val bag = new ArrayListTaskBag[Long]();
        val reducer = Reducible.SumReducer[Long]();
        var result:Long=0;
        public def getTaskBag()=bag;
        public def getReducer()=reducer;
        public def getResult()= result;
        public def initTask() {
            if (here.id==0) bag.bag().add(n);
        }
        public def runAtMostNTasks(n:Long) {
            val b = bag.bag();
            for (var i:Long=0; bag.size() > 0 && i < n; i++) {
                val x = b.removeLast(); // constant time
                if (x < 2) result += x;
                else {
                    b.add(x-1); // constant time
                    b.add(x-2);
                }
            }
            return b.size()>0;
        }
    }
    public def run():Long {
        val g = new GlobalLoadBalancer[Long](GLBParameters.Default, GlobalLoadBalancer.BALANCED_LEVEL_NUB, false);
        return g.run(()=>new FibFrame());
    }
    static def fib(n:Long):Long=n<2? n: fib(n-1)+fib(n-2);
    public static def main(args:Rail[String]) {
        val N = args.size < 1 ? 10 : Long.parseLong(args(0));
        val result = new Fib(N).run();
        
        Console.OUT.println("fib(" + N + ")=" + result + " (actual=" + fib(N)+")");
    }
}