
final public class FixedBinaryHeap
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<FixedBinaryHeap> _RTT = new x10.rtt.RuntimeType<FixedBinaryHeap>(
    /* base class */FixedBinaryHeap.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "FixedBinaryHeap";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 19
private x10.core.Rail<java.lang.Integer>
          internalHeap;
        
//#line 20
private x10.core.Rail<java.lang.Integer>
          indexMap;
        
//#line 21
private x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>
          comparator;
        
//#line 22
private int
          size;
        
        
//#line 25
public FixedBinaryHeap(final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> comparator,
                                           final int N) {
            super();
            
//#line 17
this.__fieldInitializers78449();
            
//#line 26
this.comparator = comparator;
            
//#line 27
this.internalHeap = x10.core.RailFactory.<java.lang.Integer>makeVarRail(x10.rtt.Types.INT, ((int)(((((int)(N))) + (((int)(1)))))));
            
//#line 28
this.indexMap = x10.core.RailFactory.<java.lang.Integer>makeVarRail(x10.rtt.Types.INT, ((int)(N)));
            
//#line 29
this.size = 0;
        }
        
        
//#line 33
public boolean
                      isEmpty(
                      ){
            
//#line 33
return ((int) this.
                                        size) ==
            ((int) 0);
        }
        
        
//#line 37
private void
                      swapElements(
                      final int indexOne,
                      final int indexTwo){
            
//#line 38
assert (((((int)(indexOne))) < (((int)(this.
                                                                 size)))) &&
                                ((((int)(indexTwo))) < (((int)(this.
                                                                 size)))));
            
//#line 41
final int indexOneShadow =
              ((java.lang.Integer)(((int[])this.
                                             indexMap.value)[((int[])this.
                                                                       internalHeap.value)[indexOne]]));
            
//#line 42
((int[])this.
                                  indexMap.value)[((int[])this.
                                                            internalHeap.value)[indexOne]] = ((int[])this.
                                                                                                       indexMap.value)[((int[])this.
                                                                                                                                 internalHeap.value)[indexTwo]];
            
//#line 44
((int[])this.
                                  indexMap.value)[((int[])this.
                                                            internalHeap.value)[indexTwo]] = indexOneShadow;
            
//#line 47
final int shadowElement =
              ((java.lang.Integer)(((int[])this.
                                             internalHeap.value)[indexOne]));
            
//#line 48
((int[])this.
                                  internalHeap.value)[indexOne] = ((int[])this.
                                                                            internalHeap.value)[indexTwo];
            
//#line 49
((int[])this.
                                  internalHeap.value)[indexTwo] = shadowElement;
        }
        
        
//#line 53
public void
                      push(
                      final int newElement){
            
//#line 58
assert (((((int)((((((int)(this.
                                                     size))) + (((int)(1)))))))) < (((int)(((x10.core.Rail<java.lang.Integer>)(this.
                                                                                                                                 internalHeap)).length())))));
            
//#line 61
new x10.core.fun.Fun_0_2<FixedBinaryHeap, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final FixedBinaryHeap x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply(x,(int)y);}
            public final int apply(final FixedBinaryHeap x, final int y) { {
                
//#line 61
return x.size = ((((int)(x.
                                                       size))) + (((int)(y))));
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return FixedBinaryHeap._RTT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
            }
            }.apply(this,
                    1);
            
//#line 64
((int[])this.
                                  indexMap.value)[newElement] = this.
                                                                  size;
            
//#line 65
((int[])this.
                                  internalHeap.value)[this.
                                                        size] = newElement;
            
//#line 68
for (
//#line 68
int i =
                               this.
                                 size;
                             ((((int)(i))) > (((int)(1)))) &&
                             ((((int) 1) !=
                               ((int) ((java.lang.Integer)comparator.apply(((int[])this.
                                                                                     internalHeap.value)[((((int)(i))) / (((int)(2))))],x10.rtt.Types.INT,
                                                                           ((int[])this.
                                                                                     internalHeap.value)[i],x10.rtt.Types.INT)))));
                             
//#line 70
i = (((((int)(i))) / (((int)(2)))))) {
                
//#line 71
this.swapElements((int)(i),
                                              (int)(((((int)(i))) / (((int)(2))))));
            }
        }
        
        
//#line 76
public int
                      pop(
                      ){
            
//#line 78
assert (((((int)(this.
                                           size))) > (((int)(0)))));
            
//#line 81
final int element =
              ((java.lang.Integer)(((int[])this.
                                             internalHeap.value)[1]));
            
//#line 85
((int[])this.
                                  indexMap.value)[((int[])this.
                                                            internalHeap.value)[this.
                                                                                  size]] = 1;
            
//#line 86
((int[])this.
                                  internalHeap.value)[1] = ((int[])this.
                                                                     internalHeap.value)[this.
                                                                                           size];
            
//#line 87
new x10.core.fun.Fun_0_2<FixedBinaryHeap, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final FixedBinaryHeap x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply(x,(int)y);}
            public final int apply(final FixedBinaryHeap x, final int y) { {
                
//#line 87
return x.size = ((((int)(x.
                                                       size))) - (((int)(y))));
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return FixedBinaryHeap._RTT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
            }
            }.apply(this,
                    1);
            
//#line 90
int c =
               0;
            
//#line 91
for (
//#line 91
int i =
                               1;
                             ((((int)((c = ((((int)(2))) * (((int)(i)))))))) <= (((int)(this.
                                                                                          size))));
                             
//#line 91
i = c) {
                
//#line 93
if (((((int)((((((int)(c))) + (((int)(1)))))))) <= (((int)(this.
                                                                                         size)))) &&
                                ((((int) 1) ==
                                  ((int) ((java.lang.Integer)comparator.apply(((int[])this.
                                                                                        internalHeap.value)[((((int)(c))) + (((int)(1))))],x10.rtt.Types.INT,
                                                                              ((int[])this.
                                                                                        internalHeap.value)[c],x10.rtt.Types.INT)))))) {
                    
//#line 96
c = ((((int)(c))) + (((int)(1))));
                }
                
//#line 100
if (((int) -1) !=
                                 ((int) ((java.lang.Integer)comparator.apply(((int[])this.
                                                                                       internalHeap.value)[i],x10.rtt.Types.INT,
                                                                             ((int[])this.
                                                                                       internalHeap.value)[c],x10.rtt.Types.INT)))) {
                    
//#line 100
break;
                }
                
//#line 103
this.swapElements((int)(i),
                                               (int)(c));
            }
            
//#line 106
return element;
        }
        
        
//#line 116
public void
                       decreaseKey(
                       final int element){
            
//#line 117
final int currentPositionInHeap =
              ((java.lang.Integer)(((int[])this.
                                             indexMap.value)[element]));
            
//#line 123
for (
//#line 123
int i =
                                currentPositionInHeap;
                              ((((int)(i))) > (((int)(1)))) &&
                              ((((int) 1) !=
                                ((int) ((java.lang.Integer)comparator.apply(((int[])this.
                                                                                      internalHeap.value)[((((int)(i))) / (((int)(2))))],x10.rtt.Types.INT,
                                                                            ((int[])this.
                                                                                      internalHeap.value)[i],x10.rtt.Types.INT)))));
                              
//#line 125
i = (((((int)(i))) / (((int)(2)))))) {
                
//#line 126
this.swapElements((int)(i),
                                               (int)(((((int)(i))) / (((int)(2))))));
            }
        }
        
        
//#line 131
public int
                       clear(
                       ){
            
//#line 131
return this.size = 0;
        }
        
        
//#line 134
public void
                       print(
                       ){
            
//#line 135
x10.
              io.
              Console.OUT.print(((java.lang.String)("[")));
            
//#line 136
for (
//#line 136
int i =
                                1;
                              ((((int)(i))) <= (((int)(this.
                                                         size))));
                              
//#line 136
i = ((((int)(i))) + (((int)(1))))) {
                
//#line 137
x10.
                  io.
                  Console.OUT.print(((java.lang.String)((((((((((((int) i) ==
                                                                 ((int) 1)))
                                                                 ? ""
                                                                 : ",")) + (((java.lang.Integer)(((int[])this.
                                                                                                           internalHeap.value)[i]))))) + (":"))) + (((java.lang.Integer)(((int[])this.
                                                                                                                                                                                   indexMap.value)[((int[])this.
                                                                                                                                                                                                             internalHeap.value)[i]])))))));
            }
            
//#line 140
x10.
              io.
              Console.OUT.println(((java.lang.Object)("]")));
        }
        
        
//#line 143
public static class Main extends x10.runtime.impl.java.Runtime {
        public static void main(java.lang.String[] args) {
        // start native runtime
        new Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void main(final x10.array.Array<java.lang.String> args) {
        try {
        // start xrx
        x10.lang.Runtime.start(
        // static init activity
        new x10.core.fun.VoidFun_0_0() {
        public void apply() {
        // preload classes
        if (Boolean.getBoolean("x10.PRELOAD_CLASSES")) {
        x10.runtime.impl.java.PreLoader.preLoad(this.getClass().getEnclosingClass(), Boolean.getBoolean("x10.PRELOAD_STRINGS"));
        }
        }
        public x10.rtt.RuntimeType<?> getRTT() {
        return _RTT;
        }
        public x10.rtt.Type<?> getParam(int i) {
        return null;
        }
        },
        // body of main activity
        new x10.core.fun.VoidFun_0_0() {
        public void apply() {
        // catch and rethrow checked exceptions
        // (closures cannot throw checked exceptions)
        try {
        // call the original app-main method
        FixedBinaryHeap.main(args);
        } catch (java.lang.RuntimeException e) {
        throw e;
        } catch (java.lang.Error e) {
        throw e;
        } catch (java.lang.Throwable t) {
        throw new x10.runtime.impl.java.X10WrappedThrowable(t);
        }
        }
        public x10.rtt.RuntimeType<?> getRTT() {
        return _RTT;
        }
        public x10.rtt.Type<?> getParam(int i) {
        return null;
        }
        });
        } catch (java.lang.Throwable t) {
        t.printStackTrace();
        }
        }
        }
        
        // the original app-main method
        public static void main(final x10.
          array.
          Array<java.lang.String> args)  {
            
//#line 144
final x10.
              util.
              OptionsParser inputValues =
              ((x10.
              util.
              OptionsParser)(new x10.
              util.
              OptionsParser(args,
                            null,
                            x10.core.RailFactory.<x10.
                              util.
                              Option>makeArrayFromJavaArray(x10.util.Option._RTT, new x10.
                              util.
                              Option[] {new x10.
                              util.
                              Option("s",
                                     "",
                                     "Increasing order")}))));
            
//#line 146
final int isIncreasing =
              inputValues.apply(((java.lang.String)("-s")),
                                (int)(1));
            
//#line 148
final x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer> distanceMap =
              ((x10.
              util.
              HashMap)(new x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>(x10.rtt.Types.INT,
                                                            x10.rtt.Types.INT)));
            
//#line 150
final x10.core.fun.Fun_0_1<x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>,x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>> makeIncreasingComparator =
              ((x10.core.fun.Fun_0_1)(new x10.core.fun.Fun_0_1<x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>, x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>>() {public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer> distanceMap, x10.rtt.Type t1) { return apply(distanceMap);}
            public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer> distanceMap) { {
                
//#line 151
return new x10.core.fun.Fun_0_2<java.lang.Integer, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final java.lang.Integer x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply((int)x,(int)y);}
                public final int apply(final int x, final int y) { {
                    
//#line 152
final int dx =
                      ((java.lang.Integer)(((x10.
                      util.
                      Box<java.lang.Integer>)(((x10.
                      util.
                      HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).get_0_$$x10$util$HashMap_K((java.lang.Integer)(x)))).value$G()));
                    
//#line 153
final int dy =
                      ((java.lang.Integer)(((x10.
                      util.
                      Box<java.lang.Integer>)(((x10.
                      util.
                      HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).get_0_$$x10$util$HashMap_K((java.lang.Integer)(y)))).value$G()));
                    
//#line 154
return ((((int) dx) ==
                                          ((int) dy)))
                      ? 0
                      : (((((((int)(dx))) < (((int)(dy))))))
                           ? -1
                           : (+(((int)(1)))));
                }}
                public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return x10.rtt.Types.INT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
                }
                };
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.INT);if (i ==1) return new x10.rtt.ParameterizedType(x10.core.fun.Fun_0_2._RTT,x10.rtt.Types.INT,x10.rtt.Types.INT,x10.rtt.Types.INT);return null;
            }
            }));
            
//#line 158
final x10.core.fun.Fun_0_1<x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>,x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>> makeNonIncreasingComparator =
              ((x10.core.fun.Fun_0_1)(new x10.core.fun.Fun_0_1<x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>, x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>>() {public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer> distanceMap, x10.rtt.Type t1) { return apply(distanceMap);}
            public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer> distanceMap) { {
                
//#line 159
return new x10.core.fun.Fun_0_2<java.lang.Integer, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final java.lang.Integer x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply((int)x,(int)y);}
                public final int apply(final int x, final int y) { {
                    
//#line 160
final int dx =
                      ((java.lang.Integer)(((x10.
                      util.
                      Box<java.lang.Integer>)(((x10.
                      util.
                      HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).get_0_$$x10$util$HashMap_K((java.lang.Integer)(x)))).value$G()));
                    
//#line 161
final int dy =
                      ((java.lang.Integer)(((x10.
                      util.
                      Box<java.lang.Integer>)(((x10.
                      util.
                      HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).get_0_$$x10$util$HashMap_K((java.lang.Integer)(y)))).value$G()));
                    
//#line 162
return ((((int) dx) ==
                                          ((int) dy)))
                      ? 0
                      : (((((((int)(dx))) < (((int)(dy))))))
                           ? (+(((int)(1))))
                           : -1);
                }}
                public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return x10.rtt.Types.INT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
                }
                };
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.INT);if (i ==1) return new x10.rtt.ParameterizedType(x10.core.fun.Fun_0_2._RTT,x10.rtt.Types.INT,x10.rtt.Types.INT,x10.rtt.Types.INT);return null;
            }
            }));
            
//#line 166
final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> comparator =
              ((((int) 1) ==
                ((int) isIncreasing)))
              ? ((x10.core.fun.Fun_0_2)makeIncreasingComparator.apply(distanceMap,new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.INT)))
              : ((x10.core.fun.Fun_0_2)makeNonIncreasingComparator.apply(distanceMap,new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.INT)));
            
//#line 169
final FixedBinaryHeap myQueue =
              ((FixedBinaryHeap)(new FixedBinaryHeap(comparator,
                                                     10)));
            
//#line 171
((x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(0),
                                                                                                                             (java.lang.Integer)(0));
            
//#line 172
myQueue.push((int)(0));
            
//#line 174
((x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(1),
                                                                                                                             (java.lang.Integer)(1));
            
//#line 175
myQueue.push((int)(1));
            
//#line 177
((x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(2),
                                                                                                                             (java.lang.Integer)(2));
            
//#line 178
myQueue.push((int)(2));
            
//#line 180
((x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(3),
                                                                                                                             (java.lang.Integer)(3));
            
//#line 181
myQueue.push((int)(3));
            
//#line 183
((x10.
              util.
              HashMap<java.lang.Integer, java.lang.Integer>)(distanceMap)).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(4),
                                                                                                                             (java.lang.Integer)(4));
            
//#line 184
myQueue.push((int)(4));
            
//#line 186
myQueue.print();
            
//#line 188
myQueue.pop();
            
//#line 189
myQueue.print();
            
//#line 190
myQueue.pop();
            
//#line 191
myQueue.print();
        }
        
        
//#line 17
final private void
                      __fieldInitializers78449(
                      ){
            
//#line 17
this.size = 0;
        }
    
}
