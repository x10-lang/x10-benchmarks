
final public class LockedDouble
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<LockedDouble> _RTT = new x10.rtt.RuntimeType<LockedDouble>(
    /* base class */LockedDouble.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "LockedDouble";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 10
public double
          value;
        
//#line 11
public x10.
          lang.
          Lock
          lock;
        
        
//#line 14
public LockedDouble(final double init) {
            super();
            
//#line 9
this.__fieldInitializers442();
            
//#line 14
this.value = init;
        }
        
        
//#line 17
public void
                      adjust(
                      final double delta){
            
//#line 18
lock.lock();
            
//#line 19
LockedDouble.__$closure$apply$__444(((LockedDouble)(this)),
                                                            (double)(delta));
            
//#line 20
lock.unlock();
        }
        
        
//#line 24
public double
                      get(
                      ){
            
//#line 24
return this.
                                 value;
        }
        
        
//#line 27
public java.lang.String
                      toString(
                      ){
            
//#line 27
return (("") + (((java.lang.Double)(value))));
        }
        
        
//#line 9
final private void
                     __fieldInitializers442(
                     ){
            
//#line 9
this.value = 0.0;
            
//#line 9
this.lock = ((x10.
              lang.
              Lock)(new x10.
              lang.
              Lock()));
        }
        
        final public static void
          __fieldInitializers442$P(
          final LockedDouble LockedDouble){
            LockedDouble.__fieldInitializers442();
        }
        
        final private static double
          __$closure$apply$__444(
          final LockedDouble x,
          final double y){
            
//#line 19
return x.value = ((((double)(x.
                                                       value))) + (((double)(y))));
        }
        
        final public static double
          __$closure$apply$__444$P(
          final LockedDouble x,
          final double y){
            return LockedDouble.__$closure$apply$__444(((LockedDouble)(x)),
                                                       (double)(y));
        }
    
}
