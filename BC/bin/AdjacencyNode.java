public class AdjacencyNode
extends x10.core.Struct
{
    public static final x10.rtt.RuntimeType<AdjacencyNode> _RTT = new x10.rtt.RuntimeType<AdjacencyNode>(
    /* base class */AdjacencyNode.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, x10.rtt.Types.ANY}
    ) {public String typeName() {return "AdjacencyNode";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 3
private int
          targetVertex;
        
//#line 4
private x10.
          lang.
          ULong
          edgeWeight;
        
        
//#line 7
public AdjacencyNode(final int targetVertex,
                                        final long edgeWeight) {
            {
                
            }
            
//#line 8
this.targetVertex = targetVertex;
            
//#line 9
this.edgeWeight = x10.
              lang.
              ULong.$implicit_convert((long)(edgeWeight));
        }
        
        
//#line 13
final public int
                      getTargetVertex(
                      ){
            
//#line 13
return this.
                                 targetVertex;
        }
        
        
//#line 14
final public x10.
                      lang.
                      ULong
                      getEdgeWeight(
                      ){
            
//#line 14
return this.
                                 edgeWeight;
        }
        
        
//#line 2
final native public java.lang.String
                     typeName(
                     );
        
        
//#line 2
final public java.lang.String
                     toString(
                     ){
            
//#line 2
return (((((((("struct AdjacencyNode:") + (" targetVertex="))) + (((java.lang.Integer)(this.
                                                                                                                targetVertex))))) + (" edgeWeight="))) + (((x10.
              lang.
              ULong)(this.
                       edgeWeight))));
        }
        
        
//#line 2
final public int
                     hashCode(
                     ){
            
//#line 2
int result =
              0;
            
//#line 2
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                targetVertex)).hashCode()))));
            
//#line 2
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                edgeWeight)).hashCode()))));
            
//#line 2
return result;
        }
        
        
//#line 2
final public boolean
                     equals(
                     java.lang.Object other){
            
//#line 2
if ((!(((boolean)(AdjacencyNode._RTT.instanceof$(other)))))) {
                
//#line 2
return false;
            }
            
//#line 2
return this.equals(((AdjacencyNode)((new java.lang.Object() {final AdjacencyNode cast(final AdjacencyNode self) {if (self==null) return null;x10.rtt.Type rtt = AdjacencyNode._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((AdjacencyNode) other)))));
        }
        
        
//#line 2
final public boolean
                     equals(
                     AdjacencyNode other){
            
//#line 2
return ((int) this.
                                       targetVertex) ==
            ((int) other.
                     targetVertex) &&
            ((x10.
              lang.
              ULong) this.
                       edgeWeight).equals(((x10.
              lang.
              ULong) other.
                       edgeWeight));
        }
        
        
//#line 2
final public boolean
                     _struct_equals(
                     java.lang.Object other){
            
//#line 2
if ((!(((boolean)(AdjacencyNode._RTT.instanceof$(other)))))) {
                
//#line 2
return false;
            }
            
//#line 2
return this._struct_equals(((AdjacencyNode)((new java.lang.Object() {final AdjacencyNode cast(final AdjacencyNode self) {if (self==null) return null;x10.rtt.Type rtt = AdjacencyNode._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((AdjacencyNode) other)))));
        }
        
        
//#line 2
final public boolean
                     _struct_equals(
                     AdjacencyNode other){
            
//#line 2
return ((int) this.
                                       targetVertex) ==
            ((int) other.
                     targetVertex) &&
            ((x10.
              lang.
              ULong) this.
                       edgeWeight).equals(((x10.
              lang.
              ULong) other.
                       edgeWeight));
        }
    
}
