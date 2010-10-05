import x10.compiler.*;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;
import x10.util.Random;
import x10.util.Stack;

// Need to implement this
// import x10.util.PriorityQueue;

// This seems to be automatically included
// import x10.util.Rail;
// import x10.util.ValRail;

public final class Brandes {
  private final def printHello() = Console.OUT.println ("Hello from Brandes");

  public static def main (args:Rail[String]!):void {
    try {
      val numPlaces = Place.MAX_PLACES;
      val brandesHandle = PlaceLocalHandle.make[Brandes]
                           (Dist.makeUnique(), ()=>new Brandes());
      val myQueue = PriorityQueue[Int]();
      myQueue.push(0);
      Console.OUT.println (myQueue.top());
      myQueue.pop();
      if (!myQueue.empty()) {
        Console.OUT.println ("What!");
      } else {
        Console.OUT.println ("Thats right!");
      }

      finish {
        for (var thisPlace:Int = 0; thisPlace<numPlaces; ++thisPlace) {
          async (Place(thisPlace)) brandesHandle().printHello();
        }
      }
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
