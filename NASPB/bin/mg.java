
@x10.runtime.impl.java.X10Generated public class mg extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<mg> $RTT = x10.rtt.NamedType.<mg> make(
    "mg", /* base class */mg.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(mg $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + mg.class + " calling"); } 
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        mg $_obj = new mg((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public mg(final java.lang.System[] $dummy) { 
    }
    
        
        
//#line 19 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
public boolean
                                                                        run$O(
                                                                        ){
            
//#line 20 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
final x10.array.Array t1936457 =
              ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.String> makeArrayFromJavaArray(x10.rtt.Types.STRING, new java.lang.String[] {"-np8", "CLASS=S"})));
            
//#line 20 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
NPB3_0_X10.MG.entryPoint__0$1x10$lang$String$2(((x10.array.Array)(t1936457)));
            
//#line 21 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
return true;
        }
        
        
//#line 24 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
public static class $Main extends x10.runtime.impl.java.Runtime {
        private static final long serialVersionUID = 1L;
        public static void main(java.lang.String[] args)  {
        // start native runtime
        new $Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void runtimeCallback(final x10.array.Array<java.lang.String> args)  {
        // call the original app-main method
        mg.main(args);
        }
        }
        
        // the original app-main method
        public static void main(final x10.array.Array<java.lang.String> args)  {
            
//#line 25 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
final mg t1936458 =
              ((mg)(new mg((java.lang.System[]) null).mg$$init$S()));
            
//#line 25 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
t1936458.run$O();
        }
        
        
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
final public mg
                                                                        mg$$this$mg(
                                                                        ){
            
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
return mg.this;
        }
        
        
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
// creation method for java code (1-phase java constructor)
        public mg(){this((java.lang.System[]) null);
                        mg$$init$S();}
        
        // constructor for non-virtual call
        final public mg mg$$init$S() { {
                                              
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"
;
                                              {
                                                  {
                                                      
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/mg.x10"

                                                  }
                                                  {
                                                      
                                                  }
                                              }
                                          }
                                          return this;
                                          }
        
    
}

