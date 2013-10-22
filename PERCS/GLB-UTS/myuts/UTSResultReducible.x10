package myuts;

public class UTSResultReducible implements Reducible[Long]{ // basically a SumReducer
	
	public def this(){
		
	}
	
	public operator this(a:Long, b:Long)=a+b;	
	public def zero():Long {
	
		return 0L;
	}
	
	
	
	
}