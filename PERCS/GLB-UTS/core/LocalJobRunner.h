#ifndef __CORE_LOCALJOBRUNNER_H
#define __CORE_LOCALJOBRUNNER_H

#include <x10rt.h>


#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_BOOLEAN_H_NODEPS
#include <x10/lang/Boolean.h>
#undef X10_LANG_BOOLEAN_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_BOOLEAN_H_NODEPS
#include <x10/lang/Boolean.h>
#undef X10_LANG_BOOLEAN_H_NODEPS
namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class TaskFrame;
} 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace core { 
class Logger;
} 
namespace core { 
template<class TPMGL(T)> class FixedSizeStack;
} 
namespace x10 { namespace util { 
class Random;
} } 
namespace x10 { namespace compiler { 
class Volatile;
} } 
namespace x10 { namespace lang { 
class Runtime;
} } 
namespace core { 
class LifelineGenerator;
} 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class PlaceLocalHandle;
} } 
namespace core { 
template<class TPMGL(T)> class TaskBag;
} 
namespace x10 { namespace lang { 
class Place;
} } 
namespace x10 { namespace lang { 
class VoidFun_0_0;
} } 
namespace x10 { namespace lang { 
class Runtime__Profile;
} } 
namespace x10 { namespace lang { 
class Error;
} } 
namespace x10 { namespace lang { 
class CheckedThrowable;
} } 
namespace x10 { namespace lang { 
class Exception;
} } 
namespace x10 { namespace compiler { 
class AsyncClosure;
} } 
namespace x10 { namespace lang { 
class Any;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace lang { 
class FinishState;
} } 
namespace x10 { namespace compiler { 
class Pragma;
} } 
namespace x10 { namespace compiler { 
class Finalization;
} } 
namespace x10 { namespace compiler { 
class Abort;
} } 
namespace x10 { namespace compiler { 
class CompilerFlags;
} } 
namespace x10 { namespace util { 
class Timer;
} } 
namespace core { 

template<class TPMGL(T), class TPMGL(Z)> class LocalJobRunner;
template <> class LocalJobRunner<void, void>;
template<class TPMGL(T), class TPMGL(Z)> class LocalJobRunner : public x10::lang::X10Class
  {
    public:
    RTT_H_DECLS_CLASS
    
    core::TaskFrame<TPMGL(T), TPMGL(Z)>* FMGL(tf);
    
    x10::lang::Rail<x10_long >* FMGL(victims);
    
    x10::lang::Rail<x10_long >* FMGL(lifelines);
    
    x10_int FMGL(n);
    
    x10_long FMGL(h);
    
    core::Logger* FMGL(logger);
    
    core::FixedSizeStack<x10_long>* FMGL(lifelineThieves);
    
    core::FixedSizeStack<x10_long>* FMGL(thieves);
    
    x10::lang::Rail<x10_boolean >* FMGL(lifelinesActivated);
    
    x10_long FMGL(P);
    
    x10::util::Random* FMGL(random);
    
    x10_int FMGL(w);
    
    x10_int FMGL(m);
    
    volatile x10_boolean FMGL(active);
    
    volatile x10_boolean FMGL(empty);
    
    volatile x10_boolean FMGL(waiting);
    
    x10_long FMGL(last);
    
    x10_long FMGL(phase);
    
    x10_long FMGL(probes);
    
    void _constructor(core::TaskFrame<TPMGL(T), TPMGL(Z)>* tf, x10_int n,
                      x10_int w, x10_int l, x10_int z, x10_int m);
    
    static core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* _make(core::TaskFrame<TPMGL(T), TPMGL(Z)>* tf,
                                                           x10_int n,
                                                           x10_int w,
                                                           x10_int l,
                                                           x10_int z,
                                                           x10_int m);
    
    virtual void probe(x10_long n);
    virtual void processStack(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st);
    virtual x10_boolean processAtMostN();
    virtual void distribute(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st);
    void give(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
              core::TaskBag<TPMGL(T)>* loot);
    virtual void deal(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
                      core::TaskBag<TPMGL(T)>* loot, x10_long source);
    virtual void processLoot(core::TaskBag<TPMGL(T)>* loot,
                             x10_boolean lifeline);
    virtual void reject(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st);
    virtual x10_boolean steal(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st);
    virtual void request(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
                         x10_long thief, x10_boolean lifeline);
    virtual void main(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st);
    virtual core::TaskFrame<TPMGL(T), TPMGL(Z)>* getTF();
    virtual core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* core__LocalJobRunner____this__core__LocalJobRunner(
      );
    virtual void __fieldInitializers_core_LocalJobRunner(
      );
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

template<class TPMGL(T), class TPMGL(Z)> x10aux::RuntimeType core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::rtt;
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<core::LocalJobRunner<void, void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType** parents = NULL; 
    const x10aux::RuntimeType* params[2] = { x10aux::getRTT<TPMGL(T)>(), x10aux::getRTT<TPMGL(Z)>()};
    x10aux::RuntimeType::Variance variances[2] = { x10aux::RuntimeType::invariant, x10aux::RuntimeType::invariant};
    const char *baseName = "core.LocalJobRunner";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::class_kind, 0, parents, 2, params, variances);
}

template <> class LocalJobRunner<void, void> : public x10::lang::X10Class
{
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    static void error(x10::lang::CheckedThrowable* v);
    
    
};

} 
#endif // CORE_LOCALJOBRUNNER_H

namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class LocalJobRunner;
} 

#ifndef CORE_LOCALJOBRUNNER_H_NODEPS
#define CORE_LOCALJOBRUNNER_H_NODEPS
#include <x10/lang/Long.h>
#include <x10/lang/Int.h>
#include <x10/lang/Boolean.h>
#include <core/TaskFrame.h>
#include <x10/lang/Rail.h>
#include <core/Logger.h>
#include <core/FixedSizeStack.h>
#include <x10/util/Random.h>
#include <x10/compiler/Volatile.h>
#include <x10/lang/Runtime.h>
#include <core/LifelineGenerator.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/PlaceLocalHandle.h>
#include <core/TaskBag.h>
#include <x10/lang/Place.h>
#include <x10/lang/VoidFun_0_0.h>
#include <x10/lang/Runtime__Profile.h>
#include <x10/lang/Error.h>
#include <x10/lang/CheckedThrowable.h>
#include <x10/lang/Exception.h>
#include <x10/compiler/AsyncClosure.h>
#include <x10/lang/Any.h>
#include <x10/lang/String.h>
#include <x10/lang/FinishState.h>
#include <x10/compiler/Pragma.h>
#include <x10/compiler/Finalization.h>
#include <x10/compiler/Abort.h>
#include <x10/compiler/CompilerFlags.h>
#include <x10/util/Timer.h>
#ifndef CORE_LOCALJOBRUNNER_H_GENERICS
#define CORE_LOCALJOBRUNNER_H_GENERICS
#endif // CORE_LOCALJOBRUNNER_H_GENERICS
#ifndef CORE_LOCALJOBRUNNER_H_IMPLEMENTATION
#define CORE_LOCALJOBRUNNER_H_IMPLEMENTATION
#include <core/LocalJobRunner.h>

#ifndef CORE_LOCALJOBRUNNER__CLOSURE__1_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__1 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st22311->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
          st22311, loot22312, victim22299);
        
        //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st22311->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311;
    core::TaskBag<TPMGL(T)>* loot22312;
    x10_long victim22299;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st22311);
        buf.write(this->loot22312);
        buf.write(this->victim22299);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st22311 = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot22312 = buf.read<core::TaskBag<TPMGL(T)>*>();
        x10_long that_victim22299 = buf.read<x10_long>();
        core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >(that_st22311, that_loot22312, that_victim22299);
        return this_;
    }
    
    core_LocalJobRunner__closure__1(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311, core::TaskBag<TPMGL(T)>* loot22312, x10_long victim22299) : st22311(st22311), loot22312(loot22312), victim22299(victim22299) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:128";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__1_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__2_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__2_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__2 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st22311->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
          st22311, loot22312, ((x10_long)-1ll));
        
        //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st22311->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311;
    core::TaskBag<TPMGL(T)>* loot22312;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st22311);
        buf.write(this->loot22312);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st22311 = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot22312 = buf.read<core::TaskBag<TPMGL(T)>*>();
        core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >(that_st22311, that_loot22312);
        return this_;
    }
    
    core_LocalJobRunner__closure__2(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311, core::TaskBag<TPMGL(T)>* loot22312) : st22311(st22311), loot22312(loot22312) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:131";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__2_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__3_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__3_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__3 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
        try {
            
            //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(st22311->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
              st22311, loot22312, victim22299);
        }
        catch (x10::lang::CheckedThrowable* __exc20) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc20)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc20);
                {
                    
                    //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc20);
                {
                    
                    //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311;
    core::TaskBag<TPMGL(T)>* loot22312;
    x10_long victim22299;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st22311);
        buf.write(this->loot22312);
        buf.write(this->victim22299);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st22311 = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot22312 = buf.read<core::TaskBag<TPMGL(T)>*>();
        x10_long that_victim22299 = buf.read<x10_long>();
        core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >(that_st22311, that_loot22312, that_victim22299);
        return this_;
    }
    
    core_LocalJobRunner__closure__3(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311, core::TaskBag<TPMGL(T)>* loot22312, x10_long victim22299) : st22311(st22311), loot22312(loot22312), victim22299(victim22299) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:136";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__3_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__4_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__4_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__4 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
          st, loot, victim);
        
        //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    core::TaskBag<TPMGL(T)>* loot;
    x10_long victim;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
        buf.write(this->loot);
        buf.write(this->victim);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot = buf.read<core::TaskBag<TPMGL(T)>*>();
        x10_long that_victim = buf.read<x10_long>();
        core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >(that_st, that_loot, that_victim);
        return this_;
    }
    
    core_LocalJobRunner__closure__4(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st, core::TaskBag<TPMGL(T)>* loot, x10_long victim) : st(st), loot(loot), victim(victim) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:128";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__4_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__5_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__5_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__5 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
          st, loot, ((x10_long)-1ll));
        
        //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    core::TaskBag<TPMGL(T)>* loot;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
        buf.write(this->loot);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot = buf.read<core::TaskBag<TPMGL(T)>*>();
        core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >(that_st, that_loot);
        return this_;
    }
    
    core_LocalJobRunner__closure__5(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st, core::TaskBag<TPMGL(T)>* loot) : st(st), loot(loot) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:131";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__5_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__6_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__6_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__6 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
        try {
            
            //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->deal(
              st, loot, victim);
        }
        catch (x10::lang::CheckedThrowable* __exc22) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc22)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc22);
                {
                    
                    //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc22);
                {
                    
                    //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    core::TaskBag<TPMGL(T)>* loot;
    x10_long victim;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
        buf.write(this->loot);
        buf.write(this->victim);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core::TaskBag<TPMGL(T)>* that_loot = buf.read<core::TaskBag<TPMGL(T)>*>();
        x10_long that_victim = buf.read<x10_long>();
        core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >(that_st, that_loot, that_victim);
        return this_;
    }
    
    core_LocalJobRunner__closure__6(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st, core::TaskBag<TPMGL(T)>* loot, x10_long victim) : st(st), loot(loot), victim(victim) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:136";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__6_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__7_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__7_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__7 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 184 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >(that_st);
        return this_;
    }
    
    core_LocalJobRunner__closure__7(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) : st(st) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:184";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__7_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__8_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__8_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__8 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 186 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >(that_st);
        return this_;
    }
    
    core_LocalJobRunner__closure__8(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) : st(st) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:186";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__8_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__9_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__9_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__9 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 200 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->request(
          st, p, false);
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    x10_long p;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
        buf.write(this->p);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        x10_long that_p = buf.read<x10_long>();
        core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >(that_st, that_p);
        return this_;
    }
    
    core_LocalJobRunner__closure__9(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st, x10_long p) : st(st), p(p) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:200";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__9_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__10_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__10_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__10 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 211 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->request(
          st, p, true);
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    x10_long p;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
        buf.write(this->p);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        x10_long that_p = buf.read<x10_long>();
        core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >(that_st, that_p);
        return this_;
    }
    
    core_LocalJobRunner__closure__10(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st, x10_long p) : st(st), p(p) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:211";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__10_CLOSURE
#ifndef CORE_LOCALJOBRUNNER__CLOSURE__11_CLOSURE
#define CORE_LOCALJOBRUNNER__CLOSURE__11_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_LocalJobRunner__closure__11 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 225 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->
          FMGL(waiting) = false;
    }
    
    // captured environment
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->st);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >(that_st);
        return this_;
    }
    
    core_LocalJobRunner__closure__11(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) : st(st) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10:225";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::VoidFun_0_0::template itable <core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) > >core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::__apply, &core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_LOCALJOBRUNNER__CLOSURE__11_CLOSURE

//#line 13 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 15 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 16 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 17 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 18 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 19 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 20 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 21 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 22 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 23 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 24 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 25 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 26 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 29 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 30 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 31 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 35 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 36 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 37 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 39 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_constructor(
                                           core::TaskFrame<TPMGL(T), TPMGL(Z)>* tf,
                                           x10_int n, x10_int w,
                                           x10_int l, x10_int z,
                                           x10_int m) {
    
    //#line 39 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.AssignPropertyCall_c
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
    this->core::template LocalJobRunner<TPMGL(T), TPMGL(Z)>::__fieldInitializers_core_LocalJobRunner();
    
    //#line 40 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(n) = n;
    
    //#line 41 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(w) = w;
    
    //#line 42 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(m) = m;
    
    //#line 45 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(tf) = tf;
    
    //#line 51 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(h) = ((x10_long)x10aux::here);
    
    //#line 53 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(victims) = x10::lang::Rail<x10_long >::_make(((x10_long) (m)));
    
    //#line 54 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (((this->FMGL(P)) > (((x10_long)1ll)))) {
        
        //#line 54 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.For_c
        {
            x10_long i;
            for (
                 //#line 54 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_long)0ll); ((i) < (((x10_long) (m))));
                 
                 //#line 54 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_long) ((i) + (((x10_long)1ll)))))
            {
                
                //#line 55 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
                while ((x10aux::struct_equals(x10aux::nullCheck(this->
                                                                  FMGL(victims))->x10::lang::template Rail<x10_long >::__set(
                                                i, this->
                                                     FMGL(random)->nextLong(
                                                     this->
                                                       FMGL(P))),
                                              this->FMGL(h))))
                {
                    
                    //#line 55 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Empty_c
                    ;
                }
                
            }
        }
        
    }
    
    //#line 59 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelines) = core::LifelineGenerator::generateHyperCubeLifeLine(
                              this->FMGL(h), this->FMGL(P),
                              ((x10_long) (l)), ((x10_long) (z)));
    
    //#line 62 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineThieves) = (__extension__ ({
        
        //#line 62 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::FixedSizeStack<x10_long>* alloc15551 =  (new (x10aux::alloc_z<core::FixedSizeStack<x10_long> >()) core::FixedSizeStack<x10_long>())
        ;
        
        //#line 62 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
        (alloc15551)->::core::FixedSizeStack<x10_long>::_constructor(
          ((x10_long) (((x10_long)(x10aux::nullCheck(this->
                                                       FMGL(lifelines))->FMGL(size))) + (((x10_long)3ll)))));
        alloc15551;
    }))
    ;
    
    //#line 63 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(thieves) = (__extension__ ({
        
        //#line 63 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::FixedSizeStack<x10_long>* alloc15552 =  (new (x10aux::alloc_z<core::FixedSizeStack<x10_long> >()) core::FixedSizeStack<x10_long>())
        ;
        
        //#line 63 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
        (alloc15552)->::core::FixedSizeStack<x10_long>::_constructor(
          this->FMGL(P));
        alloc15552;
    }))
    ;
    
    //#line 64 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelinesActivated) = x10::lang::Rail<x10_boolean >::_make(this->
                                                                            FMGL(P));
    
    //#line 67 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (((((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                            FMGL(h))))) + (((x10_long)1ll))))) < (this->
                                                                                                    FMGL(P))))
    {
        
        //#line 67 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::FixedSizeStack<x10_long>* this22285 = this->
                                                      FMGL(lifelineThieves);
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
        x10_long t22286 = ((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                                            FMGL(h))))) + (((x10_long)1ll))));
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this22285)->FMGL(data))->x10::lang::template Rail<x10_long >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
              core::FixedSizeStack<x10_long>* x22284 = this22285;
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x22284)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x22284)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), t22286);
    }
    
    //#line 68 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (((((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                            FMGL(h))))) + (((x10_long)2ll))))) < (this->
                                                                                                    FMGL(P))))
    {
        
        //#line 68 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::FixedSizeStack<x10_long>* this22288 = this->
                                                      FMGL(lifelineThieves);
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
        x10_long t22289 = ((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                                            FMGL(h))))) + (((x10_long)2ll))));
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this22288)->FMGL(data))->x10::lang::template Rail<x10_long >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
              core::FixedSizeStack<x10_long>* x22287 = this22288;
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x22287)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x22287)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), t22289);
    }
    
    //#line 69 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (((((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                            FMGL(h))))) + (((x10_long)3ll))))) < (this->
                                                                                                    FMGL(P))))
    {
        
        //#line 69 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::FixedSizeStack<x10_long>* this22291 = this->
                                                      FMGL(lifelineThieves);
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
        x10_long t22292 = ((x10_long) ((((x10_long) ((((x10_long)3ll)) * (this->
                                                                            FMGL(h))))) + (((x10_long)3ll))));
        
        //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this22291)->FMGL(data))->x10::lang::template Rail<x10_long >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
              core::FixedSizeStack<x10_long>* x22290 = this22291;
              
              //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x22290)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x22290)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), t22292);
    }
    
    //#line 70 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (((this->FMGL(h)) > (((x10_long)0ll)))) {
        
        //#line 70 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(lifelinesActivated))->x10::lang::template Rail<x10_boolean >::__set(
          ((x10_long) ((((x10_long) ((this->FMGL(h)) - (((x10_long)1ll))))) / x10aux::zeroCheck(((x10_long)3ll)))),
          true);
    }
    
    //#line 72 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(logger) = (__extension__ ({
        
        //#line 72 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* alloc15553 =  (new (x10aux::alloc_z<core::Logger>()) core::Logger())
        ;
        
        //#line 72 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
        (alloc15553)->::core::Logger::_constructor(true);
        alloc15553;
    }))
    ;
}
template<class TPMGL(T), class TPMGL(Z)> core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_make(
                                           core::TaskFrame<TPMGL(T), TPMGL(Z)>* tf,
                                           x10_int n, x10_int w,
                                           x10_int l, x10_int z,
                                           x10_int m) {
    core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this_ = new (x10aux::alloc_z<core::LocalJobRunner<TPMGL(T), TPMGL(Z)> >()) core::LocalJobRunner<TPMGL(T), TPMGL(Z)>();
    this_->_constructor(tf, n, w, l, z, m);
    return this_;
}



//#line 81 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::probe(
  x10_long n) {
    
    //#line 83 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
    x10::lang::Runtime::probe();
}

//#line 86 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::processStack(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) {
    
    //#line 87 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Do_c
    do {
        
        //#line 88 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
        while ((__extension__ ({
                   
                   //#line 88 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                   core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this22109 =
                     this;
                   
                   //#line 103 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                   x10_boolean ret22110;
                   
                   //#line 105 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                   x10_boolean result22293 = x10aux::nullCheck(x10aux::nullCheck(this22109)->
                                                                 FMGL(tf))->runAtMostNTask(
                                               ((x10_long) (x10aux::nullCheck(this22109)->
                                                              FMGL(n))));
                   
                   //#line 107 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
                   ret22110 = result22293;
                   ret22110;
               }))
               ) {
            
            //#line 89 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            this->probe(((x10_long)9999999ll));
            
            //#line 91 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            this->distribute(st);
            
            //#line 93 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            this->reject(st);
        }
        
        //#line 95 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        this->reject(st);
    } while (this->steal(st));
    
}

//#line 103 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> x10_boolean core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::processAtMostN(
  ) {
    
    //#line 105 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_boolean result = x10aux::nullCheck(this->FMGL(tf))->runAtMostNTask(
                           ((x10_long) (this->FMGL(n))));
    
    //#line 107 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Return_c
    return result;
    
}

//#line 110 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::distribute(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) {
    
    //#line 111 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    core::TaskBag<TPMGL(T)>* loot;
    
    //#line 112 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
    while (((((__extension__ ({
                
                //#line 112 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22112 =
                  this->FMGL(thieves);
                x10aux::nullCheck(this22112)->FMGL(size);
            }))
            ) > (((x10_long)0ll))) || (((__extension__ ({
                
                //#line 112 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22113 =
                  this->FMGL(lifelineThieves);
                x10aux::nullCheck(this22113)->FMGL(size);
            }))
            ) > (((x10_long)0ll)))) && (!x10aux::struct_equals((loot =
                                                                  core::TaskBag<TPMGL(T)>::split(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                                                       FMGL(tf))->getTaskBag()))),
                                                               reinterpret_cast<x10::lang::NullType*>(X10_NULL))))
    {
        
        //#line 114 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this22310 =
          this;
        
        //#line 121 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st22311 =
          st;
        
        //#line 121 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::TaskBag<TPMGL(T)>* loot22312 = loot;
        
        //#line 122 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long victim22299 = ((x10_long)x10aux::here);
        
        //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22297 = x10aux::nullCheck(this22310)->
                                 FMGL(logger);
        
        //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long y22298 = core::TaskBag<TPMGL(T)>::size(x10aux::nullCheck(loot22312));
        
        //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22297)->FMGL(nodesGiven) = ((x10_long) ((x10aux::nullCheck(x22297)->
                                                                      FMGL(nodesGiven)) + (y22298)));
        
        //#line 124 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if ((((__extension__ ({
                
                //#line 124 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22300 =
                  x10aux::nullCheck(this22310)->FMGL(thieves);
                x10aux::nullCheck(this22300)->FMGL(size);
            }))
            ) > (((x10_long)0ll)))) {
            
            //#line 125 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long thief22301 = (__extension__ ({
                
                //#line 125 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22302 =
                  x10aux::nullCheck(this22310)->FMGL(thieves);
                x10aux::nullCheck(x10aux::nullCheck(this22302)->
                                    FMGL(data))->x10::lang::template Rail<x10_long >::__apply(
                  (__extension__ ({
                      
                      //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                      core::FixedSizeStack<x10_long>* x22303 =
                        this22302;
                      
                      //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                      ;
                      x10aux::nullCheck(x22303)->FMGL(size) =
                        ((x10_long) ((x10aux::nullCheck(x22303)->
                                        FMGL(size)) - (((x10_long)1ll))));
                  }))
                  );
            }))
            ;
            
            //#line 126 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (((thief22301) >= (((x10_long)0ll)))) {
                
                //#line 127 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22294 = x10aux::nullCheck(this22310)->
                                         FMGL(logger);
                
                //#line 127 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22294)->FMGL(lifelineStealsSuffered) =
                  ((x10_long) ((x10aux::nullCheck(x22294)->
                                  FMGL(lifelineStealsSuffered)) + (((x10_long)1ll))));
                
                //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                          
                                                          //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                          x10::lang::Place alloc22304 =
                                                            
                                                          x10::lang::Place::_alloc();
                                                          
                                                          //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                          (alloc22304)->::x10::lang::Place::_constructor(
                                                            thief22301);
                                                          alloc22304;
                                                      }))
                                                      , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__1<TPMGL(T),TPMGL(Z)>(st22311, loot22312, victim22299))),
                                                      x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
            } else {
                
                //#line 130 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22295 = x10aux::nullCheck(this22310)->
                                         FMGL(logger);
                
                //#line 130 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22295)->FMGL(stealsSuffered) =
                  ((x10_long) ((x10aux::nullCheck(x22295)->
                                  FMGL(stealsSuffered)) + (((x10_long)1ll))));
                
                //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                          
                                                          //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                          x10::lang::Place alloc22305 =
                                                            
                                                          x10::lang::Place::_alloc();
                                                          
                                                          //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                          (alloc22305)->::x10::lang::Place::_constructor(
                                                            ((x10_long) ((((x10_long) -(thief22301))) - (((x10_long)1ll)))));
                                                          alloc22305;
                                                      }))
                                                      , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__2<TPMGL(T),TPMGL(Z)>(st22311, loot22312))),
                                                      x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
            }
            
        } else {
            
            //#line 134 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22296 = x10aux::nullCheck(this22310)->
                                     FMGL(logger);
            
            //#line 134 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22296)->FMGL(lifelineStealsSuffered) =
              ((x10_long) ((x10aux::nullCheck(x22296)->FMGL(lifelineStealsSuffered)) + (((x10_long)1ll))));
            
            //#line 135 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long thief22306 = (__extension__ ({
                
                //#line 135 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22307 =
                  x10aux::nullCheck(this22310)->FMGL(lifelineThieves);
                x10aux::nullCheck(x10aux::nullCheck(this22307)->
                                    FMGL(data))->x10::lang::template Rail<x10_long >::__apply(
                  (__extension__ ({
                      
                      //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                      core::FixedSizeStack<x10_long>* x22308 =
                        this22307;
                      
                      //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                      ;
                      x10aux::nullCheck(x22308)->FMGL(size) =
                        ((x10_long) ((x10aux::nullCheck(x22308)->
                                        FMGL(size)) - (((x10_long)1ll))));
                  }))
                  );
            }))
            ;
            
            //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runAsync((__extension__ ({
                                             
                                             //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                             x10::lang::Place alloc22309 =
                                                x10::lang::Place::_alloc();
                                             
                                             //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                             (alloc22309)->::x10::lang::Place::_constructor(
                                               thief22306);
                                             alloc22309;
                                         }))
                                         , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__3<TPMGL(T),TPMGL(Z)>(st22311, loot22312, victim22299))),
                                         x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        }
        
    }
    
}

//#line 121 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::give(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
  core::TaskBag<TPMGL(T)>* loot) {
    
    //#line 122 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long victim = ((x10_long)x10aux::here);
    
    //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    core::Logger* x22316 = this->FMGL(logger);
    
    //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long y22317 = core::TaskBag<TPMGL(T)>::size(x10aux::nullCheck(loot));
    
    //#line 123 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x22316)->FMGL(nodesGiven) = ((x10_long) ((x10aux::nullCheck(x22316)->
                                                                  FMGL(nodesGiven)) + (y22317)));
    
    //#line 124 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if ((((__extension__ ({
            
            //#line 124 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22154 = this->
                                                          FMGL(thieves);
            x10aux::nullCheck(this22154)->FMGL(size);
        }))
        ) > (((x10_long)0ll)))) {
        
        //#line 125 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long thief = (__extension__ ({
            
            //#line 125 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22157 = this->
                                                          FMGL(thieves);
            x10aux::nullCheck(x10aux::nullCheck(this22157)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__apply(
              (__extension__ ({
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22158 =
                    this22157;
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22158)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22158)->
                                    FMGL(size)) - (((x10_long)1ll))));
              }))
              );
        }))
        ;
        
        //#line 126 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (((thief) >= (((x10_long)0ll)))) {
            
            //#line 127 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22313 = this->FMGL(logger);
            
            //#line 127 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22313)->FMGL(lifelineStealsSuffered) =
              ((x10_long) ((x10aux::nullCheck(x22313)->FMGL(lifelineStealsSuffered)) + (((x10_long)1ll))));
            
            //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15554 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 128 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15554)->::x10::lang::Place::_constructor(
                                                        thief);
                                                      alloc15554;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__4<TPMGL(T),TPMGL(Z)>(st, loot, victim))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        } else {
            
            //#line 130 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22314 = this->FMGL(logger);
            
            //#line 130 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22314)->FMGL(stealsSuffered) =
              ((x10_long) ((x10aux::nullCheck(x22314)->FMGL(stealsSuffered)) + (((x10_long)1ll))));
            
            //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15555 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 131 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15555)->::x10::lang::Place::_constructor(
                                                        ((x10_long) ((((x10_long) -(thief))) - (((x10_long)1ll)))));
                                                      alloc15555;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__5<TPMGL(T),TPMGL(Z)>(st, loot))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        }
        
    } else {
        
        //#line 134 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22315 = this->FMGL(logger);
        
        //#line 134 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22315)->FMGL(lifelineStealsSuffered) =
          ((x10_long) ((x10aux::nullCheck(x22315)->FMGL(lifelineStealsSuffered)) + (((x10_long)1ll))));
        
        //#line 135 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long thief = (__extension__ ({
            
            //#line 135 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22168 = this->
                                                          FMGL(lifelineThieves);
            x10aux::nullCheck(x10aux::nullCheck(this22168)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__apply(
              (__extension__ ({
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22169 =
                    this22168;
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22169)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22169)->
                                    FMGL(size)) - (((x10_long)1ll))));
              }))
              );
        }))
        ;
        
        //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10::lang::Runtime::runAsync((__extension__ ({
                                         
                                         //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                         x10::lang::Place alloc15556 =
                                            x10::lang::Place::_alloc();
                                         
                                         //#line 136 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                         (alloc15556)->::x10::lang::Place::_constructor(
                                           thief);
                                         alloc15556;
                                     }))
                                     , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__6<TPMGL(T),TPMGL(Z)>(st, loot, victim))),
                                     x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    }
    
}

//#line 141 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::deal(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
  core::TaskBag<TPMGL(T)>* loot, x10_long source) {
    
    //#line 142 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
    try {
        
        //#line 143 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_boolean lifeline = ((source) >= (((x10_long)0ll)));
        
        //#line 144 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (lifeline) {
            
            //#line 144 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(lifelinesActivated))->x10::lang::template Rail<x10_boolean >::__set(
              source, false);
        }
        
        //#line 145 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        this->FMGL(empty) = false;
        
        //#line 146 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (this->FMGL(active)) {
            
            //#line 147 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this22325 =
              this;
            
            //#line 166 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::TaskBag<TPMGL(T)>* loot22326 = loot;
            
            //#line 166 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_boolean lifeline22327 = lifeline;
            
            //#line 167 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long n22324 = core::TaskBag<TPMGL(T)>::size(x10aux::nullCheck(loot22326));
            
            //#line 168 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (lifeline22327) {
                
                //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22318 = x10aux::nullCheck(this22325)->
                                         FMGL(logger);
                
                //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22318)->FMGL(lifelineStealsPerpetrated) =
                  ((x10_long) ((x10aux::nullCheck(x22318)->
                                  FMGL(lifelineStealsPerpetrated)) + (((x10_long)1ll))));
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22319 = x10aux::nullCheck(this22325)->
                                         FMGL(logger);
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                x10_long y22320 = n22324;
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22319)->FMGL(lifelineNodesReceived) =
                  ((x10_long) ((x10aux::nullCheck(x22319)->
                                  FMGL(lifelineNodesReceived)) + (y22320)));
            } else {
                
                //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22321 = x10aux::nullCheck(this22325)->
                                         FMGL(logger);
                
                //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22321)->FMGL(stealsPerpetrated) =
                  ((x10_long) ((x10aux::nullCheck(x22321)->
                                  FMGL(stealsPerpetrated)) + (((x10_long)1ll))));
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22322 = x10aux::nullCheck(this22325)->
                                         FMGL(logger);
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                x10_long y22323 = n22324;
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22322)->FMGL(nodesReceived) =
                  ((x10_long) ((x10aux::nullCheck(x22322)->
                                  FMGL(nodesReceived)) + (y22323)));
            }
            
            //#line 175 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            core::TaskBag<TPMGL(T)>::merge(x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this22325)->
                                                                                 FMGL(tf))->getTaskBag()), 
              loot22326);
        } else {
            
            //#line 150 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            this->FMGL(active) = true;
            
            //#line 151 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(logger))->startLive();
            
            //#line 152 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this22335 =
              this;
            
            //#line 166 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::TaskBag<TPMGL(T)>* loot22336 = loot;
            
            //#line 166 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_boolean lifeline22337 = lifeline;
            
            //#line 167 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long n22334 = core::TaskBag<TPMGL(T)>::size(x10aux::nullCheck(loot22336));
            
            //#line 168 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (lifeline22337) {
                
                //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22328 = x10aux::nullCheck(this22335)->
                                         FMGL(logger);
                
                //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22328)->FMGL(lifelineStealsPerpetrated) =
                  ((x10_long) ((x10aux::nullCheck(x22328)->
                                  FMGL(lifelineStealsPerpetrated)) + (((x10_long)1ll))));
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22329 = x10aux::nullCheck(this22335)->
                                         FMGL(logger);
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                x10_long y22330 = n22334;
                
                //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22329)->FMGL(lifelineNodesReceived) =
                  ((x10_long) ((x10aux::nullCheck(x22329)->
                                  FMGL(lifelineNodesReceived)) + (y22330)));
            } else {
                
                //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22331 = x10aux::nullCheck(this22335)->
                                         FMGL(logger);
                
                //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22331)->FMGL(stealsPerpetrated) =
                  ((x10_long) ((x10aux::nullCheck(x22331)->
                                  FMGL(stealsPerpetrated)) + (((x10_long)1ll))));
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22332 = x10aux::nullCheck(this22335)->
                                         FMGL(logger);
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                x10_long y22333 = n22334;
                
                //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22332)->FMGL(nodesReceived) =
                  ((x10_long) ((x10aux::nullCheck(x22332)->
                                  FMGL(nodesReceived)) + (y22333)));
            }
            
            //#line 175 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            core::TaskBag<TPMGL(T)>::merge(x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this22335)->
                                                                                 FMGL(tf))->getTaskBag()), 
              loot22336);
            
            //#line 154 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            this->core::template LocalJobRunner<TPMGL(T), TPMGL(Z)>::processStack(
              st);
            
            //#line 155 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(logger))->stopLive();
            
            //#line 156 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            this->FMGL(active) = false;
        }
        
    }
    catch (x10::lang::CheckedThrowable* __exc24) {
        if (true) {
            x10::lang::CheckedThrowable* v = static_cast<x10::lang::CheckedThrowable*>(__exc24);
            {
                
                //#line 162 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                core::LocalJobRunner<void, void>::error(v);
            }
        } else
        throw;
    }
}

//#line 166 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::processLoot(
  core::TaskBag<TPMGL(T)>* loot, x10_boolean lifeline) {
    
    //#line 167 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long n = core::TaskBag<TPMGL(T)>::size(x10aux::nullCheck(loot));
    
    //#line 168 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if (lifeline) {
        
        //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22338 = this->FMGL(logger);
        
        //#line 169 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22338)->FMGL(lifelineStealsPerpetrated) =
          ((x10_long) ((x10aux::nullCheck(x22338)->FMGL(lifelineStealsPerpetrated)) + (((x10_long)1ll))));
        
        //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22339 = this->FMGL(logger);
        
        //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long y22340 = n;
        
        //#line 170 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22339)->FMGL(lifelineNodesReceived) =
          ((x10_long) ((x10aux::nullCheck(x22339)->FMGL(lifelineNodesReceived)) + (y22340)));
    } else {
        
        //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22341 = this->FMGL(logger);
        
        //#line 172 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22341)->FMGL(stealsPerpetrated) =
          ((x10_long) ((x10aux::nullCheck(x22341)->FMGL(stealsPerpetrated)) + (((x10_long)1ll))));
        
        //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        core::Logger* x22342 = this->FMGL(logger);
        
        //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long y22343 = n;
        
        //#line 173 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x22342)->FMGL(nodesReceived) = ((x10_long) ((x10aux::nullCheck(x22342)->
                                                                         FMGL(nodesReceived)) + (y22343)));
    }
    
    //#line 175 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
    core::TaskBag<TPMGL(T)>::merge(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                         FMGL(tf))->getTaskBag()), 
      loot);
}

//#line 179 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::reject(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) {
    
    //#line 180 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
    while ((((__extension__ ({
               
               //#line 180 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
               core::FixedSizeStack<x10_long>* this22223 =
                 this->FMGL(thieves);
               x10aux::nullCheck(this22223)->FMGL(size);
           }))
           ) > (((x10_long)0ll)))) {
        
        //#line 181 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10_long thief = (__extension__ ({
            
            //#line 181 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22226 = this->
                                                          FMGL(thieves);
            x10aux::nullCheck(x10aux::nullCheck(this22226)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__apply(
              (__extension__ ({
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22227 =
                    this22226;
                  
                  //#line 11 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22227)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22227)->
                                    FMGL(size)) - (((x10_long)1ll))));
              }))
              );
        }))
        ;
        
        //#line 182 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (((thief) >= (((x10_long)0ll)))) {
            
            //#line 183 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22345 = this->
                                                          FMGL(lifelineThieves);
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
            x10_long t22346 = thief;
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this22345)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22344 =
                    this22345;
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22344)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22344)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), t22346);
            
            //#line 184 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 184 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15557 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 184 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15557)->::x10::lang::Place::_constructor(
                                                        thief);
                                                      alloc15557;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__7<TPMGL(T),TPMGL(Z)>(st))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        } else {
            
            //#line 186 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 186 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15558 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 186 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15558)->::x10::lang::Place::_constructor(
                                                        ((x10_long) ((((x10_long) -(thief))) - (((x10_long)1ll)))));
                                                      alloc15558;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__8<TPMGL(T),TPMGL(Z)>(st))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        }
        
    }
    
}

//#line 191 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> x10_boolean core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::steal(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) {
    
    //#line 192 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(this->FMGL(P), ((x10_long)1ll))))
    {
        
        //#line 192 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Return_c
        return false;
        
    }
    
    //#line 193 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long p = ((x10_long)x10aux::here);
    
    //#line 194 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(empty) = true;
    
    //#line 195 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 195 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < (((x10_long) (this->
                                                         FMGL(w))))) &&
                                  this->FMGL(empty); 
                                                     //#line 195 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
                                                     i = ((x10_long) ((i) + (((x10_long)1ll)))))
        {
            
            //#line 196 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22347 = this->FMGL(logger);
            
            //#line 196 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22347)->FMGL(stealsAttempted) =
              ((x10_long) ((x10aux::nullCheck(x22347)->FMGL(stealsAttempted)) + (((x10_long)1ll))));
            
            //#line 197 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            this->FMGL(waiting) = true;
            
            //#line 198 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(logger))->stopLive();
            
            //#line 199 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long v = x10aux::nullCheck(this->FMGL(victims))->x10::lang::template Rail<x10_long >::__apply(
                           ((x10_long) (this->FMGL(random)->nextInt(
                                          this->FMGL(m)))));
            
            //#line 200 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 200 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15559 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 200 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15559)->::x10::lang::Place::_constructor(
                                                        v);
                                                      alloc15559;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__9<TPMGL(T),TPMGL(Z)>(st, p))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
            
            //#line 201 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
            while (this->FMGL(waiting)) {
                
                //#line 201 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                this->probe(v);
            }
            
            //#line 202 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(logger))->startLive();
        }
    }
    
    //#line 204 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 204 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < ((x10_long)(x10aux::nullCheck(this->
                                                                         FMGL(lifelines))->FMGL(size)))) &&
                                  this->FMGL(empty) && ((((x10_long)0ll)) <= (x10aux::nullCheck(this->
                                                                                                  FMGL(lifelines))->x10::lang::template Rail<x10_long >::__apply(
                                                                                i)));
             
             //#line 204 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 205 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10_long lifeline = x10aux::nullCheck(this->FMGL(lifelines))->x10::lang::template Rail<x10_long >::__apply(
                                  i);
            
            //#line 206 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (!(x10aux::nullCheck(this->FMGL(lifelinesActivated))->x10::lang::template Rail<x10_boolean >::__apply(
                    lifeline))) {
                
                //#line 207 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::Logger* x22348 = this->FMGL(logger);
                
                //#line 207 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x22348)->FMGL(lifelineStealsAttempted) =
                  ((x10_long) ((x10aux::nullCheck(x22348)->
                                  FMGL(lifelineStealsAttempted)) + (((x10_long)1ll))));
                
                //#line 208 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this->FMGL(lifelinesActivated))->x10::lang::template Rail<x10_boolean >::__set(
                  lifeline, true);
                
                //#line 209 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                this->FMGL(waiting) = true;
                
                //#line 210 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this->FMGL(logger))->stopLive();
                
                //#line 211 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                          
                                                          //#line 211 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                          x10::lang::Place alloc15560 =
                                                            
                                                          x10::lang::Place::_alloc();
                                                          
                                                          //#line 211 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                          (alloc15560)->::x10::lang::Place::_constructor(
                                                            lifeline);
                                                          alloc15560;
                                                      }))
                                                      , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__10<TPMGL(T),TPMGL(Z)>(st, p))),
                                                      x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
                
                //#line 212 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10While_c
                while (this->FMGL(waiting)) {
                    
                    //#line 212 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                    this->probe(((x10_long) -(lifeline)));
                }
                
                //#line 213 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this->FMGL(logger))->startLive();
            }
            
        }
    }
    
    //#line 216 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Return_c
    return !(this->FMGL(empty));
    
}

//#line 220 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::request(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st,
  x10_long thief, x10_boolean lifeline) {
    
    //#line 221 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
    try {
        
        //#line 222 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (lifeline) {
            
            //#line 222 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22349 = this->FMGL(logger);
            
            //#line 222 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22349)->FMGL(lifelineStealsReceived) =
              ((x10_long) ((x10aux::nullCheck(x22349)->FMGL(lifelineStealsReceived)) + (((x10_long)1ll))));
        } else {
            
            //#line 222 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::Logger* x22350 = this->FMGL(logger);
            
            //#line 222 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x22350)->FMGL(stealsReceived) =
              ((x10_long) ((x10aux::nullCheck(x22350)->FMGL(stealsReceived)) + (((x10_long)1ll))));
        }
        
        //#line 223 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (this->FMGL(empty) || this->FMGL(waiting)) {
            
            //#line 224 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (lifeline) {
                
                //#line 224 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                core::FixedSizeStack<x10_long>* this22352 =
                  this->FMGL(lifelineThieves);
                
                //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                x10_long t22353 = thief;
                
                //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(x10aux::nullCheck(this22352)->
                                    FMGL(data))->x10::lang::template Rail<x10_long >::__set(
                  ((x10_long) (((__extension__ ({
                      
                      //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                      core::FixedSizeStack<x10_long>* x22351 =
                        this22352;
                      
                      //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                      ;
                      x10aux::nullCheck(x22351)->FMGL(size) =
                        ((x10_long) ((x10aux::nullCheck(x22351)->
                                        FMGL(size)) + (((x10_long)1ll))));
                  }))
                  ) - (((x10_long)1ll)))), t22353);
            }
            
            //#line 225 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runUncountedAsync((__extension__ ({
                                                      
                                                      //#line 225 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                      x10::lang::Place alloc15561 =
                                                         x10::lang::Place::_alloc();
                                                      
                                                      //#line 225 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                      (alloc15561)->::x10::lang::Place::_constructor(
                                                        thief);
                                                      alloc15561;
                                                  }))
                                                  , reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z)>)))core_LocalJobRunner__closure__11<TPMGL(T),TPMGL(Z)>(st))),
                                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        } else 
        //#line 227 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
        if (lifeline) {
            
            //#line 227 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22355 = this->
                                                          FMGL(thieves);
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
            x10_long t22356 = thief;
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this22355)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22354 =
                    this22355;
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22354)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22354)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), t22356);
        } else {
            
            //#line 227 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            core::FixedSizeStack<x10_long>* this22358 = this->
                                                          FMGL(thieves);
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
            x10_long t22359 = ((x10_long) ((((x10_long) -(thief))) - (((x10_long)1ll))));
            
            //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this22358)->
                                FMGL(data))->x10::lang::template Rail<x10_long >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": x10.ast.X10LocalDecl_c
                  core::FixedSizeStack<x10_long>* x22357 =
                    this22358;
                  
                  //#line 12 "/home/weiz/outgoing/wglb/core/FixedSizeStack.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x22357)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x22357)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), t22359);
        }
        
    }
    catch (x10::lang::CheckedThrowable* __exc29) {
        if (true) {
            x10::lang::CheckedThrowable* v = static_cast<x10::lang::CheckedThrowable*>(__exc29);
            {
                
                //#line 230 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                core::LocalJobRunner<void, void>::error(v);
            }
        } else
        throw;
    }
}

//#line 233 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c

//#line 238 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::main(
  x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) {
    {
        
        //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
        x10::lang::Runtime::ensureNotInAtomic();
        
        //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10::lang::FinishState* x10____var0 = x10::lang::Runtime::startFinish(
                                                x10::compiler::Pragma::
                                                  FMGL(FINISH_DENSE__get)());
        {
            
            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
            x10::lang::CheckedThrowable* throwable22398 =
              x10aux::class_cast_unchecked<x10::lang::CheckedThrowable*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
            
            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
            try {
                
                //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
                try {
                    {
                        
                        //#line 240 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Try_c
                        try {
                            
                            //#line 242 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                            this->FMGL(empty) = false;
                            
                            //#line 243 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                            this->FMGL(active) = true;
                            
                            //#line 244 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                            x10aux::nullCheck(this->FMGL(logger))->startLive();
                            
                            //#line 246 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                            x10aux::nullCheck(this->FMGL(tf))->initTask();
                            
                            //#line 248 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                            this->core::template LocalJobRunner<TPMGL(T), TPMGL(Z)>::processStack(
                              st);
                            
                            //#line 250 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                            x10aux::nullCheck(this->FMGL(logger))->stopLive();
                            
                            //#line 251 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
                            this->FMGL(active) = false;
                        }
                        catch (x10::lang::CheckedThrowable* __exc31) {
                            if (true) {
                                x10::lang::CheckedThrowable* v =
                                  static_cast<x10::lang::CheckedThrowable*>(__exc31);
                                {
                                    
                                    //#line 256 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                                    core::LocalJobRunner<void, void>::error(
                                      v);
                                }
                            } else
                            throw;
                        }
                    }
                }
                catch (x10::lang::CheckedThrowable* __exc32) {
                    if (true) {
                        x10::lang::CheckedThrowable* __lowerer__var__0__ =
                          static_cast<x10::lang::CheckedThrowable*>(__exc32);
                        {
                            
                            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                            x10::lang::Runtime::pushException(
                              __lowerer__var__0__);
                            
                            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                            x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::_make()));
                        }
                    } else
                    throw;
                }
                
                //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10::compiler::Finalization::plausibleThrow();
            }
            catch (x10::lang::CheckedThrowable* __exc33) {
                if (true) {
                    x10::lang::CheckedThrowable* formal22399 =
                      static_cast<x10::lang::CheckedThrowable*>(__exc33);
                    {
                        
                        //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
                        throwable22398 = formal22399;
                    }
                } else
                throw;
            }
            
            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                        throwable22398)))
            {
                
                //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
                if (x10aux::instanceof<x10::compiler::Abort*>(throwable22398))
                {
                    
                    //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(throwable22398));
                }
                
            }
            
            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if (true) {
                
                //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10Call_c
                x10::lang::Runtime::stopFinish(x10____var0);
            }
            
            //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
            if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                        throwable22398)))
            {
                
                //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10If_c
                if (!(x10aux::instanceof<x10::compiler::Finalization*>(throwable22398)))
                {
                    
                    //#line 239 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(throwable22398));
                }
                
            }
            
        }
    }
}

//#line 262 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> core::TaskFrame<TPMGL(T), TPMGL(Z)>*
  core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::getTF() {
    
    //#line 263 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Return_c
    return this->FMGL(tf);
    
}

//#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*
  core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::core__LocalJobRunner____this__core__LocalJobRunner(
  ) {
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::__fieldInitializers_core_LocalJobRunner(
  ) {
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(P) = ((x10_long)x10aux::num_hosts);
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(random) = (__extension__ ({
        
        //#line 24 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": x10.ast.X10LocalDecl_c
        x10::util::Random* alloc15562 =  (new (x10aux::alloc_z<x10::util::Random>()) x10::util::Random())
        ;
        
        //#line 18 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Random.x10": x10.ast.X10ConstructorCall_c
        (alloc15562)->::x10::util::Random::_constructor(x10::lang::RuntimeNatives::currentTimeMillis());
        alloc15562;
    }))
    ;
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(active) = false;
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(empty) = true;
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(waiting) = false;
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(last) = ((x10_long)0ll);
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(phase) = ((x10_long)0ll);
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LocalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(probes) = ((x10_long)0ll);
}
template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(tf));
    buf.write(this->FMGL(victims));
    buf.write(this->FMGL(lifelines));
    buf.write(this->FMGL(n));
    buf.write(this->FMGL(h));
    buf.write(this->FMGL(logger));
    buf.write(this->FMGL(lifelineThieves));
    buf.write(this->FMGL(thieves));
    buf.write(this->FMGL(lifelinesActivated));
    buf.write(this->FMGL(P));
    buf.write(this->FMGL(random));
    buf.write(this->FMGL(w));
    buf.write(this->FMGL(m));
    buf.write(this->FMGL(last));
    buf.write(this->FMGL(phase));
    buf.write(this->FMGL(probes));
    
}

template<class TPMGL(T), class TPMGL(Z)> x10::lang::Reference* core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_deserializer(x10aux::deserialization_buffer& buf) {
    core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* this_ = new (x10aux::alloc_z<core::LocalJobRunner<TPMGL(T), TPMGL(Z)> >()) core::LocalJobRunner<TPMGL(T), TPMGL(Z)>();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

template<class TPMGL(T), class TPMGL(Z)> void core::LocalJobRunner<TPMGL(T), TPMGL(Z)>::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(tf) = buf.read<core::TaskFrame<TPMGL(T), TPMGL(Z)>*>();
    FMGL(victims) = buf.read<x10::lang::Rail<x10_long >*>();
    FMGL(lifelines) = buf.read<x10::lang::Rail<x10_long >*>();
    FMGL(n) = buf.read<x10_int>();
    FMGL(h) = buf.read<x10_long>();
    FMGL(logger) = buf.read<core::Logger*>();
    FMGL(lifelineThieves) = buf.read<core::FixedSizeStack<x10_long>*>();
    FMGL(thieves) = buf.read<core::FixedSizeStack<x10_long>*>();
    FMGL(lifelinesActivated) = buf.read<x10::lang::Rail<x10_boolean >*>();
    FMGL(P) = buf.read<x10_long>();
    FMGL(random) = buf.read<x10::util::Random*>();
    FMGL(w) = buf.read<x10_int>();
    FMGL(m) = buf.read<x10_int>();
    FMGL(last) = buf.read<x10_long>();
    FMGL(phase) = buf.read<x10_long>();
    FMGL(probes) = buf.read<x10_long>();
}

#endif // CORE_LOCALJOBRUNNER_H_IMPLEMENTATION
#endif // __CORE_LOCALJOBRUNNER_H_NODEPS
