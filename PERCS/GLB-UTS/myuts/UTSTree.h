#ifndef __MYUTS_UTSTREE_H
#define __MYUTS_UTSTREE_H

#include <x10rt.h>


#define MYUTS_SHA1RAND_H_NODEPS
#include <myuts/SHA1Rand.h>
#undef MYUTS_SHA1RAND_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace lang { 
class Math;
} } 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace myuts { 
class Queue;
} 
namespace x10 { namespace util { 
class Timer;
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
namespace myuts { 

class UTSTree : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    x10::lang::Rail<myuts::SHA1Rand >* FMGL(hash);
    
    x10::lang::Rail<x10_int >* FMGL(lower);
    
    x10::lang::Rail<x10_int >* FMGL(upper);
    
    x10_long FMGL(size);
    
    x10_double FMGL(den);
    
    x10_long FMGL(count);
    
    x10_int FMGL(factor);
    
    void _constructor(x10_int factor);
    
    static myuts::UTSTree* _make(x10_int factor);
    
    virtual void init(x10_int seed, x10_int height);
    virtual void push(myuts::SHA1Rand h);
    virtual void expand();
    virtual void grow();
    static x10::lang::String* sub(x10::lang::String* str, x10_int start, x10_int end);
    static void main(x10::lang::Rail<x10::lang::String* >* id__1999);
    virtual myuts::UTSTree* myuts__UTSTree____this__myuts__UTSTree();
    virtual void __fieldInitializers_myuts_UTSTree();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};


} 
#endif // MYUTS_UTSTREE_H

namespace myuts { 
class UTSTree;
} 

#ifndef MYUTS_UTSTREE_H_NODEPS
#define MYUTS_UTSTREE_H_NODEPS
#ifndef MYUTS_UTSTREE_H_GENERICS
#define MYUTS_UTSTREE_H_GENERICS
#endif // MYUTS_UTSTREE_H_GENERICS
#endif // __MYUTS_UTSTREE_H_NODEPS
