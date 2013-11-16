package uts.lib;

import x10.compiler.*;

public final class TaskBag implements glb.TaskBag {
    public val hash:Rail[uts.SHA1Rand];
    public val lower:Rail[Int];
    public val upper:Rail[Int];
    
    public def this(size:Long) {
        hash = new Rail[uts.SHA1Rand](size);
        lower = new Rail[Int](size);
        upper = new Rail[Int](size);
    }
    
    @Inline public def size() = hash.size;
}
