#ifndef __MYUTS_UTSTREENODE_H
#define __MYUTS_UTSTREENODE_H

#include <x10rt.h>


namespace myuts { 

class UTSTreeNode : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    virtual myuts::UTSTreeNode* myuts__UTSTreeNode____this__myuts__UTSTreeNode(
      );
    void _constructor();
    
    static myuts::UTSTreeNode* _make();
    
    virtual void __fieldInitializers_myuts_UTSTreeNode();
    
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
#endif // MYUTS_UTSTREENODE_H

namespace myuts { 
class UTSTreeNode;
} 

#ifndef MYUTS_UTSTREENODE_H_NODEPS
#define MYUTS_UTSTREENODE_H_NODEPS
#ifndef MYUTS_UTSTREENODE_H_GENERICS
#define MYUTS_UTSTREENODE_H_GENERICS
#endif // MYUTS_UTSTREENODE_H_GENERICS
#endif // __MYUTS_UTSTREENODE_H_NODEPS
