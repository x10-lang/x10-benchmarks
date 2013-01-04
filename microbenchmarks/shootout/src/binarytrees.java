public class binarytrees
extends x10.core.Ref
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<binarytrees> $RTT = new x10.rtt.NamedType<binarytrees>(
    "binarytrees", /* base class */binarytrees.class
    , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    
    // constructor just for allocation
    public binarytrees(final java.lang.System[] $dummy) { super($dummy);}
    
        
//#line 10 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final public static int
          minDepth =
          4;
        
        
//#line 12 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public static class $Main extends x10.runtime.impl.java.Runtime {
        private static final long serialVersionUID = 1L;
        public static void main(java.lang.String[] args) {
        // start native runtime
        new $Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void runtimeCallback(final x10.array.Array<java.lang.String> args) {
        // call the original app-main method
        binarytrees.main(args);
        }
        }
        
        // the original app-main method
        public static void main(final x10.array.Array<java.lang.String> args) {
            
//#line 13 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final long Starttime =
              x10.lang.System.nanoTime$O();
            
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3507 =
              ((x10.array.Array<java.lang.String>)args).
                size;
            
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3511 =
              ((t3507) > (((int)(0))));
            
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int t3512 =
               0;
            
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (t3511) {
                
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.array.Array<java.lang.String> target2732 =
                  ((x10.array.Array)(args));
                
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.array.Array<java.lang.String> this2733 =
                  ((x10.array.Array)(target2732));
                
//#line 408 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
java.lang.String ret2734 =
                   null;
                
//#line 409 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
__ret2735: {
//#line 412 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
final x10.core.IndexedMemoryChunk<java.lang.String> t3508 =
                                                                                                     ((x10.core.IndexedMemoryChunk)(((x10.array.Array<java.lang.String>)this2733).
                                                                                                                                      raw));
                                                                                                   
//#line 412 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
final java.lang.String t3509 =
                                                                                                     ((java.lang.String)(((java.lang.String[])t3508.value)[0]));
                                                                                                   
//#line 412 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
ret2734 = t3509;
//#line 412 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
break __ret2735;}
                
//#line 408 "/usr/local/x10-2.2.0/stdlib/x10.jar:x10/array/Array.x10"
final java.lang.String t3510 =
                  ret2734;
                
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3512 = java.lang.Integer.parseInt(t3510);
            } else {
                
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3512 = 0;
            }
            
//#line 14 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int n =
              t3512;
            
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3516 =
              ((6) > (((int)(n))));
            
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int t3517 =
               0;
            
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (t3516) {
                
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3517 = 6;
            } else {
                
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3517 = n;
            }
            
//#line 16 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int maxDepth =
              t3517;
            
//#line 17 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int stretchDepth =
              ((maxDepth) + (((int)(1))));
            
//#line 19 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3518 =
              binarytrees.tree((int)(0),
                               (int)(stretchDepth));
            
//#line 19 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int check =
              t3518.itemCheck$O();
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.io.Printer t3522 =
              ((x10.io.Printer)(x10.io.Console.OUT));
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3519 =
              (("stretch tree of depth ") + (((java.lang.Integer)(stretchDepth))));
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3520 =
              ((t3519) + ("\t check: "));
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3521 =
              check;
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3523 =
              ((t3520) + (((java.lang.Integer)(t3521))));
            
//#line 21 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3522.println(((java.lang.String)(t3523)));
            
//#line 23 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode longLivedTree =
              binarytrees.tree((int)(0),
                               (int)(maxDepth));
            {
                
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int depth =
                  4;
                
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
for (;
                                                                                                                                  true;
                                                                                                                                  ) {
                    
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3525 =
                      depth;
                    
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3557 =
                      ((t3525) <= (((int)(maxDepth))));
                    
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (!(t3557)) {
                        
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
break;
                    }
                    {
                        
//#line 26 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3528 =
                          depth;
                        
//#line 26 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3529 =
                          ((maxDepth) - (((int)(t3528))));
                        
//#line 26 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3531 =
                          ((t3529) + (((int)(4))));
                        
//#line 26 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int iterations =
                          ((1) << (((int)(t3531))));
                        
//#line 27 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
check = 0;
                        {
                            
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int i =
                              1;
                            
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
for (;
                                                                                                                                              true;
                                                                                                                                              ) {
                                
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3533 =
                                  i;
                                
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3548 =
                                  ((t3533) <= (((int)(iterations))));
                                
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (!(t3548)) {
                                    
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
break;
                                }
                                {
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3545 =
                                      check;
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3536 =
                                      i;
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3537 =
                                      depth;
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3538 =
                                      binarytrees.tree((int)(t3536),
                                                       (int)(t3537));
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3543 =
                                      t3538.itemCheck$O();
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3539 =
                                      i;
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3540 =
                                      (-(t3539));
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3541 =
                                      depth;
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3542 =
                                      binarytrees.tree((int)(t3540),
                                                       (int)(t3541));
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3544 =
                                      t3542.itemCheck$O();
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3546 =
                                      ((t3543) + (((int)(t3544))));
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3547 =
                                      ((t3545) + (((int)(t3546))));
                                    
//#line 30 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
check = t3547;
                                }
                                {
                                    
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3534 =
                                      i;
                                    
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3535 =
                                      ((t3534) + (((int)(1))));
                                    
//#line 29 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
i = t3535;
                                }
                            }
                        }
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.io.Printer t3555 =
                          ((x10.io.Printer)(x10.io.Console.OUT));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3549 =
                          ((iterations) * (((int)(2))));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3550 =
                          ((((java.lang.Integer)(t3549))) + ("\t trees of depth "));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3551 =
                          depth;
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3552 =
                          ((t3550) + (((java.lang.Integer)(t3551))));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3553 =
                          ((t3552) + ("\t check: "));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3554 =
                          check;
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3556 =
                          ((t3553) + (((java.lang.Integer)(t3554))));
                        
//#line 34 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3555.println(((java.lang.String)(t3556)));
                    }
                    {
                        
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3526 =
                          depth;
                        
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3527 =
                          ((t3526) + (((int)(2))));
                        
//#line 25 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
depth = t3527;
                    }
                }
            }
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.io.Printer t3561 =
              ((x10.io.Printer)(x10.io.Console.OUT));
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3558 =
              (("long lived tree of depth ") + (((java.lang.Integer)(maxDepth))));
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3559 =
              ((t3558) + ("\t check: "));
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3560 =
              longLivedTree.itemCheck$O();
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3562 =
              ((t3559) + (((java.lang.Integer)(t3560))));
            
//#line 36 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3561.println(((java.lang.String)(t3562)));
            
//#line 37 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final long endtime =
              x10.lang.System.nanoTime$O();
            
//#line 38 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final x10.io.Printer t3564 =
              ((x10.io.Printer)(x10.io.Console.OUT));
            
//#line 38 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final long t3563 =
              ((endtime) - (((long)(Starttime))));
            
//#line 38 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final java.lang.String t3565 =
              (("innerloop time: ") + (((java.lang.Long)(t3563))));
            
//#line 38 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3564.println(((java.lang.String)(t3565)));
        }
        
        
//#line 41 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public static binarytrees.TreeNode
                                                                                                                       tree(
                                                                                                                       final int item,
                                                                                                                       final int depth){
            
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3573 =
              ((depth) > (((int)(0))));
            
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
binarytrees.TreeNode t3574 =
               null;
            
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (t3573) {
                
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode alloc480 =
                  ((binarytrees.TreeNode)(new binarytrees.TreeNode((java.lang.System[])null)));
                {
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3566 =
                      ((2) * (((int)(item))));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3567 =
                      ((t3566) - (((int)(1))));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3568 =
                      ((depth) - (((int)(1))));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3571 =
                      binarytrees.tree((int)(t3567),
                                       (int)(t3568));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3569 =
                      ((2) * (((int)(item))));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3570 =
                      ((depth) - (((int)(1))));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3572 =
                      binarytrees.tree((int)(t3569),
                                       (int)(t3570));
                    
//#line 43 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
alloc480.$init(t3571,
                                                                                                                                                t3572,
                                                                                                                                                ((int)(item)));
                }
                
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3574 = ((binarytrees.TreeNode)(alloc480));
            } else {
                
//#line 44 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode alloc481 =
                  ((binarytrees.TreeNode)(new binarytrees.TreeNode((java.lang.System[])null)));
                {
                    
//#line 44 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
alloc481.$init(((binarytrees.TreeNode)(null)),
                                                                                                                                                ((binarytrees.TreeNode)(null)),
                                                                                                                                                ((int)(item)));
                }
                
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3574 = ((binarytrees.TreeNode)(alloc481));
            }
            
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3575 =
              ((binarytrees.TreeNode)(t3574));
            
//#line 42 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
return t3575;
        }
        
        
//#line 47 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public static class TreeNode
                                                                                                                     extends x10.core.Ref
                                                                                                                     {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<TreeNode> $RTT = new x10.rtt.NamedType<TreeNode>(
            "binarytrees.TreeNode", /* base class */TreeNode.class
            , /* parents */ new x10.rtt.Type[] {x10.rtt.Types.OBJECT}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            
            // constructor just for allocation
            public TreeNode(final java.lang.System[] $dummy) { super($dummy);}
            
                
//#line 48 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public binarytrees.TreeNode
                  leftTree;
                
//#line 49 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public binarytrees.TreeNode
                  rightTree;
                
//#line 50 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public int
                  item;
                
                
//#line 51 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
// creation method for java code
                public static binarytrees.TreeNode $make(final binarytrees.TreeNode left,
                                                         final binarytrees.TreeNode right,
                                                         final int num){return new binarytrees.TreeNode((java.lang.System[])null).$init(left,right,num);}
                public binarytrees.TreeNode $init(final binarytrees.TreeNode left,
                                                  final binarytrees.TreeNode right,
                                                  final int num) { {
                                                                          {
                                                                              
//#line 51 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"

                                                                          }
                                                                          {
                                                                              {
                                                                                  
//#line 51 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"

                                                                              }
                                                                              {
                                                                                  
                                                                              }
                                                                          }
                                                                          
//#line 53 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
this.leftTree = ((binarytrees.TreeNode)(left));
                                                                          
//#line 54 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
this.rightTree = ((binarytrees.TreeNode)(right));
                                                                          
//#line 55 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
this.item = num;
                                                                      }
                                                                      return this;
                                                                      }
                
                
//#line 57 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
public int
                                                                                                                               itemCheck$O(
                                                                                                                               ){
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3576 =
                      ((binarytrees.TreeNode)(leftTree));
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final boolean t3583 =
                      ((t3576) == (null));
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
int t3584 =
                       0;
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
if (t3583) {
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3584 = item;
                    } else {
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3578 =
                          item;
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3577 =
                          ((binarytrees.TreeNode)(leftTree));
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3579 =
                          t3577.itemCheck$O();
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3581 =
                          ((t3578) + (((int)(t3579))));
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final binarytrees.TreeNode t3580 =
                          ((binarytrees.TreeNode)(rightTree));
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3582 =
                          t3580.itemCheck$O();
                        
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
t3584 = ((t3581) - (((int)(t3582))));
                    }
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final int t3585 =
                      t3584;
                    
//#line 58 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
return t3585;
                }
                
                
//#line 47 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final public binarytrees.TreeNode
                                                                                                                               binarytrees$TreeNode$$binarytrees$TreeNode$this(
                                                                                                                               ){
                    
//#line 47 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
return binarytrees.TreeNode.this;
                }
            
        }
        
        
        
//#line 9 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
final public binarytrees
                                                                                                                      binarytrees$$binarytrees$this(
                                                                                                                      ){
            
//#line 9 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
return binarytrees.this;
        }
        
        
//#line 9 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"
// creation method for java code
        public static binarytrees $make(){return new binarytrees((java.lang.System[])null).$init();}
        public binarytrees $init() { {
                                            {
                                                
//#line 9 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"

                                            }
                                            {
                                                {
                                                    
//#line 9 "/Users/emontal/Desktop/x10dt/x10dt.app/Contents/MacOS/workspace/Benchmarks/src/binarytrees.x10"

                                                }
                                                {
                                                    
                                                }
                                            }
                                        }
                                        return this;
                                        }
        
        public static int
          getInitialized$minDepth(
          ){
            return binarytrees.minDepth;
        }
    
}
