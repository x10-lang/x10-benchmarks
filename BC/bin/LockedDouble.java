
final public class LockedDouble
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<LockedDouble> _RTT = new x10.rtt.RuntimeType<LockedDouble>(
    /* base class */LockedDouble.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "LockedDouble";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 10
private double
          value;
        
//#line 11
private x10.
          lang.
          Lock
          lock;
        
        
//#line 14
public LockedDouble(final double init) {
            super();
            
//#line 9
this.__fieldInitializers78458();
            
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
new x10.core.fun.Fun_0_2<LockedDouble, java.lang.Double, java.lang.Double>() {public final java.lang.Double apply(final LockedDouble x, x10.rtt.Type t1,final java.lang.Double y, x10.rtt.Type t2) { return apply(x,(double)y);}
            public final double apply(final LockedDouble x, final double y) { {
                
//#line 19
return x.value = ((((double)(x.
                                                           value))) + (((double)(y))));
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return LockedDouble._RTT;if (i ==1) return x10.rtt.Types.DOUBLE;if (i ==2) return x10.rtt.Types.DOUBLE;return null;
            }
            }.apply(this,
                    delta);
            
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
public void
                      set(
                      final double newValue){
            
//#line 27
this.value = newValue;
        }
        
        
//#line 30
public java.lang.String
                      toString(
                      ){
            
//#line 30
return (("") + (((java.lang.Double)(value))));
        }
        
        
//#line 9
final private void
                     __fieldInitializers78458(
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
    
}
