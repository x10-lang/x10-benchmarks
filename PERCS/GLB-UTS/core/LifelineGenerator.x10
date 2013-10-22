package core;

/**
 * a static class that generates lifeline for a given id( usually the place id)
 */
public class LifelineGenerator {
	
	public static def generateHyperCubeLifeLine(id: Long, P:Long, l:Long, z:Long): Rail[Long]{
		val lifelines:Rail[Long] = new  Rail[Long](z, -1);
		var x:Long = 1;
		var t:Long = 0;
		
		for (var j:Long=0; j<z; j++) {
			var v:Long = id;
			for (var k:Long=1; k<l; k++) {
				v = v - v%(x*l) + (v+x*l-x)%(x*l);// e.g. 987 => 986(whenx=1), 987=>977(x-10); etc
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