public class Vector<T>
extends x10.core.Struct
  implements x10.core.fun.Fun_0_1
{
    public static final x10.rtt.RuntimeType<Vector> _RTT = new x10.rtt.RuntimeType<Vector>(
    /* base class */Vector.class, 
    /* variances */ new x10.rtt.RuntimeType.Variance[] {x10.rtt.RuntimeType.Variance.INVARIANT}
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, new x10.rtt.ParameterizedType(x10.core.fun.Fun_0_1._RTT, x10.rtt.Types.INT, new x10.rtt.UnresolvedType(0)), x10.rtt.Types.ANY}
    ) {public String typeName() {return "Vector";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    public x10.rtt.Type<?> getParam(int i) {if (i ==0)return T;return null;}
    // dispatcher for method abstract public (a1:Z1)=> U.apply(a1:Z1): U
    public java.lang.Object
      apply(final java.lang.Object a1,final x10.rtt.Type t1){return apply$G((int)(java.lang.Integer)a1);}
    
        private x10.rtt.Type T;
        
        
//#line 1
public int
          size;
        
        
        
//#line 3
public x10.core.Rail<T>
          rail;
        
        
//#line 4
public Vector(final x10.rtt.Type T,
                                 final x10.core.Rail<T> r,java.lang.Class $dummy0) {this.T = T;
                                                                                         {
                                                                                            {
                                                                                                
//#line 5
this.size = r.
                                                                                                                         length;
                                                                                                
                                                                                                {
                                                                                                    
                                                                                                }
                                                                                            }
                                                                                            
//#line 6
this.rail = r;
                                                                                        }}
        
        
//#line 8
final public T
                     apply$G(
                     final int i){
            
//#line 8
return (rail).apply$G(((int)(i)));
        }
        
        
//#line 9
final public static <T>Vector<T>
                     make_1_$_x10$lang$Int_$_$_Vector_T_$(
                     final x10.rtt.Type T,
                     final int n,
                     final x10.core.fun.Fun_0_1<java.lang.Integer,T> init){
            
//#line 10
return new Vector<T>(T,
                                             x10.core.RailFactory.<T>makeVarRail(T, ((int)(n)), init),(java.lang.Class) null);
        }
        
        
//#line 12
final public static <T>Vector<T>
                      make_1_$$Vector_T(
                      final x10.rtt.Type T,
                      final int n,
                      final T init){
            
//#line 13
return new Vector<T>(T,
                                             x10.core.RailFactory.<T>makeVarRail(T, ((int)(n)), init),(java.lang.Class) null);
        }
        
        
//#line 15
final public static Vector<java.lang.Integer>
                      $times_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 17
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) * (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       size)),(java.lang.Class) null);
        }
        
        
//#line 18
final public static Vector<java.lang.Integer>
                      $times_0_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final int right){
            
//#line 20
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) * (((int)(right))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                      size)),(java.lang.Class) null);
        }
        
        
//#line 21
final public static Vector<java.lang.Integer>
                      $plus_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 23
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) + (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       size)),(java.lang.Class) null);
        }
        
        
//#line 24
final public static Vector<java.lang.Integer>
                      $minus_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 26
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) - (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       size)),(java.lang.Class) null);
        }
        
        
//#line 27
final public static Vector<java.lang.Integer>
                      $gt_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 29
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) > (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 30
final public static Vector<java.lang.Integer>
                      $gt_0_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final int right){
            
//#line 32
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) > (((int)(right))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 33
final public static Vector<java.lang.Integer>
                      $ge_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 35
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) >= (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 36
final public static Vector<java.lang.Integer>
                      $lt_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 38
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) < (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 39
final public static Vector<java.lang.Integer>
                      $le_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                      final Vector<java.lang.Integer> left,
                      final Vector<java.lang.Integer> right){
            
//#line 41
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((Vector<java.lang.Integer>)(left)).apply$G((int)(i))))) <= (((int)(((Vector<java.lang.Integer>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 43
final public static Vector<java.lang.Double>
                      $times_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 45
return new Vector<java.lang.Double>(x10.rtt.Types.DOUBLE,
                                                            (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) * (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 size)),(java.lang.Class) null);
        }
        
        
//#line 46
final public static Vector<java.lang.Double>
                      $times_0_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final double right){
            
//#line 48
return new Vector<java.lang.Double>(x10.rtt.Types.DOUBLE,
                                                            (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) * (((double)(right))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                 size)),(java.lang.Class) null);
        }
        
        
//#line 49
final public static Vector<java.lang.Double>
                      $plus_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 51
return new Vector<java.lang.Double>(x10.rtt.Types.DOUBLE,
                                                            (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) + (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 size)),(java.lang.Class) null);
        }
        
        
//#line 52
final public static Vector<java.lang.Double>
                      $minus_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 54
return new Vector<java.lang.Double>(x10.rtt.Types.DOUBLE,
                                                            (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) - (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(left.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 size)),(java.lang.Class) null);
        }
        
        
//#line 55
final public static Vector<java.lang.Integer>
                      $gt_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 57
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) > (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 58
final public static Vector<java.lang.Integer>
                      $gt_0_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final double right){
            
//#line 60
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) > (((double)(right))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 61
final public static Vector<java.lang.Integer>
                      $ge_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 63
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) >= (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 64
final public static Vector<java.lang.Integer>
                      $lt_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 66
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) < (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 67
final public static Vector<java.lang.Integer>
                      $le_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final Vector<java.lang.Double> left,
                      final Vector<java.lang.Double> right){
            
//#line 69
return new Vector<java.lang.Integer>(x10.rtt.Types.INT,
                                                             (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((Vector<java.lang.Double>)(left)).apply$G((int)(i))))) <= (((double)(((Vector<java.lang.Double>)(right)).apply$G((int)(i))))))
                                                               ? 1
                                                               : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(left.
                                                                                                                                                               size)),(java.lang.Class) null);
        }
        
        
//#line 1
final public int
                     size(
                     ){
            
//#line 1
return this.
                                size;
        }
        
        
//#line 1
final native public java.lang.String
                     typeName(
                     );
        
        
//#line 1
final public java.lang.String
                     toString(
                     ){
            
//#line 1
return (((((((("struct Vector:") + (" size="))) + (((java.lang.Integer)(this.
                                                                                                 size))))) + (" rail="))) + (this.
                                                                                                                               rail));
        }
        
        
//#line 1
final public int
                     hashCode(
                     ){
            
//#line 1
int result =
              0;
            
//#line 1
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                size)).hashCode()))));
            
//#line 1
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(this.
                                                                                            rail.hashCode()))));
            
//#line 1
return result;
        }
        
        
//#line 1
final public boolean
                     equals(
                     java.lang.Object other){
            
//#line 1
if ((!(((boolean)(Vector._RTT.instanceof$(other, T)))))) {
                
//#line 1
return false;
            }
            
//#line 1
return this.equals_0_$_Vector_T_$(((Vector)((new java.lang.Object() {final Vector<T> cast(final Vector<T> self) {if (self==null) return null;x10.rtt.Type rtt = new x10.rtt.ParameterizedType(Vector._RTT, T);if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((Vector<T>) other)))));
        }
        
        
//#line 1
final public boolean
                     equals_0_$_Vector_T_$(
                     Vector other){
            
//#line 1
return ((int) this.
                                       size) ==
            ((int) other.
                     size) &&
            x10.rtt.Equality.equalsequals(this.
                                            rail,((x10.core.Rail)(other.
                                                                    rail)));
        }
        
        
//#line 1
final public boolean
                     _struct_equals(
                     java.lang.Object other){
            
//#line 1
if ((!(((boolean)(Vector._RTT.instanceof$(other, T)))))) {
                
//#line 1
return false;
            }
            
//#line 1
return this._struct_equals_0_$_Vector_T_$(((Vector)((new java.lang.Object() {final Vector<T> cast(final Vector<T> self) {if (self==null) return null;x10.rtt.Type rtt = new x10.rtt.ParameterizedType(Vector._RTT, T);if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((Vector<T>) other)))));
        }
        
        
//#line 1
final public boolean
                     _struct_equals_0_$_Vector_T_$(
                     Vector other){
            
//#line 1
return ((int) this.
                                       size) ==
            ((int) other.
                     size) &&
            x10.rtt.Equality.equalsequals(this.
                                            rail,((x10.core.Rail)(other.
                                                                    rail)));
        }
    
}
