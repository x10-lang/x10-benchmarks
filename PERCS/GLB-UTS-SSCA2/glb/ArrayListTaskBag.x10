package glb;

import x10.util.ArrayList;
/**
 * A TaskBag[T] implemented with a backing ArrayList.
 */
public class ArrayListTaskBag[T] implements TaskBag {
    
    val bag = new ArrayList[T]();
  
    public def size():Long=bag.size();
    
    public def merge(tb0:TaskBag) {
        assert tb0 instanceof ArrayListTaskBag[T];
        val tb = tb0 as ArrayListTaskBag[T];
        bag.addAll(tb.bag);
    }
    
    public def split():ArrayListTaskBag[T] {
        if (bag.size() <= 1) return null;
        val size = bag.size()/2;
        val o = new ArrayListTaskBag[T]();
        for (i in 1..size) o.bag.add(bag.removeLast());
        return o;
    }
    public def bag()=bag;
}
