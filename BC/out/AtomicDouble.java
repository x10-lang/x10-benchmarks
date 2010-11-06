
final public class AtomicDouble
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<AtomicDouble> _RTT = new x10.rtt.RuntimeType<AtomicDouble>(
    /* base class */AtomicDouble.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "AtomicDouble";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 7
public x10.core.atomic.AtomicLong
          value;
        
        
//#line 10
public AtomicDouble(final double init) {
            super();
            
//#line 6
this.__fieldInitializers369();
            
//#line 11
this.value = new x10.core.atomic.AtomicLong(java.lang.Double.doubleToRawLongBits(init));
        }
        
        
//#line 15
public void
                      adjust(
                      final double delta){
            
//#line 16
double oldValue =
              java.lang.Double.longBitsToDouble(((long)(value.get())));
            
//#line 17
double newValue =
              ((((double)(oldValue))) + (((double)(delta))));
            
//#line 18
while ((!(((boolean)(value.compareAndSet(((long)(java.lang.Double.doubleToRawLongBits(oldValue))),((long)(java.lang.Double.doubleToRawLongBits(newValue))))))))) {
                
//#line 20
oldValue = java.lang.Double.longBitsToDouble(((long)(value.get())));
                
//#line 21
newValue = ((((double)(oldValue))) + (((double)(delta))));
            }
        }
        
        
//#line 26
public x10.core.atomic.AtomicLong
                      get(
                      ){
            
//#line 26
return this.
                                 value;
        }
        
        
//#line 29
public java.lang.String
                      toString(
                      ){
            
//#line 29
return (("") + (((java.lang.Double)(java.lang.Double.longBitsToDouble(((long)(value.get())))))));
        }
        
        
//#line 6
final private void
                     __fieldInitializers369(
                     ){
            
//#line 6
this.value = null;
        }
        
        final public static void
          __fieldInitializers369$P(
          final AtomicDouble AtomicDouble){
            AtomicDouble.__fieldInitializers369();
        }
    
}
