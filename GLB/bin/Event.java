public class Event
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<Event> _RTT = new x10.rtt.RuntimeType<Event>(
    /* base class */Event.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "Event";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 13
final public static boolean
          logEvents =
          false;
        
        
//#line 14
public static void
                      event(
                      final java.lang.String s){
            
//#line 15
Event.event((boolean)(Event.logEvents),
                                    ((java.lang.String)(s)));
        }
        
        
//#line 18
public static void
                      event(
                      final boolean verbose,
                      final java.lang.String s){
            
//#line 19
if (verbose) {
                
//#line 20
x10.
                  io.
                  Console.OUT.println(((java.lang.Object)((((((((((("[Place(") + (((java.lang.Integer)(x10.
                                                                                                         lang.
                                                                                                         Runtime.here().
                                                                                                         id))))) + ("), at "))) + (((java.lang.Long)(x10.
                                        lang.
                                        System.nanoTime()))))) + ("] "))) + (s)))));
            }
        }
        
        
//#line 12
public Event() {
            
//#line 12
super();
            {
                
            }
        }
    
}
