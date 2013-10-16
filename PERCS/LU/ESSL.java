public class ESSL {
    static {
        System.loadLibrary("ESSL");
    }
    public static native void blockTriSolve(double[] me, double[] diag, int B);
    public static native void blockTriSolveDiag(double[] diag, int min, int max, int B);
    public static native void blockBackSolve(double[] me, double[] diag, int B);
    public static native void blockMulSub(double[] me, double[] left, double[] upper, int B);
    public static native void blockMulSubDiag(double[] diag, int min, int max, int B);
    public static native void blockMulSubPanel(double[] me, double[] diag, int min, int max, int B);
    public static native void blockMulSubRow(double[] me, double[] diag, int B, int j, boolean cond);
}
