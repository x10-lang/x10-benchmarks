/*************************************************/
/* START of SHA1Rand */
#include <myuts/SHA1Rand.h>

#include <x10/lang/Any.h>
#include <x10/lang/Int.h>
#include <x10/compiler/Native.h>
#include <x10/lang/String.h>
#include <x10/compiler/NonEscaping.h>
#include <x10/lang/Boolean.h>
#include <x10/compiler/NativeCPPInclude.h>
#include <x10/compiler/NativeCPPCompilationUnit.h>
namespace myuts { 
class SHA1Rand_ibox0 : public x10::lang::IBox<myuts::SHA1Rand> {
public:
    static x10::lang::Any::itable<SHA1Rand_ibox0 > itable;
    x10_boolean equals(x10::lang::Any* arg0) {
        return this->value->equals(arg0);
    }
    x10_int hashCode() {
        return this->value->hashCode();
    }
    x10::lang::String* toString() {
        return this->value->toString();
    }
    x10::lang::String* typeName() {
        return this->value->typeName();
    }
    
};
x10::lang::Any::itable<SHA1Rand_ibox0 >  SHA1Rand_ibox0::itable(&SHA1Rand_ibox0::equals, &SHA1Rand_ibox0::hashCode, &SHA1Rand_ibox0::toString, &SHA1Rand_ibox0::typeName);
} 
x10::lang::Any::itable<myuts::SHA1Rand >  myuts::SHA1Rand::_itable_0(&myuts::SHA1Rand::equals, &myuts::SHA1Rand::hashCode, &myuts::SHA1Rand::toString, &myuts::SHA1Rand::typeName);
x10aux::itable_entry myuts::SHA1Rand::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &myuts::SHA1Rand::_itable_0), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<myuts::SHA1Rand>())};
x10aux::itable_entry myuts::SHA1Rand::_iboxitables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &myuts::SHA1Rand_ibox0::itable), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<myuts::SHA1Rand>())};

//#line 8 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 10 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10ConstructorDecl_c


//#line 17 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10ConstructorDecl_c


//#line 22 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
x10::lang::String* myuts::SHA1Rand::typeName(){
    return x10aux::type_name((*this));
}

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
x10::lang::String* myuts::SHA1Rand::toString() {
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
    return x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("struct myuts.SHA1Rand:"), x10aux::makeStringLit(" w0=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                      FMGL(w0)), x10aux::makeStringLit(" w1=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                   FMGL(w1)), x10aux::makeStringLit(" w2=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                FMGL(w2)), x10aux::makeStringLit(" w3=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             FMGL(w3)), x10aux::makeStringLit(" w4=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          FMGL(w4)), x10aux::makeStringLit(" depth=")), (*this)->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          FMGL(depth));
    
}

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
x10_int myuts::SHA1Rand::hashCode() {
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10LocalDecl_c
    x10_int result = ((x10_int)1);
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(w0)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(w1)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(w2)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(w3)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(w4)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": Eval of x10.ast.X10LocalAssign_c
    result = ((x10_int) ((((x10_int) ((((x10_int)8191)) * (result)))) + (x10aux::hash_code((*this)->
                                                                                             FMGL(depth)))));
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
    return result;
    
}

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
x10_boolean myuts::SHA1Rand::equals(x10::lang::Any* other) {
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10If_c
    if (!(x10aux::instanceof<myuts::SHA1Rand>(other))) {
        
        //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
        return false;
        
    }
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
    return (*this)->myuts::SHA1Rand::equals(x10aux::class_cast<myuts::SHA1Rand>(other));
    
}

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
x10_boolean myuts::SHA1Rand::_struct_equals(x10::lang::Any* other) {
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10If_c
    if (!(x10aux::instanceof<myuts::SHA1Rand>(other))) {
        
        //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
        return false;
        
    }
    
    //#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10Return_c
    return (*this)->myuts::SHA1Rand::_struct_equals(x10aux::class_cast<myuts::SHA1Rand>(other));
    
}

//#line 7 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c

//#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c

//#line 4 "/home/weiz/outgoing/wglb/myuts/SHA1Rand.x10": x10.ast.X10MethodDecl_c
void myuts::SHA1Rand::_serialize(myuts::SHA1Rand this_, x10aux::serialization_buffer& buf) {
    buf.write(this_->FMGL(w0));
    buf.write(this_->FMGL(w1));
    buf.write(this_->FMGL(w2));
    buf.write(this_->FMGL(w3));
    buf.write(this_->FMGL(w4));
    buf.write(this_->FMGL(depth));
    
}

void myuts::SHA1Rand::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(w0) = buf.read<x10_int>();
    FMGL(w1) = buf.read<x10_int>();
    FMGL(w2) = buf.read<x10_int>();
    FMGL(w3) = buf.read<x10_int>();
    FMGL(w4) = buf.read<x10_int>();
    FMGL(depth) = buf.read<x10_int>();
}


x10aux::RuntimeType myuts::SHA1Rand::rtt;
void myuts::SHA1Rand::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[2] = { x10aux::getRTT<x10::lang::Any>(), x10aux::getRTT<x10::lang::Any>()};
    rtt.initStageTwo("myuts.SHA1Rand",x10aux::RuntimeType::struct_kind, 2, parents, 0, NULL, NULL);
    rtt.containsPtrs = false;
}

/* END of SHA1Rand */
/*************************************************/
