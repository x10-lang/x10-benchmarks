package glb;

public struct GLBParameters(
	n:Int, // at most N task in a batch to run
	w:Int, // number of theft attempts before quiescence
	l:Int, // power of lifeline graph
	z:Int, // base of lifeline graph
	m:Int, // max number of thieves
	v:Int // verbose level
	){
    public static def computeZ(p:Long, l:Int):Int {
        var z0:Int = 1n;
        var zz:Int = l; 
        while (zz < p) {
            z0++;
            zz *= l;
        }
        return z0;
    }
    public static Default = GLBParameters(100n,4n,4n,computeZ(Place.MAX_PLACES,4n),1024n,1n);
}
