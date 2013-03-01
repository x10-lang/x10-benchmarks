package NPB3_0_X10;

@x10.runtime.impl.java.X10Generated public class Random extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Random> $RTT = x10.rtt.NamedType.<Random> make(
    "NPB3_0_X10.Random", /* base class */Random.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.Random $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Random.class + " calling"); } 
        $_obj.tran = $deserializer.readDouble();
        $_obj.amult = $deserializer.readDouble();
        $_obj.KS = $deserializer.readInt();
        $_obj.R23 = $deserializer.readDouble();
        $_obj.R46 = $deserializer.readDouble();
        $_obj.T23 = $deserializer.readDouble();
        $_obj.T46 = $deserializer.readDouble();
        $_obj.seed = $deserializer.readDouble();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        Random $_obj = new Random((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        $serializer.write(this.tran);
        $serializer.write(this.amult);
        $serializer.write(this.KS);
        $serializer.write(this.R23);
        $serializer.write(this.R46);
        $serializer.write(this.T23);
        $serializer.write(this.T46);
        $serializer.write(this.seed);
        
    }
    
    // constructor just for allocation
    public Random(final java.lang.System[] $dummy) { 
    }
    
        
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double tran;
        
//#line 57 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double amult;
        
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public int KS;
        
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double R23;
        
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double R46;
        
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double T23;
        
//#line 62 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double T46;
        
//#line 64 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
private static double d2m46 = 0.0;
        
//#line 65 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
private static long i246m1 = 0L;
        
        
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
// creation method for java code (1-phase java constructor)
        public Random(){this((java.lang.System[]) null);
                            NPB3_0_X10$Random$$init$S();}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.Random NPB3_0_X10$Random$$init$S() { {
                                                                            
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
;
                                                                            {
                                                                                {
                                                                                    
//#line 67 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"

                                                                                }
                                                                                
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.__fieldInitializers386186();
                                                                            }
                                                                        }
                                                                        return this;
                                                                        }
        
        
        
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
// creation method for java code (1-phase java constructor)
        public Random(double sd){this((java.lang.System[]) null);
                                     NPB3_0_X10$Random$$init$S(sd);}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.Random NPB3_0_X10$Random$$init$S(double sd) { {
                                                                                     
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
;
                                                                                     {
                                                                                         {
                                                                                             
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"

                                                                                         }
                                                                                         
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.__fieldInitializers386186();
                                                                                     }
                                                                                     
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386482 =
                                                                                       sd;
                                                                                     
//#line 68 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386482;
                                                                                 }
                                                                                 return this;
                                                                                 }
        
        
        
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double
                                                                                       randlc$O(
                                                                                       double x,
                                                                                       double a){
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x10.array.Array y =
               null;
            
//#line 73 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double r23 =
               0;
            
//#line 74 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double r46 =
               0;
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t23 =
               0;
            
//#line 76 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t46 =
               0;
            
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t1 =
               0;
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t2 =
               0;
            
//#line 79 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t3 =
               0;
            
//#line 80 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t4 =
               0;
            
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double a1 =
               0;
            
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double a2 =
               0;
            
//#line 83 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double x1 =
               0;
            
//#line 84 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double x2 =
               0;
            
//#line 85 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double z =
               0;
            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386483 =
              ((double)(int)(((int)(23))));
            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386484 =
              java.lang.Math.pow(((double)(0.5)), ((double)(t386483)));
            
//#line 86 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r23 = t386484;
            
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386485 =
              r23;
            
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386486 =
              ((double)(int)(((int)(2))));
            
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386487 =
              java.lang.Math.pow(((double)(t386485)), ((double)(t386486)));
            
//#line 87 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r46 = t386487;
            
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386488 =
              ((double)(int)(((int)(23))));
            
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386489 =
              java.lang.Math.pow(((double)(2.0)), ((double)(t386488)));
            
//#line 88 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t23 = t386489;
            
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386490 =
              t23;
            
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386491 =
              ((double)(int)(((int)(2))));
            
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386492 =
              java.lang.Math.pow(((double)(t386490)), ((double)(t386491)));
            
//#line 89 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t46 = t386492;
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386493 =
              r23;
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386494 =
              a;
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386495 =
              ((t386493) * (((double)(t386494))));
            
//#line 93 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386495;
            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386496 =
              t1;
            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386497 =
              ((int)(double)(((double)(t386496))));
            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386498 =
              ((double)(int)(((int)(t386497))));
            
//#line 94 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
a1 = t386498;
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386501 =
              a;
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386499 =
              t23;
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386500 =
              a1;
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386502 =
              ((t386499) * (((double)(t386500))));
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386503 =
              ((t386501) - (((double)(t386502))));
            
//#line 95 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
a2 = t386503;
            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386504 =
              r23;
            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386505 =
              x;
            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386506 =
              ((t386504) * (((double)(t386505))));
            
//#line 101 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386506;
            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386507 =
              t1;
            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386508 =
              ((int)(double)(((double)(t386507))));
            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386509 =
              ((double)(int)(((int)(t386508))));
            
//#line 102 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x1 = t386509;
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386512 =
              x;
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386510 =
              t23;
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386511 =
              x1;
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386513 =
              ((t386510) * (((double)(t386511))));
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386514 =
              ((t386512) - (((double)(t386513))));
            
//#line 103 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x2 = t386514;
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386515 =
              a1;
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386516 =
              x2;
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386519 =
              ((t386515) * (((double)(t386516))));
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386517 =
              a2;
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386518 =
              x1;
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386520 =
              ((t386517) * (((double)(t386518))));
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386521 =
              ((t386519) + (((double)(t386520))));
            
//#line 104 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386521;
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386522 =
              r23;
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386523 =
              t1;
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386524 =
              ((t386522) * (((double)(t386523))));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386525 =
              ((int)(double)(((double)(t386524))));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386526 =
              ((double)(int)(((int)(t386525))));
            
//#line 105 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t2 = t386526;
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386529 =
              t1;
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386527 =
              t23;
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386528 =
              t2;
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386530 =
              ((t386527) * (((double)(t386528))));
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386531 =
              ((t386529) - (((double)(t386530))));
            
//#line 106 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
z = t386531;
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386532 =
              t23;
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386533 =
              z;
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386536 =
              ((t386532) * (((double)(t386533))));
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386534 =
              a2;
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386535 =
              x2;
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386537 =
              ((t386534) * (((double)(t386535))));
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386538 =
              ((t386536) + (((double)(t386537))));
            
//#line 107 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t3 = t386538;
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386539 =
              r46;
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386540 =
              t3;
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386541 =
              ((t386539) * (((double)(t386540))));
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386542 =
              ((int)(double)(((double)(t386541))));
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386543 =
              ((double)(int)(((int)(t386542))));
            
//#line 108 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t4 = t386543;
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386546 =
              t3;
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386544 =
              t46;
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386545 =
              t4;
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386547 =
              ((t386544) * (((double)(t386545))));
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386548 =
              ((t386546) - (((double)(t386547))));
            
//#line 109 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x = t386548;
            
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386549 =
              x;
            
//#line 110 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386549;
        }
        
        
//#line 114 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double
                                                                                        randlc$O(
                                                                                        double a){
            
//#line 115 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x10.array.Array y =
               null;
            
//#line 116 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double r23 =
               0;
            
//#line 117 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double r46 =
               0;
            
//#line 118 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t23 =
               0;
            
//#line 119 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t46 =
               0;
            
//#line 120 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t1 =
               0;
            
//#line 121 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t2 =
               0;
            
//#line 122 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t3 =
               0;
            
//#line 123 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double t4 =
               0;
            
//#line 124 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double a1 =
               0;
            
//#line 125 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double a2 =
               0;
            
//#line 126 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double x1 =
               0;
            
//#line 127 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double x2 =
               0;
            
//#line 128 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double z =
               0;
            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386550 =
              ((double)(int)(((int)(23))));
            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386551 =
              java.lang.Math.pow(((double)(0.5)), ((double)(t386550)));
            
//#line 129 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r23 = t386551;
            
//#line 130 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386552 =
              r23;
            
//#line 130 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386553 =
              ((double)(int)(((int)(2))));
            
//#line 130 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386554 =
              java.lang.Math.pow(((double)(t386552)), ((double)(t386553)));
            
//#line 130 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r46 = t386554;
            
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386555 =
              ((double)(int)(((int)(23))));
            
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386556 =
              java.lang.Math.pow(((double)(2.0)), ((double)(t386555)));
            
//#line 131 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t23 = t386556;
            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386557 =
              t23;
            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386558 =
              ((double)(int)(((int)(2))));
            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386559 =
              java.lang.Math.pow(((double)(t386557)), ((double)(t386558)));
            
//#line 132 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t46 = t386559;
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386560 =
              r23;
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386561 =
              a;
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386562 =
              ((t386560) * (((double)(t386561))));
            
//#line 136 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386562;
            
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386563 =
              t1;
            
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386564 =
              ((int)(double)(((double)(t386563))));
            
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386565 =
              ((double)(int)(((int)(t386564))));
            
//#line 137 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
a1 = t386565;
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386568 =
              a;
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386566 =
              t23;
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386567 =
              a1;
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386569 =
              ((t386566) * (((double)(t386567))));
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386570 =
              ((t386568) - (((double)(t386569))));
            
//#line 138 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
a2 = t386570;
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386571 =
              r23;
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386572 =
              tran;
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386573 =
              ((t386571) * (((double)(t386572))));
            
//#line 144 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386573;
            
//#line 145 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386574 =
              t1;
            
//#line 145 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386575 =
              ((int)(double)(((double)(t386574))));
            
//#line 145 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386576 =
              ((double)(int)(((int)(t386575))));
            
//#line 145 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x1 = t386576;
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386579 =
              tran;
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386577 =
              t23;
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386578 =
              x1;
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386580 =
              ((t386577) * (((double)(t386578))));
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386581 =
              ((t386579) - (((double)(t386580))));
            
//#line 146 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
x2 = t386581;
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386582 =
              a1;
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386583 =
              x2;
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386586 =
              ((t386582) * (((double)(t386583))));
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386584 =
              a2;
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386585 =
              x1;
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386587 =
              ((t386584) * (((double)(t386585))));
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386588 =
              ((t386586) + (((double)(t386587))));
            
//#line 147 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t1 = t386588;
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386589 =
              r23;
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386590 =
              t1;
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386591 =
              ((t386589) * (((double)(t386590))));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386592 =
              ((int)(double)(((double)(t386591))));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386593 =
              ((double)(int)(((int)(t386592))));
            
//#line 148 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t2 = t386593;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386596 =
              t1;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386594 =
              t23;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386595 =
              t2;
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386597 =
              ((t386594) * (((double)(t386595))));
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386598 =
              ((t386596) - (((double)(t386597))));
            
//#line 149 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
z = t386598;
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386599 =
              t23;
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386600 =
              z;
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386603 =
              ((t386599) * (((double)(t386600))));
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386601 =
              a2;
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386602 =
              x2;
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386604 =
              ((t386601) * (((double)(t386602))));
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386605 =
              ((t386603) + (((double)(t386604))));
            
//#line 150 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t3 = t386605;
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386606 =
              r46;
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386607 =
              t3;
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386608 =
              ((t386606) * (((double)(t386607))));
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386609 =
              ((int)(double)(((double)(t386608))));
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386610 =
              ((double)(int)(((int)(t386609))));
            
//#line 151 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
t4 = t386610;
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386613 =
              t3;
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386611 =
              t46;
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386612 =
              t4;
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386614 =
              ((t386611) * (((double)(t386612))));
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386615 =
              ((t386613) - (((double)(t386614))));
            
//#line 152 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.tran = t386615;
            
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386616 =
              r46;
            
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386617 =
              tran;
            
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386618 =
              ((t386616) * (((double)(t386617))));
            
//#line 153 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386618;
        }
        
        
//#line 156 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double
                                                                                        vranlc__3$1x10$lang$Double$2$O(
                                                                                        double n,
                                                                                        double x,
                                                                                        double a,
                                                                                        x10.array.Array y,
                                                                                        final int offset){
            
//#line 157 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386619 =
              x;
            
//#line 157 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
long Lx =
              ((long)(double)(((double)(t386619))));
            
//#line 158 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386620 =
              a;
            
//#line 158 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
long La =
              ((long)(double)(((double)(t386620))));
            {
                
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
int i =
                  0;
                
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
for (;
                                                                                                   true;
                                                                                                   ) {
                    
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386622 =
                      i;
                    
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386623 =
                      ((double)(int)(((int)(t386622))));
                    
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386624 =
                      n;
                    
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386640 =
                      ((t386623) < (((double)(t386624))));
                    
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (!(t386640)) {
                        
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
break;
                    }
                    {
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386627 =
                          Lx;
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386628 =
                          La;
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386629 =
                          ((t386627) * (((long)(t386628))));
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386630 =
                          NPB3_0_X10.Random.get$i246m1();
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386631 =
                          ((t386629) & (((long)(t386630))));
                        
//#line 161 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
Lx = t386631;
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final x10.array.Array t386637 =
                          ((x10.array.Array)(y));
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386632 =
                          i;
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386638 =
                          ((offset) + (((int)(t386632))));
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386634 =
                          NPB3_0_X10.Random.get$d2m46();
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386633 =
                          Lx;
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386635 =
                          ((double)(long)(((long)(t386633))));
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386636 =
                          ((t386634) * (((double)(t386635))));
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386639 =
                          t386636;
                        
//#line 162 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
((x10.array.Array<x10.core.Double>)t386637).$set__1x10$array$Array$$T$G((int)(t386638),
                                                                                                                                                                              x10.core.Double.$box(t386639));
                    }
                    {
                        
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386625 =
                          i;
                        
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386626 =
                          ((t386625) + (((int)(1))));
                        
//#line 160 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
i = t386626;
                    }
                }
            }
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final long t386641 =
              Lx;
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386642 =
              ((double)(long)(((long)(t386641))));
            
//#line 164 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386642;
        }
        
        
//#line 167 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double seed;
        
        
//#line 168 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double
                                                                                        ipow46$O(
                                                                                        final double a,
                                                                                        final int exponent){
            
//#line 169 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
int n =
               0;
            
//#line 170 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
int n2 =
               0;
            
//#line 171 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double q =
               0;
            
//#line 172 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double r =
               0;
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386644 =
              ((int) exponent) ==
            ((int) 0);
            
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (t386644) {
                
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386643 =
                  seed;
                
//#line 178 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386643;
            }
            
//#line 179 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
q = a;
            
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386645 =
              ((double)(int)(((int)(1))));
            
//#line 180 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r = t386645;
            
//#line 181 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
n = exponent;
            
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
while (true) {
                
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386646 =
                  n;
                
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386664 =
                  ((t386646) > (((int)(1))));
                
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (!(t386664)) {
                    
//#line 183 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
break;
                }
                {
                    
//#line 184 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386647 =
                      n;
                    
//#line 184 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386648 =
                      ((t386647) / (((int)(2))));
                    
//#line 184 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
n2 = t386648;
                    
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386649 =
                      n2;
                    
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386650 =
                      ((t386649) * (((int)(2))));
                    
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386651 =
                      n;
                    
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386663 =
                      ((int) t386650) ==
                    ((int) t386651);
                    
//#line 185 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (t386663) {
                        
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386652 =
                          q;
                        
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386653 =
                          q;
                        
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386654 =
                          this.randlc$O((double)(t386652),
                                        (double)(t386653));
                        
//#line 186 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386654;
                        
//#line 187 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386655 =
                          seed;
                        
//#line 187 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
q = t386655;
                        
//#line 188 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386656 =
                          n2;
                        
//#line 188 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
n = t386656;
                    } else {
                        
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386657 =
                          r;
                        
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386658 =
                          q;
                        
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386659 =
                          this.randlc$O((double)(t386657),
                                        (double)(t386658));
                        
//#line 190 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386659;
                        
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386660 =
                          seed;
                        
//#line 191 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
r = t386660;
                        
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386661 =
                          n;
                        
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386662 =
                          ((t386661) - (((int)(1))));
                        
//#line 192 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
n = t386662;
                    }
                }
            }
            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386665 =
              r;
            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386666 =
              q;
            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386667 =
              this.randlc$O((double)(t386665),
                            (double)(t386666));
            
//#line 195 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386667;
            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386668 =
              seed;
            
//#line 196 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386668;
        }
        
        
//#line 199 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
public double
                                                                                        power$O(
                                                                                        final double a,
                                                                                        final int n){
            
//#line 204 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double aj =
              a;
            
//#line 205 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double ajj =
               0;
            
//#line 206 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
double pow =
              1.0;
            
//#line 207 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
int nj =
              n;
            
//#line 209 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
while (true) {
                
//#line 209 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386669 =
                  nj;
                
//#line 209 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386684 =
                  ((int) t386669) !=
                ((int) 0);
                
//#line 209 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (!(t386684)) {
                    
//#line 209 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
break;
                }
                {
                    
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386670 =
                      nj;
                    
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386671 =
                      ((t386670) % (((int)(2))));
                    
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final boolean t386676 =
                      ((int) t386671) ==
                    ((int) 1);
                    
//#line 210 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
if (t386676) {
                        
//#line 211 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386672 =
                          pow;
                        
//#line 211 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386673 =
                          aj;
                        
//#line 211 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386674 =
                          this.randlc$O((double)(t386672),
                                        (double)(t386673));
                        
//#line 211 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386674;
                        
//#line 212 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386675 =
                          seed;
                        
//#line 212 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
pow = t386675;
                    }
                    
//#line 214 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386677 =
                      aj;
                    
//#line 214 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
ajj = t386677;
                    
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386678 =
                      aj;
                    
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386679 =
                      ajj;
                    
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386680 =
                      this.randlc$O((double)(t386678),
                                    (double)(t386679));
                    
//#line 215 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = t386680;
                    
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386681 =
                      seed;
                    
//#line 216 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
aj = t386681;
                    
//#line 217 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386682 =
                      nj;
                    
//#line 217 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final int t386683 =
                      ((t386682) / (((int)(2))));
                    
//#line 217 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
nj = t386683;
                }
            }
            
//#line 219 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final double t386685 =
              pow;
            
//#line 219 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return t386685;
        }
        
        
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final public NPB3_0_X10.Random
                                                                                       NPB3_0_X10$Random$$this$NPB3_0_X10$Random(
                                                                                       ){
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
return NPB3_0_X10.Random.this;
        }
        
        
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
final public void
                                                                                       __fieldInitializers386186(
                                                                                       ){
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.tran = 3.14159265E8;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.amult = 1.220703125E9;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.KS = 0;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.R23 = 0.0;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.R46 = 0.0;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.T23 = 0.0;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.T46 = 0.0;
            
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Random.x10"
this.seed = 0.0;
        }
        
        private static short fieldId$i246m1;
        final private static x10.core.concurrent.AtomicInteger initStatus$i246m1 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$i246m1;
        private static short fieldId$d2m46;
        final private static x10.core.concurrent.AtomicInteger initStatus$d2m46 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$d2m46;
        
        public static double
          get$d2m46(
          ){
            if (((int) NPB3_0_X10.Random.initStatus$d2m46.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return NPB3_0_X10.Random.d2m46;
            }
            if (((int) NPB3_0_X10.Random.initStatus$d2m46.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.Random.d2m46")));
                }
                throw NPB3_0_X10.Random.exception$d2m46;
            }
            if (NPB3_0_X10.Random.initStatus$d2m46.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    NPB3_0_X10.Random.d2m46 = java.lang.Math.pow(((double)(0.5)), ((double)(((double)(int)(((int)(46)))))));
                }}catch (java.lang.Throwable exc$386686) {
                    NPB3_0_X10.Random.exception$d2m46 = new x10.lang.ExceptionInInitializer(((java.lang.RuntimeException)(exc$386686)));
                    NPB3_0_X10.Random.initStatus$d2m46.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw NPB3_0_X10.Random.exception$d2m46;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: NPB3_0_X10.Random.d2m46")));
                }
                NPB3_0_X10.Random.initStatus$d2m46.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (NPB3_0_X10.Random.initStatus$d2m46.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (NPB3_0_X10.Random.initStatus$d2m46.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) NPB3_0_X10.Random.initStatus$d2m46.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.Random.d2m46")));
                        }
                        throw NPB3_0_X10.Random.exception$d2m46;
                    }
                }
            }
            return NPB3_0_X10.Random.d2m46;
        }
        
        public static long
          get$i246m1(
          ){
            if (((int) NPB3_0_X10.Random.initStatus$i246m1.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return NPB3_0_X10.Random.i246m1;
            }
            if (((int) NPB3_0_X10.Random.initStatus$i246m1.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.Random.i246m1")));
                }
                throw NPB3_0_X10.Random.exception$i246m1;
            }
            if (NPB3_0_X10.Random.initStatus$i246m1.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                  (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    NPB3_0_X10.Random.i246m1 = ((long)(double)(((double)(((java.lang.Math.pow(((double)(((double)(int)(((int)(2)))))), ((double)(((double)(int)(((int)(46)))))))) - (((double)(((double)(int)(((int)(1))))))))))));
                }}catch (java.lang.Throwable exc$386687) {
                    NPB3_0_X10.Random.exception$i246m1 = new x10.lang.ExceptionInInitializer(((java.lang.RuntimeException)(exc$386687)));
                    NPB3_0_X10.Random.initStatus$i246m1.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw NPB3_0_X10.Random.exception$i246m1;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: NPB3_0_X10.Random.i246m1")));
                }
                NPB3_0_X10.Random.initStatus$i246m1.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (NPB3_0_X10.Random.initStatus$i246m1.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (NPB3_0_X10.Random.initStatus$i246m1.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) NPB3_0_X10.Random.initStatus$i246m1.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: NPB3_0_X10.Random.i246m1")));
                        }
                        throw NPB3_0_X10.Random.exception$i246m1;
                    }
                }
            }
            return NPB3_0_X10.Random.i246m1;
        }
    
}

