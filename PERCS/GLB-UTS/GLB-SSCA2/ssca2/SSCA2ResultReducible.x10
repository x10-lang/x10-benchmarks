package ssca2;

public class SSCA2ResultReducible implements Reducible[SSCA2Result]{
	val N:Int;
	public def this(N:Int){
		this.N = N;
	}
	public operator this(a:SSCA2Result, b:SSCA2Result){
		
		for(var i:Long=0L;  i < a.betweennessMap.size; i++){
			a.betweennessMap(i)+=b.betweennessMap(i);
		} //based on the fact that we know a(i) & b(i) == 0, so we can save an allocation by resuing a (or b)
		return a;
	}
	public def zero():SSCA2Result {
		
		return new SSCA2Result(N); 
	}
}