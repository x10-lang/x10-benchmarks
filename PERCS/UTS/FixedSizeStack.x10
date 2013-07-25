import x10.compiler.Inline;

final class FixedSizeStack[T]{T haszero} {
    val data:Rail[T];
    private var size:Long;
    def this(n:Long) {
        data = new Rail[T](n);
        size = 0;
    }
    @Inline def pop():T = data(--size);
    @Inline def push(t:T) { data(size++) = t; }
    @Inline def size() = size;
}
