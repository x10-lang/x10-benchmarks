import x10.compiler.*;

@NativeRep ("c++", "SHA1RandX", "SHA1RandX", null)
@NativeCPPCompilationUnit ("sha1.c")
@NativeCPPCompilationUnit ("SHA1RandX.cc")
public struct SHA1RandX {
    public def this(seed:Int) { }
    public def toString():String = "<" + hashCode()+">";
    public def this(parent:SHA1RandX) { }
    public def this(parent:SHA1RandX, spawnNumber:Int) { }
    @Native ("c++", "(#0)->__apply()")
    public operator this():Int = 0;
    @Native ("c++", "(#0)->depth()")
    public def depth():Int = 0;
}

// vim: ts=2:sw=2:et
