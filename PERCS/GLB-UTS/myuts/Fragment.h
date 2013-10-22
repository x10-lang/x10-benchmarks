#ifndef __MYUTS_FRAGMENT_H
#define __MYUTS_FRAGMENT_H

#include <x10rt.h>


#define MYUTS_SHA1RAND_H_NODEPS
#include <myuts/SHA1Rand.h>
#undef MYUTS_SHA1RAND_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace myuts { 
class Queue;
} 
namespace myuts { 
class UTSTree;
} 
namespace myuts { 

class Fragment : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    x10::lang::Rail<myuts::SHA1Rand >* FMGL(hash);
    
    x10::lang::Rail<x10_int >* FMGL(lower);
    
    x10::lang::Rail<x10_int >* FMGL(upper);
    
    void _constructor(x10_long size);
    
    static myuts::Fragment* _make(x10_long size);
    
    static myuts::Fragment* make(myuts::Queue* queue);
    virtual void push(myuts::Queue* queue);
    virtual void pushWA(myuts::UTSTree* queue);
    virtual myuts::Fragment* myuts__Fragment____this__myuts__Fragment();
    virtual void __fieldInitializers_myuts_Fragment();
    
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
#endif // MYUTS_FRAGMENT_H

namespace myuts { 
class Fragment;
} 

#ifndef MYUTS_FRAGMENT_H_NODEPS
#define MYUTS_FRAGMENT_H_NODEPS
#ifndef MYUTS_FRAGMENT_H_GENERICS
#define MYUTS_FRAGMENT_H_GENERICS
#endif // MYUTS_FRAGMENT_H_GENERICS
#endif // __MYUTS_FRAGMENT_H_NODEPS
