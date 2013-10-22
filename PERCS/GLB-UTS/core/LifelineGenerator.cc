/*************************************************/
/* START of LifelineGenerator */
#include <core/LifelineGenerator.h>

#include <x10/lang/Long.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Boolean.h>

//#line 8 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10MethodDecl_c
x10::lang::Rail<x10_long >* core::LifelineGenerator::generateHyperCubeLifeLine(
  x10_long id, x10_long P, x10_long l, x10_long z) {
    
    //#line 9 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_long >* lifelines = x10::lang::Rail<x10_long >::_make(z,
                                                                              ((x10_long)-1ll));
    
    //#line 10 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
    x10_long x = ((x10_long)1ll);
    
    //#line 11 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
    x10_long t = ((x10_long)0ll);
    
    //#line 13 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": polyglot.ast.For_c
    {
        x10_long j;
        for (
             //#line 13 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
             j = ((x10_long)0ll); ((j) < (z)); 
                                               //#line 13 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": Eval of x10.ast.X10LocalAssign_c
                                               j = ((x10_long) ((j) + (((x10_long)1ll)))))
        {
            
            //#line 14 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
            x10_long v = id;
            
            //#line 15 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": polyglot.ast.For_c
            {
                x10_long k;
                for (
                     //#line 15 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
                     k = ((x10_long)1ll); ((k) < (l)); 
                                                       //#line 15 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": Eval of x10.ast.X10LocalAssign_c
                                                       k = ((x10_long) ((k) + (((x10_long)1ll)))))
                {
                    
                    //#line 16 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": Eval of x10.ast.X10LocalAssign_c
                    v = ((x10_long) ((((x10_long) ((v) - (((x10_long) ((v) % x10aux::zeroCheck(((x10_long) ((x) * (l)))))))))) + (((x10_long) ((((x10_long) ((((x10_long) ((v) + (((x10_long) ((x) * (l))))))) - (x)))) % x10aux::zeroCheck(((x10_long) ((x) * (l)))))))));
                    
                    //#line 17 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10If_c
                    if (((v) < (P))) {
                        
                        //#line 18 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": Eval of x10.ast.X10Call_c
                        x10aux::nullCheck(lifelines)->x10::lang::Rail<x10_long >::__set(
                          ((x10_long) ((t = ((x10_long) ((t) + (((x10_long)1ll))))) - (((x10_long)1ll)))),
                          v);
                        
                        //#line 19 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": polyglot.ast.Branch_c
                        break;
                    }
                    
                }
            }
            
            //#line 22 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": Eval of x10.ast.X10LocalAssign_c
            x = ((x10_long) ((x) * (l)));
        }
    }
    
    //#line 24 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10Return_c
    return lifelines;
    
}

//#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10MethodDecl_c
core::LifelineGenerator* core::LifelineGenerator::core__LifelineGenerator____this__core__LifelineGenerator(
  ) {
    
    //#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10ConstructorDecl_c
void core::LifelineGenerator::_constructor() {
    
    //#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.AssignPropertyCall_c
    
    //#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10LocalDecl_c
    core::LifelineGenerator* this16490 = this;
    
}
core::LifelineGenerator* core::LifelineGenerator::_make()
{
    core::LifelineGenerator* this_ = new (x10aux::alloc_z<core::LifelineGenerator>()) core::LifelineGenerator();
    this_->_constructor();
    return this_;
}



//#line 6 "/home/weiz/outgoing/wglb/core/LifelineGenerator.x10": x10.ast.X10MethodDecl_c
void core::LifelineGenerator::__fieldInitializers_core_LifelineGenerator(
  ) {
 
}
const x10aux::serialization_id_t core::LifelineGenerator::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core::LifelineGenerator::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void core::LifelineGenerator::_serialize_body(x10aux::serialization_buffer& buf) {
    
}

x10::lang::Reference* core::LifelineGenerator::_deserializer(x10aux::deserialization_buffer& buf) {
    core::LifelineGenerator* this_ = new (x10aux::alloc_z<core::LifelineGenerator>()) core::LifelineGenerator();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void core::LifelineGenerator::_deserialize_body(x10aux::deserialization_buffer& buf) {
    
}

x10aux::RuntimeType core::LifelineGenerator::rtt;
void core::LifelineGenerator::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("core.LifelineGenerator",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of LifelineGenerator */
/*************************************************/
