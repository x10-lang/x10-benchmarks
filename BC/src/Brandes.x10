import x10.compiler.*;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.lang.Math;
import x10.util.Random;
import x10.util.Stack;

// This seems to be automatically included
// import x10.util.Rail;
// import x10.util.ValRail;

public final class Brandes {
  public static type VertexType = Int;

  private def printHello() = Console.OUT.println ("Hello from Brandes");

  public static def main (args:Array[String](1)):void {
    try {
      val cmdLineParams = new OptionsParser 
                      (args, null,
                       [Option("s", "", "Seed for the random number"),
                        Option("n", "", "Number of vertices = 2^n"),
                        Option("a", "", "Probability a"),
                        Option("b", "", "Probability b"),
                        Option("c", "", "Probability c"),
                        Option("d", "", "Probability d")]);
      val seed:Long = cmdLineParams ("-s", 2);
      val n:Int = cmdLineParams ("-n", 2);
      val a:Double = cmdLineParams ("-a", 0.55);
      val b:Double = cmdLineParams ("-b", 0.1);
      val c:Double = cmdLineParams ("-c", 0.1);
      val d:Double = cmdLineParams ("-d", 0.25);

      Console.OUT.println ("Running SSCA2 with the following parameters:");
      Console.OUT.println ("seed = " + seed);
      Console.OUT.println ("N = " + Math.pow(2, n) as Int);
      Console.OUT.println ("a = " + a);
      Console.OUT.println ("b = " + b);
      Console.OUT.println ("c = " + c);
      Console.OUT.println ("d = " + d);


      val numPlaces = Place.MAX_PLACES;
      val brandesHandle = PlaceLocalHandle.make[Brandes]
                           (Dist.makeUnique(), ()=>new Brandes());

      val recursiveMatrixGenerator = new Rmat (seed, n, a, b, c, d);
      val adjacencyList = recursiveMatrixGenerator.generate ();

      finish {
        for (var thisPlace:Int = 0; thisPlace<numPlaces; ++thisPlace) {
          async at (Place(thisPlace)) brandesHandle().printHello();
        }
      }
    } catch (e:Throwable) {
      e.printStackTrace(Console.ERR);
    }
  }
}
