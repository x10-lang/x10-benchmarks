public class FixedRailStack<T>
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<FixedRailStack> _RTT = new x10.rtt.RuntimeType<FixedRailStack>(
    /* base class */FixedRailStack.class, 
    /* variances */ new x10.rtt.RuntimeType.Variance[] {x10.rtt.RuntimeType.Variance.INVARIANT}
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "FixedRailStack";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    public x10.rtt.Type<?> getParam(int i) {if (i ==0)return T;return null;}
    
        private x10.rtt.Type T;
        
        
//#line 7
public x10.core.Rail<T>
          internalStorage;
        
//#line 8
public int
          size;
        
        
//#line 11
public FixedRailStack(final x10.rtt.Type T,
                                          final int N) {
                                                                super();
                                                            this.T = T;
                                                             {
                                                                
//#line 6
this.__fieldInitializers438();
                                                                
//#line 12
this.internalStorage = x10.core.RailFactory.<T>makeVarRail(T, ((int)(N)));
                                                                
//#line 13
this.size = 0;
                                                            }}
        
        
//#line 17
public int
                      size(
                      ){
            
//#line 17
return this.
                                 size;
        }
        
        
//#line 20
public boolean
                      isEmpty(
                      ){
            
//#line 20
return ((int) this.
                                        size) ==
            ((int) 0);
        }
        
        
//#line 23
public void
                      push_0_$$FixedRailStack_T(
                      final T v){
            
//#line 25
assert (((((int)((((((int)(this.
                                                     size))) + (((int)(1)))))))) < (((int)(((x10.core.Rail<T>)(this.
                                                                                                                 internalStorage)).length())))));
            
//#line 28
(this.
                           internalStorage).set$G(v, ((int)(this.
                                                              size)));
            
//#line 29
FixedRailStack.<T>__$closure$apply$__440_0_$_FixedRailStack_T_$(T,
                                                                                        ((FixedRailStack)(this)),
                                                                                        (int)(1));
        }
        
        
//#line 33
public T
                      pop$G(
                      ){
            
//#line 35
assert (((((int)((this.
                                            size)))) > (((int)(0)))));
            
//#line 38
return (this.
                                  internalStorage).apply$G(FixedRailStack.<T>__$closure$apply$__441_0_$_FixedRailStack_T_$(T,
                                                                                                                           ((FixedRailStack)(this)),
                                                                                                                           (int)(1)));
        }
        
        
//#line 42
public T
                      peek$G(
                      ){
            
//#line 44
assert (((((int)((this.
                                            size)))) > (((int)(0)))));
            
//#line 47
return (this.
                                  internalStorage).apply$G(((int)((((((int)(this.
                                                                              size))) - (((int)(1))))))));
        }
        
        
//#line 51
public int
                      clear(
                      ){
            
//#line 51
return this.size = 0;
        }
        
        
//#line 54
public void
                      print(
                      ){
            
//#line 55
x10.
              io.
              Console.OUT.print(((java.lang.String)("[")));
            
//#line 56
for (
//#line 56
int i =
                               0;
                             ((((int)(i))) < (((int)(this.
                                                       size))));
                             
//#line 56
i = ((((int)(i))) + (((int)(1))))) {
                
//#line 57
x10.
                  io.
                  Console.OUT.print(((java.lang.String)((((((((int) i) ==
                                                             ((int) 0)))
                                                             ? ""
                                                             : ",")) + ((this.
                                                                           internalStorage).apply$G(((int)(i))))))));
            }
            
//#line 59
x10.
              io.
              Console.OUT.println(((java.lang.Object)("]")));
        }
        
        
//#line 62
public static class Main extends x10.runtime.impl.java.Runtime {
        public static void main(java.lang.String[] args) {
        // start native runtime
        new Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void main(final x10.array.Array<java.lang.String> args) {
        try {
        // start xrx
        x10.lang.Runtime.start(
        // static init activity
        new x10.core.fun.VoidFun_0_0() {
        public void apply() {
        // preload classes
        if (Boolean.getBoolean("x10.PRELOAD_CLASSES")) {
        x10.runtime.impl.java.PreLoader.preLoad(this.getClass().getEnclosingClass(), Boolean.getBoolean("x10.PRELOAD_STRINGS"));
        }
        }
        public x10.rtt.RuntimeType<?> getRTT() {
        return _RTT;
        }
        public x10.rtt.Type<?> getParam(int i) {
        return null;
        }
        },
        // body of main activity
        new x10.core.fun.VoidFun_0_0() {
        public void apply() {
        // catch and rethrow checked exceptions
        // (closures cannot throw checked exceptions)
        try {
        // call the original app-main method
        FixedRailStack.main(args);
        } catch (java.lang.RuntimeException e) {
        throw e;
        } catch (java.lang.Error e) {
        throw e;
        } catch (java.lang.Throwable t) {
        throw new x10.runtime.impl.java.X10WrappedThrowable(t);
        }
        }
        public x10.rtt.RuntimeType<?> getRTT() {
        return _RTT;
        }
        public x10.rtt.Type<?> getParam(int i) {
        return null;
        }
        });
        } catch (java.lang.Throwable t) {
        t.printStackTrace();
        }
        }
        }
        
        // the original app-main method
        public static void main(final x10.
          array.
          Array<java.lang.String> args)  {
            
//#line 63
final FixedRailStack<java.lang.Integer> myStack =
              ((FixedRailStack)(new FixedRailStack<java.lang.Integer>(x10.rtt.Types.INT,
                                                                      5)));
            
//#line 65
((FixedRailStack<java.lang.Integer>)(myStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(1));
            
//#line 66
((FixedRailStack<java.lang.Integer>)(myStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(2));
            
//#line 67
((FixedRailStack<java.lang.Integer>)(myStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(3));
            
//#line 68
((FixedRailStack<java.lang.Integer>)(myStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(4));
            
//#line 69
((FixedRailStack<java.lang.Integer>)(myStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(5));
            
//#line 71
((FixedRailStack<java.lang.Integer>)(myStack)).print();
            
//#line 73
((FixedRailStack<java.lang.Integer>)(myStack)).pop$G();
            
//#line 74
((FixedRailStack<java.lang.Integer>)(myStack)).pop$G();
            
//#line 76
((FixedRailStack<java.lang.Integer>)(myStack)).print();
        }
        
        
//#line 6
final private void
                     __fieldInitializers438(
                     ){
            
//#line 6
this.size = 0;
        }
        
        final public static <T>void
          __fieldInitializers438$P_0_$_FixedRailStack_T_$(
          final x10.rtt.Type T,
          final FixedRailStack<T> FixedRailStack){
            ((FixedRailStack<T>)(FixedRailStack)).__fieldInitializers438();
        }
        
        final private static <T>int
          __$closure$apply$__440_0_$_FixedRailStack_T_$(
          final x10.rtt.Type T,
          final FixedRailStack<T> x,
          final int y){
            
//#line 29
return x.size = ((((int)(x.
                                                   size))) + (((int)(y))));
        }
        
        final public static <T>int
          __$closure$apply$__440$P_0_$_FixedRailStack_T_$(
          final x10.rtt.Type T,
          final FixedRailStack<T> x,
          final int y){
            return FixedRailStack.<T>__$closure$apply$__440_0_$_FixedRailStack_T_$(T,
                                                                                   ((FixedRailStack)(x)),
                                                                                   (int)(y));
        }
        
        final private static <T>int
          __$closure$apply$__441_0_$_FixedRailStack_T_$(
          final x10.rtt.Type T,
          final FixedRailStack<T> x,
          final int y){
            
//#line 38
return x.size = ((((int)(x.
                                                   size))) - (((int)(y))));
        }
        
        final public static <T>int
          __$closure$apply$__441$P_0_$_FixedRailStack_T_$(
          final x10.rtt.Type T,
          final FixedRailStack<T> x,
          final int y){
            return FixedRailStack.<T>__$closure$apply$__441_0_$_FixedRailStack_T_$(T,
                                                                                   ((FixedRailStack)(x)),
                                                                                   (int)(y));
        }
    
}
