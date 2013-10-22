#ifndef __CORE_TASKFRAME_H
#define __CORE_TASKFRAME_H

#include <x10rt.h>


namespace core { 
template<class TPMGL(T)> class TaskBag;
} 
namespace core { 

template<class TPMGL(T), class TPMGL(Z)> class TaskFrame;
template <> class TaskFrame<void, void>;
template<class TPMGL(T), class TPMGL(Z)> class TaskFrame : public x10::lang::X10Class
  {
    public:
    RTT_H_DECLS_CLASS
    
    core::TaskBag<TPMGL(T)>* FMGL(tb);
    
    virtual x10_boolean runAtMostNTask(x10_long n) = 0;
    virtual TPMGL(Z) getResult() = 0;
    virtual void initTask() = 0;
    virtual core::TaskBag<TPMGL(T)>* getTaskBag() = 0;
    virtual core::TaskFrame<TPMGL(T), TPMGL(Z)>* core__TaskFrame____this__core__TaskFrame(
      );
    void _constructor();
    
    virtual void __fieldInitializers_core_TaskFrame();
    
    // Serialization
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

template<class TPMGL(T), class TPMGL(Z)> x10aux::RuntimeType core::TaskFrame<TPMGL(T), TPMGL(Z)>::rtt;
template<class TPMGL(T), class TPMGL(Z)> void core::TaskFrame<TPMGL(T), TPMGL(Z)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<core::TaskFrame<void, void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType** parents = NULL; 
    const x10aux::RuntimeType* params[2] = { x10aux::getRTT<TPMGL(T)>(), x10aux::getRTT<TPMGL(Z)>()};
    x10aux::RuntimeType::Variance variances[2] = { x10aux::RuntimeType::invariant, x10aux::RuntimeType::invariant};
    const char *baseName = "core.TaskFrame";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::class_kind, 0, parents, 2, params, variances);
}

template <> class TaskFrame<void, void> : public x10::lang::X10Class
{
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    
};

} 
#endif // CORE_TASKFRAME_H

namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class TaskFrame;
} 

#ifndef CORE_TASKFRAME_H_NODEPS
#define CORE_TASKFRAME_H_NODEPS
#include <core/TaskBag.h>
#include <x10/lang/Long.h>
#include <x10/lang/Boolean.h>
#ifndef CORE_TASKFRAME_H_GENERICS
#define CORE_TASKFRAME_H_GENERICS
#endif // CORE_TASKFRAME_H_GENERICS
#ifndef CORE_TASKFRAME_H_IMPLEMENTATION
#define CORE_TASKFRAME_H_IMPLEMENTATION
#include <core/TaskFrame.h>


//#line 9 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 24 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c

//#line 26 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c

//#line 28 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c

//#line 30 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c

//#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> core::TaskFrame<TPMGL(T), TPMGL(Z)>*
  core::TaskFrame<TPMGL(T), TPMGL(Z)>::core__TaskFrame____this__core__TaskFrame(
  ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::TaskFrame<TPMGL(T), TPMGL(Z)>::_constructor(
                                           ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.AssignPropertyCall_c
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10LocalDecl_c
    core::TaskFrame<TPMGL(T), TPMGL(Z)>* this22542 = this;
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22542)->FMGL(tb) = (x10aux::class_cast_unchecked<core::TaskBag<TPMGL(T)>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}


//#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::TaskFrame<TPMGL(T), TPMGL(Z)>::__fieldInitializers_core_TaskFrame(
  ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(tb) = (x10aux::class_cast_unchecked<core::TaskBag<TPMGL(T)>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
template<class TPMGL(T), class TPMGL(Z)> void core::TaskFrame<TPMGL(T), TPMGL(Z)>::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(tb));
    
}

template<class TPMGL(T), class TPMGL(Z)> void core::TaskFrame<TPMGL(T), TPMGL(Z)>::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(tb) = buf.read<core::TaskBag<TPMGL(T)>*>();
}

#endif // CORE_TASKFRAME_H_IMPLEMENTATION
#endif // __CORE_TASKFRAME_H_NODEPS
