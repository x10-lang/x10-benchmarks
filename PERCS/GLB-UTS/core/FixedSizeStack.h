#ifndef __CORE_FIXEDSIZESTACK_H
#define __CORE_FIXEDSIZESTACK_H

#include <x10rt.h>


#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace core { 

template<class TPMGL(T)> class FixedSizeStack;
template <> class FixedSizeStack<void>;
template<class TPMGL(T)> class FixedSizeStack : public x10::lang::X10Class
  {
    public:
    RTT_H_DECLS_CLASS
    
    x10::lang::Rail<TPMGL(T) >* FMGL(data);
    
    x10_long FMGL(size);
    
    void _constructor(x10_long n);
    
    static core::FixedSizeStack<TPMGL(T)>* _make(x10_long n);
    
    virtual TPMGL(T) pop();
    virtual void push(TPMGL(T) t);
    virtual x10_long size();
    virtual core::FixedSizeStack<TPMGL(T)>* core__FixedSizeStack____this__core__FixedSizeStack(
      );
    virtual void __fieldInitializers_core_FixedSizeStack();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

template<class TPMGL(T)> x10aux::RuntimeType core::FixedSizeStack<TPMGL(T)>::rtt;
template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<core::FixedSizeStack<void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType** parents = NULL; 
    const x10aux::RuntimeType* params[1] = { x10aux::getRTT<TPMGL(T)>()};
    x10aux::RuntimeType::Variance variances[1] = { x10aux::RuntimeType::invariant};
    const char *baseName = "core.FixedSizeStack";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::class_kind, 0, parents, 1, params, variances);
}

template <> class FixedSizeStack<void> : public x10::lang::X10Class
{
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    
};

} 
#endif // CORE_FIXEDSIZESTACK_H

namespace core { 
template<class TPMGL(T)> class FixedSizeStack;
} 

#ifndef CORE_FIXEDSIZESTACK_H_NODEPS
#define CORE_FIXEDSIZESTACK_H_NODEPS
#include <x10/lang/Long.h>
#include <x10/lang/Rail.h>
#include <x10/compiler/Inline.h>
#ifndef CORE_FIXEDSIZESTACK_H_GENERICS
#define CORE_FIXEDSIZESTACK_H_GENERICS
#endif // CORE_FIXEDSIZESTACK_H_GENERICS
#ifndef CORE_FIXEDSIZESTACK_H_IMPLEMENTATION
#define CORE_FIXEDSIZESTACK_H_IMPLEMENTATION
#include <core/FixedSizeStack.h>


//#line 5 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10FieldDecl_c

//#line 6 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::_constructor(
                           x10_long n) {
    
    //#line 7 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
    core::FixedSizeStack<TPMGL(T)>* this26322 = this;
    
    //#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this26322)->FMGL(size) = ((x10_long)0ll);
    
    //#line 8 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(data) = x10::lang::Rail<TPMGL(T) >::_make(n);
    
    //#line 9 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = ((x10_long)0ll);
}
template<class TPMGL(T)> core::FixedSizeStack<TPMGL(T)>* core::FixedSizeStack<TPMGL(T)>::_make(
                           x10_long n) {
    core::FixedSizeStack<TPMGL(T)>* this_ = new (x10aux::alloc_z<core::FixedSizeStack<TPMGL(T)> >()) core::FixedSizeStack<TPMGL(T)>();
    this_->_constructor(n);
    return this_;
}



//#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T)> TPMGL(T) core::FixedSizeStack<TPMGL(T)>::pop(
  ) {
    
    //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10Return_c
    return x10aux::nullCheck(this->FMGL(data))->x10::lang::template Rail<TPMGL(T) >::__apply(
             (__extension__ ({
                 
                 //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                 core::FixedSizeStack<TPMGL(T)>* x26318 =
                   this;
                 
                 //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                 ;
                 x10aux::nullCheck(x26318)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x26318)->
                                                                         FMGL(size)) - (((x10_long)1ll))));
             }))
             );
    
}

//#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::push(
  TPMGL(T) t) {
    
    //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(this->FMGL(data))->x10::lang::template Rail<TPMGL(T) >::__set(
      ((x10_long) (((__extension__ ({
          
          //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
          core::FixedSizeStack<TPMGL(T)>* x26320 = this;
          
          //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
          ;
          x10aux::nullCheck(x26320)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x26320)->
                                                                  FMGL(size)) + (((x10_long)1ll))));
      }))
      ) - (((x10_long)1ll)))), t);
}

//#line 13 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T)> x10_long core::FixedSizeStack<TPMGL(T)>::size(
  ) {
    
    //#line 13 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10Return_c
    return this->FMGL(size);
    
}

//#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T)> core::FixedSizeStack<TPMGL(T)>* core::FixedSizeStack<TPMGL(T)>::core__FixedSizeStack____this__core__FixedSizeStack(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::__fieldInitializers_core_FixedSizeStack(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = ((x10_long)0ll);
}
template<class TPMGL(T)> const x10aux::serialization_id_t core::FixedSizeStack<TPMGL(T)>::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core::FixedSizeStack<TPMGL(T)>::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(data));
    buf.write(this->FMGL(size));
    
}

template<class TPMGL(T)> x10::lang::Reference* core::FixedSizeStack<TPMGL(T)>::_deserializer(x10aux::deserialization_buffer& buf) {
    core::FixedSizeStack<TPMGL(T)>* this_ = new (x10aux::alloc_z<core::FixedSizeStack<TPMGL(T)> >()) core::FixedSizeStack<TPMGL(T)>();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

template<class TPMGL(T)> void core::FixedSizeStack<TPMGL(T)>::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(data) = buf.read<x10::lang::Rail<TPMGL(T) >*>();
    FMGL(size) = buf.read<x10_long>();
}

#endif // CORE_FIXEDSIZESTACK_H_IMPLEMENTATION
#endif // __CORE_FIXEDSIZESTACK_H_NODEPS
