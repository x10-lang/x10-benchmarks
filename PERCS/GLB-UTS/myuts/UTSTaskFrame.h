#ifndef __MYUTS_UTSTASKFRAME_H
#define __MYUTS_UTSTASKFRAME_H

#include <x10rt.h>


#define CORE_TASKFRAME_H_NODEPS
#include <core/TaskFrame.h>
#undef CORE_TASKFRAME_H_NODEPS
namespace myuts { 
class UTSTreeNode;
} 
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_LONG_H_NODEPS
#include <x10/lang/Long.h>
#undef X10_LANG_LONG_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace core { 
template<class TPMGL(T)> class TaskBag;
} 
namespace myuts { 
template<class TPMGL(UTSTreeNode)> class UTSTaskBag;
} 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace myuts { 

class UTSTaskFrame : public core::TaskFrame<myuts::UTSTreeNode*, x10_long>
  {
    public:
    RTT_H_DECLS_CLASS
    
    x10_long FMGL(last);
    
    core::TaskBag<myuts::UTSTreeNode*>* FMGL(tb);
    
    x10_int FMGL(seed);
    
    x10_int FMGL(depth);
    
    x10_int FMGL(branchfactor);
    
    virtual void runTask(myuts::UTSTreeNode* t, core::TaskBag<myuts::UTSTreeNode*>* tb);
    x10_long FMGL(result);
    
    void _constructor(x10_int branchfactor, x10_int seed, x10_int depth);
    
    static myuts::UTSTaskFrame* _make(x10_int branchfactor, x10_int seed,
                                      x10_int depth);
    
    virtual x10_boolean runAtMostNTask(myuts::UTSTaskBag<myuts::UTSTreeNode*>* tb,
                                       x10_long n);
    virtual x10_boolean runAtMostNTask(x10_long n);
    virtual x10_long getResult();
    virtual void initTask();
    virtual core::TaskBag<myuts::UTSTreeNode*>* getTaskBag();
    virtual myuts::UTSTaskFrame* myuts__UTSTaskFrame____this__myuts__UTSTaskFrame(
      );
    virtual void __fieldInitializers_myuts_UTSTaskFrame();
    
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
#endif // MYUTS_UTSTASKFRAME_H

namespace myuts { 
class UTSTaskFrame;
} 

#ifndef MYUTS_UTSTASKFRAME_H_NODEPS
#define MYUTS_UTSTASKFRAME_H_NODEPS
#ifndef MYUTS_UTSTASKFRAME_H_GENERICS
#define MYUTS_UTSTASKFRAME_H_GENERICS
#endif // MYUTS_UTSTASKFRAME_H_GENERICS
#endif // __MYUTS_UTSTASKFRAME_H_NODEPS
