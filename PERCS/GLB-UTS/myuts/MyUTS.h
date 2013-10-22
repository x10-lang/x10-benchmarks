#ifndef __MYUTS_MYUTS_H
#define __MYUTS_MYUTS_H

#include <x10rt.h>


#define CORE_GLOBALJOBRUNNER_H_NODEPS
#include <core/GlobalJobRunner.h>
#undef CORE_GLOBALJOBRUNNER_H_NODEPS
namespace myuts { 
class UTSTreeNode;
} 
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Reducible;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace util { 
class OptionsParser;
} } 
namespace x10 { namespace util { 
class Option;
} } 
namespace x10 { namespace lang { 
class Place;
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
class UTSResultReducible;
} 
namespace x10 { namespace util { 
class Timer;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(U)> class Fun_0_0;
} } 
namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class LocalJobRunner;
} 
namespace core { 
template<class TPMGL(T), class TPMGL(Z)> class TaskFrame;
} 
namespace myuts { 
class UTSTaskFrame;
} 
namespace myuts { 

class MyUTS : public core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long>
  {
    public:
    RTT_H_DECLS_CLASS
    
    using core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long>::main;
    
    x10::lang::Reducible<x10_long>* FMGL(resultReducer);
    
    virtual x10::lang::Reducible<x10_long>* getResultReducer();
    virtual void setResultReducer(x10::lang::Reducible<x10_long>* r);
    static void main(x10::lang::Rail<x10::lang::String* >* args);
    virtual myuts::MyUTS* myuts__MyUTS____this__myuts__MyUTS();
    void _constructor();
    
    static myuts::MyUTS* _make();
    
    virtual void __fieldInitializers_myuts_MyUTS();
    
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
#endif // MYUTS_MYUTS_H

namespace myuts { 
class MyUTS;
} 

#ifndef MYUTS_MYUTS_H_NODEPS
#define MYUTS_MYUTS_H_NODEPS
#ifndef MYUTS_MYUTS_H_GENERICS
#define MYUTS_MYUTS_H_GENERICS
#endif // MYUTS_MYUTS_H_GENERICS
#endif // __MYUTS_MYUTS_H_NODEPS
