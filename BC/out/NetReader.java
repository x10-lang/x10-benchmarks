
final public class NetReader
extends x10.core.Struct
{
    public static final x10.rtt.RuntimeType<NetReader> _RTT = new x10.rtt.RuntimeType<NetReader>(
    /* base class */NetReader.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.ANY, x10.rtt.Types.ANY}
    ) {public String typeName() {return "NetReader";}};
    public x10.rtt.RuntimeType<?> getRTT() {return _RTT;}
    
    
    
        
        
//#line 8
final public static AdjacencyGraph
                     readNetFile(
                     final java.lang.String fileName,
                     final int startIndex){
            
//#line 12
final x10.
              io.
              File inputFile =
              new x10.
              io.
              File(fileName);
            
//#line 13
final x10.
              io.
              Reader inputFileReader =
              ((x10.
                io.
                Reader)
                inputFile.openRead());
            
//#line 14
final x10.
              io.
              ReaderIterator<java.lang.String> inputFileIterator =
              inputFileReader.lines();
            
//#line 17
final java.lang.String firstLine =
              (((x10.
              io.
              ReaderIterator<java.lang.String>)(inputFileIterator)).next$G()).toLowerCase();
            
//#line 18
final int N =
              ((((((int)(0))) > (((int)((firstLine).lastIndexOf("*vertices")))))))
              ? -1
              : new Object() { int eval(String s) { try { return java.lang.Integer.parseInt(s); } catch (java.lang.NumberFormatException e) { throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(e); } } }.eval(((java.lang.String)((java.lang.String[])x10.core.RailFactory.<java.lang.String>makeRailFromJavaArray(x10.rtt.Types.STRING, (firstLine).split(" ")).value)[1]));
            
//#line 22
if (((((int)(0))) > (((int)(N))))) {
                
//#line 22
throw new x10.
                  lang.
                  Exception("Incorrect File Format");
            }
            
//#line 24
final AdjacencyGraph adjacencyGraph =
              new AdjacencyGraph(N);
            
//#line 27
boolean foundEdges =
              false;
            
//#line 28
while (((x10.
                                 io.
                                 ReaderIterator<java.lang.String>)(inputFileIterator)).hasNext()) {
                
//#line 29
final java.lang.String thisLine =
                  ((((x10.
                  io.
                  ReaderIterator<java.lang.String>)(inputFileIterator)).next$G()).toLowerCase()).trim();
                
//#line 31
if (((((int)(0))) <= (((int)((thisLine).lastIndexOf("*edgeslist"))))) ||
                                ((((int)(0))) <= (((int)((thisLine).lastIndexOf("*arcslist")))))) {
                    
//#line 33
throw new x10.
                      lang.
                      Exception("We do not support EdgesList or ArcsList");
                } else {
                    
//#line 34
if (((((int)(0))) <= (((int)((thisLine).lastIndexOf("*edges"))))) ||
                                    ((((int)(0))) <= (((int)((thisLine).lastIndexOf("*arcs")))))) {
                        
//#line 36
foundEdges = true;
                        
//#line 37
continue;
                    }
                }
                
//#line 41
if (foundEdges) {
                    
//#line 42
final x10.core.Rail<java.lang.String> tokens =
                      x10.core.RailFactory.<java.lang.String>makeRailFromJavaArray(x10.rtt.Types.STRING, (thisLine).split(" "));
                    
//#line 44
if (((int) 3) !=
                                    ((int) ((x10.core.Rail<java.lang.String>)(tokens)).length()) &&
                                    ((int) 2) !=
                                    ((int) ((x10.core.Rail<java.lang.String>)(tokens)).length())) {
                        
//#line 45
throw new x10.
                          lang.
                          Exception("Format not \"src dest weight\"");
                    }
                    
//#line 47
final int source =
                      ((((int)(new Object() { int eval(String s) { try { return java.lang.Integer.parseInt(s); } catch (java.lang.NumberFormatException e) { throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(e); } } }.eval(((java.lang.String)((java.lang.String[])tokens.value)[0]))))) - (((int)(startIndex))));
                    
//#line 48
final int destination =
                      ((((int)(new Object() { int eval(String s) { try { return java.lang.Integer.parseInt(s); } catch (java.lang.NumberFormatException e) { throw x10.core.ThrowableUtilities.getCorrespondingX10Exception(e); } } }.eval(((java.lang.String)((java.lang.String[])tokens.value)[1]))))) - (((int)(startIndex))));
                    
//#line 49
final x10.
                      lang.
                      ULong weight =
                      ((((int) 2) ==
                        ((int) ((x10.core.Rail<java.lang.String>)(tokens)).length())))
                      ? x10.
                      lang.
                      ULong.$implicit_convert((int)(1))
                      : x10.
                      lang.
                      ULong.parse(((java.lang.String)(((java.lang.String)((java.lang.String[])tokens.value)[2]))));
                    
//#line 52
adjacencyGraph.addEdge((int)(source),
                                                       (int)(destination),
                                                       (x10.
                                                         lang.
                                                         ULong)(weight));
                    
//#line 53
adjacencyGraph.incrementInDegree((int)(destination));
                }
            }
            
//#line 56
return adjacencyGraph;
        }
        
        
//#line 6
final native public java.lang.String
                     typeName(
                     );
        
        
//#line 6
final public java.lang.String
                     toString(
                     ){
            
//#line 6
return "struct NetReader";
        }
        
        
//#line 6
final public int
                     hashCode(
                     ){
            
//#line 6
int result =
              0;
            
//#line 6
return result;
        }
        
        
//#line 6
final public boolean
                     equals(
                     java.lang.Object other){
            
//#line 6
if ((!(((boolean)(NetReader._RTT.instanceof$(other)))))) {
                
//#line 6
return false;
            }
            
//#line 6
return this.equals(((NetReader)((new java.lang.Object() {final NetReader cast(final NetReader self) {if (self==null) return null;x10.rtt.Type rtt = NetReader._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((NetReader) other)))));
        }
        
        
//#line 6
final public boolean
                     equals(
                     NetReader other){
            
//#line 6
return true;
        }
        
        
//#line 6
final public boolean
                     _struct_equals(
                     java.lang.Object other){
            
//#line 6
if ((!(((boolean)(NetReader._RTT.instanceof$(other)))))) {
                
//#line 6
return false;
            }
            
//#line 6
return this._struct_equals(((NetReader)((new java.lang.Object() {final NetReader cast(final NetReader self) {if (self==null) return null;x10.rtt.Type rtt = NetReader._RTT;if (rtt != null && ! rtt.instanceof$(self)) throw new x10.lang.ClassCastException();return self;}}.cast((NetReader) other)))));
        }
        
        
//#line 6
final public boolean
                     _struct_equals(
                     NetReader other){
            
//#line 6
return true;
        }
        
        
//#line 6
public NetReader() {
            {
                
            }
        }
    
}
