package glb;
/**
 * A structure that captures the essence of lifeline graph structure
 */
public struct GLBParameters(
	n:Int, // at most N task in a batch to run
	w:Int, // number of theft attempts before quiescence
	l:Int, // power of lifeline graph
	z:Int, // base of lifeline graph
	m:Int, // max number of thieves
	v:Int // verbose level
	){
	/**
	 * Calculate power of lineline given the base and the total number of places
	 * @param p total number of places in the system
	 * @param l base of lifeline
	 * @return power of lifeline
	 */
    public static def computeZ(p:Long, l:Int):Int {
        var z0:Int = 1n;
        var zz:Int = l; 
        while (zz < p) {
            z0++;
            zz *= l;
        }
        return z0;
    }
    /**
     * Returns a default glb parameter
     */
    public static Default = GLBParameters(100n,4n,4n,computeZ(Place.MAX_PLACES,4n),1024n,1n);
}
