/*************************************************/
/* START of UTSResultReducible */
#include <myuts/UTSResultReducible.h>

#include <x10/lang/Reducible.h>
#include <x10/lang/Long.h>
x10::lang::Reducible<x10_long>::itable<myuts::UTSResultReducible >  myuts::UTSResultReducible::_itable_0(&x10::lang::X10Class::equals, &x10::lang::X10Class::hashCode, &myuts::UTSResultReducible::__apply, &x10::lang::X10Class::toString, &x10::lang::X10Class::typeName, &myuts::UTSResultReducible::zero);
x10::lang::Any::itable<myuts::UTSResultReducible >  myuts::UTSResultReducible::_itable_1(&x10::lang::X10Class::equals, &x10::lang::X10Class::hashCode, &x10::lang::X10Class::toString, &x10::lang::X10Class::typeName);
x10aux::itable_entry myuts::UTSResultReducible::_itables[3] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Reducible<x10_long> >, &_itable_0), x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &_itable_1), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<myuts::UTSResultReducible>())};

//#line 5 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10ConstructorDecl_c
void myuts::UTSResultReducible::_constructor() {
    
    //#line 5 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.AssignPropertyCall_c
    
    //#line 3 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10LocalDecl_c
    myuts::UTSResultReducible* this22408 = this;
    
}
myuts::UTSResultReducible* myuts::UTSResultReducible::_make() {
    myuts::UTSResultReducible* this_ = new (x10aux::alloc_z<myuts::UTSResultReducible>()) myuts::UTSResultReducible();
    this_->_constructor();
    return this_;
}



//#line 9 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10MethodDecl_c
x10_long myuts::UTSResultReducible::__apply(x10_long a, x10_long b) {
    
    //#line 9 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10Return_c
    return ((x10_long) ((a) + (b)));
    
}

//#line 10 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10MethodDecl_c
x10_long myuts::UTSResultReducible::zero() {
    
    //#line 12 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10Return_c
    return ((x10_long)0ll);
    
}

//#line 3 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10MethodDecl_c
myuts::UTSResultReducible* myuts::UTSResultReducible::myuts__UTSResultReducible____this__myuts__UTSResultReducible(
  ) {
    
    //#line 3 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 3 "/home/weiz/outgoing/wglb/myuts/UTSResultReducible.x10": x10.ast.X10MethodDecl_c
void myuts::UTSResultReducible::__fieldInitializers_myuts_UTSResultReducible(
  ) {
 
}
const x10aux::serialization_id_t myuts::UTSResultReducible::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::UTSResultReducible::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::UTSResultReducible::_serialize_body(x10aux::serialization_buffer& buf) {
    
}

x10::lang::Reference* myuts::UTSResultReducible::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::UTSResultReducible* this_ = new (x10aux::alloc_z<myuts::UTSResultReducible>()) myuts::UTSResultReducible();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::UTSResultReducible::_deserialize_body(x10aux::deserialization_buffer& buf) {
    
}

x10aux::RuntimeType myuts::UTSResultReducible::rtt;
void myuts::UTSResultReducible::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[1] = { x10aux::getRTT<x10::lang::Reducible<x10_long> >()};
    rtt.initStageTwo("myuts.UTSResultReducible",x10aux::RuntimeType::class_kind, 1, parents, 0, NULL, NULL);
}

/* END of UTSResultReducible */
/*************************************************/
