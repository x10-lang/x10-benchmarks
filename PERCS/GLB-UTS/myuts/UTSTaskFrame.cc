/*************************************************/
/* START of UTSTaskFrame */
#include <myuts/UTSTaskFrame.h>

#include <core/TaskFrame.h>
#include <myuts/UTSTreeNode.h>
#include <x10/lang/Long.h>
#include <x10/lang/Int.h>
#include <core/TaskBag.h>
#include <myuts/UTSTaskBag.h>
#include <x10/lang/Boolean.h>
#include <x10/compiler/Inline.h>

//#line 8 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 9 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 13 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 14 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 21 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTaskFrame::runTask(myuts::UTSTreeNode* t, core::TaskBag<myuts::UTSTreeNode*>* tb) {
 
}

//#line 23 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10FieldDecl_c

//#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10ConstructorDecl_c
void myuts::UTSTaskFrame::_constructor(x10_int branchfactor, x10_int seed,
                                       x10_int depth) {
    
    //#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10LocalDecl_c
    core::TaskFrame<myuts::UTSTreeNode*, x10_long>* this22538 = this;
    
    //#line 6 "/home/weiz/outgoing/wglb/core/TaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22538)->FMGL(tb) = (x10aux::class_cast_unchecked<core::TaskBag<myuts::UTSTreeNode*>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.AssignPropertyCall_c
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTaskFrame* this22537 = this;
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22537)->FMGL(last) = ((x10_long)0ll);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22537)->FMGL(seed) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22537)->FMGL(depth) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22537)->FMGL(branchfactor) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this22537)->FMGL(result) = ((x10_long)0ll);
    
    //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(branchfactor) = branchfactor;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(seed) = seed;
    
    //#line 28 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(depth) = depth;
    
    //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(tb) = (reinterpret_cast<core::TaskBag<myuts::UTSTreeNode*>*>((__extension__ ({
                          
                          //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10LocalDecl_c
                          myuts::UTSTaskBag<myuts::UTSTreeNode*>* alloc15172 =
                             (new (x10aux::alloc_z<myuts::UTSTaskBag<myuts::UTSTreeNode*> >()) myuts::UTSTaskBag<myuts::UTSTreeNode*>())
                          ;
                          
                          //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10ConstructorCall_c
                          (alloc15172)->::myuts::UTSTaskBag<myuts::UTSTreeNode*>::_constructor(
                            branchfactor);
                          alloc15172;
                      }))
                      ));
}
myuts::UTSTaskFrame* myuts::UTSTaskFrame::_make(x10_int branchfactor,
                                                x10_int seed, x10_int depth)
{
    myuts::UTSTaskFrame* this_ = new (x10aux::alloc_z<myuts::UTSTaskFrame>()) myuts::UTSTaskFrame();
    this_->_constructor(branchfactor, seed, depth);
    return this_;
}



//#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
x10_boolean myuts::UTSTaskFrame::runAtMostNTask(myuts::UTSTaskBag<myuts::UTSTreeNode*>* tb,
                                                x10_long n) {
    
    //#line 38 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10LocalDecl_c
    x10_long i = ((x10_long)0ll);
    
    //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": polyglot.ast.For_c
    {
        for (; ((i) < (n)) && ((x10aux::nullCheck(tb)->size()) > (((x10_long)0ll)));
             
             //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 42 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(tb)->expand();
        }
    }
    
    //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(tb)->incByI(i);
    
    //#line 53 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(result) = x10aux::nullCheck(tb)->getCount();
    
    //#line 55 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10Return_c
    return ((x10aux::nullCheck(tb)->size()) > (((x10_long)0ll)));
    
}

//#line 58 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
x10_boolean myuts::UTSTaskFrame::runAtMostNTask(x10_long n) {
    
    //#line 60 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10Return_c
    return this->runAtMostNTask(x10aux::class_cast<myuts::UTSTaskBag<myuts::UTSTreeNode*>*>(this->
                                                                                              FMGL(tb)),
                                n);
    
}

//#line 63 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
x10_long myuts::UTSTaskFrame::getResult() {
    
    //#line 64 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10Return_c
    return this->FMGL(result);
    
}

//#line 78 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTaskFrame::initTask() {
    
    //#line 79 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10Call_c
    (x10aux::class_cast<myuts::UTSTaskBag<myuts::UTSTreeNode*>*>(this->
                                                                   FMGL(tb)))->initTree(
      this->FMGL(seed), this->FMGL(depth));
}

//#line 81 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
core::TaskBag<myuts::UTSTreeNode*>* myuts::UTSTaskFrame::getTaskBag(
  ) {
    
    //#line 83 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10Return_c
    return this->FMGL(tb);
    
}

//#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
myuts::UTSTaskFrame* myuts::UTSTaskFrame::myuts__UTSTaskFrame____this__myuts__UTSTaskFrame(
  ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTaskFrame::__fieldInitializers_myuts_UTSTaskFrame(
  ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(last) = ((x10_long)0ll);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(seed) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(depth) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(branchfactor) = ((x10_int)0);
    
    //#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTaskFrame.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(result) = ((x10_long)0ll);
}
const x10aux::serialization_id_t myuts::UTSTaskFrame::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::UTSTaskFrame::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::UTSTaskFrame::_serialize_body(x10aux::serialization_buffer& buf) {
    core::TaskFrame<myuts::UTSTreeNode*, x10_long>::_serialize_body(buf);
    buf.write(this->FMGL(last));
    buf.write(this->FMGL(tb));
    buf.write(this->FMGL(seed));
    buf.write(this->FMGL(depth));
    buf.write(this->FMGL(branchfactor));
    buf.write(this->FMGL(result));
    
}

x10::lang::Reference* myuts::UTSTaskFrame::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::UTSTaskFrame* this_ = new (x10aux::alloc_z<myuts::UTSTaskFrame>()) myuts::UTSTaskFrame();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::UTSTaskFrame::_deserialize_body(x10aux::deserialization_buffer& buf) {
    core::TaskFrame<myuts::UTSTreeNode*, x10_long>::_deserialize_body(buf);
    FMGL(last) = buf.read<x10_long>();
    FMGL(tb) = buf.read<core::TaskBag<myuts::UTSTreeNode*>*>();
    FMGL(seed) = buf.read<x10_int>();
    FMGL(depth) = buf.read<x10_int>();
    FMGL(branchfactor) = buf.read<x10_int>();
    FMGL(result) = buf.read<x10_long>();
}

x10aux::RuntimeType myuts::UTSTaskFrame::rtt;
void myuts::UTSTaskFrame::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[1] = { x10aux::getRTT<core::TaskFrame<myuts::UTSTreeNode*, x10_long> >()};
    rtt.initStageTwo("myuts.UTSTaskFrame",x10aux::RuntimeType::class_kind, 1, parents, 0, NULL, NULL);
}

/* END of UTSTaskFrame */
/*************************************************/
