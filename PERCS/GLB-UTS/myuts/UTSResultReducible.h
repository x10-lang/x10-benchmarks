#ifndef __MYUTS_UTSRESULTREDUCIBLE_H
#define __MYUTS_UTSRESULTREDUCIBLE_H

#include <x10rt.h>


#define X10_LANG_REDUCIBLE_H_NODEPS
#include <x10/lang/Reducible.h>
#undef X10_LANG_REDUCIBLE_H_NODEPS
namespace myuts { 

class UTSResultReducible : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static x10aux::itable_entry _itables[3];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    static x10::lang::Reducible<x10_long>::itable<myuts::UTSResultReducible > _itable_0;
    
    static x10::lang::Any::itable<myuts::UTSResultReducible > _itable_1;
    
    void _constructor();
    
    static myuts::UTSResultReducible* _make();
    
    virtual x10_long __apply(x10_long a, x10_long b);
    virtual x10_long zero();
    virtual myuts::UTSResultReducible* myuts__UTSResultReducible____this__myuts__UTSResultReducible(
      );
    virtual void __fieldInitializers_myuts_UTSResultReducible();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};


} 
#endif // MYUTS_UTSRESULTREDUCIBLE_H

namespace myuts { 
class UTSResultReducible;
} 

#ifndef MYUTS_UTSRESULTREDUCIBLE_H_NODEPS
#define MYUTS_UTSRESULTREDUCIBLE_H_NODEPS
#ifndef MYUTS_UTSRESULTREDUCIBLE_H_GENERICS
#define MYUTS_UTSRESULTREDUCIBLE_H_GENERICS
#endif // MYUTS_UTSRESULTREDUCIBLE_H_GENERICS
#endif // __MYUTS_UTSRESULTREDUCIBLE_H_NODEPS
