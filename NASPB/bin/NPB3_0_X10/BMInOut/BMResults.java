package NPB3_0_X10.BMInOut;


@x10.runtime.impl.java.X10Generated public class BMResults extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<BMResults> $RTT = x10.rtt.NamedType.<BMResults> make(
    "NPB3_0_X10.BMInOut.BMResults", /* base class */BMResults.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.BMInOut.BMResults $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + BMResults.class + " calling"); } 
        $_obj.name = $deserializer.readRef();
        $_obj.MachineName = $deserializer.readRef();
        $_obj.PrLang = $deserializer.readRef();
        $_obj.clss = $deserializer.readChar();
        $_obj.n1 = $deserializer.readInt();
        $_obj.n2 = $deserializer.readInt();
        $_obj.n3 = $deserializer.readInt();
        $_obj.niter = $deserializer.readInt();
        $_obj.time = $deserializer.readDouble();
        $_obj.acctime = $deserializer.readDouble();
        $_obj.wctime = $deserializer.readDouble();
        $_obj.mops = $deserializer.readDouble();
        $_obj.tmSent = $deserializer.readDouble();
        $_obj.tmReceived = $deserializer.readDouble();
        $_obj.RecArrSize = $deserializer.readInt();
        $_obj.optype = $deserializer.readRef();
        $_obj.numthreads = $deserializer.readInt();
        $_obj.serial = $deserializer.readBoolean();
        $_obj.pid = $deserializer.readInt();
        $_obj.verified = $deserializer.readInt();
        $_obj.out = $deserializer.readRef();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        BMResults $_obj = new BMResults((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        $serializer.write(this.name);
        $serializer.write(this.MachineName);
        $serializer.write(this.PrLang);
        $serializer.write(this.clss);
        $serializer.write(this.n1);
        $serializer.write(this.n2);
        $serializer.write(this.n3);
        $serializer.write(this.niter);
        $serializer.write(this.time);
        $serializer.write(this.acctime);
        $serializer.write(this.wctime);
        $serializer.write(this.mops);
        $serializer.write(this.tmSent);
        $serializer.write(this.tmReceived);
        $serializer.write(this.RecArrSize);
        $serializer.write(this.optype);
        $serializer.write(this.numthreads);
        $serializer.write(this.serial);
        $serializer.write(this.pid);
        $serializer.write(this.verified);
        if (out instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.out);
        } else {
        $serializer.write(this.out);
        }
        
    }
    
    // constructor just for allocation
    public BMResults(final java.lang.System[] $dummy) { 
    }
    
        
//#line 57 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public java.lang.String name;
        
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public java.lang.String MachineName;
        
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public java.lang.String PrLang;
        
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public char clss;
        
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int n1;
        
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int n2;
        
//#line 63 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int n3;
        
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int niter;
        
//#line 65 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double time;
        
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double acctime;
        
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double wctime;
        
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double mops;
        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double tmSent;
        
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public double tmReceived;
        
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int RecArrSize;
        
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public java.lang.String optype;
        
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int numthreads;
        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public boolean serial;
        
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int pid;
        
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int verified;
        
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public x10.io.Printer out;
        
        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
// creation method for java code (1-phase java constructor)
        public BMResults(){this((java.lang.System[]) null);
                               NPB3_0_X10$BMInOut$BMResults$$init$S();}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.BMInOut.BMResults NPB3_0_X10$BMInOut$BMResults$$init$S() { {
                                                                                                  
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
;
                                                                                                  {
                                                                                                      {
                                                                                                          
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"

                                                                                                      }
                                                                                                      
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.__fieldInitializers394515();
                                                                                                  }
                                                                                              }
                                                                                              return this;
                                                                                              }
        
        
        
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
// creation method for java code (1-phase java constructor)
        public BMResults(final int bid){this((java.lang.System[]) null);
                                            NPB3_0_X10$BMInOut$BMResults$$init$S(bid);}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.BMInOut.BMResults NPB3_0_X10$BMInOut$BMResults$$init$S(final int bid) { {
                                                                                                               
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
;
                                                                                                               {
                                                                                                                   {
                                                                                                                       
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"

                                                                                                                   }
                                                                                                                   
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.__fieldInitializers394515();
                                                                                                               }
                                                                                                               
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.pid = bid;
                                                                                                               
//#line 83 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.clss = 'S';
                                                                                                               
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.optype = ((java.lang.String)("floating point"));
                                                                                                           }
                                                                                                           return this;
                                                                                                           }
        
        
        
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
// creation method for java code (1-phase java constructor)
        public BMResults(final java.lang.String bname,
                         final char CLASS,
                         final int bn1,
                         final int bn2,
                         final int bn3,
                         final int bniter,
                         final double btime,
                         final double bmops,
                         final java.lang.String boptype,
                         final int passed_verification,
                         final boolean bserial,
                         final int num_threads,
                         final int bid){this((java.lang.System[]) null);
                                            NPB3_0_X10$BMInOut$BMResults$$init$S(bname,CLASS,bn1,bn2,bn3,bniter,btime,bmops,boptype,passed_verification,bserial,num_threads,bid);}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.BMInOut.BMResults NPB3_0_X10$BMInOut$BMResults$$init$S(final java.lang.String bname,
                                                                                       final char CLASS,
                                                                                       final int bn1,
                                                                                       final int bn2,
                                                                                       final int bn3,
                                                                                       final int bniter,
                                                                                       final double btime,
                                                                                       final double bmops,
                                                                                       final java.lang.String boptype,
                                                                                       final int passed_verification,
                                                                                       final boolean bserial,
                                                                                       final int num_threads,
                                                                                       final int bid) { {
                                                                                                               
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
;
                                                                                                               {
                                                                                                                   {
                                                                                                                       
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"

                                                                                                                   }
                                                                                                                   
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.__fieldInitializers394515();
                                                                                                               }
                                                                                                               
//#line 91 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.pid = bid;
                                                                                                               
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.name = ((java.lang.String)(bname));
                                                                                                               
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.clss = CLASS;
                                                                                                               
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n1 = bn1;
                                                                                                               
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n2 = bn2;
                                                                                                               
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n3 = bn3;
                                                                                                               
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.niter = bniter;
                                                                                                               
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.time = btime;
                                                                                                               
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.mops = bmops;
                                                                                                               
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.optype = ((java.lang.String)(boptype));
                                                                                                               
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.verified = passed_verification;
                                                                                                               
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.serial = bserial;
                                                                                                               
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.numthreads = num_threads;
                                                                                                           }
                                                                                                           return this;
                                                                                                           }
        
        
        
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public void
                                                                                                   print(
                                                                                                   ){
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String fmt =
              ((java.lang.String)("%.3f"));
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396942 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396943 =
              "                                                               *";
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
x10.util.StringBuilder outbuf =
              t396942.add(((java.lang.String)(t396943)));
            
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396944 =
              outbuf;
            
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
int len =
              t396944.length$O();
            
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396945 =
              "***** NAS Parallel Benchmarks X10 version (NPB3_0_X10) ";
            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396946 =
              ((java.lang.String)(name));
            
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396947 =
              ((t396945) + (t396946));
            
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396948 =
              ((t396947) + (" ****"));
            
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
java.lang.String outline =
              new java.lang.String(t396948);
            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396949 =
              outbuf;
            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396950 =
              outline;
            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396949.insert((int)(0),
                                                                                                                    ((java.lang.String)(t396950)));
            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
;
            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396952 =
              outbuf;
            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396951 =
              len;
            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396953 =
              ((t396951) - (((int)(1))));
            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396952.insert((int)(t396953),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t396955 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396954 =
              outbuf;
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396956 =
              t396954.toString();
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396955.println(((java.lang.Object)(t396956)));
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396957 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396958 =
              "                                                   *";
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396959 =
              t396957.add(((java.lang.String)(t396958)));
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t396959;
            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t396960 =
              clss;
            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396961 =
              (("* Class             = ") + ((x10.core.Char.$box(t396960))));
            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396962 =
              ((java.lang.String)(new java.lang.String(t396961)));
            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t396962;
            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396963 =
              outbuf;
            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396964 =
              outline;
            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396963.insert((int)(0),
                                                                                                                    ((java.lang.String)(t396964)));
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396966 =
              outbuf;
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396965 =
              len;
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396967 =
              ((t396965) - (((int)(1))));
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396966.insert((int)(t396967),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t396969 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396968 =
              outbuf;
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396970 =
              t396968.toString();
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396969.println(((java.lang.Object)(t396970)));
            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396971 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396972 =
              "                                                   *";
            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396973 =
              t396971.add(((java.lang.String)(t396972)));
            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t396973;
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396974 =
              n2;
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t396976 =
              ((int) t396974) ==
            ((int) 0);
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t396976) {
                
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396975 =
                  n3;
                
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396976 = ((int) t396975) ==
                ((int) 0);
            }
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t396989 =
              t396976;
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t396989) {
                
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396977 =
                  n1;
                
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396978 =
                  (("* Size              = ") + ((x10.core.Int.$box(t396977))));
                
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396979 =
                  ((java.lang.String)(new java.lang.String(t396978)));
                
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t396979;
            } else {
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396980 =
                  n1;
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396981 =
                  (("* Size              = ") + ((x10.core.Int.$box(t396980))));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396982 =
                  ((t396981) + (" X "));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396983 =
                  n2;
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396984 =
                  ((t396982) + ((x10.core.Int.$box(t396983))));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396985 =
                  ((t396984) + (" X "));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396986 =
                  n3;
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396987 =
                  ((t396985) + ((x10.core.Int.$box(t396986))));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396988 =
                  ((java.lang.String)(new java.lang.String(t396987)));
                
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t396988;
            }
            
//#line 133 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396990 =
              outbuf;
            
//#line 133 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396991 =
              outline;
            
//#line 133 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396990.insert((int)(0),
                                                                                                                    ((java.lang.String)(t396991)));
            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396993 =
              outbuf;
            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396992 =
              len;
            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t396994 =
              ((t396992) - (((int)(1))));
            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396993.insert((int)(t396994),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t396996 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396995 =
              outbuf;
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396997 =
              t396995.toString();
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t396996.println(((java.lang.Object)(t396997)));
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t396998 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t396999 =
              "                                                   *";
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397000 =
              t396998.add(((java.lang.String)(t396999)));
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397000;
            
//#line 140 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397001 =
              niter;
            
//#line 140 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397002 =
              (("* Iterations        = ") + ((x10.core.Int.$box(t397001))));
            
//#line 140 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397003 =
              ((java.lang.String)(new java.lang.String(t397002)));
            
//#line 140 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397003;
            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397004 =
              outbuf;
            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397005 =
              outline;
            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397004.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397005)));
            
//#line 143 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397007 =
              outbuf;
            
//#line 143 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397006 =
              len;
            
//#line 143 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397008 =
              ((t397006) - (((int)(1))));
            
//#line 143 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397007.insert((int)(t397008),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397010 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397009 =
              outbuf;
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397011 =
              t397009.toString();
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397010.println(((java.lang.Object)(t397011)));
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397012 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397013 =
              "                                                   *";
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397014 =
              t397012.add(((java.lang.String)(t397013)));
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397014;
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397015 =
              time;
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397016 =
              ((java.lang.Object)
                x10.core.Double.$box(t397015));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397017 =
              ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397016})));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397018 =
              x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397017).raw().value);
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397019 =
              (("* Time in seconds   = ") + (t397018));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397020 =
              ((java.lang.String)(new java.lang.String(t397019)));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397020;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397021 =
              outbuf;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397022 =
              outline;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397021.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397022)));
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397024 =
              outbuf;
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397023 =
              len;
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397025 =
              ((t397023) - (((int)(1))));
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397024.insert((int)(t397025),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397027 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397026 =
              outbuf;
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397028 =
              t397026.toString();
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397027.println(((java.lang.Object)(t397028)));
            
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397029 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397030 =
              "                                                   *";
            
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397031 =
              t397029.add(((java.lang.String)(t397030)));
            
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397031;
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397032 =
              acctime;
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397033 =
              ((java.lang.Object)
                x10.core.Double.$box(t397032));
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397034 =
              ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397033})));
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397035 =
              x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397034).raw().value);
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397036 =
              (("* ACCTime           = ") + (t397035));
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397037 =
              ((java.lang.String)(new java.lang.String(t397036)));
            
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397037;
            
//#line 157 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397038 =
              outbuf;
            
//#line 157 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397039 =
              outline;
            
//#line 157 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397038.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397039)));
            
//#line 159 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397041 =
              outbuf;
            
//#line 159 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397040 =
              len;
            
//#line 159 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397042 =
              ((t397040) - (((int)(1))));
            
//#line 159 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397041.insert((int)(t397042),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397044 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397043 =
              outbuf;
            
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397045 =
              t397043.toString();
            
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397044.println(((java.lang.Object)(t397045)));
            
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397046 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397047 =
              "                                                   *";
            
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397048 =
              t397046.add(((java.lang.String)(t397047)));
            
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397048;
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397049 =
              mops;
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397050 =
              ((java.lang.Object)
                x10.core.Double.$box(t397049));
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397051 =
              ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397050})));
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397052 =
              x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397051).raw().value);
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397053 =
              (("* Mops total        = ") + (t397052));
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397054 =
              ((java.lang.String)(new java.lang.String(t397053)));
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397054;
            
//#line 165 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397055 =
              outbuf;
            
//#line 165 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397056 =
              outline;
            
//#line 165 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397055.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397056)));
            
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397058 =
              outbuf;
            
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397057 =
              len;
            
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397059 =
              ((t397057) - (((int)(1))));
            
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397058.insert((int)(t397059),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 168 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397061 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 168 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397060 =
              outbuf;
            
//#line 168 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397062 =
              t397060.toString();
            
//#line 168 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397061.println(((java.lang.Object)(t397062)));
            
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397063 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397064 =
              "                                                   *";
            
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397065 =
              t397063.add(((java.lang.String)(t397064)));
            
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397065;
            
//#line 172 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397066 =
              ((java.lang.String)(optype));
            
//#line 172 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397067 =
              (("* Operation type    = ") + (t397066));
            
//#line 172 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397068 =
              ((java.lang.String)(new java.lang.String(t397067)));
            
//#line 172 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397068;
            
//#line 173 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397069 =
              outbuf;
            
//#line 173 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397070 =
              outline;
            
//#line 173 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397069.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397070)));
            
//#line 175 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397072 =
              outbuf;
            
//#line 175 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397071 =
              len;
            
//#line 175 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397073 =
              ((t397071) - (((int)(1))));
            
//#line 175 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397072.insert((int)(t397073),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 176 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397075 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 176 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397074 =
              outbuf;
            
//#line 176 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397076 =
              t397074.toString();
            
//#line 176 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397075.println(((java.lang.Object)(t397076)));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397077 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397078 =
              "                                                   *";
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397079 =
              t397077.add(((java.lang.String)(t397078)));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397079;
            
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397080 =
              verified;
            
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397086 =
              ((int) t397080) ==
            ((int) 1);
            
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397086) {
                
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397081 =
                  ((java.lang.String)(new java.lang.String(((java.lang.String)("* Verification      = Successful")))));
                
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397081;
            } else {
                
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397082 =
                  verified;
                
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397085 =
                  ((int) t397082) ==
                ((int) 0);
                
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397085) {
                    
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397083 =
                      ((java.lang.String)(new java.lang.String(((java.lang.String)("* Verification      = Failed")))));
                    
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397083;
                } else {
                    
//#line 182 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397084 =
                      ((java.lang.String)(new java.lang.String(((java.lang.String)("* Verification      = Not Performed")))));
                    
//#line 182 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397084;
                }
            }
            
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397087 =
              outbuf;
            
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397088 =
              outline;
            
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397087.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397088)));
            
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397090 =
              outbuf;
            
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397089 =
              len;
            
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397091 =
              ((t397089) - (((int)(1))));
            
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397090.insert((int)(t397091),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397093 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397092 =
              outbuf;
            
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397094 =
              t397092.toString();
            
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397093.println(((java.lang.Object)(t397094)));
            
//#line 188 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397095 =
              serial;
            
//#line 188 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397109 =
              !(t397095);
            
//#line 188 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397109) {
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397096 =
                  ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397097 =
                  "                                                   *";
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397098 =
                  t397096.add(((java.lang.String)(t397097)));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397098;
                
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397099 =
                  numthreads;
                
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397100 =
                  (("* Threads requested = ") + ((x10.core.Int.$box(t397099))));
                
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397100;
                
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397101 =
                  outbuf;
                
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397102 =
                  outline;
                
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397101.insert((int)(0),
                                                                                                                        ((java.lang.String)(t397102)));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397104 =
                  outbuf;
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397103 =
                  len;
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397105 =
                  ((t397103) - (((int)(1))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397104.insert((int)(t397105),
                                                                                                                        ((java.lang.String)("*")));
                
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397107 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397106 =
                  outbuf;
                
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397108 =
                  t397106.toString();
                
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397107.println(((java.lang.Object)(t397108)));
            }
            
//#line 198 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397110 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 198 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397111 =
              "*                                                              *";
            
//#line 198 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397112 =
              t397110.add(((java.lang.String)(t397111)));
            
//#line 198 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397112;
            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397114 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397113 =
              outbuf;
            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397115 =
              t397113.toString();
            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397114.println(((java.lang.Object)(t397115)));
            
//#line 202 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397116 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 202 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397117 =
              "                                                   *";
            
//#line 202 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397118 =
              t397116.add(((java.lang.String)(t397117)));
            
//#line 202 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397118;
            
//#line 204 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "* Please send all errors/feedbacks to:";
            
//#line 205 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397119 =
              outbuf;
            
//#line 205 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397120 =
              outline;
            
//#line 205 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397119.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397120)));
            
//#line 207 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397122 =
              outbuf;
            
//#line 207 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397121 =
              len;
            
//#line 207 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397123 =
              ((t397121) - (((int)(1))));
            
//#line 207 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397122.insert((int)(t397123),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 208 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397125 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 208 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397124 =
              outbuf;
            
//#line 208 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397126 =
              t397124.toString();
            
//#line 208 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397125.println(((java.lang.Object)(t397126)));
            
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397127 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397128 =
              "                                                   *";
            
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397129 =
              t397127.add(((java.lang.String)(t397128)));
            
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397129;
            
//#line 212 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "* NPB Working Team";
            
//#line 213 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397130 =
              outbuf;
            
//#line 213 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397131 =
              outline;
            
//#line 213 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397130.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397131)));
            
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397133 =
              outbuf;
            
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397132 =
              len;
            
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397134 =
              ((t397132) - (((int)(1))));
            
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397133.insert((int)(t397134),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397136 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397135 =
              outbuf;
            
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397137 =
              t397135.toString();
            
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397136.println(((java.lang.Object)(t397137)));
            
//#line 218 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397138 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 218 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397139 =
              "                                                   *";
            
//#line 218 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397140 =
              t397138.add(((java.lang.String)(t397139)));
            
//#line 218 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397140;
            
//#line 220 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "* x10-dev@cs.purdue.edu";
            
//#line 221 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397141 =
              outbuf;
            
//#line 221 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397142 =
              outline;
            
//#line 221 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397141.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397142)));
            
//#line 223 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397144 =
              outbuf;
            
//#line 223 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397143 =
              len;
            
//#line 223 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397145 =
              ((t397143) - (((int)(1))));
            
//#line 223 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397144.insert((int)(t397145),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 224 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397147 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 224 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397146 =
              outbuf;
            
//#line 224 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397148 =
              t397146.toString();
            
//#line 224 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397147.println(((java.lang.Object)(t397148)));
            
//#line 226 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397149 =
              ((x10.util.StringBuilder)(new x10.util.StringBuilder((java.lang.System[]) null).x10$util$StringBuilder$$init$S()));
            
//#line 226 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397150 =
              "                                                   *";
            
//#line 226 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397151 =
              t397149.add(((java.lang.String)(t397150)));
            
//#line 226 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outbuf = t397151;
            
//#line 228 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397152 =
              "***************************************************************";
            
//#line 228 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397153 =
              ((java.lang.String)(new java.lang.String(t397152)));
            
//#line 228 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397153;
            
//#line 230 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397154 =
              outbuf;
            
//#line 230 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397155 =
              outline;
            
//#line 230 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397154.insert((int)(0),
                                                                                                                    ((java.lang.String)(t397155)));
            
//#line 232 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397157 =
              outbuf;
            
//#line 232 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397156 =
              len;
            
//#line 232 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397158 =
              ((t397156) - (((int)(1))));
            
//#line 232 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397157.insert((int)(t397158),
                                                                                                                    ((java.lang.String)("*")));
            
//#line 233 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397160 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 233 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.util.StringBuilder t397159 =
              outbuf;
            
//#line 233 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397161 =
              t397159.toString();
            
//#line 233 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397160.println(((java.lang.Object)(t397161)));
            
//#line 235 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397162 =
              ((x10.io.Printer)(out));
            
//#line 235 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397240 =
              ((t397162) != (null));
            
//#line 235 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397240) {
                
//#line 236 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
try {{
                    
//#line 238 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397163 =
                      ((java.lang.String)(name));
                    
//#line 237 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397164 =
                      (("***** NAS Parallel Benchmarks X10 version (NPB3_0_X10) ") + (t397163));
                    
//#line 237 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397165 =
                      ((t397164) + (" Report *****"));
                    
//#line 237 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397165;
                    
//#line 239 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397166 =
                      ((x10.io.Printer)(out));
                    
//#line 239 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397167 =
                      outline;
                    
//#line 239 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397166.println(((java.lang.Object)(t397167)));
                    
//#line 241 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t397168 =
                      clss;
                    
//#line 241 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397169 =
                      java.lang.String.valueOf((x10.core.Char.$box(t397168)));
                    
//#line 241 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397170 =
                      (("Class           = ") + (t397169));
                    
//#line 241 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397170;
                    
//#line 242 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397171 =
                      ((x10.io.Printer)(out));
                    
//#line 242 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397172 =
                      outline;
                    
//#line 242 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397171.println(((java.lang.Object)(t397172)));
                    
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397173 =
                      n2;
                    
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t397175 =
                      ((int) t397173) ==
                    ((int) 0);
                    
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397175) {
                        
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397174 =
                          n3;
                        
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397175 = ((int) t397174) ==
                        ((int) 0);
                    }
                    
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397190 =
                      t397175;
                    
//#line 244 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397190) {
                        
//#line 245 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397176 =
                          n1;
                        
//#line 245 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397177 =
                          java.lang.String.valueOf((x10.core.Int.$box(t397176)));
                        
//#line 245 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397178 =
                          (("Size            = ") + (t397177));
                        
//#line 245 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397178;
                    } else {
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397179 =
                          n1;
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397180 =
                          java.lang.String.valueOf((x10.core.Int.$box(t397179)));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397181 =
                          (("Size            = ") + (t397180));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397183 =
                          ((t397181) + (" X "));
                        
//#line 248 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397182 =
                          n2;
                        
//#line 248 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397184 =
                          java.lang.String.valueOf((x10.core.Int.$box(t397182)));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397185 =
                          ((t397183) + (t397184));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397187 =
                          ((t397185) + (" X "));
                        
//#line 249 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397186 =
                          n3;
                        
//#line 249 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397188 =
                          java.lang.String.valueOf((x10.core.Int.$box(t397186)));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397189 =
                          ((t397187) + (t397188));
                        
//#line 247 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397189;
                    }
                    
//#line 251 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397191 =
                      ((x10.io.Printer)(out));
                    
//#line 251 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397192 =
                      outline;
                    
//#line 251 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397191.println(((java.lang.Object)(t397192)));
                    
//#line 253 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397193 =
                      niter;
                    
//#line 253 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397194 =
                      java.lang.String.valueOf((x10.core.Int.$box(t397193)));
                    
//#line 253 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397195 =
                      (("Iterations      = ") + (t397194));
                    
//#line 253 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397195;
                    
//#line 254 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397196 =
                      ((x10.io.Printer)(out));
                    
//#line 254 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397197 =
                      outline;
                    
//#line 254 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397196.println(((java.lang.Object)(t397197)));
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397198 =
                      time;
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397199 =
                      ((java.lang.Object)
                        x10.core.Double.$box(t397198));
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397200 =
                      ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397199})));
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397201 =
                      x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397200).raw().value);
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397202 =
                      (("Time in seconds = ") + (t397201));
                    
//#line 256 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397202;
                    
//#line 257 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397203 =
                      ((x10.io.Printer)(out));
                    
//#line 257 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397204 =
                      outline;
                    
//#line 257 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397203.println(((java.lang.Object)(t397204)));
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397205 =
                      acctime;
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397206 =
                      ((java.lang.Object)
                        x10.core.Double.$box(t397205));
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397207 =
                      ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397206})));
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397208 =
                      x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397207).raw().value);
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397209 =
                      (("ACCTime         = ") + (t397208));
                    
//#line 259 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397209;
                    
//#line 260 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397210 =
                      ((x10.io.Printer)(out));
                    
//#line 260 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397211 =
                      outline;
                    
//#line 260 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397210.println(((java.lang.Object)(t397211)));
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397212 =
                      mops;
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.Object t397213 =
                      ((java.lang.Object)
                        x10.core.Double.$box(t397212));
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.array.Array t397214 =
                      ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeArrayFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t397213})));
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397215 =
                      x10.runtime.impl.java.StringUtils.format(fmt,(java.lang.Object[]) (t397214).raw().value);
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397216 =
                      (("Mops total      = ") + (t397215));
                    
//#line 262 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397216;
                    
//#line 263 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397217 =
                      ((x10.io.Printer)(out));
                    
//#line 263 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397218 =
                      outline;
                    
//#line 263 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397217.println(((java.lang.Object)(t397218)));
                    
//#line 265 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397219 =
                      ((java.lang.String)(optype));
                    
//#line 265 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397220 =
                      java.lang.String.valueOf(t397219);
                    
//#line 265 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397221 =
                      (("Operation type  = ") + (t397220));
                    
//#line 265 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = t397221;
                    
//#line 266 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397222 =
                      ((x10.io.Printer)(out));
                    
//#line 266 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397223 =
                      outline;
                    
//#line 266 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397222.println(((java.lang.Object)(t397223)));
                    
//#line 268 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397224 =
                      verified;
                    
//#line 268 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397227 =
                      ((int) t397224) ==
                    ((int) 1);
                    
//#line 268 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397227) {
                        
//#line 268 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "Verification    = Successful";
                    } else {
                        
//#line 269 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397225 =
                          verified;
                        
//#line 269 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397226 =
                          ((int) t397225) ==
                        ((int) 0);
                        
//#line 269 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397226) {
                            
//#line 269 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "Verification Failed";
                        } else {
                            
//#line 270 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "Verification Not Performed";
                        }
                    }
                    
//#line 271 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397228 =
                      ((x10.io.Printer)(out));
                    
//#line 271 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397229 =
                      outline;
                    
//#line 271 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397228.println(((java.lang.Object)(t397229)));
                    
//#line 274 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = "\n Please send all errors/feedbacks to:";
                    
//#line 275 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397230 =
                      ((x10.io.Printer)(out));
                    
//#line 275 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397231 =
                      outline;
                    
//#line 275 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397230.println(((java.lang.Object)(t397231)));
                    
//#line 277 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = " NPB Working Team";
                    
//#line 278 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397232 =
                      ((x10.io.Printer)(out));
                    
//#line 278 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397233 =
                      outline;
                    
//#line 278 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397232.println(((java.lang.Object)(t397233)));
                    
//#line 280 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
outline = " npb@nas.nasa.gov\n";
                    
//#line 281 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397234 =
                      ((x10.io.Printer)(out));
                    
//#line 281 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397235 =
                      outline;
                    
//#line 281 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397234.println(((java.lang.Object)(t397235)));
                    
//#line 283 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397236 =
                      ((x10.io.Printer)(out));
                    
//#line 283 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397236.flush();
                }}catch (final java.lang.RuntimeException e) {
                    
//#line 285 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397238 =
                      ((x10.io.Printer)(x10.io.Console.get$ERR()));
                    
//#line 285 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397237 =
                      x10.runtime.impl.java.ThrowableUtils.toString(e);
                    
//#line 285 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397239 =
                      (("Res.print: write file: ") + (t397237));
                    
//#line 285 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397238.println(((java.lang.Object)(t397239)));
                }
            }
        }
        
        
//#line 290 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public int
                                                                                                   getFromFile$O(
                                                                                                   final java.lang.String filename){
            
//#line 291 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
x10.io.FileReader inp =
              null;
            
//#line 292 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.verified = -1;
            
//#line 293 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
try {{
                
//#line 294 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.File t397241 =
                  ((x10.io.File)(new x10.io.File((java.lang.System[]) null).x10$io$File$$init$S(((java.lang.String)(filename)))));
                
//#line 294 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.FileReader t397242 =
                  ((x10.io.FileReader)(new x10.io.FileReader((java.lang.System[]) null).x10$io$FileReader$$init$S(((x10.io.File)(t397241)))));
                
//#line 294 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
inp = t397242;
            }}catch (final java.lang.RuntimeException e) {
                
//#line 296 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397244 =
                  ((x10.io.Printer)(x10.io.Console.get$ERR()));
                
//#line 296 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397243 =
                  x10.runtime.impl.java.ThrowableUtils.toString(e);
                
//#line 296 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397245 =
                  (("BMResults.getFromFile: filename ") + (t397243));
                
//#line 296 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397244.println(((java.lang.Object)(t397245)));
                
//#line 297 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return 0;
            }
            
//#line 299 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
java.lang.String line =
              "";
            
//#line 300 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
java.lang.String keyword =
               null;
            
//#line 301 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
int idx1 =
               0;
            
//#line 302 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
try {{
                
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
while (true) {
                    
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.FileReader t397246 =
                      inp;
                    
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397247 =
                      t397246.readLine();
                    
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397248 =
                      line = t397247;
                    
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397295 =
                      ((t397248) != (null));
                    
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (!(t397295)) {
                        
//#line 303 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
break;
                    }
                    {
                        
//#line 304 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397249 =
                          line;
                        
//#line 304 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397250 =
                          (t397249).indexOf("Time in seconds =");
                        
//#line 304 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397294 =
                          ((t397250) >= (((int)(0))));
                        
//#line 304 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397294) {
                            
//#line 305 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397251 =
                              ((java.lang.String)(new java.lang.String(((java.lang.String)("Time in seconds =")))));
                            
//#line 305 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
keyword = t397251;
                            
//#line 306 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397252 =
                              line;
                            
//#line 306 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397253 =
                              keyword;
                            
//#line 306 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397254 =
                              (t397252).indexOf(t397253);
                            
//#line 306 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
idx1 = t397254;
                            
//#line 307 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397256 =
                              idx1;
                            
//#line 307 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397255 =
                              keyword;
                            
//#line 307 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397257 =
                              (t397255).length();
                            
//#line 307 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397258 =
                              ((t397256) + (((int)(t397257))));
                            
//#line 307 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
idx1 = t397258;
                            
//#line 308 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397259 =
                              line;
                            
//#line 308 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397260 =
                              idx1;
                            
//#line 308 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397261 =
                              (t397259).substring(((int)(t397260)));
                            
//#line 308 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
double dbl =
                              java.lang.Double.parseDouble(t397261);
                            
//#line 309 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397262 =
                              dbl;
                            
//#line 309 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397263 =
                              this.wctime = t397262;
                            
//#line 309 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.acctime = t397263;
                        } else {
                            
//#line 310 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397264 =
                              line;
                            
//#line 310 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397265 =
                              (t397264).indexOf("Verification    =");
                            
//#line 310 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397293 =
                              ((t397265) >= (((int)(0))));
                            
//#line 310 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397293) {
                                
//#line 311 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.verified = 0;
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397266 =
                                  line;
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397267 =
                                  (t397266).indexOf("successful");
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t397270 =
                                  ((t397267) >= (((int)(0))));
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397270) {
                                    
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397268 =
                                      line;
                                    
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397269 =
                                      (t397268).indexOf("successful");
                                    
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397270 = ((t397269) < (((int)(0))));
                                }
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t397276 =
                                  t397270;
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (!(t397276)) {
                                    
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397271 =
                                      line;
                                    
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397272 =
                                      (t397271).indexOf("SUCCESSFUL");
                                    
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t397275 =
                                      ((t397272) >= (((int)(0))));
                                    
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397275) {
                                        
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397273 =
                                          line;
                                        
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397274 =
                                          (t397273).indexOf("UNSUCCESSFUL");
                                        
//#line 313 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397275 = ((t397274) < (((int)(0))));
                                    }
                                    
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397276 = t397275;
                                }
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397277 =
                                  t397276;
                                
//#line 312 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397277) {
                                    
//#line 314 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.verified = 1;
                                }
                            } else {
                                
//#line 315 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397278 =
                                  line;
                                
//#line 315 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397279 =
                                  (t397278).indexOf("Mop/s total     =");
                                
//#line 315 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397292 =
                                  ((t397279) >= (((int)(0))));
                                
//#line 315 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397292) {
                                    
//#line 316 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397280 =
                                      ((java.lang.String)(new java.lang.String(((java.lang.String)("Mop/s total     =")))));
                                    
//#line 316 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
keyword = t397280;
                                    
//#line 317 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397281 =
                                      line;
                                    
//#line 317 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397282 =
                                      keyword;
                                    
//#line 317 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397283 =
                                      (t397281).indexOf(t397282);
                                    
//#line 317 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
idx1 = t397283;
                                    
//#line 318 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397285 =
                                      idx1;
                                    
//#line 318 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397284 =
                                      keyword;
                                    
//#line 318 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397286 =
                                      (t397284).length();
                                    
//#line 318 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397287 =
                                      ((t397285) + (((int)(t397286))));
                                    
//#line 318 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
idx1 = t397287;
                                    
//#line 319 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397288 =
                                      line;
                                    
//#line 319 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397289 =
                                      idx1;
                                    
//#line 319 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397290 =
                                      (t397288).substring(((int)(t397289)));
                                    
//#line 319 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
double dbl =
                                      java.lang.Double.parseDouble(t397290);
                                    
//#line 320 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397291 =
                                      dbl;
                                    
//#line 320 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.mops = t397291;
                                }
                            }
                        }
                    }
                }
            }}catch (java.lang.RuntimeException e) {
                
//#line 324 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397298 =
                  ((x10.io.Printer)(x10.io.Console.get$ERR()));
                
//#line 324 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.RuntimeException t397296 =
                  e;
                
//#line 324 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397297 =
                  x10.runtime.impl.java.ThrowableUtils.toString(t397296);
                
//#line 324 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397299 =
                  (("BMResults.getFromFile: ") + (t397297));
                
//#line 324 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397298.println(((java.lang.Object)(t397299)));
                
//#line 325 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return 0;
            }
            
//#line 328 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return 1;
        }
        
        
//#line 331 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public static void
                                                                                                   printVerificationStatus(
                                                                                                   char clss,
                                                                                                   int verified,
                                                                                                   java.lang.String BMName){
            
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t397300 =
              clss;
            
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
boolean t397302 =
              ((char) t397300) ==
            ((char) 'U');
            
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (!(t397302)) {
                
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397301 =
                  verified;
                
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397302 = ((int) t397301) ==
                ((int) -1);
            }
            
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397324 =
              t397302;
            
//#line 332 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397324) {
                
//#line 333 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
verified = -1;
                
//#line 334 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397303 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 334 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397303.println(((java.lang.Object)(" Problem size unknown")));
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397308 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397304 =
                  BMName;
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397305 =
                  ((t397304) + ("."));
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t397306 =
                  clss;
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397307 =
                  ((t397305) + ((x10.core.Char.$box(t397306))));
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397309 =
                  ((t397307) + (": Verification Not Performed"));
                
//#line 335 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397308.println(((java.lang.Object)(t397309)));
            } else {
                
//#line 336 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397310 =
                  verified;
                
//#line 336 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397323 =
                  ((int) t397310) ==
                ((int) 1);
                
//#line 336 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397323) {
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397315 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397311 =
                      BMName;
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397312 =
                      ((t397311) + ("."));
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t397313 =
                      clss;
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397314 =
                      ((t397312) + ((x10.core.Char.$box(t397313))));
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397316 =
                      ((t397314) + (": Verification Successful"));
                    
//#line 337 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397315.println(((java.lang.Object)(t397316)));
                } else {
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397321 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397317 =
                      BMName;
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397318 =
                      ((t397317) + ("."));
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final char t397319 =
                      clss;
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397320 =
                      ((t397318) + ((x10.core.Char.$box(t397319))));
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397322 =
                      ((t397320) + (": Verification Failed"));
                    
//#line 339 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397321.println(((java.lang.Object)(t397322)));
                }
            }
        }
        
        
//#line 343 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public static int
                                                                                                   printComparisonStatus__3$1x10$lang$Double$2__4$1x10$lang$Double$2__5$1x10$lang$Double$2$O(
                                                                                                   final char clss,
                                                                                                   final int verified,
                                                                                                   final double epsilon,
                                                                                                   final x10.array.Array<x10.core.Double> xcr,
                                                                                                   final x10.array.Array<x10.core.Double> xcrref,
                                                                                                   final x10.array.Array<x10.core.Double> xcrdif){
            {
                
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
int m =
                  0;
                
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
for (;
                                                                                                              true;
                                                                                                              ) {
                    
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397326 =
                      m;
                    
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397327 =
                      ((x10.array.Array<x10.core.Double>)xcr).
                        size;
                    
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397355 =
                      ((t397326) < (((int)(t397327))));
                    
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (!(t397355)) {
                        
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
break;
                    }
                    {
                        
//#line 346 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397354 =
                          ((char) clss) ==
                        ((char) 'U');
                        
//#line 346 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397354) {
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397334 =
                              ((x10.io.Printer)(x10.io.Console.get$OUT()));
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397330 =
                              m;
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397332 =
                              (((x10.core.Int.$box(t397330))) + (". "));
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397331 =
                              m;
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397333 =
                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)xcr).$apply$G((int)(t397331)));
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397335 =
                              ((t397332) + ((x10.core.Double.$box(t397333))));
                            
//#line 347 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397334.println(((java.lang.Object)(t397335)));
                        } else {
                            
//#line 349 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397336 =
                              m;
                            
//#line 349 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397337 =
                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)xcrdif).$apply$G((int)(t397336)));
                            
//#line 349 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397339 =
                              ((t397337) <= (((double)(epsilon))));
                            
//#line 349 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397339) {
                                
                            } else {
                                
//#line 353 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397338 =
                                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                
//#line 353 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397338.print(((java.lang.String)("FAILURE: ")));
                            }
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397352 =
                              ((x10.io.Printer)(x10.io.Console.get$OUT()));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397340 =
                              m;
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397342 =
                              (((x10.core.Int.$box(t397340))) + (". "));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397341 =
                              m;
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397343 =
                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)xcr).$apply$G((int)(t397341)));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397344 =
                              ((t397342) + ((x10.core.Double.$box(t397343))));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397346 =
                              ((t397344) + (" "));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397345 =
                              m;
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397347 =
                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)xcrref).$apply$G((int)(t397345)));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397348 =
                              ((t397346) + ((x10.core.Double.$box(t397347))));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397350 =
                              ((t397348) + (" "));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397349 =
                              m;
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final double t397351 =
                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)xcrdif).$apply$G((int)(t397349)));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397353 =
                              ((t397350) + ((x10.core.Double.$box(t397351))));
                            
//#line 355 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397352.println(((java.lang.Object)(t397353)));
                        }
                    }
                    {
                        
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397328 =
                          m;
                        
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397329 =
                          ((t397328) + (((int)(1))));
                        
//#line 345 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
m = t397329;
                    }
                }
            }
            
//#line 358 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return verified;
        }
        
        
//#line 361 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
public static int
                                                                                                   printComparisonStatus$O(
                                                                                                   final char clss,
                                                                                                   int verified,
                                                                                                   final double epsilon,
                                                                                                   final double xcr,
                                                                                                   final double xcrref,
                                                                                                   final double xcrdif){
            
//#line 363 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397367 =
              ((char) clss) ==
            ((char) 'U');
            
//#line 363 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397367) {
                
//#line 364 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397356 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 364 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397357 =
                  ((" ") + ((x10.core.Double.$box(xcr))));
                
//#line 364 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397356.println(((java.lang.Object)(t397357)));
            } else {
                
//#line 366 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397361 =
                  ((xcrdif) <= (((double)(epsilon))));
                
//#line 366 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397361) {
                    
//#line 367 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397358 =
                      verified;
                    
//#line 367 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final boolean t397359 =
                      ((int) t397358) ==
                    ((int) -1);
                    
//#line 367 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
if (t397359) {
                        
//#line 367 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
verified = 1;
                    }
                } else {
                    
//#line 369 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
verified = 0;
                    
//#line 370 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397360 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 370 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397360.print(((java.lang.String)("FAILURE: ")));
                }
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final x10.io.Printer t397365 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397362 =
                  (((x10.core.Double.$box(xcr))) + (" "));
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397363 =
                  ((t397362) + ((x10.core.Double.$box(xcrref))));
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397364 =
                  ((t397363) + (" "));
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final java.lang.String t397366 =
                  ((t397364) + ((x10.core.Double.$box(xcrdif))));
                
//#line 372 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
t397365.println(((java.lang.Object)(t397366)));
            }
            
//#line 374 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final int t397368 =
              verified;
            
//#line 374 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return t397368;
        }
        
        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final public NPB3_0_X10.BMInOut.BMResults
                                                                                                  NPB3_0_X10$BMInOut$BMResults$$this$NPB3_0_X10$BMInOut$BMResults(
                                                                                                  ){
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
return NPB3_0_X10.BMInOut.BMResults.this;
        }
        
        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
final public void
                                                                                                  __fieldInitializers394515(
                                                                                                  ){
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.name = null;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.MachineName = null;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.PrLang = null;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.clss = '\000';
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n1 = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n2 = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.n3 = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.niter = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.time = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.acctime = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.wctime = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.mops = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.tmSent = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.tmReceived = 0.0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.RecArrSize = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.optype = null;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.numthreads = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.serial = false;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.pid = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.verified = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/BMInOut/BMResults.x10"
this.out = null;
        }
    
}

