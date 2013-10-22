/*************************************************/
/* START of UTSTreeNode */
#include <myuts/UTSTreeNode.h>


//#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.X10MethodDecl_c
myuts::UTSTreeNode* myuts::UTSTreeNode::myuts__UTSTreeNode____this__myuts__UTSTreeNode(
  ) {
    
    //#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.X10ConstructorDecl_c
void myuts::UTSTreeNode::_constructor() {
    
    //#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.AssignPropertyCall_c
    
    //#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTreeNode* this22404 = this;
    
}
myuts::UTSTreeNode* myuts::UTSTreeNode::_make() {
    myuts::UTSTreeNode* this_ = new (x10aux::alloc_z<myuts::UTSTreeNode>()) myuts::UTSTreeNode();
    this_->_constructor();
    return this_;
}



//#line 3 "/home/weiz/outgoing/wglb/myuts/UTSTreeNode.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTreeNode::__fieldInitializers_myuts_UTSTreeNode() {
 
}
const x10aux::serialization_id_t myuts::UTSTreeNode::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::UTSTreeNode::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::UTSTreeNode::_serialize_body(x10aux::serialization_buffer& buf) {
    
}

x10::lang::Reference* myuts::UTSTreeNode::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::UTSTreeNode* this_ = new (x10aux::alloc_z<myuts::UTSTreeNode>()) myuts::UTSTreeNode();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::UTSTreeNode::_deserialize_body(x10aux::deserialization_buffer& buf) {
    
}

x10aux::RuntimeType myuts::UTSTreeNode::rtt;
void myuts::UTSTreeNode::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("myuts.UTSTreeNode",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of UTSTreeNode */
/*************************************************/
