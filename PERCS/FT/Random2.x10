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
