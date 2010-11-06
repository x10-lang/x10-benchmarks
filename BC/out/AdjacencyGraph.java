
final public class AdjacencyGraph
extends x10.core.Struct
{
    public static final x10.rtt.RuntimeType<AdjacencyGraph> _RTT = new x10.rtt.RuntimeType<AdjacencyGraph>(
    /* base class */AdjacencyGraph.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, x10.rtt.Types.ANY}
    ) {public String typeName() {return "AdjacencyGraph";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 8
public int
          N;
        
//#line 9
public x10.core.Rail<x10.
          util.
          HashMap<java.lang.Integer, x10.
          lang.
          ULong>>
          adjacencyList;
        
//#line 10
public x10.core.Rail<java.lang.Integer>
          inDegreeMap;
        
        
//#line 15
public AdjacencyGraph(final int N) {
            {
                
            }
            
//#line 16
this.N = N;
            
//#line 17
this.adjacencyList = (new java.lang.Object() {final x10.core.Rail<x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>> apply(int length$) {x10.
              util.
              HashMap[] array$ = new x10.
              util.
              HashMap[length$];for (int id$0$ = 0; id$0$ < length$; id$0$++) {final int id$0 = id$0$;array$[id$0] = new x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>(x10.rtt.Types.INT,
                     x10.rtt.Types.ULONG);}return new x10.core.Rail<x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>>(new x10.rtt.ParameterizedType(x10.util.HashMap._RTT, x10.rtt.Types.INT, x10.rtt.Types.ULONG), length$, array$);}}.apply(N));
            
//#line 19
this.inDegreeMap = (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int id$1$ = 0; id$1$ < length$; id$1$++) {final int id$1 = id$1$;array$[id$1] = 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(N));
        }
        
        
//#line 25
final public x10.
                      util.
                      HashMap<java.lang.Integer, x10.
                      lang.
                      ULong>
                      getNeighbors(
                      final int v){
            
//#line 25
return ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)((x10.
              util.
              HashMap[])this.
                          adjacencyList.value)[v]);
        }
        
        
//#line 30
final public boolean
                      existsEdge(
                      final int v,
                      final int w){
            
//#line 30
return ((x10.
              util.
              HashMap<java.lang.Integer, x10.
              lang.
              ULong>)(this.getNeighbors((int)(v)))).containsKey_0_$$x10$util$HashMap_K((java.lang.Integer)(w));
        }
        
        
//#line 35
final public x10.
                      lang.
                      ULong
                      getEdgeWeight(
                      final int v,
                      final int w){
            
//#line 36
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
        
        
//#line 43
final public x10.
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
            
//#line 43
return ((x10.
                                 util.
                                 Box<x10.
                                 lang.
                                 ULong>)(x10.
                                 util.
                                 Box)
                                 ((x10.
                                 util.
                                 HashMap<java.lang.Integer, x10.
                                 lang.
                                 ULong>)(this.getNeighbors((int)(v)))).put_0_$$x10$util$HashMap_K_1_$$x10$util$HashMap_V((java.lang.Integer)(w),
                                                                                                                         (x10.
                                                                                                                           lang.
                                                                                                                           ULong)(d)));
        }
        
        
//#line 48
final public int
                      numVertices(
                      ){
            
//#line 48
return this.
                                 N;
        }
        
        
//#line 53
final public void
                      incrementInDegree(
                      final int v){
            
//#line 53
((int[])this.
                                  inDegreeMap.value)[v] += 1;
        }
        
        
//#line 58
final public int
                      getInDegree(
                      final int v){
            
//#line 58
return ((int[])this.
                                         inDegreeMap.value)[v];
        }
        
        
//#line 60
final public java.lang.String
                      toString(
                      ){
            
//#line 61
java.lang.String outString =
              "";
            {
                
//#line 63
final int v350min351 =
                  0;
                
//#line 63
final int v350max352 =
                  ((((int)(N))) - (((int)(1))));
                
//#line 63
for (
//#line 63
int v350 =
                                   v350min351;
                                 ((((int)(v350))) <= (((int)(v350max352))));
                                 
//#line 63
v350 = ((((int)(v350))) + (((int)(1))))) {
                    
//#line 63
final int v =
                      v350;
                    {
                        
//#line 64
final x10.
                          util.
                          HashMap<java.lang.Integer, x10.
                          lang.
                          ULong> neighbors =
                          this.getNeighbors((int)(v));
                        
//#line 66
for (
//#line 66
final x10.
                                           lang.
                                           Iterator<java.lang.Integer> w348 =
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
                                                ULong>)(neighbors)).keySet())).iterator());
                                         ((x10.
                                           lang.
                                           Iterator<java.lang.Integer>)(w348)).hasNext();
                                         ) {
                            
//#line 66
final int w =
                              ((java.lang.Integer)(((x10.
                              lang.
                              Iterator<java.lang.Integer>)(w348)).next$G()));
                            
//#line 67
final x10.
                              lang.
                              ULong d =
                              this.getEdgeWeight((int)(v),
                                                 (int)(w));
                            
//#line 68
outString = ((outString) + ((((((((((((((("(") + (((java.lang.Integer)(v))))) + (", "))) + (((java.lang.Integer)(w))))) + (")"))) + (" => "))) + (((x10.
                              lang.
                              ULong)(d))))) + ("\n"))));
                        }
                    }
                }
            }
            
//#line 72
return outString;
        }
        
        
//#line 7
final native public java.lang.String
                     typeName(
                     );
        
        
//#line 7
final public int
                     hashCode(
                     ){
            
//#line 7
int result =
              0;
            
//#line 7
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                N)).hashCode()))));
            
//#line 7
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(this.
                                                                                            adjacencyList.hashCode()))));
            
//#line 7
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(this.
                                                                                            inDegreeMap.hashCode()))));
            
//#line 7
return result;
        }
        
        
//#line 7
final public boolean
                     equals(
                     java.lang.Object other){
            
//#line 7
if ((!(((boolean)(AdjacencyGraph._RTT.instanceof$(other)))))) {
                
//#line 7
return false;
            }
            
//#line 7
return this.equals(((AdjacencyGraph)((new java.lang.Object() {final AdjacencyGraph cast(final AdjacencyGraph self) {if (self==null) return null;x10.rtt.Type rtt = AdjacencyGraph._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((AdjacencyGraph) other)))));
        }
        
        
//#line 7
final public boolean
                     equals(
                     AdjacencyGraph other){
            
//#line 7
return ((int) this.
                                       N) ==
            ((int) other.
                     N) &&
            x10.rtt.Equality.equalsequals(this.
                                            adjacencyList,other.
                                                            adjacencyList) &&
            x10.rtt.Equality.equalsequals(this.
                                            inDegreeMap,other.
                                                          inDegreeMap);
        }
        
        
//#line 7
final public boolean
                     _struct_equals(
                     java.lang.Object other){
            
//#line 7
if ((!(((boolean)(AdjacencyGraph._RTT.instanceof$(other)))))) {
                
//#line 7
return false;
            }
            
//#line 7
return this._struct_equals(((AdjacencyGraph)((new java.lang.Object() {final AdjacencyGraph cast(final AdjacencyGraph self) {if (self==null) return null;x10.rtt.Type rtt = AdjacencyGraph._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((AdjacencyGraph) other)))));
        }
        
        
//#line 7
final public boolean
                     _struct_equals(
                     AdjacencyGraph other){
            
//#line 7
return ((int) this.
                                       N) ==
            ((int) other.
                     N) &&
            x10.rtt.Equality.equalsequals(this.
                                            adjacencyList,other.
                                                            adjacencyList) &&
            x10.rtt.Equality.equalsequals(this.
                                            inDegreeMap,other.
                                                          inDegreeMap);
        }
    
}
