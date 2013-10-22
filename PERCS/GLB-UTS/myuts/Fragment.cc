/*************************************************/
/* START of Fragment */
#include <myuts/Fragment.h>

#include <myuts/SHA1Rand.h>
#include <x10/lang/Int.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Long.h>
#include <myuts/Queue.h>
#include <x10/lang/Boolean.h>
#include <myuts/UTSTree.h>

//#line 3 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10FieldDecl_c

//#line 4 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10FieldDecl_c

//#line 5 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10ConstructorDecl_c
void myuts::Fragment::_constructor(x10_long size) {
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.AssignPropertyCall_c
    
    //#line 2 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    myuts::Fragment* this27862 = this;
    
    //#line 8 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = x10::lang::Rail<myuts::SHA1Rand >::_make(size);
    
    //#line 9 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = x10::lang::Rail<x10_int >::_make(size);
    
    //#line 10 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = x10::lang::Rail<x10_int >::_make(size);
}
myuts::Fragment* myuts::Fragment::_make(x10_long size) {
    myuts::Fragment* this_ = new (x10aux::alloc_z<myuts::Fragment>()) myuts::Fragment();
    this_->_constructor(size);
    return this_;
}



//#line 13 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10MethodDecl_c
myuts::Fragment* myuts::Fragment::make(myuts::Queue* queue) {
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long s = ((x10_long)0ll);
    
    //#line 15 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 15 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < (x10aux::nullCheck(queue)->FMGL(size)));
             
             //#line 15 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 16 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10If_c
            if (((((x10_long) (((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                                FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                                              i)) - (x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                                         FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                                                       i))))))) >= (((x10_long)2ll))))
            {
                
                //#line 16 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10LocalAssign_c
                s = ((x10_long) ((s) + (((x10_long)1ll))));
            }
            
        }
    }
    
    //#line 18 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(s, ((x10_long)0ll)))) {
        
        //#line 18 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10Return_c
        return x10aux::class_cast_unchecked<myuts::Fragment*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
        
    }
    
    //#line 19 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    myuts::Fragment* fragment =  (new (x10aux::alloc_z<myuts::Fragment>()) myuts::Fragment())
    ;
    
    //#line 19 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10ConstructorCall_c
    (fragment)->::myuts::Fragment::_constructor(s);
    
    //#line 20 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10LocalAssign_c
    s = ((x10_long)0ll);
    
    //#line 21 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 21 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < (x10aux::nullCheck(queue)->
                                            FMGL(size)));
             
             //#line 21 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 22 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
            x10_int p = ((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                         FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                                       i)) - (x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                                  FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                                                i))));
            
            //#line 23 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10If_c
            if (((p) >= (((x10_int)2)))) {
                
                //#line 24 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
                  s, x10aux::nullCheck(x10aux::nullCheck(queue)->
                                         FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__apply(
                       i));
                
                //#line 25 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
                  s, x10aux::nullCheck(x10aux::nullCheck(queue)->
                                         FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                       i));
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
                x10::lang::Rail<x10_int >* x27864 = x10aux::nullCheck(queue)->
                                                      FMGL(upper);
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
                x10_long y27865 = i;
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
                x10_int z27866 = ((x10_int) ((p) / x10aux::zeroCheck(((x10_int)2))));
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
                x10_int ret27867;
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
                x10_int r27863 = ((x10_int) ((x10aux::nullCheck(x27864)->x10::lang::Rail<x10_int >::__apply(
                                                y27865)) - (z27866)));
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(x27864)->x10::lang::Rail<x10_int >::__set(
                  y27865, r27863);
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10LocalAssign_c
                ret27867 = r27863;
                
                //#line 26 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Local_c
                ret27867;
                
                //#line 27 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) ((s = ((x10_long) ((s) + (((x10_long)1ll))))) - (((x10_long)1ll)))),
                  x10aux::nullCheck(x10aux::nullCheck(queue)->
                                      FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                    i));
            }
            
        }
    }
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10Return_c
    return fragment;
    
}

//#line 33 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10MethodDecl_c
void myuts::Fragment::push(myuts::Queue* queue) {
    
    //#line 34 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long h = (x10_long)(x10aux::nullCheck(this->FMGL(hash))->FMGL(size));
    
    //#line 35 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long q = x10aux::nullCheck(queue)->FMGL(size);
    
    //#line 36 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10While_c
    while (((((x10_long) ((h) + (q)))) > ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                                         FMGL(hash))->FMGL(size)))))
    {
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue)->myuts::Queue::grow();
    }
    
    //#line 37 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<myuts::SHA1Rand >(this->
                                                     FMGL(hash),
                                                   ((x10_long)0ll),
                                                   x10aux::nullCheck(queue)->
                                                     FMGL(hash),
                                                   q, h);
    
    //#line 38 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(lower),
                                           ((x10_long)0ll),
                                           x10aux::nullCheck(queue)->
                                             FMGL(lower),
                                           q, h);
    
    //#line 39 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(upper),
                                           ((x10_long)0ll),
                                           x10aux::nullCheck(queue)->
                                             FMGL(upper),
                                           q, h);
    
    //#line 40 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* x27868 = queue;
    
    //#line 40 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long y27869 = h;
    
    //#line 40 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27868)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27868)->
                                                            FMGL(size)) + (y27869)));
}

//#line 43 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10MethodDecl_c
void myuts::Fragment::pushWA(myuts::UTSTree* queue) {
    
    //#line 44 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long h = (x10_long)(x10aux::nullCheck(this->FMGL(hash))->FMGL(size));
    
    //#line 45 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long q = x10aux::nullCheck(queue)->FMGL(size);
    
    //#line 46 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10While_c
    while (((((x10_long) ((h) + (q)))) > ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(queue)->
                                                                         FMGL(hash))->FMGL(size)))))
    {
        
        //#line 46 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue)->myuts::UTSTree::grow();
    }
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<myuts::SHA1Rand >(this->
                                                     FMGL(hash),
                                                   ((x10_long)0ll),
                                                   x10aux::nullCheck(queue)->
                                                     FMGL(hash),
                                                   q, h);
    
    //#line 48 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(lower),
                                           ((x10_long)0ll),
                                           x10aux::nullCheck(queue)->
                                             FMGL(lower),
                                           q, h);
    
    //#line 49 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(upper),
                                           ((x10_long)0ll),
                                           x10aux::nullCheck(queue)->
                                             FMGL(upper),
                                           q, h);
    
    //#line 50 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* x27870 = queue;
    
    //#line 50 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10LocalDecl_c
    x10_long y27871 = h;
    
    //#line 50 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27870)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27870)->
                                                            FMGL(size)) + (y27871)));
}

//#line 2 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10MethodDecl_c
myuts::Fragment* myuts::Fragment::myuts__Fragment____this__myuts__Fragment(
  ) {
    
    //#line 2 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 2 "/home/weiz/outgoing/wglb/myuts/Fragment.x10": x10.ast.X10MethodDecl_c
void myuts::Fragment::__fieldInitializers_myuts_Fragment(
  ) {
 
}
const x10aux::serialization_id_t myuts::Fragment::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::Fragment::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::Fragment::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(hash));
    buf.write(this->FMGL(lower));
    buf.write(this->FMGL(upper));
    
}

x10::lang::Reference* myuts::Fragment::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::Fragment* this_ = new (x10aux::alloc_z<myuts::Fragment>()) myuts::Fragment();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::Fragment::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(hash) = buf.read<x10::lang::Rail<myuts::SHA1Rand >*>();
    FMGL(lower) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(upper) = buf.read<x10::lang::Rail<x10_int >*>();
}

x10aux::RuntimeType myuts::Fragment::rtt;
void myuts::Fragment::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("myuts.Fragment",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Fragment */
/*************************************************/
