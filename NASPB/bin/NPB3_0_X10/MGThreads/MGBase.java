package NPB3_0_X10.MGThreads;


@x10.runtime.impl.java.X10Generated public class MGBase extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<MGBase> $RTT = x10.rtt.NamedType.<MGBase> make(
    "NPB3_0_X10.MGThreads.MGBase", /* base class */MGBase.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.MGThreads.MGBase $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + MGBase.class + " calling"); } 
        $_obj.nit = $deserializer.readInt();
        $_obj.nx_default = $deserializer.readInt();
        $_obj.ny_default = $deserializer.readInt();
        $_obj.nz_default = $deserializer.readInt();
        $_obj.nit_default = $deserializer.readInt();
        $_obj.lm = $deserializer.readInt();
        $_obj.lt_default = $deserializer.readInt();
        $_obj.ndim1 = $deserializer.readInt();
        $_obj.ndim2 = $deserializer.readInt();
        $_obj.ndim3 = $deserializer.readInt();
        $_obj.nm = $deserializer.readInt();
        $_obj.nv = $deserializer.readInt();
        $_obj.nr = $deserializer.readInt();
        $_obj.nm2 = $deserializer.readInt();
        $_obj.timer = $deserializer.readRef();
        $_obj.nx = $deserializer.readRef();
        $_obj.ny = $deserializer.readRef();
        $_obj.nz = $deserializer.readRef();
        $_obj.ir = $deserializer.readRef();
        $_obj.m1 = $deserializer.readRef();
        $_obj.m2 = $deserializer.readRef();
        $_obj.m3 = $deserializer.readRef();
        $_obj.lt = $deserializer.readInt();
        $_obj.lb = $deserializer.readInt();
        $_obj.u = $deserializer.readRef();
        $_obj.v = $deserializer.readRef();
        $_obj.r = $deserializer.readRef();
        $_obj.a = $deserializer.readRef();
        $_obj.c = $deserializer.readRef();
        $_obj.timeron = $deserializer.readBoolean();
        $_obj.CLASS = $deserializer.readChar();
        $_obj.num_threads = $deserializer.readInt();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        MGBase $_obj = new MGBase((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        $serializer.write(this.nit);
        $serializer.write(this.nx_default);
        $serializer.write(this.ny_default);
        $serializer.write(this.nz_default);
        $serializer.write(this.nit_default);
        $serializer.write(this.lm);
        $serializer.write(this.lt_default);
        $serializer.write(this.ndim1);
        $serializer.write(this.ndim2);
        $serializer.write(this.ndim3);
        $serializer.write(this.nm);
        $serializer.write(this.nv);
        $serializer.write(this.nr);
        $serializer.write(this.nm2);
        if (timer instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.timer);
        } else {
        $serializer.write(this.timer);
        }
        if (nx instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.nx);
        } else {
        $serializer.write(this.nx);
        }
        if (ny instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.ny);
        } else {
        $serializer.write(this.ny);
        }
        if (nz instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.nz);
        } else {
        $serializer.write(this.nz);
        }
        if (ir instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.ir);
        } else {
        $serializer.write(this.ir);
        }
        if (m1 instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.m1);
        } else {
        $serializer.write(this.m1);
        }
        if (m2 instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.m2);
        } else {
        $serializer.write(this.m2);
        }
        if (m3 instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.m3);
        } else {
        $serializer.write(this.m3);
        }
        $serializer.write(this.lt);
        $serializer.write(this.lb);
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
        $serializer.write(this.timeron);
        $serializer.write(this.CLASS);
        $serializer.write(this.num_threads);
        
    }
    
    // constructor just for allocation
    public MGBase(final java.lang.System[] $dummy) { 
    }
    
        
//#line 57 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static java.lang.String BMName = "MG";
        
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int maxlevel = 11;
        
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nit;
        
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nx_default;
        
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int ny_default;
        
//#line 63 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nz_default;
        
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nit_default;
        
//#line 65 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int lm;
        
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int lt_default;
        
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int ndim1;
        
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int ndim2;
        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int ndim3;
        
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nm;
        
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nv;
        
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nr;
        
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int nm2;
        
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public NPB3_0_X10.Timer timer;
        
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> nx;
        
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> ny;
        
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> nz;
        
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> ir;
        
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> m1;
        
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> m2;
        
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Int> m3;
        
//#line 83 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int lt;
        
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int lb;
        
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Double> u;
        
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Double> v;
        
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Double> r;
        
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Double> a;
        
//#line 90 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public x10.array.Array<x10.core.Double> c;
        
//#line 92 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_total = 0;
        
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_init = 1;
        
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_bench = 2;
        
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_mg3P = 3;
        
//#line 96 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_psinv = 4;
        
//#line 97 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_resid = 5;
        
//#line 98 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_resid2 = 6;
        
//#line 99 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_rprj3 = 7;
        
//#line 100 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_interp = 8;
        
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_norm2 = 9;
        
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public static int T_last = 9;
        
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public boolean timeron;
        
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public char CLASS;
        
        
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
// creation method for java code (1-phase java constructor)
        public MGBase(final char clss,
                      final int np,
                      final boolean serial){this((java.lang.System[]) null);
                                                NPB3_0_X10$MGThreads$MGBase$$init$S(clss,np,serial);}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.MGThreads.MGBase NPB3_0_X10$MGThreads$MGBase$$init$S(final char clss,
                                                                                     final int np,
                                                                                     final boolean serial) { {
                                                                                                                    
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
;
                                                                                                                    {
                                                                                                                        {
                                                                                                                            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"

                                                                                                                        }
                                                                                                                        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.__fieldInitializers1934421();
                                                                                                                    }
                                                                                                                    
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.CLASS = clss;
                                                                                                                    
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.num_threads = np;
                                                                                                                    
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final char t1936115 =
                                                                                                                      CLASS;
                                                                                                                    
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
switch (t1936115) {
                                                                                                                        
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'S':
                                                                                                                        
//#line 111 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 's':
                                                                                                                            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936088 =
                                                                                                                              this.nz_default = 32;
                                                                                                                            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936090 =
                                                                                                                              this.ny_default = t1936088;
                                                                                                                            
//#line 112 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx_default = t1936090;
                                                                                                                            
//#line 113 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit_default = 4;
                                                                                                                            
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lm = 5;
                                                                                                                            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936091 =
                                                                                                                              this.lt_default = 5;
                                                                                                                            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt = t1936091;
                                                                                                                            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936092 =
                                                                                                                              this.ndim3 = 5;
                                                                                                                            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936093 =
                                                                                                                              this.ndim2 = t1936092;
                                                                                                                            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ndim1 = t1936093;
                                                                                                                            
//#line 117 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936094 =
                                                                                                                              nit_default;
                                                                                                                            
//#line 117 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit = t1936094;
                                                                                                                            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                                                                                                        
//#line 119 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'W':
                                                                                                                        
//#line 119 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'w':
                                                                                                                            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936095 =
                                                                                                                              this.nz_default = 64;
                                                                                                                            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936096 =
                                                                                                                              this.ny_default = t1936095;
                                                                                                                            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx_default = t1936096;
                                                                                                                            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit_default = 40;
                                                                                                                            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lm = 6;
                                                                                                                            
//#line 122 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt_default = 6;
                                                                                                                            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936097 =
                                                                                                                              this.ndim3 = 6;
                                                                                                                            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936098 =
                                                                                                                              this.ndim2 = t1936097;
                                                                                                                            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ndim1 = t1936098;
                                                                                                                            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                                                                                                        
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'A':
                                                                                                                        
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'a':
                                                                                                                            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936099 =
                                                                                                                              this.nz_default = 256;
                                                                                                                            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936100 =
                                                                                                                              this.ny_default = t1936099;
                                                                                                                            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx_default = t1936100;
                                                                                                                            
//#line 127 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit_default = 4;
                                                                                                                            
//#line 127 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lm = 8;
                                                                                                                            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt_default = 8;
                                                                                                                            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936102 =
                                                                                                                              this.ndim3 = 8;
                                                                                                                            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936103 =
                                                                                                                              this.ndim2 = t1936102;
                                                                                                                            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ndim1 = t1936103;
                                                                                                                            
//#line 130 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                                                                                                        
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'B':
                                                                                                                        
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'b':
                                                                                                                            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936104 =
                                                                                                                              this.nz_default = 256;
                                                                                                                            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936105 =
                                                                                                                              this.ny_default = t1936104;
                                                                                                                            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx_default = t1936105;
                                                                                                                            
//#line 133 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit_default = 20;
                                                                                                                            
//#line 133 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lm = 8;
                                                                                                                            
//#line 134 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt_default = 8;
                                                                                                                            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936108 =
                                                                                                                              this.ndim3 = 8;
                                                                                                                            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936109 =
                                                                                                                              this.ndim2 = t1936108;
                                                                                                                            
//#line 135 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ndim1 = t1936109;
                                                                                                                            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                                                                                                        
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'C':
                                                                                                                        
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
case 'c':
                                                                                                                            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936110 =
                                                                                                                              this.nz_default = 512;
                                                                                                                            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936111 =
                                                                                                                              this.ny_default = t1936110;
                                                                                                                            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx_default = t1936111;
                                                                                                                            
//#line 139 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit_default = 20;
                                                                                                                            
//#line 139 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lm = 9;
                                                                                                                            
//#line 140 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt_default = 9;
                                                                                                                            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936112 =
                                                                                                                              this.ndim3 = 9;
                                                                                                                            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936113 =
                                                                                                                              this.ndim2 = t1936112;
                                                                                                                            
//#line 141 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ndim1 = t1936113;
                                                                                                                            
//#line 142 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                                                                                                        
//#line 143 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
default:
                                                                                                                            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final java.lang.Error t1936114 =
                                                                                                                              ((java.lang.Error)(new java.lang.Error("Class must be one of SWABC")));
                                                                                                                            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
throw t1936114;
                                                                                                                    }
                                                                                                                    
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936116 =
                                                                                                                      lt_default;
                                                                                                                    
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt = t1936116;
                                                                                                                    
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936117 =
                                                                                                                      nit_default;
                                                                                                                    
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit = t1936117;
                                                                                                                    
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936119 =
                                                                                                                      ((x10.array.Array)(nx));
                                                                                                                    
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936118 =
                                                                                                                      lt;
                                                                                                                    
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936120 =
                                                                                                                      ((t1936118) - (((int)(1))));
                                                                                                                    
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936121 =
                                                                                                                      nx_default;
                                                                                                                    
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Int>)t1936119).$set__1x10$array$Array$$T$G((int)(t1936120),
                                                                                                                                                                                                                                                                                  x10.core.Int.$box(t1936121));
                                                                                                                    
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936129 =
                                                                                                                      ((x10.array.Array)(ny));
                                                                                                                    
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936128 =
                                                                                                                      lt;
                                                                                                                    
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936130 =
                                                                                                                      ((t1936128) - (((int)(1))));
                                                                                                                    
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936131 =
                                                                                                                      ny_default;
                                                                                                                    
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Int>)t1936129).$set__1x10$array$Array$$T$G((int)(t1936130),
                                                                                                                                                                                                                                                                                  x10.core.Int.$box(t1936131));
                                                                                                                    
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936133 =
                                                                                                                      ((x10.array.Array)(nz));
                                                                                                                    
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936132 =
                                                                                                                      lt;
                                                                                                                    
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936134 =
                                                                                                                      ((t1936132) - (((int)(1))));
                                                                                                                    
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936135 =
                                                                                                                      nz_default;
                                                                                                                    
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Int>)t1936133).$set__1x10$array$Array$$T$G((int)(t1936134),
                                                                                                                                                                                                                                                                                  x10.core.Int.$box(t1936135));
                                                                                                                    
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936137 =
                                                                                                                      lm;
                                                                                                                    
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936138 =
                                                                                                                      ((1) << (((int)(t1936137))));
                                                                                                                    
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936139 =
                                                                                                                      ((2) + (((int)(t1936138))));
                                                                                                                    
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nm = t1936139;
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936140 =
                                                                                                                      ndim1;
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936141 =
                                                                                                                      ((1) << (((int)(t1936140))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936144 =
                                                                                                                      ((2) + (((int)(t1936141))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936142 =
                                                                                                                      ndim2;
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936143 =
                                                                                                                      ((1) << (((int)(t1936142))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936145 =
                                                                                                                      ((2) + (((int)(t1936143))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936148 =
                                                                                                                      ((t1936144) * (((int)(t1936145))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936146 =
                                                                                                                      ndim3;
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936147 =
                                                                                                                      ((1) << (((int)(t1936146))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936149 =
                                                                                                                      ((2) + (((int)(t1936147))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936150 =
                                                                                                                      ((t1936148) * (((int)(t1936149))));
                                                                                                                    
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nv = t1936150;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936153 =
                                                                                                                      nv;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936151 =
                                                                                                                      nm;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936152 =
                                                                                                                      nm;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936154 =
                                                                                                                      ((t1936151) * (((int)(t1936152))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936156 =
                                                                                                                      ((t1936153) + (((int)(t1936154))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936155 =
                                                                                                                      nm;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936157 =
                                                                                                                      ((5) * (((int)(t1936155))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936159 =
                                                                                                                      ((t1936156) + (((int)(t1936157))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936158 =
                                                                                                                      lm;
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936160 =
                                                                                                                      ((7) * (((int)(t1936158))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936161 =
                                                                                                                      ((t1936159) + (((int)(t1936160))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936162 =
                                                                                                                      ((8) * (((int)(t1936161))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936163 =
                                                                                                                      ((t1936162) / (((int)(7))));
                                                                                                                    
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nr = t1936163;
                                                                                                                    
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936164 =
                                                                                                                      nm;
                                                                                                                    
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936165 =
                                                                                                                      ((2) * (((int)(t1936164))));
                                                                                                                    
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936166 =
                                                                                                                      nm;
                                                                                                                    
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936167 =
                                                                                                                      ((t1936165) * (((int)(t1936166))));
                                                                                                                    
//#line 154 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nm2 = t1936167;
                                                                                                                    
//#line 158 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936168 =
                                                                                                                      nr;
                                                                                                                    
//#line 158 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936169 =
                                                                                                                      ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t1936168)),
                                                                                                                                                                                                                                                       (x10.core.Double.$box(0.0)), (x10.array.Array.__1x10$array$Array$$T) null)));
                                                                                                                    
//#line 158 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.r = ((x10.array.Array)(t1936169));
                                                                                                                    
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936170 =
                                                                                                                      nv;
                                                                                                                    
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936171 =
                                                                                                                      ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t1936170)),
                                                                                                                                                                                                                                                       (x10.core.Double.$box(0.0)), (x10.array.Array.__1x10$array$Array$$T) null)));
                                                                                                                    
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.v = ((x10.array.Array)(t1936171));
                                                                                                                    
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936172 =
                                                                                                                      nr;
                                                                                                                    
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936173 =
                                                                                                                      ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t1936172)),
                                                                                                                                                                                                                                                       (x10.core.Double.$box(0.0)), (x10.array.Array.__1x10$array$Array$$T) null)));
                                                                                                                    
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.u = ((x10.array.Array)(t1936173));
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936174 =
                                                                                                                      -8.0;
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936175 =
                                                                                                                      ((t1936174) / (((double)(3.0))));
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936176 =
                                                                                                                      ((1.0) / (((double)(6.0))));
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936177 =
                                                                                                                      ((1.0) / (((double)(12.0))));
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936178 =
                                                                                                                      ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<x10.core.Double> makeArrayFromJavaArray(x10.rtt.Types.DOUBLE, new double[] {t1936175, 0.0, t1936176, t1936177})));
                                                                                                                    
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.a = ((x10.array.Array)(t1936178));
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final char t1936179 =
                                                                                                                      CLASS;
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
boolean t1936181 =
                                                                                                                      ((char) t1936179) ==
                                                                                                                    ((char) 'A');
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936181)) {
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final char t1936180 =
                                                                                                                          CLASS;
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936181 = ((char) t1936180) ==
                                                                                                                        ((char) 'S');
                                                                                                                    }
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
boolean t1936183 =
                                                                                                                      t1936181;
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936183)) {
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final char t1936182 =
                                                                                                                          CLASS;
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936183 = ((char) t1936182) ==
                                                                                                                        ((char) 'W');
                                                                                                                    }
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936194 =
                                                                                                                      t1936183;
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
x10.array.Array t1936195 =
                                                                                                                       null;
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (t1936194) {
                                                                                                                        
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936184 =
                                                                                                                          -3.0;
                                                                                                                        
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936186 =
                                                                                                                          ((t1936184) / (((double)(8.0))));
                                                                                                                        
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936187 =
                                                                                                                          ((1.0) / (((double)(32.0))));
                                                                                                                        
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936185 =
                                                                                                                          -1.0;
                                                                                                                        
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936188 =
                                                                                                                          ((t1936185) / (((double)(64.0))));
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936195 = ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<x10.core.Double> makeArrayFromJavaArray(x10.rtt.Types.DOUBLE, new double[] {t1936186, t1936187, t1936188, 0.0})));
                                                                                                                    } else {
                                                                                                                        
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936189 =
                                                                                                                          -3.0;
                                                                                                                        
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936191 =
                                                                                                                          ((t1936189) / (((double)(17.0))));
                                                                                                                        
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936192 =
                                                                                                                          ((1.0) / (((double)(33.0))));
                                                                                                                        
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936190 =
                                                                                                                          -1.0;
                                                                                                                        
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936193 =
                                                                                                                          ((t1936190) / (((double)(61.0))));
                                                                                                                        
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936195 = ((x10.array.Array)(x10.runtime.impl.java.ArrayUtils.<x10.core.Double> makeArrayFromJavaArray(x10.rtt.Types.DOUBLE, new double[] {t1936191, t1936192, t1936193, 0.0})));
                                                                                                                    }
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936196 =
                                                                                                                      ((x10.array.Array)(t1936195));
                                                                                                                    
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.c = ((x10.array.Array)(t1936196));
                                                                                                                }
                                                                                                                return this;
                                                                                                                }
        
        
        
//#line 174 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public int num_threads;
        
        
//#line 175 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public static void
                                                                                                  checksum__0$1x10$lang$Int$2(
                                                                                                  final x10.array.Array<x10.core.Int> arr,
                                                                                                  final java.lang.String name,
                                                                                                  final boolean stop){
            
//#line 176 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
double csum =
              ((double)(int)(((int)(0))));
            {
                
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i =
                  0;
                
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                             true;
                                                                                                             ) {
                    
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936200 =
                      i;
                    
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936201 =
                      ((x10.array.Array<x10.core.Int>)arr).
                        size;
                    
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936212 =
                      ((t1936200) < (((int)(t1936201))));
                    
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936212)) {
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                    }
                    {
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936208 =
                          csum;
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936205 =
                          i;
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936206 =
                          x10.core.Int.$unbox(((x10.array.Array<x10.core.Int>)arr).$apply$G((int)(t1936205)));
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936209 =
                          ((double)(int)(((int)(t1936206))));
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936210 =
                          ((t1936208) + (((double)(t1936209))));
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
csum = t1936210;
                    }
                    {
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936202 =
                          i;
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936203 =
                          ((t1936202) + (((int)(1))));
                        
//#line 177 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i = t1936203;
                    }
                }
            }
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.io.Printer t1936216 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final java.lang.String t1936214 =
              ((name) + (" checksum MG "));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936215 =
              csum;
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final java.lang.String t1936217 =
              ((t1936214) + ((x10.core.Double.$box(t1936215))));
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936216.println(((java.lang.Object)(t1936217)));
            
//#line 179 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (stop) {
                
//#line 179 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IllegalOperationException t1936218 =
                  ((x10.lang.IllegalOperationException)(new x10.lang.IllegalOperationException()));
                
//#line 179 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
throw t1936218;
            }
        }
        
        
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public static double
                                                                                                  dmax1$O(
                                                                                                  final double a,
                                                                                                  final double b){
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936219 =
              ((a) < (((double)(b))));
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
double t1936220 =
               0;
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (t1936219) {
                
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936220 = b;
            } else {
                
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
t1936220 = a;
            }
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936221 =
              t1936220;
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
return t1936221;
        }
        
        
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
public static void
                                                                                                  comm3__0$1x10$lang$Double$2(
                                                                                                  final x10.array.Array<x10.core.Double> u,
                                                                                                  final int off,
                                                                                                  final int n1,
                                                                                                  final int n2,
                                                                                                  final int n3){
            {
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936222 =
                  ((n3) - (((int)(2))));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936225 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(1)), ((int)(t1936222)))));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936224 =
                  ((n2) - (((int)(2))));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936226 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(1)), ((int)(t1936224)))));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Region p1935908 =
                  ((x10.array.Region)(t1936225.$times(((x10.lang.IntRange)(t1936226)))));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i21935909min1935910 =
                  p1935908.min$O((int)(1));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i21935909max1935911 =
                  p1935908.max$O((int)(1));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i31935943min1935944 =
                  p1935908.min$O((int)(0));
                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i31935943max1935945 =
                  p1935908.max$O((int)(0));
                {
                    
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i31935943 =
                      i31935943min1935944;
                    
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                 true;
                                                                                                                 ) {
                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936228 =
                          i31935943;
                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936259 =
                          ((t1936228) <= (((int)(i31935943max1935945))));
                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936259)) {
                            
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                        }
                        {
                            
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i3 =
                              i31935943;
                            {
                                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i21935909 =
                                  i21935909min1935910;
                                
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                             true;
                                                                                                                             ) {
                                    
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936232 =
                                      i21935909;
                                    
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936258 =
                                      ((t1936232) <= (((int)(i21935909max1935911))));
                                    
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936258)) {
                                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                    }
                                    {
                                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i2 =
                                          i21935909;
                                        {
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936235 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936236 =
                                              ((i2) + (((int)(t1936235))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936237 =
                                              ((n1) * (((int)(t1936236))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936244 =
                                              ((off) + (((int)(t1936237))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936238 =
                                              ((off) + (((int)(n1))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936241 =
                                              ((t1936238) - (((int)(2))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936239 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936240 =
                                              ((i2) + (((int)(t1936239))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936242 =
                                              ((n1) * (((int)(t1936240))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936243 =
                                              ((t1936241) + (((int)(t1936242))));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936245 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936243)));
                                            
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936244),
                                                                                                                                                                                                      x10.core.Double.$box(t1936245));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936246 =
                                              ((off) + (((int)(n1))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936249 =
                                              ((t1936246) - (((int)(1))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936247 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936248 =
                                              ((i2) + (((int)(t1936247))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936250 =
                                              ((n1) * (((int)(t1936248))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936256 =
                                              ((t1936249) + (((int)(t1936250))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936253 =
                                              ((off) + (((int)(1))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936251 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936252 =
                                              ((i2) + (((int)(t1936251))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936254 =
                                              ((n1) * (((int)(t1936252))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936255 =
                                              ((t1936253) + (((int)(t1936254))));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936257 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936255)));
                                            
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936256),
                                                                                                                                                                                                      x10.core.Double.$box(t1936257));
                                        }
                                    }
                                    {
                                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936233 =
                                          i21935909;
                                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936234 =
                                          ((t1936233) + (((int)(1))));
                                        
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i21935909 = t1936234;
                                    }
                                }
                            }
                        }
                        {
                            
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936229 =
                              i31935943;
                            
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936230 =
                              ((t1936229) + (((int)(1))));
                            
//#line 189 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i31935943 = t1936230;
                        }
                    }
                }
            }
            {
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936261 =
                  ((n3) - (((int)(2))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936264 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(1)), ((int)(t1936261)))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936262 =
                  ((n1) - (((int)(1))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936265 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(0)), ((int)(t1936262)))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Region p1935962 =
                  ((x10.array.Region)(t1936264.$times(((x10.lang.IntRange)(t1936265)))));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i11935963min1935964 =
                  p1935962.min$O((int)(1));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i11935963max1935965 =
                  p1935962.max$O((int)(1));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i31935986min1935987 =
                  p1935962.min$O((int)(0));
                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i31935986max1935988 =
                  p1935962.max$O((int)(0));
                {
                    
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i31935986 =
                      i31935986min1935987;
                    
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                 true;
                                                                                                                 ) {
                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936268 =
                          i31935986;
                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936303 =
                          ((t1936268) <= (((int)(i31935986max1935988))));
                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936303)) {
                            
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                        }
                        {
                            
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i3 =
                              i31935986;
                            {
                                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i11935963 =
                                  i11935963min1935964;
                                
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                             true;
                                                                                                                             ) {
                                    
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936274 =
                                      i11935963;
                                    
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936302 =
                                      ((t1936274) <= (((int)(i11935963max1935965))));
                                    
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936302)) {
                                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                    }
                                    {
                                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i1 =
                                          i11935963;
                                        {
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936279 =
                                              ((off) + (((int)(i1))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936278 =
                                              ((n1) * (((int)(n2))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936280 =
                                              ((t1936278) * (((int)(i3))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936287 =
                                              ((t1936279) + (((int)(t1936280))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936284 =
                                              ((off) + (((int)(i1))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936281 =
                                              ((n2) - (((int)(2))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936282 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936283 =
                                              ((t1936281) + (((int)(t1936282))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936285 =
                                              ((n1) * (((int)(t1936283))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936286 =
                                              ((t1936284) + (((int)(t1936285))));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936288 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936286)));
                                            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936287),
                                                                                                                                                                                                      x10.core.Double.$box(t1936288));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936293 =
                                              ((off) + (((int)(i1))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936290 =
                                              ((n2) - (((int)(1))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936291 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936292 =
                                              ((t1936290) + (((int)(t1936291))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936294 =
                                              ((n1) * (((int)(t1936292))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936300 =
                                              ((t1936293) + (((int)(t1936294))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936297 =
                                              ((off) + (((int)(i1))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936295 =
                                              ((n2) * (((int)(i3))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936296 =
                                              ((1) + (((int)(t1936295))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936298 =
                                              ((n1) * (((int)(t1936296))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936299 =
                                              ((t1936297) + (((int)(t1936298))));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936301 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936299)));
                                            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936300),
                                                                                                                                                                                                      x10.core.Double.$box(t1936301));
                                        }
                                    }
                                    {
                                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936276 =
                                          i11935963;
                                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936277 =
                                          ((t1936276) + (((int)(1))));
                                        
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i11935963 = t1936277;
                                    }
                                }
                            }
                        }
                        {
                            
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936270 =
                              i31935986;
                            
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936271 =
                              ((t1936270) + (((int)(1))));
                            
//#line 194 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i31935986 = t1936271;
                        }
                    }
                }
            }
            {
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936304 =
                  ((n2) - (((int)(1))));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936306 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(0)), ((int)(t1936304)))));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936305 =
                  ((n1) - (((int)(1))));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.lang.IntRange t1936307 =
                  ((x10.lang.IntRange)(new x10.lang.IntRange((java.lang.System[]) null).x10$lang$IntRange$$init$S(((int)(0)), ((int)(t1936305)))));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Region p1936014 =
                  ((x10.array.Region)(t1936306.$times(((x10.lang.IntRange)(t1936307)))));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i11936015min1936016 =
                  p1936014.min$O((int)(1));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i11936015max1936017 =
                  p1936014.max$O((int)(1));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i21936036min1936037 =
                  p1936014.min$O((int)(0));
                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i21936036max1936038 =
                  p1936014.max$O((int)(0));
                {
                    
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i21936036 =
                      i21936036min1936037;
                    
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                 true;
                                                                                                                 ) {
                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936309 =
                          i21936036;
                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936344 =
                          ((t1936309) <= (((int)(i21936036max1936038))));
                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936344)) {
                            
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                        }
                        {
                            
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i2 =
                              i21936036;
                            {
                                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
int i11936015 =
                                  i11936015min1936016;
                                
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
for (;
                                                                                                                             true;
                                                                                                                             ) {
                                    
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936313 =
                                      i11936015;
                                    
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final boolean t1936343 =
                                      ((t1936313) <= (((int)(i11936015max1936017))));
                                    
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
if (!(t1936343)) {
                                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
break;
                                    }
                                    {
                                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int i1 =
                                          i11936015;
                                        {
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936316 =
                                              ((off) + (((int)(i1))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936317 =
                                              ((n1) * (((int)(i2))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936324 =
                                              ((t1936316) + (((int)(t1936317))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936321 =
                                              ((off) + (((int)(i1))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936318 =
                                              ((n3) - (((int)(2))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936319 =
                                              ((n2) * (((int)(t1936318))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936320 =
                                              ((i2) + (((int)(t1936319))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936322 =
                                              ((n1) * (((int)(t1936320))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936323 =
                                              ((t1936321) + (((int)(t1936322))));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936325 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936323)));
                                            
//#line 200 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936324),
                                                                                                                                                                                                      x10.core.Double.$box(t1936325));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936330 =
                                              ((off) + (((int)(i1))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936326 =
                                              ((n3) - (((int)(1))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936327 =
                                              ((n2) * (((int)(t1936326))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936328 =
                                              ((i2) + (((int)(t1936327))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936331 =
                                              ((n1) * (((int)(t1936328))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936337 =
                                              ((t1936330) + (((int)(t1936331))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936333 =
                                              ((off) + (((int)(i1))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936332 =
                                              ((i2) + (((int)(n2))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936335 =
                                              ((n1) * (((int)(t1936332))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936336 =
                                              ((t1936333) + (((int)(t1936335))));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final double t1936338 =
                                              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)u).$apply$G((int)(t1936336)));
                                            
//#line 201 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
((x10.array.Array<x10.core.Double>)u).$set__1x10$array$Array$$T$G((int)(t1936337),
                                                                                                                                                                                                      x10.core.Double.$box(t1936338));
                                        }
                                    }
                                    {
                                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936314 =
                                          i11936015;
                                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936315 =
                                          ((t1936314) + (((int)(1))));
                                        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i11936015 = t1936315;
                                    }
                                }
                            }
                        }
                        {
                            
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936310 =
                              i21936036;
                            
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936311 =
                              ((t1936310) + (((int)(1))));
                            
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
i21936036 = t1936311;
                        }
                    }
                }
            }
        }
        
        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public NPB3_0_X10.MGThreads.MGBase
                                                                                                 NPB3_0_X10$MGThreads$MGBase$$this$NPB3_0_X10$MGThreads$MGBase(
                                                                                                 ){
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
return NPB3_0_X10.MGThreads.MGBase.this;
        }
        
        
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final public void
                                                                                                 __fieldInitializers1934421(
                                                                                                 ){
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nit = 0;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final NPB3_0_X10.Timer t1936346 =
              ((NPB3_0_X10.Timer)(new NPB3_0_X10.Timer((java.lang.System[]) null).NPB3_0_X10$Timer$$init$S()));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.timer = t1936346;
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936347 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936348 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936347)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nx = ((x10.array.Array)(t1936348));
            
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936349 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936350 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936349)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ny = ((x10.array.Array)(t1936350));
            
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936351 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936352 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936351)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.nz = ((x10.array.Array)(t1936352));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936353 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936354 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936353)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.ir = ((x10.array.Array)(t1936354));
            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936355 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936356 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936355)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.m1 = ((x10.array.Array)(t1936356));
            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936357 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936358 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936357)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.m2 = ((x10.array.Array)(t1936358));
            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final int t1936359 =
              NPB3_0_X10.MGThreads.MGBase.maxlevel;
            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
final x10.array.Array t1936360 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$array$Array$$init$S(((int)(t1936359)))));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.m3 = ((x10.array.Array)(t1936360));
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lt = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.lb = 0;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.timeron = false;
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.CLASS = '\000';
            
//#line 56 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/MGThreads/MGBase.x10"
this.num_threads = 0;
        }
    
}

