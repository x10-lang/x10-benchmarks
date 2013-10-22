/*************************************************/
/* START of GlobalJobRunner */
#include <core/GlobalJobRunner.h>

x10aux::RuntimeType core::GlobalJobRunner<void, void>::rtt;
x10_long core::GlobalJobRunner<void, void>::min(x10_long i, x10_long j) {
                                                                            
                                                                            //#line 16 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
                                                                            return ((i) < (j))
                                                                              ? (i)
                                                                              : (j);
                                                                            
                                                                        }

/* END of GlobalJobRunner */
/*************************************************/
