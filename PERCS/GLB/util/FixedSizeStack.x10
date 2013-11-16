package util;

import x10.compiler.*;

public final class FixedSizeStack[T]{T haszero} {
    private val data:Rail[T];
    private var size:Long;

    public def this(n:Long) {
        data = new Rail[T](n);
        size = 0;
    }

    @Inline public def pop():T = data(--size);
    @Inline public def push(t:T) { data(size++) = t; }
    @Inline public def size() = size;
}
