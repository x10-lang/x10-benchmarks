#ifndef __CORE_LIFELINEGENERATOR_H
#define __CORE_LIFELINEGENERATOR_H

#include <x10rt.h>


namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace core { 

class LifelineGenerator : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static x10::lang::Rail<x10_long >* generateHyperCubeLifeLine(x10_long id,
                                                                 x10_long P,
                                                                 x10_long l,
                                                                 x10_long z);
    virtual core::LifelineGenerator* core__LifelineGenerator____this__core__LifelineGenerator(
      );
    void _constructor();
    
    static core::LifelineGenerator* _make();
    
    virtual void __fieldInitializers_core_LifelineGenerator();
    
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
#endif // CORE_LIFELINEGENERATOR_H

namespace core { 
class LifelineGenerator;
} 

#ifndef CORE_LIFELINEGENERATOR_H_NODEPS
#define CORE_LIFELINEGENERATOR_H_NODEPS
#ifndef CORE_LIFELINEGENERATOR_H_GENERICS
#define CORE_LIFELINEGENERATOR_H_GENERICS
#endif // CORE_LIFELINEGENERATOR_H_GENERICS
#endif // __CORE_LIFELINEGENERATOR_H_NODEPS
