import x10.core.Rail;
import x10.lang.Complex;

public class FTNatives {
    static {
        System.loadLibrary("FTNatives");
    }
    public static native long create_plan(long SQRTN, int direction, int flags);
    private static native void execute_plan(long plan, double[] A, double[] B, long SQRTN, long i0, long i1);


    private static void copyDoubleToComplex(double[] src, Object dstObj, int offset, int count) {
        Object[] dst = (Object[])dstObj;
        for (int i=0; i<count; i++) {
            dst[i+offset] = new Complex(src[2*i], src[2*i+1]);
        }
    }
    
    private static double[] copyComplexToNewDouble(Rail<Complex> src, int src_off, int count) {
        Object[] boxedSrc = src.getObjectArray();
        double[] tmp = new double[count*2];
        for (int i=0; i<count; i++) {
            x10.lang.Complex c = (Complex) boxedSrc[i+src_off];
            tmp[2*i] = c.re;
            tmp[2*i + 1] = c.im;
        }
        return tmp;
    }
    
    public static void execute_plan(long plan, Rail<Complex> A, Rail<Complex> B, long SQRTN, long i0, long i1) {
        double[] a_tmp = copyComplexToNewDouble(A, 0, (int)A.size);
        double[] b_tmp = copyComplexToNewDouble(B, 0, (int)B.size);
        execute_plan(plan, a_tmp, b_tmp, SQRTN, i0, i1);
        copyDoubleToComplex(a_tmp, A.getObjectArray(), 0, (int)A.size);
        copyDoubleToComplex(b_tmp, B.getObjectArray(), 0, (int)B.size);
    }
}
