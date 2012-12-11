#ifndef SHA1RAND_H
#define SHA1RAND_H

#include <x10rt.h>

#define X10_LANG_ANY_H_NODEPS
#include <x10/lang/Any.h>
#undef X10_LANG_ANY_H_NODEPS

namespace x10 {
    namespace lang {
        class String;
    }
}

#include "sha1_rand.hpp"
#include <x10aux/config.h>
#include <x10aux/ref.h>
#include <x10aux/RTT.h>
#include <x10aux/serialization.h>

class SHA1RandX {
public:
    RTT_H_DECLS_STRUCT
        
    sha1_rand FMGL(cxx_sha1_rng);
    x10_int FMGL(depth);

    SHA1RandX* operator->() { return this; }
    
    static x10aux::itable_entry _itables[2];
    x10aux::itable_entry* _getITables() { return _itables; }
    static x10::lang::Any::itable<SHA1RandX > _itable_0;

    static x10aux::itable_entry _iboxitables[2];
    x10aux::itable_entry* _getIBoxITables() { return _iboxitables; }

    static SHA1RandX _alloc() {
        SHA1RandX t;
        memset(&t, 0, sizeof(SHA1RandX));
        return t;
    }

    inline static SHA1RandX _make(x10_int seed) {
        SHA1RandX this_;
        this_->_constructor(seed);
        return this_;
    }
    void _constructor(x10_int seed) {
        FMGL(cxx_sha1_rng).init((int)seed);
        FMGL(depth) = 0;
    }
    
    inline static SHA1RandX _make(SHA1RandX parent, x10_int spawn_number) {
        SHA1RandX this_;
        this_->_constructor(parent, spawn_number);
        return this_;
    }
    void _constructor(SHA1RandX parent, x10_int spawn_number) {
        FMGL(cxx_sha1_rng).init(parent->FMGL(cxx_sha1_rng), (int)spawn_number);
        FMGL(depth) = parent->FMGL(depth)+1;
    }

    x10_int __apply() {
        return FMGL(cxx_sha1_rng)();
    }
        
    x10_int depth() {
        return FMGL(depth);
    }

    static void _serialize(SHA1RandX this_, x10aux::serialization_buffer& buf);
    
    static SHA1RandX _deserialize(x10aux::deserialization_buffer& buf) {
        SHA1RandX this_;
        this_->_deserialize_body(buf);
        return this_;
    }
    
    void _deserialize_body(x10aux::deserialization_buffer& buf);

    x10_boolean _struct_equals(SHA1RandX that);
    
    x10_boolean equals(x10aux::ref<x10::lang::Any> that);
    
    x10_boolean equals(SHA1RandX that);
    
    x10aux::ref<x10::lang::String> toString();
    
    x10_int hashCode();
    
    x10aux::ref<x10::lang::String> typeName();
};

#endif 

