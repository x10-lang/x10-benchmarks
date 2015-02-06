
public class Logger {
	public static val DEBUG=0;
	public static val LOG=1;
	public static val INFO=2;
	public static val LEVEL=INFO;
	
	static def out(s:String) { 
		Console.OUT.println("[" + here + ", " + x10.xrx.Runtime.workerId()+ System.nanoTime() + "] " + s);
	}
	public static def info(s:()=>String) { if (INFO >=LEVEL) out(s());}
	public static def info(s:String) { if (INFO>=LEVEL) out(s);}
	public static def log(s:()=>String) { if (LOG >=LEVEL) out(s());}
	public static def log(s:String) { if (LOG>=LEVEL) out(s);}
	public static def log[T](s:(T)=>String, t:T) {if (LOG>=LEVEL) out(s(t));}
	public static def debug(s:()=>String) {if (DEBUG>=LEVEL) out(s());}
	public static def debug[T](s:(T)=>String, t:T) {if (DEBUG>=LEVEL) out(s(t));}
	public static def debug(s:String) { if (DEBUG >=LEVEL) out(s);}
}
