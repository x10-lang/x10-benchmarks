package NPB3_0_X10;

@x10.runtime.impl.java.X10Generated public class Timer extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Timer> $RTT = x10.rtt.NamedType.<Timer> make(
    "NPB3_0_X10.Timer", /* base class */Timer.class
    
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(NPB3_0_X10.Timer $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Timer.class + " calling"); } 
        $_obj.start_time = $deserializer.readRef();
        $_obj.elapsed_time = $deserializer.readRef();
        $_obj.total_time = $deserializer.readRef();
        return $_obj;
        
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        Timer $_obj = new Timer((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        if (start_time instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.start_time);
        } else {
        $serializer.write(this.start_time);
        }
        if (elapsed_time instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.elapsed_time);
        } else {
        $serializer.write(this.elapsed_time);
        }
        if (total_time instanceof x10.serialization.X10JavaSerializable) {
        $serializer.write((x10.serialization.X10JavaSerializable) this.total_time);
        } else {
        $serializer.write(this.total_time);
        }
        
    }
    
    // constructor just for allocation
    public Timer(final java.lang.System[] $dummy) { 
    }
    
        
//#line 52 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final public static int max_counters = 64;
        
//#line 53 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public x10.array.Array<x10.core.Double> start_time;
        
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public x10.array.Array<x10.core.Double> elapsed_time;
        
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public x10.array.Array<x10.core.Double> total_time;
        
        
//#line 57 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public void
                                                                                      Timer(
                                                                                      ){
            
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
int i =
              0;
            
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
for (;
                                                                                             true;
                                                                                             ) {
                
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394465 =
                  i;
                
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394466 =
                  NPB3_0_X10.Timer.max_counters;
                
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final boolean t394478 =
                  ((t394465) < (((int)(t394466))));
                
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
if (!(t394478)) {
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
break;
                }
                {
                    
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394469 =
                      ((x10.array.Array)(start_time));
                    
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394470 =
                      i;
                    
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394471 =
                      ((double)(int)(((int)(0))));
                    
//#line 59 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394469).$set__1x10$array$Array$$T$G((int)(t394470),
                                                                                                                                                                        x10.core.Double.$box(t394471));
                    
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394472 =
                      ((x10.array.Array)(elapsed_time));
                    
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394473 =
                      i;
                    
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394474 =
                      ((double)(int)(((int)(0))));
                    
//#line 60 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394472).$set__1x10$array$Array$$T$G((int)(t394473),
                                                                                                                                                                        x10.core.Double.$box(t394474));
                    
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394475 =
                      ((x10.array.Array)(total_time));
                    
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394476 =
                      i;
                    
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394477 =
                      ((double)(int)(((int)(0))));
                    
//#line 61 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394475).$set__1x10$array$Array$$T$G((int)(t394476),
                                                                                                                                                                        x10.core.Double.$box(t394477));
                }
                {
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394467 =
                      i;
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394468 =
                      ((t394467) + (((int)(1))));
                    
//#line 58 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
i = t394468;
                }
            }
        }
        
        
//#line 65 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public void
                                                                                      start(
                                                                                      final int n){
            
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394480 =
              ((x10.array.Array)(start_time));
            
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final long t394479 =
              x10.lang.System.currentTimeMillis$O();
            
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394481 =
              ((double)(long)(((long)(t394479))));
            
//#line 66 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394480).$set__1x10$array$Array$$T$G((int)(n),
                                                                                                                                                                x10.core.Double.$box(t394481));
        }
        
        
//#line 69 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public void
                                                                                      stop(
                                                                                      final int n){
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394486 =
              ((x10.array.Array)(elapsed_time));
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final long t394482 =
              x10.lang.System.currentTimeMillis$O();
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394484 =
              ((double)(long)(((long)(t394482))));
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394483 =
              ((x10.array.Array)(start_time));
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394485 =
              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t394483).$apply$G((int)(n)));
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394487 =
              ((t394484) - (((double)(t394485))));
            
//#line 70 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394486).$set__1x10$array$Array$$T$G((int)(n),
                                                                                                                                                                x10.core.Double.$box(t394487));
            
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array x394452 =
              ((x10.array.Array)(elapsed_time));
            
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int y394453 =
              n;
            
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double z394454 =
              ((double)(int)(((int)(1000))));
            
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
double ret394456 =
               0;
            {
                
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394488 =
                  x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)x394452).$apply$G((int)(y394453)));
                
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double r394455 =
                  ((t394488) / (((double)(z394454))));
                
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)x394452).$set__1x10$array$Array$$T$G((int)(y394453),
                                                                                                                                                                    x10.core.Double.$box(r394455));
                
//#line 71 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
ret394456 = r394455;
            }
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array x394458 =
              ((x10.array.Array)(total_time));
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int y394459 =
              n;
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394489 =
              ((x10.array.Array)(elapsed_time));
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double z394460 =
              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t394489).$apply$G((int)(n)));
            
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
double ret394462 =
               0;
            {
                
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394490 =
                  x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)x394458).$apply$G((int)(y394459)));
                
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double r394461 =
                  ((t394490) + (((double)(z394460))));
                
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)x394458).$set__1x10$array$Array$$T$G((int)(y394459),
                                                                                                                                                                    x10.core.Double.$box(r394461));
                
//#line 72 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
ret394462 = r394461;
            }
        }
        
        
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public double
                                                                                      readTimer$O(
                                                                                      final int n){
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394491 =
              ((x10.array.Array)(total_time));
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394492 =
              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t394491).$apply$G((int)(n)));
            
//#line 75 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
return t394492;
        }
        
        
//#line 77 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public void
                                                                                      resetTimer(
                                                                                      int n){
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394499 =
              ((x10.array.Array)(elapsed_time));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394500 =
              n;
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394496 =
              ((x10.array.Array)(start_time));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394497 =
              n;
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394493 =
              ((x10.array.Array)(total_time));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394494 =
              n;
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394495 =
              ((double)(int)(((int)(0))));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394498 =
              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t394493).$set__1x10$array$Array$$T$G((int)(t394494),
                                                                                                             x10.core.Double.$box(t394495)));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final double t394501 =
              x10.core.Double.$unbox(((x10.array.Array<x10.core.Double>)t394496).$set__1x10$array$Array$$T$G((int)(t394497),
                                                                                                             x10.core.Double.$box(t394498)));
            
//#line 78 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
((x10.array.Array<x10.core.Double>)t394499).$set__1x10$array$Array$$T$G((int)(t394500),
                                                                                                                                                                x10.core.Double.$box(t394501));
        }
        
        
//#line 81 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
public void
                                                                                      resetAllTimers(
                                                                                      ){
            
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
int i =
              0;
            
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
for (;
                                                                                             true;
                                                                                             ) {
                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394503 =
                  i;
                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394504 =
                  NPB3_0_X10.Timer.max_counters;
                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final boolean t394508 =
                  ((t394503) < (((int)(t394504))));
                
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
if (!(t394508)) {
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
break;
                }
                {
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394507 =
                      i;
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
this.resetTimer((int)(t394507));
                }
                {
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394505 =
                      i;
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394506 =
                      ((t394505) + (((int)(1))));
                    
//#line 82 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
i = t394506;
                }
            }
        }
        
        
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final public NPB3_0_X10.Timer
                                                                                      NPB3_0_X10$Timer$$this$NPB3_0_X10$Timer(
                                                                                      ){
            
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
return NPB3_0_X10.Timer.this;
        }
        
        
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
// creation method for java code (1-phase java constructor)
        public Timer(){this((java.lang.System[]) null);
                           NPB3_0_X10$Timer$$init$S();}
        
        // constructor for non-virtual call
        final public NPB3_0_X10.Timer NPB3_0_X10$Timer$$init$S() { {
                                                                          
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
;
                                                                          {
                                                                              {
                                                                                  
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"

                                                                              }
                                                                              
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
this.__fieldInitializers394409();
                                                                          }
                                                                      }
                                                                      return this;
                                                                      }
        
        
        
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final public void
                                                                                      __fieldInitializers394409(
                                                                                      ){
            
//#line 53 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394509 =
              NPB3_0_X10.Timer.max_counters;
            
//#line 53 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394510 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t394509)))));
            
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
this.start_time = ((x10.array.Array)(t394510));
            
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394511 =
              NPB3_0_X10.Timer.max_counters;
            
//#line 54 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394512 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t394511)))));
            
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
this.elapsed_time = ((x10.array.Array)(t394512));
            
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final int t394513 =
              NPB3_0_X10.Timer.max_counters;
            
//#line 55 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
final x10.array.Array t394514 =
              ((x10.array.Array)(new x10.array.Array<x10.core.Double>((java.lang.System[]) null, x10.rtt.Types.DOUBLE).x10$array$Array$$init$S(((int)(t394513)))));
            
//#line 51 "/Users/vsaraswa/x10-benchmarks/NASPB/src/NPB3_0_X10/Timer.x10"
this.total_time = ((x10.array.Array)(t394514));
        }
    
}

