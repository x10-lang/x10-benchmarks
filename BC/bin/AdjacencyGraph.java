
final public class AdjacencyGraph
extends x10.core.Ref
{
    public static final x10.rtt.RuntimeType<AdjacencyGraph> _RTT = new x10.rtt.RuntimeType<AdjacencyGraph>(
    /* base class */AdjacencyGraph.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    ) {public String typeName() {return "AdjacencyGraph";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 8
private int
          N;
        
//#line 9
private int
          M;
        
//#line 10
private x10.core.Rail<x10.
          util.
          HashMap<java.lang.Integer, x10.
          lang.
          ULong>>
          adjacencyList;
        
//#line 11
private x10.core.Rail<java.lang.Integer>
          inDegreeMap;
        
//#line 18
/** The edgelist of a vertex is stored as offsetMap[i] to offsetmap[i+1] */private x10.core.Rail<java.lang.Integer>
          offsetMap;
        
//#line 21
/** This just contains a series of edges that are indexed by offsetMap */public x10.core.Rail<AdjacencyNode>
          adjacencyMap;
        
        
//#line 26
public AdjacencyGraph(final int N) {
            super();
            
//#line 7
this.__fieldInitializers78478();
            
//#line 27
this.N = N;
            
//#line 28
this.M = 0;
            
//#line 29
this.adjacencyList = (new java.lang.Object() {final x10.core.Rail<x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>> apply(int length) {x10.
              util.
              HashMap[] array = new x10.
              util.
              HashMap[length];for (int id$77706$ = 0; id$77706$ < length; id$77706$++) {final int id$77706 = id$77706$;array[id$77706] = new x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>(x10.rtt.Types.INT,
                     x10.rtt.Types.ULONG);}return new x10.core.Rail<x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>>(new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.ULONG), N, array);}}.apply(N));
            
//#line 31
this.inDegreeMap = (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length) {int[] array = new int[length];for (int id$77707$ = 0; id$77707$ < length; id$77707$++) {final int id$77707 = id$77707$;array[id$77707] = 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, N, array);}}.apply(N));
            
//#line 32
this.offsetMap = x10.core.RailFactory.<java.lang.Integer>makeVarRail(x10.rtt.Types.INT, ((int)(((((int)(N))) + (((int)(1)))))));
        }
        
        
//#line 41
public void
                      compressGraph(
                      ){
            
//#line 43
this.adjacencyMap = x10.core.RailFactory.<AdjacencyNode>makeVarRail(AdjacencyNode._RTT, ((int)(this.
                                                                                                                         M)));
            
//#line 46
int currentOffset =
              0;
            {
                
//#line 47
final int v78495min78496 =
                  0;
                
//#line 47
final int v78495max78497 =
                  ((((int)(this.
                             N))) - (((int)(1))));
                
//#line 47
for (
//#line 47
int v78495 =
                                   v78495min78496;
                                 ((((int)(v78495))) <= (((int)(v78495max78497))));
                                 
//#line 47
v78495 = ((((int)(v78495))) + (((int)(1))))) {
                    
//#line 47
final int v =
                      v78495;
                    {
                        
//#line 49
((int[])this.
                                              offsetMap.value)[v] = currentOffset;
                        
//#line 52
for (
//#line 52
final x10.
                                           lang.
                                           Iterator<java.lang.Integer> w78493 =
                                           (((x10.
                                           util.
                                           HashMap<java.lang.Integer, x10.
                                           lang.
                                           ULong>)(this.getNeighbors((int)(v)))).keySet()).iterator();
                                         ((x10.
                                           lang.
                                           Iterator<java.lang.Integer>)(w78493)).hasNext();
                                         ) {
                            
//#line 52
final int w =
                              ((java.lang.Integer)(((x10.
                              lang.
                              Iterator<java.lang.Integer>)(w78493)).next$G()));
                            
//#line 53
((AdjacencyNode[])this.
                                                            adjacencyMap.value)[currentOffset] = new AdjacencyNode(w,
                                                                                                                   ((long)(((x10.
                                                                                                                     lang.
                                                                                                                     ULong)(this.getEdgeWeight((int)(v),
                                                                                                                                               (int)(w)))).longVal)));
                            
//#line 55
currentOffset = ((((int)(currentOffset))) + (((int)(1))));
                        }
                    }
                }
            }
            
//#line 60
assert (((int) currentOffset) ==
                                ((int) this.
                                         M));
            
//#line 63
((int[])this.
                                  offsetMap.value)[N] = currentOffset;
        }
        
        
//#line 69
public int
                      begin(
                      final int v){
            
//#line 70
assert (((((int)(v))) < (((int)(this.
                                                          N)))));
            
//#line 71
return ((int[])this.
                                         offsetMap.value)[v];
        }
        
        
//#line 77
public int
                      end(
                      final int v){
            
//#line 78
assert (((((int)(v))) < (((int)(this.
                                                          N)))));
            
//#line 79
return ((int[])this.
                                         offsetMap.value)[((((int)(v))) + (((int)(1))))];
        }
        
        
//#line 85
public AdjacencyNode
                      getAdjacencyNode(
                      final int index){
            
//#line 86
assert (((((int)(index))) < (((int)(this.
                                                              M)))));
            
//#line 87
return ((AdjacencyNode)((AdjacencyNode[])this.
                                                                   adjacencyMap.value)[index]);
        }
        
        
//#line 93
public x10.
                      util.
                      HashMap<java.lang.Integer, x10.
                      lang.
                      ULong>
                      getNeighbors(
                      final int v){
            
//#line 93
return ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)((x10.
              util.
              HashMap[])this.
                          adjacencyList.value)[v]);
        }
        
        
//#line 98
public boolean
                      existsEdge(
                      final int v,
                      final int w){
            
//#line 98
return ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)(this.getNeighbors((int)(v)))).containsKey_0_$$x10$util$HashMap_K((java.lang.Integer)(w));
        }
        
        
//#line 103
public x10.
                       lang.
                       ULong
                       getEdgeWeight(
                       final int v,
                       final int w){
            
//#line 104
return ((this.existsEdge((int)(v),
                                                  (int)(w))))
              ? ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)(this.getNeighbors((int)(v)))).getOrElse_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V$G((java.lang.Integer)(w),
                                                                                                              (x10.
                                                                                                                lang.
                                                                                                                ULong)(x10.
                                                                                                                lang.
                                                                                                                ULong.$implicit_convert((int)(0))))
              : x10.
              lang.
              ULong.MAX_VALUE;
        }
        
        
//#line 111
public x10.
                       util.
                       Box<x10.
                       lang.
                       ULong>
                       addEdge(
                       final int v,
                       final int w,
                       final x10.
                         lang.
                         ULong d){
            
//#line 111
return ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)(this.getNeighbors((int)(v)))).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(w),
                                                                                                      (x10.
                                                                                                        lang.
                                                                                                        ULong)(d));
        }
        
        
//#line 116
public int
                       numVertices(
                       ){
            
//#line 116
return this.
                                  N;
        }
        
        
//#line 121
public int
                       numEdges(
                       ){
            
//#line 121
return this.
                                  M;
        }
        
        
//#line 126
public void
                       incrementInDegree(
                       final int v){
            
//#line 127
new x10.core.fun.Fun_0_3<x10.core.Rail<java.lang.Integer>, java.lang.Integer, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final x10.core.Rail<java.lang.Integer> x, x10.rtt.Type t1,final java.lang.Integer y0, x10.rtt.Type t2,final java.lang.Integer z, x10.rtt.Type t3) { return apply(x,(int)y0,(int)z);}
            public final int apply(final x10.core.Rail<java.lang.Integer> x, final int y0, final int z) { {
                
//#line 127
return ((int[])x.value)[y0] = ((((int)(((int[])x.value)[y0]))) + (((int)(z))));
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return new x10.rtt.ParameterizedType(x10.core.Rail._RTT, x10.rtt.Types.INT);if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;if (i ==3) return x10.rtt.Types.INT;return null;
            }
            }.apply(this.
                      inDegreeMap,
                    v,
                    1);
            
//#line 128
new x10.core.fun.Fun_0_2<AdjacencyGraph, java.lang.Integer, java.lang.Integer>() {public final java.lang.Integer apply(final AdjacencyGraph x, x10.rtt.Type t1,final java.lang.Integer y, x10.rtt.Type t2) { return apply(x,(int)y);}
            public final int apply(final AdjacencyGraph x, final int y) { {
                
//#line 128
return x.M = ((((int)(x.
                                                     M))) + (((int)(y))));
            }}
            public x10.rtt.RuntimeType<?> getRTT() { return _RTT;}public x10.rtt.Type<?> getParam(int i) {if (i ==0) return AdjacencyGraph._RTT;if (i ==1) return x10.rtt.Types.INT;if (i ==2) return x10.rtt.Types.INT;return null;
            }
            }.apply(this,
                    1);
        }
        
        
//#line 134
public int
                       getInDegree(
                       final int v){
            
//#line 134
return ((int[])this.
                                          inDegreeMap.value)[v];
        }
        
        
//#line 136
public java.lang.String
                       toString(
                       ){
            
//#line 137
java.lang.String outString =
              "";
            {
                
//#line 139
final int v78501min78502 =
                  0;
                
//#line 139
final int v78501max78503 =
                  ((((int)(N))) - (((int)(1))));
                
//#line 139
for (
//#line 139
int v78501 =
                                    v78501min78502;
                                  ((((int)(v78501))) <= (((int)(v78501max78503))));
                                  
//#line 139
v78501 = ((((int)(v78501))) + (((int)(1))))) {
                    
//#line 139
final int v =
                      v78501;
                    {
                        
//#line 140
final x10.
                          util.
                          HashMap<java.lang.Integer, x10.
                          lang.
                          ULong> neighbors =
                          this.getNeighbors((int)(v));
                        
//#line 142
for (
//#line 142
final x10.
                                            lang.
                                            Iterator<java.lang.Integer> w78499 =
                                            (((x10.
                                            util.
                                            HashMap<java.lang.Integer, x10.
                                            lang.
                                            ULong>)(neighbors)).keySet()).iterator();
                                          ((x10.
                                            lang.
                                            Iterator<java.lang.Integer>)(w78499)).hasNext();
                                          ) {
                            
//#line 142
final int w =
                              ((java.lang.Integer)(((x10.
                              lang.
                              Iterator<java.lang.Integer>)(w78499)).next$G()));
                            
//#line 143
final x10.
                              lang.
                              ULong d =
                              this.getEdgeWeight((int)(v),
                                                 (int)(w));
                            
//#line 144
outString = ((outString) + ((((((((((((((("(") + (((java.lang.Integer)(v))))) + (", "))) + (((java.lang.Integer)(w))))) + (")"))) + (" => "))) + (((x10.
                              lang.
                              ULong)(d))))) + ("\n"))));
                        }
                    }
                }
            }
            
//#line 148
return outString;
        }
        
        
//#line 7
final private void
                     __fieldInitializers78478(
                     ){
            
//#line 7
this.M = 0;
            
//#line 7
this.adjacencyMap = null;
        }
    
}
