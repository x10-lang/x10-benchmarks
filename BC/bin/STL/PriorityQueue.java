package STL;


final public class PriorityQueue<T, Compare>
extends x10.core.Struct
{
    public static final x10.rtt.RuntimeType<PriorityQueue> _RTT = new x10.rtt.RuntimeType<PriorityQueue>(
    /* base class */PriorityQueue.class, 
    /* variances */ new x10.rtt.RuntimeType.Variance[] {x10.rtt.RuntimeType.Variance.INVARIANT, 
    x10.rtt.RuntimeType.Variance.INVARIANT}
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, x10.rtt.Types.ANY}
    ) {public String typeName() {return "STL.PriorityQueue";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    public x10.rtt.Type<?> getParam(int i) {if (i ==0)return T;if (i ==1)return Compare;return null;}
    
        private x10.rtt.Type T;
        private x10.rtt.Type Compare;
        
        
        
//#line 13
public PriorityQueue(final x10.rtt.Type T,
                                         final x10.rtt.Type Compare) {this.T = T;
                                                                          this.Compare = Compare;
                                                                           {
                                                                              {
                                                                                  
                                                                              }
                                                                          }}
        
        
//#line 16
public PriorityQueue(final x10.rtt.Type T,
                                         final x10.rtt.Type Compare,
                                         final STL.
                                           PriorityQueue<T, Compare> x) {this.T = T;
                                                                             this.Compare = Compare;
                                                                              {
                                                                                 {
                                                                                     
                                                                                 }
                                                                             }}
        
        
//#line 19
public PriorityQueue(final x10.rtt.Type T,
                                         final x10.rtt.Type Compare,
                                         final Compare c) {this.T = T;
                                                               this.Compare = Compare;
                                                                {
                                                                   {
                                                                       
                                                                   }
                                                               }}
        
        
//#line 27
final public boolean
                      empty(
                      ){
            
//#line 27
return false;
        }
        
        
//#line 31
final public int
                      size(
                      ){
            
//#line 31
return 0;
        }
        
        
//#line 35
final public T
                      top$G(
                      ){
            
//#line 35
throw new x10.
              lang.
              NullPointerException();
        }
        
        
//#line 39
final public void
                      push_0_$$STL$PriorityQueue_T(
                      final T element){
            
        }
        
        
//#line 43
final public void
                      pop(
                      ){
            
        }
        
        
//#line 11
final native public java.lang.String
                      typeName(
                      );
        
        
//#line 11
final public java.lang.String
                      toString(
                      ){
            
//#line 11
return "struct STL.PriorityQueue";
        }
        
        
//#line 11
final public int
                      hashCode(
                      ){
            
//#line 11
int result =
              0;
            
//#line 11
return result;
        }
        
        
//#line 11
final public boolean
                      equals(
                      java.lang.Object other){
            
//#line 11
if ((!(((boolean)(STL.PriorityQueue._RTT.instanceof$(other, T, Compare)))))) {
                
//#line 11
return false;
            }
            
//#line 11
return this.equals_0_$_STL$PriorityQueue_T_$_$_STL$PriorityQueue_Compare_$(((STL.
                                                                                                     PriorityQueue)((new java.lang.Object() {final STL.
                                                                                                     PriorityQueue<T, Compare> cast(final STL.
                                                                                                     PriorityQueue<T, Compare> self) {if (self==null) return null;x10.rtt.Type rtt = new x10.rtt.ParameterizedType(STL.PriorityQueue._RTT, T, Compare);if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((STL.
                                                                                                     PriorityQueue<T, Compare>) other)))));
        }
        
        
//#line 11
final public boolean
                      equals_0_$_STL$PriorityQueue_T_$_$_STL$PriorityQueue_Compare_$(
                      STL.
                        PriorityQueue other){
            
//#line 11
return true;
        }
        
        
//#line 11
final public boolean
                      _struct_equals(
                      java.lang.Object other){
            
//#line 11
if ((!(((boolean)(STL.PriorityQueue._RTT.instanceof$(other, T, Compare)))))) {
                
//#line 11
return false;
            }
            
//#line 11
return this._struct_equals_0_$_STL$PriorityQueue_T_$_$_STL$PriorityQueue_Compare_$(((STL.
                                                                                                             PriorityQueue)((new java.lang.Object() {final STL.
                                                                                                             PriorityQueue<T, Compare> cast(final STL.
                                                                                                             PriorityQueue<T, Compare> self) {if (self==null) return null;x10.rtt.Type rtt = new x10.rtt.ParameterizedType(STL.PriorityQueue._RTT, T, Compare);if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((STL.
                                                                                                             PriorityQueue<T, Compare>) other)))));
        }
        
        
//#line 11
final public boolean
                      _struct_equals_0_$_STL$PriorityQueue_T_$_$_STL$PriorityQueue_Compare_$(
                      STL.
                        PriorityQueue other){
            
//#line 11
return true;
        }
    
}
