public class FTNatives {
    static {
        System.loadLibrary("FTNatives");
    }
    public static native long create_plan(int SQRTN, int direction, int flags);
    public static native void execute_plan(long plan, double[] A, double[] B, int SQRTN, int i0, int i1);
}
