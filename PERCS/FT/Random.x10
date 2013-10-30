import x10.compiler.Native;
import x10.compiler.NativeRep;

@NativeRep("java", "java.util.Random", null, null)
final class Random {
    @Native("c++", "srandom(#seed)")
    @Native("java", "")
    private static native def srandom(seed:Int):void;

    @Native("c++", "random()")
    @Native("java", "((long) #this.nextInt())")
    native def rand():Long;

    @Native("java", "new java.util.Random((int)(#seed))")
    def this(seed:Long) {
        srandom(seed as Int);
    }

    @Native("java", "(((long) #this.nextInt()) / ((double) 4294967296L))")
    def next():Double = rand() / (4294967296L as Double);
}
