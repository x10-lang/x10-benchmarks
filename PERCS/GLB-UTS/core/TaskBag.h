#ifndef __CORE_TASKBAG_H
#define __CORE_TASKBAG_H

#include <x10rt.h>


#define X10_LANG_ANY_H_NODEPS
#include <x10/lang/Any.h>
#undef X10_LANG_ANY_H_NODEPS
namespace core { 

template<class TPMGL(T)> class TaskBag;
template <> class TaskBag<void>;
template<class TPMGL(T)> class TaskBag   {
    public:
    RTT_H_DECLS_INTERFACE
    
    template <class I> struct itable {
        itable(x10_boolean (I::*equals) (x10::lang::Any*), x10_int (I::*hashCode) (), void (I::*merge) (core::TaskBag<TPMGL(T)>*), x10_long (I::*size) (), core::TaskBag<TPMGL(T)>* (I::*split) (), x10::lang::String* (I::*toString) (), x10::lang::String* (I::*typeName) ()) : equals(equals), hashCode(hashCode), merge(merge), size(size), split(split), toString(toString), typeName(typeName) {}
        x10_boolean (I::*equals) (x10::lang::Any*);
        x10_int (I::*hashCode) ();
        void (I::*merge) (core::TaskBag<TPMGL(T)>*);
        x10_long (I::*size) ();
        core::TaskBag<TPMGL(T)>* (I::*split) ();
        x10::lang::String* (I::*toString) ();
        x10::lang::String* (I::*typeName) ();
    };
    
    static x10_boolean equals(core::TaskBag<TPMGL(T)>* _recv, x10::lang::Any* arg0) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->equals))(arg0);
    }
    template <class R> static x10_boolean equals(R _recv, x10::lang::Any* arg0) {
        return _recv->equals(arg0);
    }
    static x10_int hashCode(core::TaskBag<TPMGL(T)>* _recv) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->hashCode))();
    }
    template <class R> static x10_int hashCode(R _recv) {
        return _recv->hashCode();
    }
    static void merge(core::TaskBag<TPMGL(T)>* _recv, core::TaskBag<TPMGL(T)>* arg0) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->merge))(arg0);
    }
    template <class R> static void merge(R _recv, core::TaskBag<TPMGL(T)>* arg0) {
        _recv->merge(arg0);
    }
    static x10_long size(core::TaskBag<TPMGL(T)>* _recv) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->size))();
    }
    template <class R> static x10_long size(R _recv) {
        return _recv->size();
    }
    static core::TaskBag<TPMGL(T)>* split(core::TaskBag<TPMGL(T)>* _recv) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->split))();
    }
    template <class R> static core::TaskBag<TPMGL(T)>* split(R _recv) {
        return _recv->split();
    }
    static x10::lang::String* toString(core::TaskBag<TPMGL(T)>* _recv) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->toString))();
    }
    template <class R> static x10::lang::String* toString(R _recv) {
        return _recv->toString();
    }
    static x10::lang::String* typeName(core::TaskBag<TPMGL(T)>* _recv) {
        x10::lang::Reference* _refRecv = reinterpret_cast<x10::lang::Reference*>(_recv);
        return (_refRecv->*(x10aux::findITable<core::TaskBag<TPMGL(T)> >(_refRecv->_getITables())->typeName))();
    }
    template <class R> static x10::lang::String* typeName(R _recv) {
        return _recv->typeName();
    }
    
};

template<class TPMGL(T)> x10aux::RuntimeType core::TaskBag<TPMGL(T)>::rtt;
template<class TPMGL(T)> void core::TaskBag<TPMGL(T)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<core::TaskBag<void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType* parents[1] = { x10aux::getRTT<x10::lang::Any>()};
    const x10aux::RuntimeType* params[1] = { x10aux::getRTT<TPMGL(T)>()};
    x10aux::RuntimeType::Variance variances[1] = { x10aux::RuntimeType::invariant};
    const char *baseName = "core.TaskBag";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::interface_kind, 1, parents, 1, params, variances);
}

template <> class TaskBag<void> : public x10::lang::X10Class {
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    
};

} 
#endif // CORE_TASKBAG_H

namespace core { 
template<class TPMGL(T)> class TaskBag;
} 

#ifndef CORE_TASKBAG_H_NODEPS
#define CORE_TASKBAG_H_NODEPS
#include <x10/lang/Any.h>
#include <x10/lang/Long.h>
#ifndef CORE_TASKBAG_H_GENERICS
#define CORE_TASKBAG_H_GENERICS
#endif // CORE_TASKBAG_H_GENERICS
#ifndef CORE_TASKBAG_H_IMPLEMENTATION
#define CORE_TASKBAG_H_IMPLEMENTATION
#include <core/TaskBag.h>

#endif // CORE_TASKBAG_H_IMPLEMENTATION
#endif // __CORE_TASKBAG_H_NODEPS
