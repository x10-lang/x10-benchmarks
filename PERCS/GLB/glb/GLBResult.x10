package glb;

public interface GLBResult {
	
	public static RESULT_LONG_TYPE:Int = 1n;
	public static RESULT_DOUBLE_TYPE:Int = 2n;
	public abstract def getDoubleResult(): Rail[Double]; // I'd like to use Z to replace Any here, but seems to be difficult
	public abstract def getLongResult(): Rail[Long];
	public abstract def getReduceOperator():Int;
	public abstract def getType():Int;
	public abstract def display():void;
}