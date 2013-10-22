#ifndef __MYUTS_SHA1RAND_H
#define __MYUTS_SHA1RAND_H

#include <x10rt.h>

#include "brg_types.h"
#include "brg_sha1.h"

#define X10_LANG_ANY_H_NODEPS
#include <x10/lang/Any.h>
#undef X10_LANG_ANY_H_NODEPS
#define X10_LANG_ANY_H_NODEPS
#include <x10/lang/Any.h>
#undef X10_LANG_ANY_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace x10 { namespace compiler { 
class Native;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace compiler { 
class NonEscaping;
} } 
namespace x10 { namespace compiler { 
class NativeCPPInclude;
} } 
namespace x10 { namespace compiler { 
class NativeCPPCompilationUnit;
} } 
namespace myuts { 

class SHA1Rand   {
    public:
    RTT_H_DECLS_STRUCT
    
    myuts::SHA1Rand* operator->() { return this; }
    
    static x10aux::itable_entry _itables[2];
    
    x10aux::itable_entry* _getITables() { return _itables; }
    
    static x10::lang::Any::itable<myuts::SHA1Rand > _itable_0;
    
    static x10aux::itable_entry _iboxitables[2];
    
    x10aux::itable_entry* _getIBoxITables() { return _iboxitables; }
    
    static myuts::SHA1Rand _alloc(){myuts::SHA1Rand t; return t; }
    
    x10_int FMGL(w0);
    
    x10_int FMGL(w1);
    
    x10_int FMGL(w2);
    
    x10_int FMGL(w3);
    
    x10_int FMGL(w4);
    
    x10_int FMGL(depth);
    
    void _constructor(x10_int seed, x10_int depth) {
        
        //#line 12 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.AssignPropertyCall_c
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand this27847 = (*this);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27847->FMGL(w0) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27847->FMGL(w1) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27847->FMGL(w2) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27847->FMGL(w3) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27847->FMGL(w4) = ((x10_int)0);
        rng_init((RNG_state*)this, seed);
        
        //#line 14 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(depth) = depth;
    }
    static myuts::SHA1Rand _make(x10_int seed, x10_int depth) {
        myuts::SHA1Rand this_; 
        this_->_constructor(seed, depth);
        return this_;
    }
    
    void _constructor(myuts::SHA1Rand parent, x10_int spawnNumber, x10_int depth) {
        
        //#line 17 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.AssignPropertyCall_c
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand this27848 = (*this);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27848->FMGL(w0) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27848->FMGL(w1) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27848->FMGL(w2) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27848->FMGL(w3) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        this27848->FMGL(w4) = ((x10_int)0);
        rng_spawn((RNG_state*)&parent, (RNG_state*)this, spawnNumber);
        
        //#line 19 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(depth) = depth;
    }
    static myuts::SHA1Rand _make(myuts::SHA1Rand parent, x10_int spawnNumber,
                                 x10_int depth) {
        myuts::SHA1Rand this_; 
        this_->_constructor(parent, spawnNumber, depth);
        return this_;
    }
    
    x10_int __apply() {
        return rng_rand((RNG_state*)this);
    }
    x10::lang::String* typeName();
    x10::lang::String* toString();
    x10_int hashCode();
    x10_boolean equals(x10::lang::Any* other);
    x10_boolean equals(myuts::SHA1Rand other) {
        
        //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
        return (x10aux::struct_equals((*this)->FMGL(w0), other->FMGL(w0))) &&
        (x10aux::struct_equals((*this)->FMGL(w1), other->FMGL(w1))) && (x10aux::struct_equals((*this)->
                                                                                                FMGL(w2),
                                                                                              other->
                                                                                                FMGL(w2))) &&
        (x10aux::struct_equals((*this)->FMGL(w3), other->
                                                    FMGL(w3))) &&
        (x10aux::struct_equals((*this)->FMGL(w4), other->
                                                    FMGL(w4))) &&
        (x10aux::struct_equals((*this)->FMGL(depth), other->
                                                       FMGL(depth)));
        
    }
    x10_boolean _struct_equals(x10::lang::Any* other);
    x10_boolean _struct_equals(myuts::SHA1Rand other) {
        
        //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
        return (x10aux::struct_equals((*this)->FMGL(w0), other->
                                                           FMGL(w0))) &&
        (x10aux::struct_equals((*this)->FMGL(w1), other->
                                                    FMGL(w1))) &&
        (x10aux::struct_equals((*this)->FMGL(w2), other->
                                                    FMGL(w2))) &&
        (x10aux::struct_equals((*this)->FMGL(w3), other->
                                                    FMGL(w3))) &&
        (x10aux::struct_equals((*this)->FMGL(w4), other->
                                                    FMGL(w4))) &&
        (x10aux::struct_equals((*this)->FMGL(depth), other->
                                                       FMGL(depth)));
        
    }
    myuts::SHA1Rand myuts__SHA1Rand____this__myuts__SHA1Rand(
      ) {
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
        return (*this);
        
    }
    void __fieldInitializers_myuts_SHA1Rand() {
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(w0) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(w1) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(w2) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(w3) = ((x10_int)0);
        
        //#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10FieldAssign_c
        (*this)->FMGL(w4) = ((x10_int)0);
    }
    
    static void _serialize(myuts::SHA1Rand this_, x10aux::serialization_buffer& buf);
    
    static myuts::SHA1Rand _deserialize(x10aux::deserialization_buffer& buf) {
        myuts::SHA1Rand this_;
        this_->_deserialize_body(buf);
        return this_;
    }
    
    void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};


} 
#endif // MYUTS_SHA1RAND_H

namespace myuts { 
class SHA1Rand;
} 

#ifndef MYUTS_SHA1RAND_H_NODEPS
#define MYUTS_SHA1RAND_H_NODEPS
#ifndef MYUTS_SHA1RAND_H_GENERICS
#define MYUTS_SHA1RAND_H_GENERICS
#endif // MYUTS_SHA1RAND_H_GENERICS
#endif // __MYUTS_SHA1RAND_H_NODEPS
