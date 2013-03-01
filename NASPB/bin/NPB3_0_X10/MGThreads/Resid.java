package NPB3_0_X10.MGThreads;


@x10.runtime.impl.java.X10Generated public class Resid extends NPB3_0_X10.MGThreads.MGWorker implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Resid> $RTT = x10.rtt.NamedType.<Resid> make(
    "NPB3_0_X10.MGThreads.Resid", /* base class */Resid.class
    , /* parents */ new x10.rtt.Type[] {NPB3_0_X10.MGThreads.MGWorker.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.MGThreads.Resid $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Resid.class + " calling"); } 
        NPB3_0_X10.MGThreads.MGWorker.$_deserialize_body($_obj, $deserializer);
        $_obj.u1 = $deserializer.readRef();
        $_obj.u2 = $deserializer.readRef();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        Resid $_obj = new Resid((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        super.$_serialize($serializer);
        if (u1 instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.u1);
        } else {
        $serializer.write(this.u1);
        }
        if (u2 instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.u2);
        } else {
        $serializer.write(this.u2);
        }
        
    }
    
    // constructor just for allocation
    public Resid(final java.lang.System[] $dummy) { 
    super($dummy);
    }
    
        
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
public x10.array.Array<x10.core.Double> u1;
        
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
public x10.array.Array<x10.core.Double> u2;
        
        
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
// creation method for java code (1-phase java constructor)
        public Resid(final NPB3_0_X10.MG mg,
                     final int i){this((java.lang.System[]) null);
                                      NPB3_0_X10$MGThreads$Resid$$init$S(mg,i);}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.MGThreads.Resid NPB3_0_X10$MGThreads$Resid$$init$S(final NPB3_0_X10.MG mg,
                                                                                   final int i) { {
                                                                                                         {
                                                                                                             
//#line 65 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
/*super.*/NPB3_0_X10$MGThreads$MGWorker$$init$S(((NPB3_0_X10.MG)(mg)),
                                                                                                                                                                                                                                                   ((int)(i)));
                                                                                                         }
                                                                                                         {
                                                                                                             {
                                                                                                                 
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"

                                                                                                             }
                                                                                                             {
                                                                                                                 
                                                                                                             }
                                                                                                         }
                                                                                                         
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951927 =
                                                                                                           nm;
                                                                                                         
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951928 =
                                                                                                           ((t1951927) + (((int)(1))));
                                                                                                         
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1951929 =
                                                                                                           ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(t1951928)));
                                                                                                         
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
this.u1 = ((x10.array.Array)(t1951929));
                                                                                                         
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951930 =
                                                                                                           nm;
                                                                                                         
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951931 =
                                                                                                           ((t1951930) + (((int)(1))));
                                                                                                         
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1951932 =
                                                                                                           ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(t1951931)));
                                                                                                         
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
this.u2 = ((x10.array.Array)(t1951932));
                                                                                                     }
                                                                                                     return this;
                                                                                                     }
        
        
        
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
public void
                                                                                                step(
                                                                                                final boolean done,
                                                                                                final boolean visr,
                                                                                                final int wstart,
                                                                                                final int wend,
                                                                                                final int n1,
                                                                                                final int n2,
                                                                                                final int n3,
                                                                                                final int off){
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
this.getWork((int)(wstart),
                                                                                                               (int)(wend));
            
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951934 =
              work;
            
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951935 =
              ((int) t1951934) ==
            ((int) 0);
            
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951935) {
                
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
return;
            }
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951886 =
              ((x10.array.Array)(u));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
x10.array.Array t1951936 =
               null;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (visr) {
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951936 = ((x10.array.Array)(r));
            } else {
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951936 = ((x10.array.Array)(v));
            }
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951887 =
              ((x10.array.Array)(t1951936));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951888 =
              ((x10.array.Array)(r));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951889 =
              off;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951890 =
              n1;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951891 =
              n2;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951892 =
              n3;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951893 =
              ((x10.array.Array)(u1));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951894 =
              ((x10.array.Array)(u2));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array p$1951895 =
              ((x10.array.Array)(a));
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951896 =
              start;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int p$1951897 =
              end;
            {
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$u1951898 =
                  p$1951886;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$v1951899 =
                  p$1951887;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$r1951900 =
                  p$1951888;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$off1951901 =
                  p$1951889;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$n1951902 =
                  p$1951890;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$n1951903 =
                  p$1951891;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$n1951904 =
                  p$1951892;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$u1951905 =
                  p$1951893;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$u1951906 =
                  p$1951894;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array x$a1951907 =
                  p$1951895;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$start1951908 =
                  p$1951896;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int x$end1951909 =
                  p$1951897;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951937 =
                  ((x10.array.Array<x10.core.Double>)x$u1951898).
                    rank;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951939 =
                  ((int) t1951937) ==
                ((int) 1);
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951939) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951938 =
                      ((x10.array.Array<x10.core.Double>)x$u1951898).
                        zeroBased;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951939 = ((boolean) t1951938) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951941 =
                  t1951939;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951941) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951940 =
                      ((x10.array.Array<x10.core.Double>)x$u1951898).
                        rect;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951941 = ((boolean) t1951940) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951943 =
                  t1951941;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951943) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951942 =
                      ((x10.array.Array<x10.core.Double>)x$u1951898).
                        rail;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951943 = ((boolean) t1951942) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951945 =
                  t1951943;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951945) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951944 =
                      ((x10.array.Array<x10.core.Double>)x$v1951899).
                        rank;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951945 = ((int) t1951944) ==
                    ((int) 1);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951947 =
                  t1951945;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951947) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951946 =
                      ((x10.array.Array<x10.core.Double>)x$v1951899).
                        zeroBased;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951947 = ((boolean) t1951946) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951949 =
                  t1951947;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951949) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951948 =
                      ((x10.array.Array<x10.core.Double>)x$v1951899).
                        rect;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951949 = ((boolean) t1951948) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951951 =
                  t1951949;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951951) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951950 =
                      ((x10.array.Array<x10.core.Double>)x$v1951899).
                        rail;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951951 = ((boolean) t1951950) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951953 =
                  t1951951;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951953) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951952 =
                      ((x10.array.Array<x10.core.Double>)x$r1951900).
                        rank;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951953 = ((int) t1951952) ==
                    ((int) 1);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951955 =
                  t1951953;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951955) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951954 =
                      ((x10.array.Array<x10.core.Double>)x$r1951900).
                        zeroBased;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951955 = ((boolean) t1951954) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951957 =
                  t1951955;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951957) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951956 =
                      ((x10.array.Array<x10.core.Double>)x$r1951900).
                        rect;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951957 = ((boolean) t1951956) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951959 =
                  t1951957;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951959) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951958 =
                      ((x10.array.Array<x10.core.Double>)x$r1951900).
                        rail;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951959 = ((boolean) t1951958) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951961 =
                  t1951959;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951961) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951960 =
                      ((x10.array.Array<x10.core.Double>)x$u1951905).
                        rank;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951961 = ((int) t1951960) ==
                    ((int) 1);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951964 =
                  t1951961;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951964) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951962 =
                      ((x10.array.Array<x10.core.Double>)x$u1951905).
                        zeroBased;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951964 = ((boolean) t1951962) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951966 =
                  t1951964;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951966) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951965 =
                      ((x10.array.Array<x10.core.Double>)x$u1951905).
                        rect;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951966 = ((boolean) t1951965) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951968 =
                  t1951966;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951968) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951967 =
                      ((x10.array.Array<x10.core.Double>)x$u1951905).
                        rail;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951968 = ((boolean) t1951967) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951970 =
                  t1951968;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951970) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951969 =
                      ((x10.array.Array<x10.core.Double>)x$u1951906).
                        rank;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951970 = ((int) t1951969) ==
                    ((int) 1);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951972 =
                  t1951970;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951972) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951971 =
                      ((x10.array.Array<x10.core.Double>)x$u1951906).
                        zeroBased;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951972 = ((boolean) t1951971) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951974 =
                  t1951972;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951974) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951973 =
                      ((x10.array.Array<x10.core.Double>)x$u1951906).
                        rect;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951974 = ((boolean) t1951973) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951976 =
                  t1951974;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951976) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951975 =
                      ((x10.array.Array<x10.core.Double>)x$u1951906).
                        rail;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951976 = ((boolean) t1951975) ==
                    ((boolean) true);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
boolean t1951978 =
                  t1951976;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951978) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951977 =
                      ((x10.array.Array<x10.core.Double>)x$a1951907).
                        rank;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
t1951978 = ((int) t1951977) ==
                    ((int) 1);
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951979 =
                  t1951978;
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951982 =
                  !(t1951979);
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951982) {
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1951981 =
                      true;
                    
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (t1951981) {
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.FailedDynamicCheckException t1951980 =
                          ((x10.lang.FailedDynamicCheckException)(new x10.lang.FailedDynamicCheckException(((java.lang.String)("!(x$u.rank == 1 && x$u.zeroBased == true && x$u.rect == true && x$u.rail == true && x$v.rank == 1 && x$v.zeroBased == true && x$v.rect == true && x$v.rail == true && x$r.rank == 1 && x$r.zeroBased == true && x$r.rect == true && x$r.rail == true && x$u1.rank == 1 && x$u1.zeroBased == true && x$u1.rect == true && x$u1.rail == true && x$u2.rank == 1 && x$u2.zeroBased == true && x$u2.rect == true && x$u2.rail == true && x$a.rank == 1)")))));
                        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
throw t1951980;
                    }
                }
                
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
NPB3_0_X10.MGThreads.Resid.resid__0$1x10$lang$Double$2__1$1x10$lang$Double$2__2$1x10$lang$Double$2__7$1x10$lang$Double$2__8$1x10$lang$Double$2__9$1x10$lang$Double$2(((x10.array.Array)(x$u1951898)),
                                                                                                                                                                                                                                                                           ((x10.array.Array)(x$v1951899)),
                                                                                                                                                                                                                                                                           ((x10.array.Array)(x$r1951900)),
                                                                                                                                                                                                                                                                           (int)(x$off1951901),
                                                                                                                                                                                                                                                                           (int)(x$n1951902),
                                                                                                                                                                                                                                                                           (int)(x$n1951903),
                                                                                                                                                                                                                                                                           (int)(x$n1951904),
                                                                                                                                                                                                                                                                           ((x10.array.Array)(x$u1951905)),
                                                                                                                                                                                                                                                                           ((x10.array.Array)(x$u1951906)),
                                                                                                                                                                                                                                                                           ((x10.array.Array)(x$a1951907)),
                                                                                                                                                                                                                                                                           (int)(x$start1951908),
                                                                                                                                                                                                                                                                           (int)(x$end1951909));
            }
            {
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951983 =
                  start;
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951984 =
                  end;
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1951986 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(t1951983)), ((int)(t1951984)))));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951985 =
                  ((n2) - (((int)(2))));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1951987 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(1)), ((int)(t1951985)))));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Region p1951693 =
                  ((x10.array.Region)(t1951986.$times(((x10.lang.IntRange)(t1951987)))));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i21951694min1951695 =
                  p1951693.min$O((int)(1));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i21951694max1951696 =
                  p1951693.max$O((int)(1));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951719min1951720 =
                  p1951693.min$O((int)(0));
                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951719max1951721 =
                  p1951693.max$O((int)(0));
                {
                    
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i31951719 =
                      i31951719min1951720;
                    
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                               true;
                                                                                                               ) {
                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951991 =
                          i31951719;
                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952033 =
                          ((t1951991) <= (((int)(i31951719max1951721))));
                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952033)) {
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                        }
                        {
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i3 =
                              i31951719;
                            {
                                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i21951694 =
                                  i21951694min1951695;
                                
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                                           true;
                                                                                                                           ) {
                                    
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952002 =
                                      i21951694;
                                    
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952032 =
                                      ((t1952002) <= (((int)(i21951694max1951696))));
                                    
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952032)) {
                                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                                    }
                                    {
                                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i2 =
                                          i21951694;
                                        {
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952015 =
                                              ((x10.array.Array)(r));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952005 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952006 =
                                              ((i2) + (((int)(t1952005))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952007 =
                                              ((n1) * (((int)(t1952006))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952016 =
                                              ((off) + (((int)(t1952007))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952013 =
                                              ((x10.array.Array)(r));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952008 =
                                              ((off) + (((int)(n1))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952011 =
                                              ((t1952008) - (((int)(2))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952009 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952010 =
                                              ((i2) + (((int)(t1952009))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952012 =
                                              ((n1) * (((int)(t1952010))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952014 =
                                              ((t1952011) + (((int)(t1952012))));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952017 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t1952013).$apply$G((int)(t1952014)));
                                            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)t1952015).$set__1x10$array$Array$$T$G((int)(t1952016),
                                                                                                                                                                                                           x10.core.Double.$box(t1952017));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952029 =
                                              ((x10.array.Array)(r));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952018 =
                                              ((off) + (((int)(n1))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952021 =
                                              ((t1952018) - (((int)(1))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952019 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952020 =
                                              ((i2) + (((int)(t1952019))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952022 =
                                              ((n1) * (((int)(t1952020))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952030 =
                                              ((t1952021) + (((int)(t1952022))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952027 =
                                              ((x10.array.Array)(r));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952025 =
                                              ((off) + (((int)(1))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952023 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952024 =
                                              ((i2) + (((int)(t1952023))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952026 =
                                              ((n1) * (((int)(t1952024))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952028 =
                                              ((t1952025) + (((int)(t1952026))));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952031 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t1952027).$apply$G((int)(t1952028)));
                                            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)t1952029).$set__1x10$array$Array$$T$G((int)(t1952030),
                                                                                                                                                                                                           x10.core.Double.$box(t1952031));
                                        }
                                    }
                                    {
                                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952003 =
                                          i21951694;
                                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952004 =
                                          ((t1952003) + (((int)(1))));
                                        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i21951694 = t1952004;
                                    }
                                }
                            }
                        }
                        {
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1951996 =
                              i31951719;
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952000 =
                              ((t1951996) + (((int)(1))));
                            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i31951719 = t1952000;
                        }
                    }
                }
            }
            {
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952034 =
                  start;
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952035 =
                  end;
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1952037 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(t1952034)), ((int)(t1952035)))));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952036 =
                  ((n1) - (((int)(1))));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1952038 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(0)), ((int)(t1952036)))));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Region p1951739 =
                  ((x10.array.Region)(t1952037.$times(((x10.lang.IntRange)(t1952038)))));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i11951740min1951741 =
                  p1951739.min$O((int)(1));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i11951740max1951742 =
                  p1951739.max$O((int)(1));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951759min1951760 =
                  p1951739.min$O((int)(0));
                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951759max1951761 =
                  p1951739.max$O((int)(0));
                {
                    
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i31951759 =
                      i31951759min1951760;
                    
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                               true;
                                                                                                               ) {
                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952040 =
                          i31951759;
                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952075 =
                          ((t1952040) <= (((int)(i31951759max1951761))));
                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952075)) {
                            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                        }
                        {
                            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i3 =
                              i31951759;
                            {
                                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i11951740 =
                                  i11951740min1951741;
                                
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                                           true;
                                                                                                                           ) {
                                    
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952044 =
                                      i11951740;
                                    
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952074 =
                                      ((t1952044) <= (((int)(i11951740max1951742))));
                                    
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952074)) {
                                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                                    }
                                    {
                                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1 =
                                          i11951740;
                                        {
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952057 =
                                              ((x10.array.Array)(r));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952048 =
                                              ((off) + (((int)(i1))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952047 =
                                              ((n1) * (((int)(n2))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952049 =
                                              ((t1952047) * (((int)(i3))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952058 =
                                              ((t1952048) + (((int)(t1952049))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952055 =
                                              ((x10.array.Array)(r));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952053 =
                                              ((off) + (((int)(i1))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952050 =
                                              ((n2) - (((int)(2))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952051 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952052 =
                                              ((t1952050) + (((int)(t1952051))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952054 =
                                              ((n1) * (((int)(t1952052))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952056 =
                                              ((t1952053) + (((int)(t1952054))));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952059 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t1952055).$apply$G((int)(t1952056)));
                                            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)t1952057).$set__1x10$array$Array$$T$G((int)(t1952058),
                                                                                                                                                                                                           x10.core.Double.$box(t1952059));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952071 =
                                              ((x10.array.Array)(r));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952063 =
                                              ((off) + (((int)(i1))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952060 =
                                              ((n2) - (((int)(1))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952061 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952062 =
                                              ((t1952060) + (((int)(t1952061))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952064 =
                                              ((n1) * (((int)(t1952062))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952072 =
                                              ((t1952063) + (((int)(t1952064))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Array t1952069 =
                                              ((x10.array.Array)(r));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952067 =
                                              ((off) + (((int)(i1))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952065 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952066 =
                                              ((1) + (((int)(t1952065))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952068 =
                                              ((n1) * (((int)(t1952066))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952070 =
                                              ((t1952067) + (((int)(t1952068))));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952073 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t1952069).$apply$G((int)(t1952070)));
                                            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)t1952071).$set__1x10$array$Array$$T$G((int)(t1952072),
                                                                                                                                                                                                           x10.core.Double.$box(t1952073));
                                        }
                                    }
                                    {
                                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952045 =
                                          i11951740;
                                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952046 =
                                          ((t1952045) + (((int)(1))));
                                        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i11951740 = t1952046;
                                    }
                                }
                            }
                        }
                        {
                            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952041 =
                              i31951759;
                            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952042 =
                              ((t1952041) + (((int)(1))));
                            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i31951759 = t1952042;
                        }
                    }
                }
            }
        }
        
        
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
public static void
                                                                                                resid__0$1x10$lang$Double$2__1$1x10$lang$Double$2__2$1x10$lang$Double$2__7$1x10$lang$Double$2__8$1x10$lang$Double$2__9$1x10$lang$Double$2(
                                                                                                final x10.array.Array<x10.core.Double> u,
                                                                                                final x10.array.Array<x10.core.Double> v,
                                                                                                final x10.array.Array<x10.core.Double> r,
                                                                                                final int off,
                                                                                                final int n1,
                                                                                                final int n2,
                                                                                                final int n3,
                                                                                                final x10.array.Array<x10.core.Double> u1,
                                                                                                final x10.array.Array<x10.core.Double> u2,
                                                                                                final x10.array.Array<x10.core.Double> a,
                                                                                                final int start,
                                                                                                final int end){
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1952077 =
              ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(start)), ((int)(end)))));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952076 =
              ((n2) - (((int)(2))));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.lang.IntRange t1952078 =
              ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(1)), ((int)(t1952076)))));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final x10.array.Region p1951824 =
              ((x10.array.Region)(t1952077.$times(((x10.lang.IntRange)(t1952078)))));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i21951825min1951826 =
              p1951824.min$O((int)(1));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i21951825max1951827 =
              p1951824.max$O((int)(1));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951842min1951843 =
              p1951824.min$O((int)(0));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i31951842max1951844 =
              p1951824.max$O((int)(0));
            {
                
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i31951842 =
                  i31951842min1951843;
                
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                           true;
                                                                                                           ) {
                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952080 =
                      i31951842;
                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952202 =
                      ((t1952080) <= (((int)(i31951842max1951844))));
                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952202)) {
                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                    }
                    {
                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i3 =
                          i31951842;
                        {
                            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i21951825 =
                              i21951825min1951826;
                            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                                       true;
                                                                                                                       ) {
                                
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952084 =
                                  i21951825;
                                
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952201 =
                                  ((t1952084) <= (((int)(i21951825max1951827))));
                                
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952201)) {
                                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                                }
                                {
                                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i2 =
                                      i21951825;
                                    {
                                        {
                                            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1951787min1951788 =
                                              0;
                                            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1951787max1951789 =
                                              ((n1) - (((int)(1))));
                                            {
                                                
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i1951787 =
                                                  i1951787min1951788;
                                                
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                                                           true;
                                                                                                                                           ) {
                                                    
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952088 =
                                                      i1951787;
                                                    
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952157 =
                                                      ((t1952088) <= (((int)(i1951787max1951789))));
                                                    
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952157)) {
                                                        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                                                    }
                                                    {
                                                        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1 =
                                                          i1951787;
                                                        {
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952094 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952091 =
                                                              ((i2) - (((int)(1))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952092 =
                                                              ((n3) * (((int)(i3))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952093 =
                                                              ((t1952091) + (((int)(t1952092))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952095 =
                                                              ((n1) * (((int)(t1952093))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952096 =
                                                              ((t1952094) + (((int)(t1952095))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952103 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952096)));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952100 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952097 =
                                                              ((i2) + (((int)(1))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952098 =
                                                              ((n3) * (((int)(i3))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952099 =
                                                              ((t1952097) + (((int)(t1952098))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952101 =
                                                              ((n1) * (((int)(t1952099))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952102 =
                                                              ((t1952100) + (((int)(t1952101))));
                                                            
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952104 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952102)));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952111 =
                                                              ((t1952103) + (((double)(t1952104))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952108 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952105 =
                                                              ((i3) - (((int)(1))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952106 =
                                                              ((n3) * (((int)(t1952105))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952107 =
                                                              ((i2) + (((int)(t1952106))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952109 =
                                                              ((n1) * (((int)(t1952107))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952110 =
                                                              ((t1952108) + (((int)(t1952109))));
                                                            
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952112 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952110)));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952119 =
                                                              ((t1952111) + (((double)(t1952112))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952116 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952113 =
                                                              ((i3) + (((int)(1))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952114 =
                                                              ((n3) * (((int)(t1952113))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952115 =
                                                              ((i2) + (((int)(t1952114))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952117 =
                                                              ((n1) * (((int)(t1952115))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952118 =
                                                              ((t1952116) + (((int)(t1952117))));
                                                            
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952120 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952118)));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952121 =
                                                              ((t1952119) + (((double)(t1952120))));
                                                            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)u1).$set__1x10$array$Array$$T$G((int)(i1),
                                                                                                                                                                                                                     x10.core.Double.$box(t1952121));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952126 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952123 =
                                                              ((i2) - (((int)(1))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952122 =
                                                              ((i3) - (((int)(1))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952124 =
                                                              ((n3) * (((int)(t1952122))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952125 =
                                                              ((t1952123) + (((int)(t1952124))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952127 =
                                                              ((n1) * (((int)(t1952125))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952128 =
                                                              ((t1952126) + (((int)(t1952127))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952136 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952128)));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952133 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952130 =
                                                              ((i2) + (((int)(1))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952129 =
                                                              ((i3) - (((int)(1))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952131 =
                                                              ((n3) * (((int)(t1952129))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952132 =
                                                              ((t1952130) + (((int)(t1952131))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952134 =
                                                              ((n1) * (((int)(t1952132))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952135 =
                                                              ((t1952133) + (((int)(t1952134))));
                                                            
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952137 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952135)));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952145 =
                                                              ((t1952136) + (((double)(t1952137))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952142 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952139 =
                                                              ((i2) - (((int)(1))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952138 =
                                                              ((i3) + (((int)(1))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952140 =
                                                              ((n3) * (((int)(t1952138))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952141 =
                                                              ((t1952139) + (((int)(t1952140))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952143 =
                                                              ((n1) * (((int)(t1952141))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952144 =
                                                              ((t1952142) + (((int)(t1952143))));
                                                            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952146 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952144)));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952154 =
                                                              ((t1952145) + (((double)(t1952146))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952151 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952148 =
                                                              ((i2) + (((int)(1))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952147 =
                                                              ((i3) + (((int)(1))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952149 =
                                                              ((n3) * (((int)(t1952147))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952150 =
                                                              ((t1952148) + (((int)(t1952149))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952152 =
                                                              ((n1) * (((int)(t1952150))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952153 =
                                                              ((t1952151) + (((int)(t1952152))));
                                                            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952155 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952153)));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952156 =
                                                              ((t1952154) + (((double)(t1952155))));
                                                            
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)u2).$set__1x10$array$Array$$T$G((int)(i1),
                                                                                                                                                                                                                     x10.core.Double.$box(t1952156));
                                                        }
                                                    }
                                                    {
                                                        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952089 =
                                                          i1951787;
                                                        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952090 =
                                                          ((t1952089) + (((int)(1))));
                                                        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i1951787 = t1952090;
                                                    }
                                                }
                                            }
                                        }
                                        {
                                            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1951808min1951809 =
                                              1;
                                            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1951808max1951810 =
                                              ((n1) - (((int)(2))));
                                            {
                                                
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
int i1951808 =
                                                  i1951808min1951809;
                                                
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
for (;
                                                                                                                                            true;
                                                                                                                                            ) {
                                                    
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952159 =
                                                      i1951808;
                                                    
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final boolean t1952200 =
                                                      ((t1952159) <= (((int)(i1951808max1951810))));
                                                    
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
if (!(t1952200)) {
                                                        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
break;
                                                    }
                                                    {
                                                        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int i1 =
                                                          i1951808;
                                                        {
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952164 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952162 =
                                                              ((n3) * (((int)(i3))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952163 =
                                                              ((i2) + (((int)(t1952162))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952165 =
                                                              ((n1) * (((int)(t1952163))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952198 =
                                                              ((t1952164) + (((int)(t1952165))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952168 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952166 =
                                                              ((n3) * (((int)(i3))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952167 =
                                                              ((i2) + (((int)(t1952166))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952169 =
                                                              ((n1) * (((int)(t1952167))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952170 =
                                                              ((t1952168) + (((int)(t1952169))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952178 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)v).$apply$G((int)(t1952170)));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952176 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)a).$apply$G((int)(0)));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952173 =
                                                              ((off) + (((int)(i1))));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952171 =
                                                              ((n3) * (((int)(i3))));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952172 =
                                                              ((i2) + (((int)(t1952171))));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952174 =
                                                              ((n1) * (((int)(t1952172))));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952175 =
                                                              ((t1952173) + (((int)(t1952174))));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952177 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1952175)));
                                                            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952179 =
                                                              ((t1952176) * (((double)(t1952177))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952188 =
                                                              ((t1952178) - (((double)(t1952179))));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952186 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)a).$apply$G((int)(2)));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952181 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u2).$apply$G((int)(i1)));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952180 =
                                                              ((i1) - (((int)(1))));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952182 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u1).$apply$G((int)(t1952180)));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952184 =
                                                              ((t1952181) + (((double)(t1952182))));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952183 =
                                                              ((i1) + (((int)(1))));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952185 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u1).$apply$G((int)(t1952183)));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952187 =
                                                              ((t1952184) + (((double)(t1952185))));
                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952189 =
                                                              ((t1952186) * (((double)(t1952187))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952196 =
                                                              ((t1952188) - (((double)(t1952189))));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952194 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)a).$apply$G((int)(3)));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952190 =
                                                              ((i1) - (((int)(1))));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952192 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u2).$apply$G((int)(t1952190)));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952191 =
                                                              ((i1) + (((int)(1))));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952193 =
                                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u2).$apply$G((int)(t1952191)));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952195 =
                                                              ((t1952192) + (((double)(t1952193))));
                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952197 =
                                                              ((t1952194) * (((double)(t1952195))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final double t1952199 =
                                                              ((t1952196) - (((double)(t1952197))));
                                                            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
((x10.array.Array<x10.core.Double>)r).$set__1x10$array$Array$$T$G((int)(t1952198),
                                                                                                                                                                                                                     x10.core.Double.$box(t1952199));
                                                        }
                                                    }
                                                    {
                                                        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952160 =
                                                          i1951808;
                                                        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952161 =
                                                          ((t1952160) + (((int)(1))));
                                                        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i1951808 = t1952161;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                {
                                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952085 =
                                      i21951825;
                                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952086 =
                                      ((t1952085) + (((int)(1))));
                                    
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i21951825 = t1952086;
                                }
                            }
                        }
                    }
                    {
                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952081 =
                          i31951842;
                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final int t1952082 =
                          ((t1952081) + (((int)(1))));
                        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
i31951842 = t1952082;
                    }
                }
            }
        }
        
        
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
final public NPB3_0_X10.MGThreads.Resid
                                                                                                NPB3_0_X10$MGThreads$Resid$$this$NPB3_0_X10$MGThreads$Resid(
                                                                                                ){
            
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/Resid.x10"
return NPB3_0_X10.MGThreads.Resid.this;
        }
    
}

