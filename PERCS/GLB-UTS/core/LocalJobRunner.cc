/*************************************************/
/* START of LocalJobRunner */
#include <core/LocalJobRunner.h>

x10aux::RuntimeType core::LocalJobRunner<void, void>::rtt;
void core::LocalJobRunner<void, void>::error(x10::lang::CheckedThrowable* v)
{
    
    //#line 234 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
    x10::lang::RuntimeNatives::println(x10aux::to_string(reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10aux::makeStringLit("Exception at "), x10::lang::Place::_make(x10aux::here))))->c_str());
    
    //#line 235 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
    (v)->printStackTrace();
}

/* END of LocalJobRunner */
/*************************************************/
