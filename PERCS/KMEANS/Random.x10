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

    @Native("java", "new java.util.Random(#seed)")
    def this(seed:Int) {
        srandom(seed);
    }

    @Native("java", "(((float) ((long) #this.nextInt())) / 2147483648f)")
    def next():Float = (rand() as Float)/2147483648f;
}
