import x10.util.IndexedMemoryChunk;

/**
 * An implementation of a queue.
 */
public final class FixedRailQueue[T] {
  private val internalStorage:IndexedMemoryChunk[T];
  private var N:Int;
  private var head:Int;
  private var tail:Int;

  /** Construct a fixed size queue */
  public def this(N:Int) { 
    this.N = N;
    this.internalStorage = IndexedMemoryChunk.allocateZeroed[T] (N);
    this.head=0;
    this.tail=0;
  }

  /** Check if the queue is empty */
  @x10.compiler.Inline public def isEmpty() = this.head==this.tail;
    
  /** Add the element to the front of the queue. */
  @x10.compiler.Inline public def push(v:T) {
    // Add the element and increase the size
    this.internalStorage(this.tail++) = v;
  }
  
  /** Remove and return one element of the queue if FIFO order. */
  @x10.compiler.Inline public def pop():T {
    // Remove the first element from the queue.
    return this.internalStorage(this.head++);
  }
  
  /** Remove and return one element of the queue in LIFO order. */
  @x10.compiler.Inline public def top():T {
    return this.internalStorage(--this.tail);
  }

  /** Rewind. */
  @x10.compiler.Inline public def rewind() {
    this.head=0;
  }

  /** Output the contents of the queue in the order they are stored */
  public def print () {
    Console.OUT.print ("[");
    for (var i:Int=this.head; i<this.tail; ++i) {
      Console.OUT.print (((i==this.head)?"":",") + this.internalStorage(i));
    }
    Console.OUT.println ("]");
  }

  public static def main (args:Array[String](1)) {
    val myQueue = new FixedRailQueue[Int] (4);
    
    myQueue.push (1);
    myQueue.push (2);
    myQueue.push (3);
    myQueue.push (4);
    myQueue.print ();

    myQueue.pop ();
    myQueue.pop ();
    myQueue.print ();

    myQueue.pop ();
    myQueue.pop ();
    myQueue.print ();

    myQueue.push (5);
    myQueue.print ();

    myQueue.push (2);
    myQueue.push (3);
    myQueue.push (4);
    myQueue.print ();
  }
}
