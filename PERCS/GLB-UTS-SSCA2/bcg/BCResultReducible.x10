package bcg;

public class BCResultReducible(N:Int) implements Reducible[BCResult]{
    public operator this(a:BCResult, b:BCResult){
	for(i in 0..(a.betweennessMap.size-1))
	    a.betweennessMap(i)+=b.betweennessMap(i);
      //based on the fact that we know a(i) & b(i) == 0, so we can save an allocation by resuing a (or b)
	return a;
    }
    public def zero():BCResult = new BCResult(N); 
}
