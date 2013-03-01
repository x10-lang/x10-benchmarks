package NPB3_0_X10.MGThreads;


@x10.runtime.impl.java.X10Generated abstract public class MGWorker extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<MGWorker> $RTT = x10.rtt.NamedType.<MGWorker> make(
    "NPB3_0_X10.MGThreads.MGWorker", /* base class */MGWorker.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.MGThreads.MGWorker $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + MGWorker.class + " calling"); } 
        $_obj.id = $deserializer.readInt();
        $_obj.u = $deserializer.readRef();
        $_obj.v = $deserializer.readRef();
        $_obj.r = $deserializer.readRef();
        $_obj.a = $deserializer.readRef();
        $_obj.c = $deserializer.readRef();
        $_obj.nm = $deserializer.readInt();
        $_obj.num_threads = $deserializer.readInt();
        $_obj.mg = $deserializer.readRef();
        $_obj.start = $deserializer.readInt();
        $_obj.end = $deserializer.readInt();
        $_obj.work = $deserializer.readInt();
        $_obj.wend = $deserializer.readInt();
        $_obj.wstart = $deserializer.readInt();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        $serializer.write(this.id);
        if (u instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.u);
        } else {
        $serializer.write(this.u);
        }
        if (v instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.v);
        } else {
        $serializer.write(this.v);
        }
        if (r instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.r);
        } else {
        $serializer.write(this.r);
        }
        if (a instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.a);
        } else {
        $serializer.write(this.a);
        }
        if (c instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.c);
        } else {
        $serializer.write(this.c);
        }
        $serializer.write(this.nm);
        $serializer.write(this.num_threads);
        if (mg instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.mg);
        } else {
        $serializer.write(this.mg);
        }
        $serializer.write(this.start);
        $serializer.write(this.end);
        $serializer.write(this.work);
        $serializer.write(this.wend);
        $serializer.write(this.wstart);
        
    }
    
    // constructor just for allocation
    public MGWorker(final java.lang.System[] $dummy) { 
    }
    
        
//#line 13 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int id;
        
//#line 14 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public x10.array.Array<x10.core.Double> u;
        
//#line 15 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public x10.array.Array<x10.core.Double> v;
        
//#line 16 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public x10.array.Array<x10.core.Double> r;
        
//#line 17 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public x10.array.Array<x10.core.Double> a;
        
//#line 18 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public x10.array.Array<x10.core.Double> c;
        
//#line 19 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int nm;
        
//#line 20 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int num_threads;
        
//#line 21 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public NPB3_0_X10.MG mg;
        
//#line 23 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int start;
        
//#line 24 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int end;
        
//#line 25 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int work;
        
//#line 27 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int wend;
        
//#line 28 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public int wstart;
        
        
//#line 30 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"

        // constructor for non-virtual call
        final public NPB3_0_X10.MGThreads.MGWorker NPB3_0_X10$MGThreads$MGWorker$$init$S(final NPB3_0_X10.MG mg0,
                                                                                         final int id0) { {
                                                                                                                 
//#line 30 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
;
                                                                                                                 {
                                                                                                                     {
                                                                                                                         
//#line 30 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"

                                                                                                                     }
                                                                                                                     
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.__fieldInitializers1958653();
                                                                                                                 }
                                                                                                                 
//#line 31 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.mg = ((NPB3_0_X10.MG)(mg0));
                                                                                                                 
//#line 32 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.id = id0;
                                                                                                                 
//#line 34 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958756 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 34 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958757 =
                                                                                                                   t1958756.
                                                                                                                     num_threads;
                                                                                                                 
//#line 34 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.num_threads = t1958757;
                                                                                                                 
//#line 35 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958758 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 35 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final x10.array.Array t1958759 =
                                                                                                                   ((x10.array.Array)(t1958758.
                                                                                                                                        r));
                                                                                                                 
//#line 35 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.r = ((x10.array.Array)(t1958759));
                                                                                                                 
//#line 36 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958760 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 36 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final x10.array.Array t1958761 =
                                                                                                                   ((x10.array.Array)(t1958760.
                                                                                                                                        u));
                                                                                                                 
//#line 36 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.u = ((x10.array.Array)(t1958761));
                                                                                                                 
//#line 37 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958762 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 37 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final x10.array.Array t1958763 =
                                                                                                                   ((x10.array.Array)(t1958762.
                                                                                                                                        c));
                                                                                                                 
//#line 37 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.c = ((x10.array.Array)(t1958763));
                                                                                                                 
//#line 38 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958764 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 38 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958765 =
                                                                                                                   t1958764.
                                                                                                                     nm;
                                                                                                                 
//#line 38 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.nm = t1958765;
                                                                                                                 
//#line 39 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958766 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 39 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final x10.array.Array t1958767 =
                                                                                                                   ((x10.array.Array)(t1958766.
                                                                                                                                        v));
                                                                                                                 
//#line 39 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.v = ((x10.array.Array)(t1958767));
                                                                                                                 
//#line 40 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final NPB3_0_X10.MG t1958768 =
                                                                                                                   ((NPB3_0_X10.MG)(mg));
                                                                                                                 
//#line 40 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final x10.array.Array t1958769 =
                                                                                                                   ((x10.array.Array)(t1958768.
                                                                                                                                        a));
                                                                                                                 
//#line 40 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.a = ((x10.array.Array)(t1958769));
                                                                                                             }
                                                                                                             return this;
                                                                                                             }
        
        
        
//#line 43 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
public void
                                                                                                   getWork(
                                                                                                   int wstart,
                                                                                                   int wend){
            
//#line 44 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958770 =
              wend;
            
//#line 44 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958771 =
              wstart;
            
//#line 44 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958772 =
              ((t1958770) - (((int)(t1958771))));
            
//#line 44 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958773 =
              num_threads;
            
//#line 44 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
int workpt =
              ((t1958772) / (((int)(t1958773))));
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958774 =
              wend;
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958775 =
              wstart;
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958778 =
              ((t1958774) - (((int)(t1958775))));
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958776 =
              workpt;
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958777 =
              num_threads;
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958779 =
              ((t1958776) * (((int)(t1958777))));
            
//#line 45 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
int remainder =
              ((t1958778) - (((int)(t1958779))));
            
//#line 46 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958780 =
              workpt;
            
//#line 46 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final boolean t1958812 =
              ((int) t1958780) ==
            ((int) 0);
            
//#line 46 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
if (t1958812) {
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958783 =
                  id;
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958781 =
                  wend;
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958782 =
                  wstart;
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958784 =
                  ((t1958781) - (((int)(t1958782))));
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final boolean t1958789 =
                  ((t1958783) < (((int)(t1958784))));
                
//#line 47 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
if (t1958789) {
                    
//#line 48 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.work = 1;
                    
//#line 49 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958785 =
                      wstart;
                    
//#line 49 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958786 =
                      id;
                    
//#line 49 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958787 =
                      ((t1958785) + (((int)(t1958786))));
                    
//#line 49 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958788 =
                      this.end = t1958787;
                    
//#line 49 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.start = t1958788;
                } else {
                    
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.work = 0;
                }
            } else {
                
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958790 =
                  id;
                
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958791 =
                  remainder;
                
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final boolean t1958806 =
                  ((t1958790) < (((int)(t1958791))));
                
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
if (t1958806) {
                    
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958792 =
                      workpt;
                    
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958793 =
                      ((t1958792) + (((int)(1))));
                    
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
workpt = t1958793;
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958796 =
                      wstart;
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958794 =
                      workpt;
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958795 =
                      id;
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958797 =
                      ((t1958794) * (((int)(t1958795))));
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958798 =
                      ((t1958796) + (((int)(t1958797))));
                    
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.start = t1958798;
                } else {
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958799 =
                      wstart;
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958800 =
                      remainder;
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958803 =
                      ((t1958799) + (((int)(t1958800))));
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958801 =
                      workpt;
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958802 =
                      id;
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958804 =
                      ((t1958801) * (((int)(t1958802))));
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958805 =
                      ((t1958803) + (((int)(t1958804))));
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.start = t1958805;
                }
                
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958807 =
                  start;
                
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958808 =
                  workpt;
                
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958809 =
                  ((t1958807) + (((int)(t1958808))));
                
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958810 =
                  ((t1958809) - (((int)(1))));
                
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.end = t1958810;
                
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final int t1958811 =
                  workpt;
                
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.work = t1958811;
            }
        }
        
        
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final public NPB3_0_X10.MGThreads.MGWorker
                                                                                                   NPB3_0_X10$MGThreads$MGWorker$$this$NPB3_0_X10$MGThreads$MGWorker(
                                                                                                   ){
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
return NPB3_0_X10.MGThreads.MGWorker.this;
        }
        
        
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
final public void
                                                                                                   __fieldInitializers1958653(
                                                                                                   ){
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.start = 0;
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.end = 0;
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.work = 0;
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.wend = 0;
            
//#line 12 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGWorker.x10"
this.wstart = 0;
        }
    
}

