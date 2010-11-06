
final public class Rmat
extends x10.core.Struct
{
    public static final x10.rtt.RuntimeType<Rmat> _RTT = new x10.rtt.RuntimeType<Rmat>(
    /* base class */Rmat.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, x10.rtt.Types.ANY}
    ) {public String typeName() {return "Rmat";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
//#line 20
public long
          seed;
        
//#line 21
public int
          n;
        
//#line 22
public int
          N;
        
//#line 23
public double
          a;
        
//#line 24
public double
          b;
        
//#line 25
public double
          c;
        
//#line 26
public double
          d;
        
        
//#line 28
public Rmat(final long seed,
                                final int n,
                                final double a,
                                final double b,
                                final double c,
                                final double d) {
            {
                
            }
            
//#line 34
this.seed = seed;
            
//#line 35
this.n = n;
            
//#line 36
this.N = ((int)(double)(((double)(java.lang.Math.pow(((double)(((double)(int)(((int)(2)))))), ((double)(((double)(int)(((int)(n)))))))))));
            
//#line 37
this.a = a;
            
//#line 38
this.b = b;
            
//#line 39
this.c = c;
            
//#line 40
this.d = d;
        }
        
        
//#line 46
final private x10.core.Rail<java.lang.Integer>
                      zeros(
                      final int numElements){
            
//#line 47
return (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int id$13$ = 0; id$13$ < length$; id$13$++) {final int id$13 = id$13$;array$[id$13] = 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(numElements));
        }
        
        final public static x10.core.Rail<java.lang.Integer>
          zeros$P(
          final int numElements,
          final Rmat Rmat){
            return Rmat.zeros((int)(numElements));
        }
        
        
//#line 53
final private x10.core.Rail<java.lang.Double>
                      rand(
                      final x10.
                        util.
                        Random rng,
                      final int numElements){
            
//#line 54
return (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int id$14$ = 0; id$14$ < length$; id$14$++) {final int id$14 = id$14$;array$[id$14] = rng.nextDouble();}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(numElements));
        }
        
        final public static x10.core.Rail<java.lang.Double>
          rand$P(
          final x10.
            util.
            Random rng,
          final int numElements,
          final Rmat Rmat){
            return Rmat.rand(((x10.
                               util.
                               Random)(rng)),
                             (int)(numElements));
        }
        
        
//#line 62
final private x10.core.Rail<java.lang.Integer>
                      greaterThan_0_$_x10$lang$Double_$(
                      final x10.core.Rail lhs,
                      final double rhs){
            
//#line 63
return (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((((double)(((double[])lhs.value)[i]))) > (((double)(rhs))))))
              ? 1
              : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(((x10.core.Rail<java.lang.Double>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Integer>
          greaterThan$P_0_$_x10$lang$Double_$(
          final x10.core.Rail<java.lang.Double> lhs,
          final double rhs,
          final Rmat Rmat){
            return Rmat.greaterThan_0_$_x10$lang$Double_$(((x10.core.Rail)(lhs)),
                                                          (double)(rhs));
        }
        
        
//#line 70
final private x10.core.Rail<java.lang.Integer>
                      greaterThan_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final x10.core.Rail lhs,
                      final x10.core.Rail rhs){
            
//#line 71
return (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((((double)(((double[])lhs.value)[i]))) > (((double)(((double[])rhs.value)[i]))))))
              ? 1
              : 0;}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(((x10.core.Rail<java.lang.Double>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Integer>
          greaterThan$P_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
          final x10.core.Rail<java.lang.Double> lhs,
          final x10.core.Rail<java.lang.Double> rhs,
          final Rmat Rmat){
            return Rmat.greaterThan_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(((x10.core.Rail)(lhs)),
                                                                                ((x10.core.Rail)(rhs)));
        }
        
        
//#line 80
final private x10.core.Rail<java.lang.Double>
                      multiply_0_$_x10$lang$Int_$(
                      final x10.core.Rail lhs,
                      final double multiplier,
                      final boolean flip){
            
//#line 83
return (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;final int lhsMultiplier =
              flip
              ? ((((((((int)(((int[])lhs.value)[i]))) > (((int)(0))))))
                    ? 0
                    : 1))
              : ((int[])lhs.value)[i];array$[i] = ((((double)(multiplier))) * (((double)((((double)(int)(((int)(lhsMultiplier)))))))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(((x10.core.Rail<java.lang.Integer>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Double>
          multiply$P_0_$_x10$lang$Int_$(
          final x10.core.Rail<java.lang.Integer> lhs,
          final double multiplier,
          final boolean flip,
          final Rmat Rmat){
            return Rmat.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(lhs)),
                                                    (double)(multiplier),
                                                    (boolean)(flip));
        }
        
        
//#line 91
final private x10.core.Rail<java.lang.Integer>
                      multiply_0_$_x10$lang$Int_$(
                      final x10.core.Rail lhs,
                      final int multiplier){
            
//#line 93
return (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((int[])lhs.value)[i]))) * (((int)(multiplier))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(((x10.core.Rail<java.lang.Integer>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Integer>
          multiply$P_0_$_x10$lang$Int_$(
          final x10.core.Rail<java.lang.Integer> lhs,
          final int multiplier,
          final Rmat Rmat){
            return Rmat.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(lhs)),
                                                    (int)(multiplier));
        }
        
        
//#line 98
final private x10.core.Rail<java.lang.Double>
                      add_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
                      final x10.core.Rail lhs,
                      final x10.core.Rail rhs){
            
//#line 99
return (new java.lang.Object() {final x10.core.Rail<java.lang.Double> apply(int length$) {double[] array$ = new double[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((double)(((double[])lhs.value)[i]))) + (((double)(((double[])rhs.value)[i]))));}return new x10.core.Rail<java.lang.Double>(x10.rtt.Types.DOUBLE, length$, array$);}}.apply(((x10.core.Rail<java.lang.Double>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Double>
          add$P_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(
          final x10.core.Rail<java.lang.Double> lhs,
          final x10.core.Rail<java.lang.Double> rhs,
          final Rmat Rmat){
            return Rmat.add_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(((x10.core.Rail)(lhs)),
                                                                        ((x10.core.Rail)(rhs)));
        }
        
        
//#line 104
final private x10.core.Rail<java.lang.Integer>
                       add_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                       final x10.core.Rail lhs,
                       final x10.core.Rail rhs){
            
//#line 105
return (new java.lang.Object() {final x10.core.Rail<java.lang.Integer> apply(int length$) {int[] array$ = new int[length$];for (int i$ = 0; i$ < length$; i$++) {final int i = i$;array$[i] = ((((int)(((int[])lhs.value)[i]))) + (((int)(((int[])rhs.value)[i]))));}return new x10.core.Rail<java.lang.Integer>(x10.rtt.Types.INT, length$, array$);}}.apply(((x10.core.Rail<java.lang.Integer>)(lhs)).length()));
        }
        
        final public static x10.core.Rail<java.lang.Integer>
          add$P_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
          final x10.core.Rail<java.lang.Integer> lhs,
          final x10.core.Rail<java.lang.Integer> rhs,
          final Rmat Rmat){
            return Rmat.add_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(((x10.core.Rail)(lhs)),
                                                                  ((x10.core.Rail)(rhs)));
        }
        
        
//#line 116
final private AdjacencyGraph
                       sparse_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
                       final x10.core.Rail row,
                       final x10.core.Rail col){
            
//#line 117
final AdjacencyGraph adjacencyGraph =
              new AdjacencyGraph(this.
                                   N);
            
//#line 118
final int numElements =
              ((x10.core.Rail<java.lang.Integer>)(row)).length();
            
//#line 120
for (
//#line 120
int i =
                                0;
                              ((((int)(i))) < (((int)(numElements))));
                              
//#line 120
i = ((((int)(i))) + (((int)(1))))) {
                
//#line 121
final int v =
                  ((int)(((int[])row.value)[i]));
                
//#line 122
final int w =
                  ((int)(((int[])col.value)[i]));
                
//#line 127
final x10.
                  lang.
                  ULong d =
                  adjacencyGraph.getEdgeWeight((int)(v),
                                               (int)(w));
                
//#line 128
if (((x10.
                                   lang.
                                   ULong) x10.
                                   lang.
                                   ULong.MAX_VALUE).equals(((x10.
                                   lang.
                                   ULong) d))) {
                    
//#line 129
adjacencyGraph.addEdge((int)(v),
                                                        (int)(w),
                                                        (x10.
                                                          lang.
                                                          ULong)(x10.
                                                          lang.
                                                          ULong.$implicit_convert((int)(1))));
                    
//#line 130
adjacencyGraph.incrementInDegree((int)(w));
                } else {
                    
//#line 132
adjacencyGraph.addEdge((int)(v),
                                                        (int)(w),
                                                        (x10.
                                                          lang.
                                                          ULong)(x10.
                                                          lang.
                                                          ULong.$plus((x10.
                                                                        lang.
                                                                        ULong)(d),
                                                                      (x10.
                                                                        lang.
                                                                        ULong)(x10.
                                                                        lang.
                                                                        ULong.$implicit_convert((int)(1))))));
                }
            }
            
//#line 136
return adjacencyGraph;
        }
        
        final public static AdjacencyGraph
          sparse$P_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(
          final x10.core.Rail<java.lang.Integer> row,
          final x10.core.Rail<java.lang.Integer> col,
          final Rmat Rmat){
            return Rmat.sparse_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(((x10.core.Rail)(row)),
                                                                     ((x10.core.Rail)(col)));
        }
        
        
//#line 142
final public AdjacencyGraph
                       generate(
                       ){
            
//#line 144
final int M =
              ((((int)(8))) * (((int)(this.
                                        N))));
            
//#line 145
final x10.
              util.
              Random rng =
              ((x10.
              util.
              Random)(new x10.
              util.
              Random(this.
                       seed)));
            
//#line 148
x10.core.Rail<java.lang.Integer> ii =
              this.zeros((int)(M));
            
//#line 149
x10.core.Rail<java.lang.Integer> jj =
              this.zeros((int)(M));
            
//#line 152
final double ab =
              ((((double)(a))) + (((double)(b))));
            
//#line 153
final double cNorm =
              ((((double)(c))) / (((double)((((((double)(c))) + (((double)(d)))))))));
            
//#line 154
final double aNorm =
              ((((double)(a))) / (((double)((((((double)(a))) + (((double)(b)))))))));
            
//#line 156
for (
//#line 156
int ib =
                                0;
                              ((((int)(ib))) < (((int)(this.
                                                         n))));
                              
//#line 156
ib = ((((int)(ib))) + (((int)(1))))) {
                
//#line 157
final x10.core.Rail<java.lang.Integer> iiBit =
                  ((x10.core.Rail)(this.greaterThan_0_$_x10$lang$Double_$(((x10.core.Rail)(this.rand(((x10.
                                                                                                       util.
                                                                                                       Random)(rng)),
                                                                                                     (int)(M)))),
                                                                          (double)(ab))));
                
//#line 158
final x10.core.Rail<java.lang.Double> jjBitComparator =
                  ((x10.core.Rail)(this.add_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(((x10.core.Rail)(this.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(iiBit)),
                                                                                                                                          (double)(cNorm),
                                                                                                                                          (boolean)(false)))),
                                                                                        ((x10.core.Rail)(this.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(iiBit)),
                                                                                                                                          (double)(aNorm),
                                                                                                                                          (boolean)(true)))))));
                
//#line 160
final x10.core.Rail<java.lang.Integer> jjBit =
                  ((x10.core.Rail)(this.greaterThan_0_$_x10$lang$Double_$_1_$_x10$lang$Double_$(((x10.core.Rail)(this.rand(((x10.
                                                                                                                             util.
                                                                                                                             Random)(rng)),
                                                                                                                           (int)(M)))),
                                                                                                ((x10.core.Rail)(jjBitComparator)))));
                
//#line 161
final int exponent =
                  ((int)(double)(((double)(java.lang.Math.pow(((double)(((double)(int)(((int)(2)))))), ((double)(((double)(int)(((int)(ib)))))))))));
                
//#line 162
ii = this.add_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(((x10.core.Rail)(ii)),
                                                                                 ((x10.core.Rail)(this.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(iiBit)),
                                                                                                                                   (int)(exponent)))));
                
//#line 163
jj = this.add_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(((x10.core.Rail)(jj)),
                                                                                 ((x10.core.Rail)(this.multiply_0_$_x10$lang$Int_$(((x10.core.Rail)(jjBit)),
                                                                                                                                   (int)(exponent)))));
            }
            
//#line 166
return this.sparse_0_$_x10$lang$Int_$_1_$_x10$lang$Int_$(((x10.core.Rail)(ii)),
                                                                                  ((x10.core.Rail)(jj)));
        }
        
        
//#line 19
final native public java.lang.String
                      typeName(
                      );
        
        
//#line 19
final public java.lang.String
                      toString(
                      ){
            
//#line 19
return (((((((((((((((((((((((((((("struct Rmat:") + (" seed="))) + (((java.lang.Long)(this.
                                                                                                                 seed))))) + (" n="))) + (((java.lang.Integer)(this.
                                                                                                                                                                 n))))) + (" N="))) + (((java.lang.Integer)(this.
                                                                                                                                                                                                              N))))) + (" a="))) + (((java.lang.Double)(this.
                                                                                                                                                                                                                                                          a))))) + (" b="))) + (((java.lang.Double)(this.
                                                                                                                                                                                                                                                                                                      b))))) + (" c="))) + (((java.lang.Double)(this.
                                                                                                                                                                                                                                                                                                                                                  c))))) + (" d="))) + (((java.lang.Double)(this.
                                                                                                                                                                                                                                                                                                                                                                                              d))));
        }
        
        
//#line 19
final public int
                      hashCode(
                      ){
            
//#line 19
int result =
              0;
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 seed)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 n)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 N)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 a)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 b)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 c)).hashCode()))));
            
//#line 19
result = ((((int)(((((int)(31))) * (((int)(result))))))) + (((int)(((java.lang.Object)(this.
                                                                                                                 d)).hashCode()))));
            
//#line 19
return result;
        }
        
        
//#line 19
final public boolean
                      equals(
                      java.lang.Object other){
            
//#line 19
if ((!(((boolean)(Rmat._RTT.instanceof$(other)))))) {
                
//#line 19
return false;
            }
            
//#line 19
return this.equals(((Rmat)((new java.lang.Object() {final Rmat cast(final Rmat self) {if (self==null) return null;x10.rtt.Type rtt = Rmat._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((Rmat) other)))));
        }
        
        
//#line 19
final public boolean
                      equals(
                      Rmat other){
            
//#line 19
return ((long) this.
                                         seed) ==
            ((long) other.
                      seed) &&
            ((int) this.
                     n) ==
            ((int) other.
                     n) &&
            ((int) this.
                     N) ==
            ((int) other.
                     N) &&
            ((double) this.
                        a) ==
            ((double) other.
                        a) &&
            ((double) this.
                        b) ==
            ((double) other.
                        b) &&
            ((double) this.
                        c) ==
            ((double) other.
                        c) &&
            ((double) this.
                        d) ==
            ((double) other.
                        d);
        }
        
        
//#line 19
final public boolean
                      _struct_equals(
                      java.lang.Object other){
            
//#line 19
if ((!(((boolean)(Rmat._RTT.instanceof$(other)))))) {
                
//#line 19
return false;
            }
            
//#line 19
return this._struct_equals(((Rmat)((new java.lang.Object() {final Rmat cast(final Rmat self) {if (self==null) return null;x10.rtt.Type rtt = Rmat._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((Rmat) other)))));
        }
        
        
//#line 19
final public boolean
                      _struct_equals(
                      Rmat other){
            
//#line 19
return ((long) this.
                                         seed) ==
            ((long) other.
                      seed) &&
            ((int) this.
                     n) ==
            ((int) other.
                     n) &&
            ((int) this.
                     N) ==
            ((int) other.
                     N) &&
            ((double) this.
                        a) ==
            ((double) other.
                        a) &&
            ((double) this.
                        b) ==
            ((double) other.
                        b) &&
            ((double) this.
                        c) ==
            ((double) other.
                        c) &&
            ((double) this.
                        d) ==
            ((double) other.
                        d);
        }
    
}
