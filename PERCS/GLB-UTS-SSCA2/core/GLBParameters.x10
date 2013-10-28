package core;

public struct GLBParameters {
	val n:Int; // at most N task in a batch to run
	val w:Int; // random thieve number
	val l:Int; // power of lifeline graph
	val z:Int; // base of lifeline graph
	val m:Int; // max number of thieves
	val v:Int; // verbose level
	public def this(n:Int, w:Int, l:Int, z:Int, m:Int, v:Int){
		this.n = n;
		this.w = w;
		this.l = l;
		this.z = z;
		this.m = m;
		this.v = v;
	} 
}