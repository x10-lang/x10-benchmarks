import x10.compiler.*;

@NativeRep ("c++", "SHA1RandXX", "SHA1RandXX", null)
@NativeCPPCompilationUnit ("sha1.c")
@NativeCPPCompilationUnit ("SHA1RandXX.cc")
public struct SHA1RandXX {
    public def this(seed:Int) { }
    public def toString():String = "<" + hashCode()+">";
    public def this(parent:SHA1RandXX) { }
    public def this(parent:SHA1RandXX, spawnNumber:Int) { }
    @Native ("c++", "(#0)->__apply()")
    public operator this():Int = 0;
    @Native ("c++", "(#0)->depth()")
    public def depth():Int = 0;
    @Native ("c++", "(#0)->index()")
    public def index():Int = 0;
    @Native ("c++", "(#0)->dec()")
    public def dec():Int = 0;
}

// vim: ts=2:sw=2:et
