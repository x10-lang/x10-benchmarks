package NPB3_0_X10.BMInOut;

@x10.runtime.impl.java.X10Generated public class BMArgs extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<BMArgs> $RTT = x10.rtt.NamedType.<BMArgs> make(
    "NPB3_0_X10.BMInOut.BMArgs", /* base class */BMArgs.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.BMInOut.BMArgs $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + BMArgs.class + " calling"); } 
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        BMArgs $_obj = new BMArgs((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public BMArgs(final java.lang.System[] $dummy) { 
    }
    
        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
private static x10.lang.Cell<x10.core.Char> CLASS;
        
//#line 57 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
private static x10.lang.Cell<x10.core.Int> num_threads;
        
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
private static x10.lang.Cell<x10.core.Boolean> serial;
        
        
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
// creation method for java code (1-phase java constructor)
        public BMArgs(){this((java.lang.System[]) null);
                            NPB3_0_X10$BMInOut$BMArgs$$init$S();}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.BMInOut.BMArgs NPB3_0_X10$BMInOut$BMArgs$$init$S() { {
                                                                                            
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
;
                                                                                            {
                                                                                                {
                                                                                                    
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"

                                                                                                }
                                                                                                {
                                                                                                    
                                                                                                }
                                                                                            }
                                                                                            
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t377983 =
                                                                                              ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                                                                            
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Char>)t377983).$set__0x10$lang$Cell$$T(x10.core.Char.$box('U'));
                                                                                            
//#line 63 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t377984 =
                                                                                              ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$num_threads()));
                                                                                            
//#line 63 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Int>)t377984).$set__0x10$lang$Cell$$T(x10.core.Int.$box(4));
                                                                                            
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t377985 =
                                                                                              ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$serial()));
                                                                                            
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Boolean>)t377985).$set__0x10$lang$Cell$$T(x10.core.Boolean.$box(true));
                                                                                        }
                                                                                        return this;
                                                                                        }
        
        
        
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
public static void
                                                                                               ParseCmdLineArgs__0$1x10$lang$String$2(
                                                                                               final x10.array.Array<java.lang.String> argv,
                                                                                               final java.lang.String BMName){
            
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
int i =
              0;
            
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
for (;
                                                                                                      true;
                                                                                                      ) {
                
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377987 =
                  i;
                
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377988 =
                  ((x10.array.Array<java.lang.String>)argv).
                    size;
                
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378069 =
                  ((t377987) < (((int)(t377988))));
                
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378069)) {
                    
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
break;
                }
                {
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377991 =
                      i;
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t377992 =
                      ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t377991));
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t377995 =
                      (t377992).equals("SERIAL");
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t377995)) {
                        
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377993 =
                          i;
                        
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t377994 =
                          ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t377993));
                        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t377995 = (t377994).equals("serial");
                    }
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t377998 =
                      t377995;
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t377998)) {
                        
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377996 =
                          i;
                        
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t377997 =
                          ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t377996));
                        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t377998 = (t377997).equals("-serial");
                    }
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378001 =
                      t377998;
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378001)) {
                        
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377999 =
                          i;
                        
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378000 =
                          ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t377999));
                        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378001 = (t378000).equals("-SERIAL");
                    }
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378068 =
                      t378001;
                    
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378068) {
                        
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378002 =
                          ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$serial()));
                        
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Boolean>)t378002).$set__0x10$lang$Cell$$T(x10.core.Boolean.$box(true));
                    } else {
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378003 =
                          i;
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378004 =
                          ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378003));
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378007 =
                          (t378004).startsWith("class=");
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378007)) {
                            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378005 =
                              i;
                            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378006 =
                              ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378005));
                            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378007 = (t378006).startsWith("CLASS=");
                        }
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378010 =
                          t378007;
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378010)) {
                            
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378008 =
                              i;
                            
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378009 =
                              ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378008));
                            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378010 = (t378009).startsWith("-class");
                        }
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378013 =
                          t378010;
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378013)) {
                            
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378011 =
                              i;
                            
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378012 =
                              ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378011));
                            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378013 = (t378012).startsWith("-CLASS");
                        }
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378067 =
                          t378013;
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378067) {
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378014 =
                              i;
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378015 =
                              ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378014));
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378016 =
                              (t378015).length();
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378022 =
                              ((t378016) > (((int)(6))));
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378022) {
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378020 =
                                  ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378017 =
                                  i;
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378018 =
                                  ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378017));
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378019 =
                                  (t378018).charAt(((int)(6)));
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378021 =
                                  java.lang.Character.toUpperCase(t378019);
                                
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Char>)t378020).$set__0x10$lang$Cell$$T(x10.core.Char.$box(t378021));
                            }
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378023 =
                              ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378024 =
                              x10.core.Char.$unbox(((x10.lang.Cell<x10.core.Char>)t378023).$apply$G());
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378027 =
                              ((char) t378024) !=
                            ((char) 'A');
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378027) {
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378025 =
                                  ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378026 =
                                  x10.core.Char.$unbox(((x10.lang.Cell<x10.core.Char>)t378025).$apply$G());
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378027 = ((char) t378026) !=
                                ((char) 'B');
                            }
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378030 =
                              t378027;
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378030) {
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378028 =
                                  ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378029 =
                                  x10.core.Char.$unbox(((x10.lang.Cell<x10.core.Char>)t378028).$apply$G());
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378030 = ((char) t378029) !=
                                ((char) 'C');
                            }
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378033 =
                              t378030;
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378033) {
                                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378031 =
                                  ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378032 =
                                  x10.core.Char.$unbox(((x10.lang.Cell<x10.core.Char>)t378031).$apply$G());
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378033 = ((char) t378032) !=
                                ((char) 'S');
                            }
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378036 =
                              t378033;
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378036) {
                                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378034 =
                                  ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$CLASS()));
                                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final char t378035 =
                                  x10.core.Char.$unbox(((x10.lang.Cell<x10.core.Char>)t378034).$apply$G());
                                
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378036 = ((char) t378035) !=
                                ((char) 'W');
                            }
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378038 =
                              t378036;
                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378038) {
                                
//#line 83 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378037 =
                                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                
//#line 83 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378037.println(((java.lang.Object)("classes allowed are A,B,C,W and S.")));
                                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
NPB3_0_X10.BMInOut.BMArgs.commandLineError(((java.lang.String)(BMName)));
                            }
                        } else {
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378039 =
                              i;
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378040 =
                              ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378039));
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378043 =
                              (t378040).startsWith("np=");
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378043)) {
                                
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378041 =
                                  i;
                                
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378042 =
                                  ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378041));
                                
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378043 = (t378042).startsWith("NP=");
                            }
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378046 =
                              t378043;
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378046)) {
                                
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378044 =
                                  i;
                                
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378045 =
                                  ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378044));
                                
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378046 = (t378045).startsWith("-NP");
                            }
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
boolean t378049 =
                              t378046;
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (!(t378049)) {
                                
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378047 =
                                  i;
                                
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378048 =
                                  ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378047));
                                
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378049 = (t378048).startsWith("-np");
                            }
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378066 =
                              t378049;
                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378066) {
                                
//#line 91 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
try {{
                                    
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378050 =
                                      i;
                                    
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378051 =
                                      ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378050));
                                    
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378052 =
                                      (t378051).length();
                                    
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final boolean t378058 =
                                      ((t378052) > (((int)(3))));
                                    
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (t378058) {
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378056 =
                                          ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$num_threads()));
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378053 =
                                          i;
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378054 =
                                          ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378053));
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378055 =
                                          (t378054).substring(((int)(3)));
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378057 =
                                          java.lang.Integer.parseInt(t378055);
                                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Int>)t378056).$set__0x10$lang$Cell$$T(x10.core.Int.$box(t378057));
                                    }
                                    
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Cell t378059 =
                                      ((x10.lang.Cell)(NPB3_0_X10.BMInOut.BMArgs.get$serial()));
                                    
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
((x10.lang.Cell<x10.core.Boolean>)t378059).$set__0x10$lang$Cell$$T(x10.core.Boolean.$box(false));
                                }}catch (final java.lang.RuntimeException e) {
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378064 =
                                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t378060 =
                                      i;
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378061 =
                                      ((x10.array.Array<java.lang.String>)argv).$apply$G((int)(t378060));
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378062 =
                                      (t378061).substring(((int)(0)), ((int)(3)));
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378063 =
                                      (("argument to ") + (t378062));
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378065 =
                                      ((t378063) + (" must be an integer."));
                                    
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378064.println(((java.lang.Object)(t378065)));
                                    
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
NPB3_0_X10.BMInOut.BMArgs.commandLineError(((java.lang.String)(BMName)));
                                }
                            }
                        }
                    }
                }
                {
                    
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377989 =
                      i;
                    
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final int t377990 =
                      ((t377989) + (((int)(1))));
                    
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
i = t377990;
                }
            }
        }
        
        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
public static void
                                                                                                commandLineError(
                                                                                                final java.lang.String BMName){
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378071 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378070 =
              (("synopsis: java ") + (BMName));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378072 =
              ((t378070) + (" CLASS=[ABCWS] -serial [-NPnnn]"));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378071.println(((java.lang.Object)(t378072)));
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378075 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378073 =
              "[ABCWS] is the size class \n-serial specifies the serial version and\n";
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378074 =
              "[ABCWS] is the size class \n-serial specifies the serial version and\n-NP specifies number of threads where nnn ";
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378076 =
              "[ABCWS] is the size class \n-serial specifies the serial version and\n-NP specifies number of threads where nnn is an integer";
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378075.println(((java.lang.Object)(t378076)));
            
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.Place t378077 =
              ((x10.lang.Place)(x10.lang.Place.get$FIRST_PLACE()));
            {
                
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
x10.lang.Runtime.runAt(((x10.lang.Place)(t378077)),
                                                                                                                             ((x10.core.fun.VoidFun_0_0)(new NPB3_0_X10.BMInOut.BMArgs.$Closure$6())),
                                                                                                                             ((x10.lang.Runtime.Profile)(null)));
            }
            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.lang.IllegalOperationException t378078 =
              ((x10.lang.IllegalOperationException)(new x10.lang.IllegalOperationException()));
            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
throw t378078;
        }
        
        
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
public static void
                                                                                                outOfMemoryMessage(
                                                                                                ){
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378079 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378080 =
              "The java maximum heap size is to small to run this benchmark class";
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378079.println(((java.lang.Object)(t378080)));
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378081 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378082 =
              "To allocate more memory, use the -mxn option where n is the number of bytes to be allocated";
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378081.println(((java.lang.Object)(t378082)));
        }
        
        
//#line 122 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
public static void
                                                                                                Banner(
                                                                                                final java.lang.String BMName,
                                                                                                final char clss,
                                                                                                final boolean serial,
                                                                                                final int np){
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378083 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378083.println(((java.lang.Object)(" NAS Parallel Benchmarks X10 version (NPB3_0_X10)")));
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
if (serial) {
                
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378086 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378084 =
                  ((" Serial Version ") + (BMName));
                
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378085 =
                  ((t378084) + ("."));
                
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378087 =
                  ((t378085) + ((x10.core.Char.$box(clss))));
                
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378086.println(((java.lang.Object)(t378087)));
            } else {
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final x10.io.Printer t378092 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378088 =
                  ((" Multithreaded Version ") + (BMName));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378089 =
                  ((t378088) + ("."));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378090 =
                  ((t378089) + ((x10.core.Char.$box(clss))));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378091 =
                  ((t378090) + (" np="));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final java.lang.String t378093 =
                  ((t378091) + ((x10.core.Int.$box(np))));
                
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
t378092.println(((java.lang.Object)(t378093)));
            }
        }
        
        
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
final public NPB3_0_X10.BMInOut.BMArgs
                                                                                               NPB3_0_X10$BMInOut$BMArgs$$this$NPB3_0_X10$BMInOut$BMArgs(
                                                                                               ){
            
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
return NPB3_0_X10.BMInOut.BMArgs.this;
        }
        
        private static short fieldId$serial;
        final private static x10.core.concurrent.AtomicInteger initStatus$serial = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$serial;
        private static short fieldId$num_threads;
        final private static x10.core.concurrent.AtomicInteger initStatus$num_threads = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$num_threads;
        private static short fieldId$CLASS;
        final private static x10.core.concurrent.AtomicInteger initStatus$CLASS = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$CLASS;
        
        public static x10.lang.Cell
          get$CLASS(
          ){
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return NPB3_0_X10.BMInOut.BMArgs.CLASS;
            }
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.CLASS")));
                }
                throw NPB3_0_X10.BMInOut.BMArgs.exception$CLASS;
            }
            if (NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                         (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    NPB3_0_X10.BMInOut.BMArgs.CLASS = ((x10.lang.Cell)(new x10.lang.Cell<x10.core.Char>((java.lang.System[]) null, x10.rtt.Types.CHAR).x10$lang$Cell$$init$S((x10.core.Char.$box('U')), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                }}catch (java.lang.Throwable exc$378098) {
                    NPB3_0_X10.BMInOut.BMArgs.exception$CLASS = new x10.lang.ExceptionInInitializer(((java.lang.RuntimeException)(exc$378098)));
                    NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw NPB3_0_X10.BMInOut.BMArgs.exception$CLASS;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: NPB3_0_X10.BMInOut.BMArgs.CLASS")));
                }
                NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$CLASS.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.CLASS")));
                        }
                        throw NPB3_0_X10.BMInOut.BMArgs.exception$CLASS;
                    }
                }
            }
            return NPB3_0_X10.BMInOut.BMArgs.CLASS;
        }
        
        public static x10.lang.Cell
          get$num_threads(
          ){
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return NPB3_0_X10.BMInOut.BMArgs.num_threads;
            }
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.num_threads")));
                }
                throw NPB3_0_X10.BMInOut.BMArgs.exception$num_threads;
            }
            if (NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                               (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    NPB3_0_X10.BMInOut.BMArgs.num_threads = ((x10.lang.Cell)(new x10.lang.Cell<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$lang$Cell$$init$S((x10.core.Int.$box(4)), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                }}catch (java.lang.Throwable exc$378099) {
                    NPB3_0_X10.BMInOut.BMArgs.exception$num_threads = new x10.lang.ExceptionInInitializer(((java.lang.RuntimeException)(exc$378099)));
                    NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw NPB3_0_X10.BMInOut.BMArgs.exception$num_threads;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: NPB3_0_X10.BMInOut.BMArgs.num_threads")));
                }
                NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$num_threads.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.num_threads")));
                        }
                        throw NPB3_0_X10.BMInOut.BMArgs.exception$num_threads;
                    }
                }
            }
            return NPB3_0_X10.BMInOut.BMArgs.num_threads;
        }
        
        public static x10.lang.Cell
          get$serial(
          ){
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return NPB3_0_X10.BMInOut.BMArgs.serial;
            }
            if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.serial")));
                }
                throw NPB3_0_X10.BMInOut.BMArgs.exception$serial;
            }
            if (NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                          (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    NPB3_0_X10.BMInOut.BMArgs.serial = ((x10.lang.Cell)(new x10.lang.Cell<x10.core.Boolean>((java.lang.System[]) null, x10.rtt.Types.BOOLEAN).x10$lang$Cell$$init$S((x10.core.Boolean.$box(true)), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                }}catch (java.lang.Throwable exc$378100) {
                    NPB3_0_X10.BMInOut.BMArgs.exception$serial = new x10.lang.ExceptionInInitializer(((java.lang.RuntimeException)(exc$378100)));
                    NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw NPB3_0_X10.BMInOut.BMArgs.exception$serial;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: NPB3_0_X10.BMInOut.BMArgs.serial")));
                }
                NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) NPB3_0_X10.BMInOut.BMArgs.initStatus$serial.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.BMInOut.BMArgs.serial")));
                        }
                        throw NPB3_0_X10.BMInOut.BMArgs.exception$serial;
                    }
                }
            }
            return NPB3_0_X10.BMInOut.BMArgs.serial;
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$6 extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$6> $RTT = x10.rtt.StaticVoidFunType.<$Closure$6> make(
            /* base class */$Closure$6.class
            , /* parents */ new x10.rtt.Type[] {x10.core.fun.VoidFun_0_0.$RTT}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.BMInOut.BMArgs.$Closure$6 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$6.class + " calling"); } 
                return $_obj;
                
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                $Closure$6 $_obj = new $Closure$6((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$6(final java.lang.System[] $dummy) { 
            }
            
                
                public void
                  $apply(
                  ){
                    
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
try {{
                        
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
x10.runtime.impl.java.Runtime.setExitCode(((int)(1)));
                    }}catch (java.lang.Throwable __lowerer__var__0__) {
                        
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMArgs.x10"
x10.lang.Runtime.wrapAtChecked(((java.lang.Throwable)(__lowerer__var__0__)));
                    }
                }
                
                public $Closure$6() { {
                                             
                                         }}
                
            }
            
        
    }
    
    