import x10.compiler.*;

@NativeRep("c++", "SHA1RandXX", "SHA1RandXX", null)
@NativeCPPCompilationUnit("sha1.c")
@NativeCPPCompilationUnit("SHA1RandXX.cc")
public struct SHA1RandXX {
    public def this(seed:Int) { }
    public def this(parent:SHA1RandXX) { }
    public def this(parent:SHA1RandXX, spawnNumber:Int) { }
    @Native ("c++", "(#0)->__apply()")
    public operator this():Int = 0;
    @Native ("c++", "(#0)->depth()")
    public def depth():Int = 0;
    @Native ("c++", "(#0)->breadth()")
    public def breadth():Int = 0;
    public def toString():String = "<" + hashCode()+">";
}

// vim: ts=2:sw=2:et
