
final public class Brandes
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<Brandes> _RTT = new x10.rtt.RuntimeType<Brandes>(
    /* base class */Brandes.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "Brandes";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 12
public int
          N;
        
        
//#line 13
final public static int
          M =
          ((((int)(1000))) * (((int)(1000))));
        
        
//#line 16
public AdjacencyGraph
          graph;
        
//#line 17
public boolean
          debug;
        
//#line 18
public x10.core.Rail<LockedDouble>
          betweennessMap;
        
        
//#line 21
public Brandes(final AdjacencyGraph g,
                                   final boolean debug) {
            super();
            {
                
//#line 22
this.N = g.numVertices();
                
                
//#line 12
this.__fieldInitializers371();
            }
            
//#line 23
this.graph = g;
            
//#line 24
this.debug = debug;
        }
        
        
//#line 28
final public static x10.core.fun.Fun_0_1<x10.core.Rail<x10.
          lang.
          ULong>,x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>>
          makeNonIncreasingComparator =
          ((x10.core.fun.Fun_0_1)(new x10.core.fun.Fun_0_1<x10.core.Rail<x10.
          lang.
          ULong>, x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer>>() {public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.core.Rail<x10.
          lang.
          ULong> distanceMap, x10.rtt.Type t1) { return apply(distanceMap);}
        public final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> apply(final x10.core.Rail<x10.
          lang.
          ULong> distanceMap) { {
            
//#line 29
return new x10.core.fun.Fun_0_2<java.lang.Integer, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final java.lang.Integer x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply((int)x,(int)y);}
            public final int apply(final int x, final int y) { {
                
//#line 30
final x10.
                  lang.
                  ULong dx =
                  ((x10.
                  lang.
                  ULong)(((x10.
                  lang.
                  ULong[])distanceMap.value)[x]));
                
//#line 31
final x10.
                  lang.
                  ULong dy =
                  ((x10.
                  lang.
                  ULong)(((x10.
                  lang.
                  ULong[])distanceMap.value)[y]));
                
//#line 32
return ((((x10.
                                       lang.
                                       ULong) dx).equals(((x10.
                                       lang.
                                       ULong) dy))))
                  ? 0
                  : (((x10.
                         lang.
                         ULong.$lt((x10.
                                     lang.
                                     ULong)(dx),
                                   (x10.
                                     lang.
                                     ULong)(dy))))
                       ? (+(((int)(1))))
                       : -1);
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return x10.rtt.Types.INT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
            }
            };
        }}
        public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return new x10.rtt.ParameterizedType(x10.core.Rail._RTT, x10.rtt.Types.ULONG);if (i ==1) return new x10.rtt.ParameterizedType(x10.core.fun.Fun_0_2._RTT,x10.rtt.Types.INT,x10.rtt.Types.INT,x10.rtt.Types.INT);return null;
        }
        }));
        
        
//#line 43
public void
                      dijkstraShortestPaths(
                      final int startVertex,
                      final int endVertex){
            
//#line 46
final x10.core.Rail<java.lang.Double> myBetweennessMap =
              ((x10.core.Rail)(x10.core.RailFactory.<java.lang.Double>makeVarRail(x10.rtt.Types.DOUBLE, ((int)(N)), ((java.lang.Double)(((double) (double) 
                                                                                                                                          (0.0)))))));
            
//#line 49
final FixedRailStack<java.lang.Integer> vertexStack =
              ((FixedRailStack)(new FixedRailStack<java.lang.Integer>(x10.rtt.Types.INT,
                                                                      N)));
            
//#line 50
final x10.core.Rail<FixedRailStack<java.lang.Integer>> predecessorMap =
              ((x10.core.Rail)((new java.lang.Object() {final x10.core.Rail<FixedRailStack<java.lang.Integer>> apply(int length$) {FixedRailStack[] array$ = new FixedRailStack[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = new FixedRailStack<java.lang.Integer>(x10.rtt.Types.INT,
                                                                                                                                                                                                                                                                                                  graph.getInDegree((int)(i)));}return new x10.core.Rail<FixedRailStack<java.lang.Integer>>(new x10.rtt.ParameterizedType(FixedRailStack._RTT, x10.rtt.Types.INT), length$, array$);}}.apply(N))));
            
//#line 52
final x10.core.Rail<x10.
              lang.
              ULong> distanceMap =
              ((x10.core.Rail)(x10.core.RailFactory.<x10.
              lang.
              ULong>makeVarRail(x10.rtt.Types.ULONG, ((int)(N)))));
            
//#line 53
final x10.core.Rail<x10.
              lang.
              ULong> sigmaMap =
              ((x10.core.Rail)(x10.core.RailFactory.<x10.
              lang.
              ULong>makeVarRail(x10.rtt.Types.ULONG, ((int)(N)), ((x10.
              lang.
              ULong)(x10.
              lang.
              ULong.$implicit_convert((int)(0)))))));
            
//#line 54
final x10.core.fun.Fun_0_2<java.lang.Integer,java.lang.Integer,java.lang.Integer> binaryHeapComparator =
              ((x10.core.fun.Fun_0_2)Brandes.makeNonIncreasingComparator.apply(distanceMap,new x10.rtt.ParameterizedType(x10.core.Rail._RTT, x10.rtt.Types.ULONG)));
            
//#line 55
final FixedBinaryHeap priorityQueue =
              ((FixedBinaryHeap)(new FixedBinaryHeap(binaryHeapComparator,
                                                     N,(java.lang.Class) null)));
            
//#line 56
final x10.core.Rail<java.lang.Double> deltaMap =
              ((x10.core.Rail)(x10.core.RailFactory.<java.lang.Double>makeVarRail(x10.rtt.Types.DOUBLE, ((int)(N)))));
            
//#line 58
x10.
              io.
              Console.OUT.println(((java.lang.Object)((("Starting processing from : ") + (((java.lang.Integer)(startVertex)))))));
            {
                
//#line 61
final int s391min392 =
                  startVertex;
                
//#line 61
final int s391max393 =
                  endVertex;
                
//#line 61
for (
//#line 61
int s391 =
                                   s391min392;
                                 ((((int)(s391))) <= (((int)(s391max393))));
                                 
//#line 61
s391 = ((((int)(s391))) + (((int)(1))))) {
                    
//#line 61
final int s =
                      s391;
                    {
                        
//#line 64
((FixedRailStack<java.lang.Integer>)(vertexStack)).clear();
                        {
                            
//#line 65
final int i373min374 =
                              0;
                            
//#line 65
final int i373max375 =
                              ((((int)(N))) - (((int)(1))));
                            
//#line 65
for (
//#line 65
int i373 =
                                               i373min374;
                                             ((((int)(i373))) <= (((int)(i373max375))));
                                             
//#line 65
i373 = ((((int)(i373))) + (((int)(1))))) {
                                
//#line 65
final int i =
                                  i373;
                                {
                                    
//#line 65
((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[i]))).clear();
                                }
                            }
                        }
                        {
                            
//#line 66
final int i377min378 =
                              0;
                            
//#line 66
final int i377max379 =
                              ((((int)(N))) - (((int)(1))));
                            
//#line 66
for (
//#line 66
int i377 =
                                               i377min378;
                                             ((((int)(i377))) <= (((int)(i377max379))));
                                             
//#line 66
i377 = ((((int)(i377))) + (((int)(1))))) {
                                
//#line 66
final int i =
                                  i377;
                                {
                                    
//#line 66
((x10.
                                      lang.
                                      ULong[])distanceMap.value)[i] = x10.
                                      lang.
                                      ULong.MAX_VALUE;
                                }
                            }
                        }
                        {
                            
//#line 67
final int i381min382 =
                              0;
                            
//#line 67
final int i381max383 =
                              ((((int)(N))) - (((int)(1))));
                            
//#line 67
for (
//#line 67
int i381 =
                                               i381min382;
                                             ((((int)(i381))) <= (((int)(i381max383))));
                                             
//#line 67
i381 = ((((int)(i381))) + (((int)(1))))) {
                                
//#line 67
final int i =
                                  i381;
                                {
                                    
//#line 67
((x10.
                                      lang.
                                      ULong[])sigmaMap.value)[i] = x10.
                                      lang.
                                      ULong.$implicit_convert((int)(0));
                                }
                            }
                        }
                        {
                            
//#line 68
final int i385min386 =
                              0;
                            
//#line 68
final int i385max387 =
                              ((((int)(N))) - (((int)(1))));
                            
//#line 68
for (
//#line 68
int i385 =
                                               i385min386;
                                             ((((int)(i385))) <= (((int)(i385max387))));
                                             
//#line 68
i385 = ((((int)(i385))) + (((int)(1))))) {
                                
//#line 68
final int i =
                                  i385;
                                {
                                    
//#line 68
((double[])deltaMap.value)[i] = ((double) (double) 
                                                                                  (0.0));
                                }
                            }
                        }
                        
//#line 69
priorityQueue.clear();
                        
//#line 72
((x10.
                          lang.
                          ULong[])distanceMap.value)[s] = x10.
                          lang.
                          ULong.$implicit_convert((int)(0));
                        
//#line 73
((x10.
                          lang.
                          ULong[])sigmaMap.value)[s] = x10.
                          lang.
                          ULong.$implicit_convert((int)(1));
                        
//#line 74
priorityQueue.push((int)(s));
                        
//#line 77
while ((!(((boolean)(priorityQueue.isEmpty()))))) {
                            
//#line 79
final int v =
                              priorityQueue.pop();
                            
//#line 80
((FixedRailStack<java.lang.Integer>)(vertexStack)).push_0_$$FixedRailStack_T((java.lang.Integer)(v));
                            
//#line 83
for (
//#line 83
final x10.
                                               lang.
                                               Iterator<java.lang.Integer> w389 =
                                               ((x10.
                                                 lang.
                                                 Iterator<java.lang.Integer>)(x10.
                                                 lang.
                                                 Iterator)
                                                 (((x10.
                                                    util.
                                                    Set<java.lang.Integer>)
                                                    ((x10.
                                                    util.
                                                    HashMap<java.lang.Integer, x10.
                                                    lang.
                                                    ULong>)(graph.getNeighbors((int)(v)))).keySet())).iterator());
                                             ((x10.
                                               lang.
                                               Iterator<java.lang.Integer>)(w389)).hasNext();
                                             ) {
                                
//#line 83
final int w =
                                  ((java.lang.Integer)(((x10.
                                  lang.
                                  Iterator<java.lang.Integer>)(w389)).next$G()));
                                
//#line 84
final x10.
                                  lang.
                                  ULong distanceThroughV =
                                  x10.
                                  lang.
                                  ULong.$plus((x10.
                                                lang.
                                                ULong)(((x10.
                                                lang.
                                                ULong[])distanceMap.value)[v]),
                                              (x10.
                                                lang.
                                                ULong)(graph.getEdgeWeight((int)(v),
                                                                           (int)(w))));
                                
//#line 88
if (x10.
                                                  lang.
                                                  ULong.$lt((x10.
                                                              lang.
                                                              ULong)(distanceThroughV),
                                                            (x10.
                                                              lang.
                                                              ULong)(((x10.
                                                              lang.
                                                              ULong[])distanceMap.value)[w]))) {
                                    
//#line 90
final boolean firstTimeRelaxation =
                                      ((((x10.
                                          lang.
                                          ULong) ((x10.
                                          lang.
                                          ULong[])distanceMap.value)[w]).equals(((x10.
                                          lang.
                                          ULong) x10.
                                          lang.
                                          ULong.MAX_VALUE))))
                                      ? true
                                      : false;
                                    
//#line 94
((x10.
                                      lang.
                                      ULong[])distanceMap.value)[w] = distanceThroughV;
                                    
//#line 97
if (firstTimeRelaxation) {
                                        
//#line 98
priorityQueue.push((int)(w));
                                    } else {
                                        
//#line 100
priorityQueue.decreaseKey((int)(w));
                                        
//#line 101
while ((!(((boolean)(((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[w]))).isEmpty())))))
                                            
//#line 101
((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[w]))).pop$G();
                                    }
                                }
                                
//#line 107
if (((x10.
                                                   lang.
                                                   ULong) distanceThroughV).equals(((x10.
                                                   lang.
                                                   ULong) ((x10.
                                                   lang.
                                                   ULong[])distanceMap.value)[w]))) {
                                    
//#line 108
((x10.
                                      lang.
                                      ULong[])sigmaMap.value)[w] = x10.
                                      lang.
                                      ULong.$plus((x10.
                                                    lang.
                                                    ULong)(((x10.
                                                    lang.
                                                    ULong[])sigmaMap.value)[w]),
                                                  (x10.
                                                    lang.
                                                    ULong)(((x10.
                                                    lang.
                                                    ULong[])sigmaMap.value)[v]));
                                    
//#line 109
((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[w]))).push_0_$$FixedRailStack_T((java.lang.Integer)(v));
                                }
                            }
                        }
                        
//#line 115
while ((!(((boolean)(((FixedRailStack<java.lang.Integer>)(vertexStack)).isEmpty()))))) {
                            
//#line 116
final int w =
                              ((int)(((FixedRailStack<java.lang.Integer>)(vertexStack)).pop$G()));
                            
//#line 117
while ((!(((boolean)((((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[w]))).isEmpty())))))) {
                                
//#line 118
final int v =
                                  ((java.lang.Integer)(((FixedRailStack<java.lang.Integer>)(((FixedRailStack<java.lang.Integer>)((FixedRailStack[])predecessorMap.value)[w]))).pop$G()));
                                
//#line 119
((double[])deltaMap.value)[v] += ((((double)((((((double)(((double)(long)(((x10.
                                                                                             lang.
                                                                                             ULong)(((x10.
                                                                                             lang.
                                                                                             ULong[])sigmaMap.value)[v])).longVal))))) / (((double)(((double)(long)(((x10.
                                                                                             lang.
                                                                                             ULong)(((x10.
                                                                                             lang.
                                                                                             ULong[])sigmaMap.value)[w])).longVal)))))))))) * (((double)((((((double)(((double)(int)(((int)(1))))))) + (((double)(((double[])deltaMap.value)[w])))))))));
                            }
                            
//#line 124
if (((int) w) !=
                                             ((int) s)) {
                                
//#line 124
((double[])myBetweennessMap.value)[w] += ((double[])deltaMap.value)[w];
                            }
                        }
                    }
                }
            }
            {
                
//#line 129
final LockedDouble[] Brandes$this$betweennessMap$value426 =
                  ((LockedDouble[])betweennessMap.value);
                
//#line 129
for (
//#line 129
int i =
                                    0;
                                  ((((int)(i))) < (((int)(N))));
                                  
//#line 129
i = ((((int)(i))) + (((int)(1))))) {
                    
//#line 130
final double result =
                      ((double)(((double[])myBetweennessMap.value)[i]));
                    
//#line 131
if (((double) result) !=
                                     ((double) 0.0)) {
                        
//#line 131
((LockedDouble)Brandes$this$betweennessMap$value426[i]).adjust((double)(result));
                    }
                }
            }
        }
        
        
//#line 138
private void
                       crunchNumbers(
                       final x10.
                         io.
                         Printer printer,
                       final boolean debug){
            
//#line 139
long time =
              x10.
              lang.
              System.nanoTime();
            
//#line 143
final int NThreads =
              x10.runtime.impl.java.Runtime.INIT_THREADS;
            
//#line 144
final int chunkSize =
              ((((int)(N))) / (((int)(NThreads))));
            
//#line 145
try {try {{
                {
                    
//#line 146
x10.
                      lang.
                      Runtime.ensureNotInAtomic();
                    
//#line 146
x10.
                      lang.
                      Runtime.startFinish();
                    
//#line 146
try {try {{
                        {
                            {
                                
//#line 147
final int i395min396 =
                                  0;
                                
//#line 147
final int i395max397 =
                                  ((((int)(NThreads))) - (((int)(1))));
                                
//#line 147
for (
//#line 147
int i395 =
                                                    i395min396;
                                                  ((((int)(i395))) <= (((int)(i395max397))));
                                                  
//#line 147
i395 = ((((int)(i395))) + (((int)(1))))) {
                                    
//#line 147
final int i =
                                      i395;
                                    {
                                        
//#line 147
x10.
                                          lang.
                                          Runtime.runAsync(new x10.core.fun.VoidFun_0_0() {public final void apply() { try {{
                                                               
//#line 148
final int startVertex =
                                                                 ((((int)(chunkSize))) * (((int)(i))));
                                                               
//#line 149
final int endVertex =
                                                                 ((((int) i) ==
                                                                   ((int) ((((int)(NThreads))) - (((int)(1)))))))
                                                                 ? ((((int)(N))) - (((int)(1))))
                                                                 : ((((((int)(((((int)(startVertex))) + (((int)(chunkSize))))))) - (((int)(1))))));
                                                               
//#line 150
Brandes.this.dijkstraShortestPaths((int)(startVertex),
                                                                                                               (int)(endVertex));
                                                           }}catch (x10.runtime.impl.java.X10WrappedThrowable ex) {x10.lang.Runtime.pushException(ex);}}
                                                           public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {return null;
                                                           }
                                                           });
                                    }
                                }
                            }
                        }
                    }}catch (x10.core.Throwable __t__) {throw __t__;}catch (java.lang.RuntimeException __e__) {throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(__e__);}catch (java.lang.Error __e__) {throw x10.core.ThrowableUtilities.getCorrespondingX10Error(__e__);}}catch (x10.core.Throwable __desugarer__var__0__) {
                        
//#line 146
x10.
                          lang.
                          Runtime.pushException(((x10.core.Throwable)(__desugarer__var__0__)));
                        
//#line 146
throw new x10.
                          lang.
                          RuntimeException();
                    }finally {{
                         
//#line 146
x10.
                           lang.
                           Runtime.stopFinish();
                     }}
                    }
                }}catch (x10.core.Throwable __t__) {throw __t__;}catch (java.lang.RuntimeException __e__) {throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(__e__);}}catch (final x10.
                                                                                                                                                                                            lang.
                                                                                                                                                                                            Exception z) {
                    
//#line 154
z.printStackTrace();
                }
            
//#line 158
time = ((((long)(x10.
              lang.
              System.nanoTime()))) - (((long)(time))));
            
//#line 159
printer.println(((java.lang.Object)((((("Betweenness calculation took ") + (((java.lang.Double)(((((double)(((double)(long)(((long)(time))))))) / (((double)(1.0E9))))))))) + (" seconds.")))));
            
//#line 161
if (debug) {
                {
                    
//#line 162
final int i399min400 =
                      0;
                    
//#line 162
final int i399max401 =
                      ((((int)(N))) - (((int)(1))));
                    {
                        
//#line 162
final LockedDouble[] Brandes$this$betweennessMap$value427 =
                          ((LockedDouble[])betweennessMap.value);
                        
//#line 162
for (
//#line 162
int i399 =
                                            i399min400;
                                          ((((int)(i399))) <= (((int)(i399max401))));
                                          
//#line 162
i399 = ((((int)(i399))) + (((int)(1))))) {
                            
//#line 162
final int i =
                              i399;
                            {
                                
//#line 163
if (((double) ((LockedDouble)Brandes$this$betweennessMap$value427[i]).get()) !=
                                                 ((double) 0.0)) {
                                    
//#line 164
printer.println(((java.lang.Object)((((((("(") + (((java.lang.Integer)(i))))) + (") ->"))) + (((LockedDouble)Brandes$this$betweennessMap$value427[i]))))));
                                }
                            }
                        }
                    }
                }
            }
            }
        
        public static void
          crunchNumbers$P(
          final x10.
            io.
            Printer printer,
          final boolean debug,
          final Brandes Brandes){
            Brandes.crunchNumbers(((x10.
                                    io.
                                    Printer)(printer)),
                                  (boolean)(debug));
        }
        
        
//#line 172
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
        Brandes.main(args);
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
            
//#line 173
try {try {{
                
//#line 174
final x10.
                  util.
                  OptionsParser cmdLineParams =
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
                                         "Seed for the random number"), new x10.
                                  util.
                                  Option("n",
                                         "",
                                         "Number of vertices = 2^n"), new x10.
                                  util.
                                  Option("a",
                                         "",
                                         "Probability a"), new x10.
                                  util.
                                  Option("b",
                                         "",
                                         "Probability b"), new x10.
                                  util.
                                  Option("c",
                                         "",
                                         "Probability c"), new x10.
                                  util.
                                  Option("d",
                                         "",
                                         "Probability d"), new x10.
                                  util.
                                  Option("f",
                                         "",
                                         "Graph file name"), new x10.
                                  util.
                                  Option("t",
                                         "",
                                         "File type: 0: NWB, 1:NET"), new x10.
                                  util.
                                  Option("i",
                                         "",
                                         "Starting index of vertices"), new x10.
                                  util.
                                  Option("debug",
                                         "",
                                         "Debug"), new x10.
                                  util.
                                  Option("o",
                                         "",
                                         "Output file name")}))));
                
//#line 188
final long seed =
                  ((long)(((int)(cmdLineParams.apply(((java.lang.String)("-s")),
                                                     (int)(2))))));
                
//#line 189
final int n =
                  cmdLineParams.apply(((java.lang.String)("-n")),
                                      (int)(2));
                
//#line 190
final double a =
                  cmdLineParams.apply(((java.lang.String)("-a")),
                                      (double)(0.55));
                
//#line 191
final double b =
                  cmdLineParams.apply(((java.lang.String)("-b")),
                                      (double)(0.1));
                
//#line 192
final double c =
                  cmdLineParams.apply(((java.lang.String)("-c")),
                                      (double)(0.1));
                
//#line 193
final double d =
                  cmdLineParams.apply(((java.lang.String)("-d")),
                                      (double)(0.25));
                
//#line 194
final java.lang.String fileName =
                  cmdLineParams.apply(((java.lang.String)("-f")),
                                      ((java.lang.String)("NOFILE")));
                
//#line 195
final int fileType =
                  cmdLineParams.apply(((java.lang.String)("-t")),
                                      (int)(0));
                
//#line 196
final int startIndex =
                  cmdLineParams.apply(((java.lang.String)("-i")),
                                      (int)(0));
                
//#line 197
final java.lang.String outFileName =
                  cmdLineParams.apply(((java.lang.String)("-o")),
                                      ((java.lang.String)("STDOUT")));
                
//#line 198
final boolean debug =
                  ((int) 0) ==
                ((int) cmdLineParams.apply(((java.lang.String)("-debug")),
                                           (int)(1)));
                
//#line 200
final int numPlaces =
                  x10.runtime.impl.java.Runtime.MAX_PLACES;
                
//#line 203
final x10.
                  io.
                  Printer printer =
                  ((((int) 0) ==
                    ((int) (outFileName).compareTo("STDOUT"))))
                  ? x10.
                  io.
                  Console.OUT
                  : (new x10.
                       io.
                       File(outFileName)).printer();
                
//#line 206
printer.println(((java.lang.Object)("Running SSCA2 with the following parameters:")));
                
//#line 208
if (((int) 0) ==
                                 ((int) (fileName).compareTo("NOFILE"))) {
                    
//#line 209
printer.println(((java.lang.Object)((("seed = ") + (((java.lang.Long)(seed)))))));
                    
//#line 210
printer.println(((java.lang.Object)((("N = ") + (((java.lang.Integer)(((int)(double)(((double)(java.lang.Math.pow(((double)(((double)(int)(((int)(2)))))), ((double)(((double)(int)(((int)(n))))))))))))))))));
                    
//#line 211
printer.println(((java.lang.Object)((("a = ") + (((java.lang.Double)(a)))))));
                    
//#line 212
printer.println(((java.lang.Object)((("b = ") + (((java.lang.Double)(b)))))));
                    
//#line 213
printer.println(((java.lang.Object)((("c = ") + (((java.lang.Double)(c)))))));
                    
//#line 214
printer.println(((java.lang.Object)((("d = ") + (((java.lang.Double)(d)))))));
                    
//#line 215
printer.println(((java.lang.Object)((((("") + (((java.lang.Integer)(x10.runtime.impl.java.Runtime.INIT_THREADS))))) + (" workers.")))));
                    
//#line 216
final Rmat recursiveMatrixGenerator =
                      new Rmat(seed,
                               n,
                               a,
                               b,
                               c,
                               d);
                    
//#line 217
final AdjacencyGraph graph =
                      ((AdjacencyGraph)(recursiveMatrixGenerator.generate()));
                    
//#line 218
final Brandes brandes =
                      ((Brandes)(new Brandes(graph,
                                             debug)));
                    
//#line 220
brandes.crunchNumbers(((x10.
                                                         io.
                                                         Printer)(printer)),
                                                       (boolean)(debug));
                    
//#line 221
x10.
                      io.
                      Console.OUT.println(((java.lang.Object)("Done.")));
                } else {
                    
//#line 223
printer.println(((java.lang.Object)((("f = ") + (fileName)))));
                    
//#line 224
printer.println(((java.lang.Object)((("t = ") + (((java.lang.Integer)(fileType)))))));
                    
//#line 225
printer.println(((java.lang.Object)((("i = ") + (((java.lang.Integer)(startIndex)))))));
                    
//#line 226
printer.println(((java.lang.Object)((((("") + (((java.lang.Integer)(x10.runtime.impl.java.Runtime.INIT_THREADS))))) + (" workers.")))));
                    
//#line 228
final AdjacencyGraph graph =
                      NetReader.readNetFile(((java.lang.String)(fileName)),
                                            (int)(startIndex));
                    
//#line 229
final Brandes brandes =
                      ((Brandes)(new Brandes(graph,
                                             debug)));
                    
//#line 231
brandes.crunchNumbers(((x10.
                                                         io.
                                                         Printer)(printer)),
                                                       (boolean)(debug));
                    
//#line 232
x10.
                      io.
                      Console.OUT.println(((java.lang.Object)("Done.")));
                }
            }}catch (x10.core.Throwable __t__) {throw __t__;}catch (java.lang.RuntimeException __e__) {throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(__e__);}catch (java.lang.Error __e__) {throw x10.core.ThrowableUtilities.getCorrespondingX10Error(__e__);}}catch (final x10.core.Throwable e) {
                
//#line 236
x10.core.ThrowableUtilities.printStackTrace(e, x10.
                  io.
                  Console.ERR);
            }
        }
        
        
//#line 12
final public int
                      N(
                      ){
            
//#line 12
return this.
                                 N;
        }
        
        
//#line 12
final private void
                      __fieldInitializers371(
                      ){
            
//#line 12
this.betweennessMap = ((x10.core.Rail)((new java.lang.Object() {final x10.core.Rail<LockedDouble> apply(int length$) {LockedDouble[] array$ = new LockedDouble[length$];for (int id$3$ = 0; id$3$ < length$; id$3$++) {final int id$3 = id$3$;array$[id$3] = new LockedDouble(0.0);}return new x10.core.Rail<LockedDouble>(LockedDouble._RTT, length$, array$);}}.apply(N))));
        }
        
        final public static void
          __fieldInitializers371$P(
          final Brandes Brandes){
            Brandes.__fieldInitializers371();
        }
        
    }
    