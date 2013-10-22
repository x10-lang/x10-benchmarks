#ifndef __CORE_GLOBALJOBRUNNER_H
#define __CORE_GLOBALJOBRUNNER_H

#include <x10rt.h>


namespace x10 { namespace compiler { 
class Inline;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Reducible;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(U)> class Fun_0_0;
} } 
namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class LocalJobRunner;
} 
namespace x10 { namespace lang { 
class Place;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class PlaceLocalHandle;
} } 
namespace x10 { namespace lang { 
class PlaceGroup;
} } 
namespace x10 { namespace io { 
class Printer;
} } 
namespace x10 { namespace io { 
class Console;
} } 
namespace x10 { namespace lang { 
class Any;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(Z1), class TPMGL(U)> class Fun_0_1;
} } 
namespace x10 { namespace lang { 
class Runtime;
} } 
namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class TaskFrame;
} 
namespace x10 { namespace lang { 
class CheckedThrowable;
} } 
namespace x10 { namespace lang { 
class Runtime__Profile;
} } 
namespace core { 

template<class TPMGL(T), class TPMGL(Z)> class GlobalJobRunner;
template <> class GlobalJobRunner<void, void>;
template<class TPMGL(T), class TPMGL(Z)> class GlobalJobRunner : public x10::lang::X10Class
  {
    public:
    RTT_H_DECLS_CLASS
    
    x10::lang::Reducible<TPMGL(Z)>* FMGL(resultReducer);
    
    virtual x10::lang::Reducible<TPMGL(Z)>* getResultReducer() = 0;
    virtual void setResultReducer(x10::lang::Reducible<TPMGL(Z)>* r) = 0;
    virtual TPMGL(Z) main(x10::lang::Fun_0_0<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>* init);
    virtual TPMGL(Z) getFinalResult(x10::lang::Rail<TPMGL(Z) >* results);
    virtual core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>* core__GlobalJobRunner____this__core__GlobalJobRunner(
      );
    void _constructor();
    
    virtual void __fieldInitializers_core_GlobalJobRunner(
      );
    
    // Serialization
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

template<class TPMGL(T), class TPMGL(Z)> x10aux::RuntimeType core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::rtt;
template<class TPMGL(T), class TPMGL(Z)> void core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<core::GlobalJobRunner<void, void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType** parents = NULL; 
    const x10aux::RuntimeType* params[2] = { x10aux::getRTT<TPMGL(T)>(), x10aux::getRTT<TPMGL(Z)>()};
    x10aux::RuntimeType::Variance variances[2] = { x10aux::RuntimeType::invariant, x10aux::RuntimeType::invariant};
    const char *baseName = "core.GlobalJobRunner";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::class_kind, 0, parents, 2, params, variances);
}

template <> class GlobalJobRunner<void, void> : public x10::lang::X10Class
{
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    static x10_long min(x10_long i, x10_long j);
    
    
};

} 
#endif // CORE_GLOBALJOBRUNNER_H

namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class GlobalJobRunner;
} 

#ifndef CORE_GLOBALJOBRUNNER_H_NODEPS
#define CORE_GLOBALJOBRUNNER_H_NODEPS
#include <x10/lang/Long.h>
#include <x10/lang/Boolean.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/Reducible.h>
#include <x10/lang/Fun_0_0.h>
#include <core/LocalJobRunner.h>
#include <x10/lang/Place.h>
#include <x10/lang/PlaceLocalHandle.h>
#include <x10/lang/PlaceGroup.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Fun_0_1.h>
#include <x10/lang/Runtime.h>
#include <core/TaskFrame.h>
#include <x10/lang/CheckedThrowable.h>
#include <x10/lang/Runtime__Profile.h>
#ifndef CORE_GLOBALJOBRUNNER_H_GENERICS
#define CORE_GLOBALJOBRUNNER_H_GENERICS
#endif // CORE_GLOBALJOBRUNNER_H_GENERICS
#ifndef CORE_GLOBALJOBRUNNER_H_IMPLEMENTATION
#define CORE_GLOBALJOBRUNNER_H_IMPLEMENTATION
#include <core/GlobalJobRunner.h>

#ifndef CORE_GLOBALJOBRUNNER__CLOSURE__2_CLOSURE
#define CORE_GLOBALJOBRUNNER__CLOSURE__2_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
template<class TPMGL(T), class TPMGL(Z)> class core_GlobalJobRunner__closure__2 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::Fun_0_0<TPMGL(Z)>::template itable <core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    TPMGL(Z) __apply() {
        
        //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": polyglot.ast.Try_c
        try {
            
            //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->getTF())->getResult();
            
        }
        catch (x10::lang::CheckedThrowable* __exc9) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc9);
                {
                    
                    //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
                    TPMGL(Z) __lowerer__var__1__ = x10aux::class_cast_unchecked<TPMGL(Z)>(x10::lang::Runtime::template wrapAtChecked<TPMGL(Z) >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
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
        core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >(that_st);
        return this_;
    }
    
    core_GlobalJobRunner__closure__2(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) : st(st) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<TPMGL(Z)> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<TPMGL(Z)> >(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10:31";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::Fun_0_0<TPMGL(Z)>::template itable <core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) > >core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::__apply, &core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<TPMGL(Z)> >, &core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_GLOBALJOBRUNNER__CLOSURE__2_CLOSURE
#ifndef CORE_GLOBALJOBRUNNER__CLOSURE__1_CLOSURE
#define CORE_GLOBALJOBRUNNER__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_1.h>
template<class TPMGL(T), class TPMGL(Z)> class core_GlobalJobRunner__closure__1 : public x10::lang::Closure {
    public:
    
    static typename x10::lang::Fun_0_1<x10_long, TPMGL(Z)>::template itable <core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > > _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    TPMGL(Z) __apply(x10_long i) {
        
        //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
        return x10::lang::Runtime::template evalAt<TPMGL(Z) >((__extension__ ({
                                                                  
                                                                  //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
                                                                  x10::lang::Place alloc15570 =
                                                                    
                                                                  x10::lang::Place::_alloc();
                                                                  
                                                                  //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10ConstructorCall_c
                                                                  (alloc15570)->::x10::lang::Place::_constructor(
                                                                    i);
                                                                  alloc15570;
                                                              }))
                                                              ,
                                                              reinterpret_cast<x10::lang::Fun_0_0<TPMGL(Z)>*>((new (x10aux::alloc<x10::lang::Fun_0_0<TPMGL(Z)> >(sizeof(core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z)>)))core_GlobalJobRunner__closure__2<TPMGL(T),TPMGL(Z)>(st))),
                                                              x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
        
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
        core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >* storage = x10aux::alloc_z<core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > >();
        buf.record_reference(storage);
        x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> that_st = buf.read<x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> >();
        core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >* this_ = new (storage) core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >(that_st);
        return this_;
    }
    
    core_GlobalJobRunner__closure__1(x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st) : st(st) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_1<x10_long, TPMGL(Z)> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_1<x10_long, TPMGL(Z)> >(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10:31";
    }

};

template<class TPMGL(T), class TPMGL(Z)> typename x10::lang::Fun_0_1<x10_long, TPMGL(Z)>::template itable <core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) > >core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::__apply, &core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::toString, &x10::lang::Closure::typeName);
template<class TPMGL(T), class TPMGL(Z)> x10aux::itable_entry core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_1<x10_long, TPMGL(Z)> >, &core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_itable),x10aux::itable_entry(NULL, NULL)};

template<class TPMGL(T), class TPMGL(Z)> const x10aux::serialization_id_t core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z) >::template _deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

#endif // CORE_GLOBALJOBRUNNER__CLOSURE__1_CLOSURE

//#line 16 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c

//#line 18 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10FieldDecl_c

//#line 20 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c

//#line 21 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c

//#line 23 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> TPMGL(Z) core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::main(
  x10::lang::Fun_0_0<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>* init) {
    
    //#line 24 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long P = ((x10_long)x10aux::num_hosts);
    
    //#line 25 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10::lang::PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*> st =
      x10::lang::PlaceLocalHandle<void>::template makeFlat<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>* >(
        reinterpret_cast<x10::lang::PlaceGroup*>(x10::lang::PlaceGroup::
                                                   FMGL(WORLD__get)()),
        init);
    
    //#line 26 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("Starting...")));
    
    //#line 28 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(st->x10::lang::template PlaceLocalHandle<core::LocalJobRunner<TPMGL(T), TPMGL(Z)>*>::__apply())->main(
      st);
    
    //#line 31 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<TPMGL(Z) >* results = x10::lang::Rail<TPMGL(Z) >::_make(P,
                                                                            reinterpret_cast<x10::lang::Fun_0_1<x10_long, TPMGL(Z)>*>((new (x10aux::alloc<x10::lang::Fun_0_1<x10_long, TPMGL(Z)> >(sizeof(core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z)>)))core_GlobalJobRunner__closure__1<TPMGL(T),TPMGL(Z)>(st))));
    
    //#line 32 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    TPMGL(Z) result = this->getFinalResult(results);
    
    //#line 34 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
    return result;
    
}

//#line 57 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> TPMGL(Z) core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::getFinalResult(
  x10::lang::Rail<TPMGL(Z) >* results) {
    
    //#line 58 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    TPMGL(Z) r = x10::lang::Reducible<TPMGL(Z)>::zero(x10aux::nullCheck(this->getResultReducer()));
    
    //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<TPMGL(Z) >* rail16371 = results;
    
    //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    x10_long size16372 = (x10_long)(x10aux::nullCheck(rail16371)->FMGL(size));
    
    //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": polyglot.ast.For_c
    {
        x10_long idx16373;
        for (
             //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
             idx16373 = ((x10_long)0ll); ((idx16373) < (size16372));
             
             //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
             idx16373 = ((x10_long) ((idx16373) + (((x10_long)1ll)))))
        {
            
            //#line 59 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
            TPMGL(Z) p16374 = x10aux::nullCheck(rail16371)->x10::lang::template Rail<TPMGL(Z) >::__apply(
                                idx16373);
            
            //#line 60 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10LocalAssign_c
            r = x10::lang::Reducible<TPMGL(Z)>::__apply(x10aux::nullCheck(this->getResultReducer()), 
                  r, p16374);
        }
    }
    
    //#line 62 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
    return r;
    
}

//#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>*
  core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::core__GlobalJobRunner____this__core__GlobalJobRunner(
  ) {
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::_constructor(
                                           ) {
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.AssignPropertyCall_c
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10LocalDecl_c
    core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>* this16375 =
      this;
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this16375)->FMGL(resultReducer) = (x10aux::class_cast_unchecked<x10::lang::Reducible<TPMGL(Z)>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}


//#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(T), class TPMGL(Z)> void core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::__fieldInitializers_core_GlobalJobRunner(
  ) {
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(resultReducer) = (x10aux::class_cast_unchecked<x10::lang::Reducible<TPMGL(Z)>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
template<class TPMGL(T), class TPMGL(Z)> void core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(resultReducer));
    
}

template<class TPMGL(T), class TPMGL(Z)> void core::GlobalJobRunner<TPMGL(T), TPMGL(Z)>::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(resultReducer) = buf.read<x10::lang::Reducible<TPMGL(Z)>*>();
}

#endif // CORE_GLOBALJOBRUNNER_H_IMPLEMENTATION
#endif // __CORE_GLOBALJOBRUNNER_H_NODEPS
