public interface Runner<T, Z>
  extends x10.core.fun.Fun_0_2
{
    public static final x10.rtt.RuntimeType<Runner> _RTT = new x10.rtt.RuntimeType<Runner>(
    /* base class */Runner.class, 
    /* variances */ new x10.rtt.RuntimeType.Variance[] {x10.rtt.RuntimeType.Variance.INVARIANT, 
    x10.rtt.RuntimeType.Variance.INVARIANT}
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, new x10.rtt.ParameterizedType(x10.core.fun.Fun_0_2._RTT, new x10.rtt.UnresolvedType(0), new x10.rtt.ParameterizedType(x10.
      lang.
      Reducible._RTT, new x10.rtt.UnresolvedType(1)), new x10.rtt.UnresolvedType(1))}
    ) {public String typeName() {return "Runner";}};
    
        
        
        
//#line 10
void
                      stats(
                      final long time,
                      final boolean verbose);
    
}
