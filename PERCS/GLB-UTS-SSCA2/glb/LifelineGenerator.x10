package glb;

/**
 * A static class that generates lifeline for a given id (usually the place id).
 */
public class LifelineGenerator {
	
	/**
	 * @param id place id in the network
	 * @param P total number of places in the system
	 * @param l base of lifeline, when l gets smaller, it has more lifeline buddies,
	 *        which means it can distribute work faster, but can potentially creates
	 *        more probing
	 * @param z power of lifeline
	 * e.g., P= 1000, id = 987, l=10, z=3, this algorithm can return 986,977,887 as 
	 *       the lifeline buddies. For the algorithm, please refer to paper
	 *       "Lifeline-based global load balancing" at PPoPP'11
	 * 		 @see <a href="http://dl.acm.org/citation.cfm?id=1941582">Lifeline-based global load balancing</a>
	 */
	public static def generateHyperCubeLifeLine(id: Long, P:Long, l:Long, z:Long): Rail[Long]{
		val lifelines:Rail[Long] = new  Rail[Long](z, -1);
		var x:Long = 1;
		var t:Long = 0;	
		for (var j:Long=0; j<z; j++) {
			var v:Long = id;
			for (var k:Long=1; k<l; k++) {
				v = v - v%(x*l) + (v+x*l-x)%(x*l);
				if (v<P) {
					lifelines(t++) = v;
					break;
				}
			}
			x *= l;
		}
		return lifelines;
	}

}
