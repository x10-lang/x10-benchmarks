import x10.util.ArrayList;
import x10.util.HashMap;
import x10.util.OptionsParser;
import x10.util.Option;

/**
 * A naive class that mimics the behavior of std::priority_queue. We are 
 * writing our own because its easier than all the hackery that is needed
 * to make the backend queue a priority queue.
 */
final class NaivePriorityQueue [T] {
  private val elements:ArrayList[T];
  private val comparator:(x:T,y:T)=>Int;

  // Constructor
  public def this (comparator:(x:T,y:T)=>Int, N:Int) {
    this.comparator = comparator;
    this.elements = new ArrayList[T] (N);
  }

  // See if the data structure is empty
  public def isEmpty () = this.elements.isEmpty();

  // Check for the number of elements
  public def size () = this.elements.size();

  // Add an element, putting it in its right order
  public def push (newElement:T) : Void {
    this.elements.add (newElement);
   // this.elements.sort (this.comparator);
  }

  // Remove the top element from the queue
  public def pop () : T {
    this.elements.sort (this.comparator);
    val element = this.elements.removeFirst();
    return element;
  }

  // Output the contents of the queue in the order they are stored
  public def print () {
    Console.OUT.print ("[");
    for (var i:Int=0; i<this.size(); ++i) {
      Console.OUT.print (((i==0)?"":",") + this.elements.get(i));
    }
    Console.OUT.println ("]");
  }

  public static def main (args:Array[String](1)) {
    val inputValues = new OptionsParser (args, null,
                                       [Option("s", "", "Increasing order")]);
    val isIncreasing = inputValues ("-s", 1);

    val distanceMap = new HashMap[Int, Int] ();

    val makeIncreasingComparator = (distanceMap:HashMap[Int, Int]) => {
      return (x:Int, y:Int) => {
        val dx = distanceMap.get(x).value();
        val dy = distanceMap.get(y).value();
        return (dx==dy) ? 0 : (dx<dy) ? -1 : +1;
      };
    };

    val makeNonIncreasingComparator = (distanceMap:HashMap[Int, Int]) => {
      return (x:Int, y:Int) => {
        val dx = distanceMap.get(x).value();
        val dy = distanceMap.get(y).value();
        return (dx==dy) ? 0 : (dx<dy) ? +1 : -1;
      };
    };

    val comparator = (1==isIncreasing) ? makeIncreasingComparator(distanceMap):
                                      makeNonIncreasingComparator(distanceMap);

    val myQueue = new NaivePriorityQueue[Int] (comparator, 10);
    
    distanceMap.put (1, 5);
    myQueue.push (1);

    distanceMap.put (2, 4);
    myQueue.push (2);

    distanceMap.put (3, 3);
    myQueue.push (3);

    distanceMap.put (4, 2);
    myQueue.push (4);

    distanceMap.put (5, 1);
    myQueue.push (5);

    myQueue.print ();

    myQueue.pop ();
    myQueue.pop ();

    myQueue.print ();
  }
}
