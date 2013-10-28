package ssca2;

/**
 * The result is essentially betweeness map
 */
public class SSCA2Result {
	val N:Int;
	val betweennessMap:Rail[Double];
	public def this(N:Int){
		this.N = N;
		this.betweennessMap = new Rail[Double](N, (i:Long)=>0d); // make sure it is initialized as 0
	}
	
	public def this(betweennessMap:Rail[Double]){
		this.betweennessMap = betweennessMap;
		this.N = betweennessMap.size as Int;
	}
}