/**
 * A Binary heap implemenation of PriorityQueue based on Jon Bentely's 
 * description in "Programming Pearls". The speciality of this one is that
 * you need to specify up front how the capacity of the heap. No changing 
 * once initialized.
 *
 * Note that in this implementation, we are leaving Rail position 0 untouched.
 * This is because its easier to then access the left and right child of a 
 * node using the 2*i and 2*i+1 operation.
 *
 */

import x10.util.HashMap;
import x10.util.OptionsParser;
import x10.util.Option;

public final class FixedBinaryHeap[T] {
  /* the internal storage is a Rail */
  private val internalHeap:Rail[T];
  private val comparator:(x:T,y:T)=>Int;
  private var size:Int;

  // Constructor
  public def this (comparator:(x:T,y:T)=>Int, N:Int) {
    this.comparator = comparator;
    this.internalHeap = Rail.make[T] (N+1);
    this.size = 0;
  } 
    
  // See if the data structure is empty
  public def isEmpty () = this.size==0;
      
  // A simple swap operation. Could use XOR, but dont know if that is 
  // valid on all types.
  private def swapElements (indexOne:Int, indexTwo:Int) {
    assert (indexOne<this.size && indexTwo<this.size);

    val tempElement = this.internalHeap (indexOne);
    this.internalHeap(indexOne) = this.internalHeap(indexTwo);
    this.internalHeap(indexTwo) = tempElement;
  }
      
  // Add an element, putting it in its right order
  public def push (newElement:T) : Void {
    // check if this is still within our Rail bounds
    // length() returns an index beyond the last point we can write.
    // we are writing to (this.size+1), so when we increment it, it should
    // still be less than the length of the Rail.
    assert ((this.size+1) < this.internalHeap.length());

    // increment the size of the array
    ++this.size;

    // insert the element at the end of the current rail.
    this.internalHeap(this.size) = newElement;

    // sift up to put this in the right place
    for (var i:Int=this.size; 
         i>1 && (1!=comparator(this.internalHeap(i/2),this.internalHeap(i)));
         i=(i/2)) this.swapElements (i, i/2);
  } 

  // Remove the top element from the queue
  public def pop () : T {
    // check that there is an element to be popped
    assert (this.size > 0);

    // The element to be returned is the first one.
    val element:T = this.internalHeap(1);

    // There is one less element now. Swap the first and last element,
    // reduce the size and see the magic trickle down.
    this.internalHeap(1) = this.internalHeap(this.size);
    --this.size;

    // Sift down operation.
    var c:Int;
    for (var i:Int=1; (c=2*i) <= this.size; i=c) {
      // If I have a right child, then see which one of these is my lesser
      if ((c+1)<=this.size && 
          (1==comparator(this.internalHeap(c+1), this.internalHeap(c)))) {
        // Set the lesser childs index
        ++c;
      }

      // If I am less than my least child, my job is done.
      if (-1!=comparator(this.internalHeap(i), this.internalHeap(c))) break;
      
      // Swap the elements
      this.swapElements (i, c);
    }

    return element;
  } 

  /** Clear everything but retain the space */
  public def clear () = this.size=0;
      
  // Output the contents of the queue in the order they are stored
  public def print () {
    Console.OUT.print ("[");
    for (var i:Int=1; i<=this.size; ++i) {
      Console.OUT.print (((i==0)?"":",") + this.internalHeap(i));
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

    val myQueue = new FixedBinaryHeap[Int] (comparator, 10);
    
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
