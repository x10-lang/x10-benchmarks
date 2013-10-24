// memory per place: 2*16*4^args(0) / MAX_PLACES
// default: m = 10 -> 32M / MAX_PLACES
// args(0) is intended to be incremented by one for every 4x increase in the number of places
// constraint: MAX_PLACES must divide 2^m

// p7ih with 1 place: args(0) = 13 -> 2G -> 4096 16M pages


import x10.compiler.Native;
import x10.compiler.NativeRep;
@NativeRep("java", "java.util.Random", null, null)
final class Random2 {
    @Native("c++", "srandom(#seed)")
    @Native("java", "")
    private static native def srandom(seed:Int):void;

    @Native("c++", "random()")
    @Native("java", "((long) #this.nextInt())")
    native def rand():Long;

    @Native("java", "new java.util.Random(#seed)")
    def this(seed:Int) {
        srandom(seed);
    }

    @Native("java", "(((long) #this.nextInt()) / ((double) 4294967296L))")
    def next():Double = rand() / (4294967296L as Double);
}
