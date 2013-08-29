final public class Timer {
    public val total:Rail[Long];
    public val count:Rail[Long];

    public def this(n:Long) {
        total = new Rail[Long](n);
        count = new Rail[Long](n);
    }

    public def start(id:Long) { total(id) -= System.nanoTime(); }
    public def clear(id:Long) { total(id) = 0; }
    public def stop(id:Long) { total(id) += System.nanoTime(); count(id)++; }
}
