#ifndef __MYUTS_UTSTASKBAG_H
#define __MYUTS_UTSTASKBAG_H

#include <x10rt.h>


#define CORE_TASKBAG_H_NODEPS
#include <core/TaskBag.h>
#undef CORE_TASKBAG_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace myuts { 
class UTSTree;
} 
namespace myuts { 
class SHA1Rand;
} 
namespace x10 { namespace lang { 
class Math;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace myuts { 
class Fragment;
} 
namespace myuts { 

template<class TPMGL(UTSTreeNode)> class UTSTaskBag;
template <> class UTSTaskBag<void>;
template<class TPMGL(UTSTreeNode)> class UTSTaskBag : public x10::lang::X10Class
  {
    public:
    RTT_H_DECLS_CLASS
    
    static x10aux::itable_entry _itables[3];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    static typename core::TaskBag<TPMGL(UTSTreeNode)>::template itable<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> > _itable_0;
    
    static x10::lang::Any::itable<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> > _itable_1;
    
    myuts::UTSTree* FMGL(queue);
    
    x10_int FMGL(branchFactor);
    
    void _constructor(x10_int b);
    
    static myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* _make(x10_int b);
    
    void _constructor(myuts::UTSTree* tree);
    
    static myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* _make(myuts::UTSTree* tree);
    
    virtual void initTree(x10_int seed, x10_int d);
    virtual core::TaskBag<TPMGL(UTSTreeNode)>* split();
    virtual void merge(core::TaskBag<TPMGL(UTSTreeNode)>* tbb);
    virtual x10_long size();
    virtual void expand();
    virtual void incByI(x10_long i);
    virtual x10_long getCount();
    virtual myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* myuts__UTSTaskBag____this__myuts__UTSTaskBag(
      );
    virtual void __fieldInitializers_myuts_UTSTaskBag();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

template<class TPMGL(UTSTreeNode)> x10aux::RuntimeType myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::rtt;
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_initRTT() {
    const x10aux::RuntimeType *canonical = x10aux::getRTT<myuts::UTSTaskBag<void> >();
    if (rtt.initStageOne(canonical)) return;
    const x10aux::RuntimeType* parents[1] = { x10aux::getRTT<core::TaskBag<TPMGL(UTSTreeNode)> >()};
    const x10aux::RuntimeType* params[1] = { x10aux::getRTT<TPMGL(UTSTreeNode)>()};
    x10aux::RuntimeType::Variance variances[1] = { x10aux::RuntimeType::invariant};
    const char *baseName = "myuts.UTSTaskBag";
    rtt.initStageTwo(baseName, x10aux::RuntimeType::class_kind, 1, parents, 1, params, variances);
}

template <> class UTSTaskBag<void> : public x10::lang::X10Class {
    public:
    static x10aux::RuntimeType rtt;
    static const x10aux::RuntimeType* getRTT() { return & rtt; }
    
};

} 
#endif // MYUTS_UTSTASKBAG_H

namespace myuts { 
template<class TPMGL(UTSTreeNode)> class UTSTaskBag;
} 

#ifndef MYUTS_UTSTASKBAG_H_NODEPS
#define MYUTS_UTSTASKBAG_H_NODEPS
#include <core/TaskBag.h>
#include <x10/lang/Int.h>
#include <myuts/UTSTree.h>
#include <myuts/SHA1Rand.h>
#include <x10/lang/Math.h>
#include <x10/lang/Double.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/Long.h>
#include <x10/lang/Rail.h>
#include <myuts/Fragment.h>
#ifndef MYUTS_UTSTASKBAG_H_GENERICS
#define MYUTS_UTSTASKBAG_H_GENERICS
#endif // MYUTS_UTSTASKBAG_H_GENERICS
#ifndef MYUTS_UTSTASKBAG_H_IMPLEMENTATION
#define MYUTS_UTSTASKBAG_H_IMPLEMENTATION
#include <myuts/UTSTaskBag.h>

template<class TPMGL(UTSTreeNode)> typename core::TaskBag<TPMGL(UTSTreeNode)>::template itable<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >  myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_itable_0(&x10::lang::X10Class::equals, &x10::lang::X10Class::hashCode, &myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::merge, &myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::size, &myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::split, &x10::lang::X10Class::toString, &x10::lang::X10Class::typeName);
template<class TPMGL(UTSTreeNode)> x10::lang::Any::itable<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >  myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_itable_1(&x10::lang::X10Class::equals, &x10::lang::X10Class::hashCode, &x10::lang::X10Class::toString, &x10::lang::X10Class::typeName);
template<class TPMGL(UTSTreeNode)> x10aux::itable_entry myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_itables[3] = {x10aux::itable_entry(&x10aux::getRTT<core::TaskBag<TPMGL(UTSTreeNode)> >, &_itable_0), x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &_itable_1), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >())};

//#line 5 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10FieldDecl_c

//#line 9 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_constructor(
                                     x10_int b) {
    
    //#line 9 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* this27287 = this;
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27287)->FMGL(branchFactor) = ((x10_int)0);
    
    //#line 10 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(branchFactor) = b;
    
    //#line 11 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(queue) = (__extension__ ({
        
        //#line 11 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* alloc22535 =  (new (x10aux::alloc_z<myuts::UTSTree>()) myuts::UTSTree())
        ;
        
        //#line 11 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10ConstructorCall_c
        (alloc22535)->::myuts::UTSTree::_constructor(b);
        alloc22535;
    }))
    ;
}
template<class TPMGL(UTSTreeNode)> myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_make(
                                     x10_int b) {
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* this_ = new (x10aux::alloc_z<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >()) myuts::UTSTaskBag<TPMGL(UTSTreeNode)>();
    this_->_constructor(b);
    return this_;
}



//#line 14 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10ConstructorDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_constructor(
                                     myuts::UTSTree* tree) {
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* this27288 = this;
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27288)->FMGL(branchFactor) = ((x10_int)0);
    
    //#line 15 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(queue) = tree;
}
template<class TPMGL(UTSTreeNode)> myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_make(
                                     myuts::UTSTree* tree)
{
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* this_ = new (x10aux::alloc_z<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >()) myuts::UTSTaskBag<TPMGL(UTSTreeNode)>();
    this_->_constructor(tree);
    return this_;
}



//#line 21 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::initTree(
  x10_int seed, x10_int d) {
    
    //#line 22 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* this27294 = this->FMGL(queue);
    
    //#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int seed27295 = seed;
    
    //#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int height27296 = d;
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27291 = (__extension__ ({
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand alloc27292 =  myuts::SHA1Rand::_alloc();
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorCall_c
        (alloc27292)->::myuts::SHA1Rand::_constructor(seed27295,
                                                      height27296);
        alloc27292;
    }))
    ;
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int u27289 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27291->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27294)->
                                                                                                                                                                                                              FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
    if (((u27289) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if (((x10aux::nullCheck(this27294)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27294)->
                                                                                           FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this27294)->myuts::UTSTree::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27294)->FMGL(hash))->x10::lang::template Rail<myuts::SHA1Rand >::__set(
          x10aux::nullCheck(this27294)->FMGL(size), h27291);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27294)->FMGL(lower))->x10::lang::template Rail<x10_int >::__set(
          x10aux::nullCheck(this27294)->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27294)->FMGL(upper))->x10::lang::template Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
              myuts::UTSTree* x27290 = this27294;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27290)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27290)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u27289);
    }
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* x27293 = this27294;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27293)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27293)->
                                                             FMGL(count)) + (((x10_long)1ll))));
}

//#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> core::TaskBag<TPMGL(UTSTreeNode)>*
  myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::split() {
    
    //#line 28 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    x10_long s = ((x10_long)0ll);
    
    //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < (x10aux::nullCheck(this->
                                                              FMGL(queue))->
                                            FMGL(size)));
             
             //#line 29 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10If_c
            if (((((x10_long) (((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                  FMGL(queue))->
                                                                FMGL(upper))->x10::lang::template Rail<x10_int >::__apply(
                                              i)) - (x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                           FMGL(queue))->
                                                                         FMGL(lower))->x10::lang::template Rail<x10_int >::__apply(
                                                       i))))))) >= (((x10_long)2ll))))
            {
                
                //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10LocalAssign_c
                s = ((x10_long) ((s) + (((x10_long)1ll))));
            }
            
        }
    }
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(s, ((x10_long)0ll)))) {
        
        //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10Return_c
        return x10aux::class_cast_unchecked<core::TaskBag<TPMGL(UTSTreeNode)>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
        
    }
    
    //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::Fragment* fragment =  (new (x10aux::alloc_z<myuts::Fragment>()) myuts::Fragment())
    ;
    
    //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10ConstructorCall_c
    (fragment)->::myuts::Fragment::_constructor(s);
    
    //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10LocalAssign_c
    s = ((x10_long)0ll);
    
    //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": polyglot.ast.For_c
    {
        x10_long i;
        for (
             //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
             i = ((x10_long)0ll); ((i) < (x10aux::nullCheck(this->
                                                              FMGL(queue))->
                                            FMGL(size)));
             
             //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_long) ((i) + (((x10_long)1ll))))) {
            
            //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
            x10_int p = ((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(this->
                                                                           FMGL(queue))->
                                                         FMGL(upper))->x10::lang::template Rail<x10_int >::__apply(
                                       i)) - (x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                    FMGL(queue))->
                                                                  FMGL(lower))->x10::lang::template Rail<x10_int >::__apply(
                                                i))));
            
            //#line 37 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10If_c
            if (((p) >= (((x10_int)2)))) {
                
                //#line 38 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(hash))->x10::lang::template Rail<myuts::SHA1Rand >::__set(
                  s, x10aux::nullCheck(x10aux::nullCheck(this->
                                                           FMGL(queue))->
                                         FMGL(hash))->x10::lang::template Rail<myuts::SHA1Rand >::__apply(
                       i));
                
                //#line 39 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(upper))->x10::lang::template Rail<x10_int >::__set(
                  s, x10aux::nullCheck(x10aux::nullCheck(this->
                                                           FMGL(queue))->
                                         FMGL(upper))->x10::lang::template Rail<x10_int >::__apply(
                       i));
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
                x10::lang::Rail<x10_int >* x27298 = x10aux::nullCheck(this->
                                                                        FMGL(queue))->
                                                      FMGL(upper);
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
                x10_long y27299 = i;
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
                x10_int z27300 = ((x10_int) ((p) / x10aux::zeroCheck(((x10_int)2))));
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
                x10_int ret27301;
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
                x10_int r27297 = ((x10_int) ((x10aux::nullCheck(x27298)->x10::lang::template Rail<x10_int >::__apply(
                                                y27299)) - (z27300)));
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(x27298)->x10::lang::template Rail<x10_int >::__set(
                  y27299, r27297);
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10LocalAssign_c
                ret27301 = r27297;
                
                //#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Local_c
                ret27301;
                
                //#line 41 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(fragment->FMGL(lower))->x10::lang::template Rail<x10_int >::__set(
                  ((x10_long) ((s = ((x10_long) ((s) + (((x10_long)1ll))))) - (((x10_long)1ll)))),
                  x10aux::nullCheck(x10aux::nullCheck(this->
                                                        FMGL(queue))->
                                      FMGL(upper))->x10::lang::template Rail<x10_int >::__apply(
                    i));
            }
            
        }
    }
    
    //#line 46 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* sentoutTree =  (new (x10aux::alloc_z<myuts::UTSTree>()) myuts::UTSTree())
    ;
    
    //#line 46 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10ConstructorCall_c
    (sentoutTree)->::myuts::UTSTree::_constructor(x10aux::nullCheck(this->
                                                                      FMGL(queue))->
                                                    FMGL(factor));
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
    fragment->myuts::Fragment::pushWA(sentoutTree);
    
    //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* alloc27303 =  (new (x10aux::alloc_z<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >()) myuts::UTSTaskBag<TPMGL(UTSTreeNode)>())
    ;
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* tree27302 = sentoutTree;
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    alloc27303->FMGL(branchFactor) = ((x10_int)0);
    
    //#line 15 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    alloc27303->FMGL(queue) = tree27302;
    
    //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10Return_c
    return reinterpret_cast<core::TaskBag<TPMGL(UTSTreeNode)>*>(alloc27303);
    
}

//#line 53 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::merge(
  core::TaskBag<TPMGL(UTSTreeNode)>* tbb) {
    
    //#line 54 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* tb = x10aux::class_cast<myuts::UTSTaskBag<TPMGL(UTSTreeNode)>*>(tbb);
    
    //#line 55 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* tbqueue = x10aux::nullCheck(tb)->FMGL(queue);
    
    //#line 56 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    x10_long h = (x10_long)(x10aux::nullCheck(x10aux::nullCheck(tbqueue)->
                                                FMGL(hash))->FMGL(size));
    
    //#line 57 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    x10_long q = x10aux::nullCheck(this->FMGL(queue))->FMGL(size);
    
    //#line 58 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10While_c
    while (((((x10_long) ((h) + (q)))) > ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                           FMGL(queue))->
                                                                         FMGL(hash))->FMGL(size)))))
    {
        
        //#line 58 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(queue))->myuts::UTSTree::grow();
    }
    
    //#line 59 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::template copy<myuts::SHA1Rand >(
      x10aux::nullCheck(tbqueue)->FMGL(hash), ((x10_long)0ll),
      x10aux::nullCheck(this->FMGL(queue))->FMGL(hash), q,
      h);
    
    //#line 60 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::template copy<x10_int >(x10aux::nullCheck(tbqueue)->
                                                      FMGL(lower),
                                                    ((x10_long)0ll),
                                                    x10aux::nullCheck(this->
                                                                        FMGL(queue))->
                                                      FMGL(lower),
                                                    q, h);
    
    //#line 61 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::template copy<x10_int >(x10aux::nullCheck(tbqueue)->
                                                      FMGL(upper),
                                                    ((x10_long)0ll),
                                                    x10aux::nullCheck(this->
                                                                        FMGL(queue))->
                                                      FMGL(upper),
                                                    q, h);
    
    //#line 62 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* x27304 = this->FMGL(queue);
    
    //#line 62 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    x10_long y27305 = h;
    
    //#line 62 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27304)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27304)->
                                                            FMGL(size)) + (y27305)));
}

//#line 69 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> x10_long myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::size(
  ) {
    
    //#line 70 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10Return_c
    return x10aux::nullCheck(this->FMGL(queue))->FMGL(size);
    
}

//#line 76 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::expand(
  ) {
    
    //#line 77 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* this27319 = this->FMGL(queue);
    
    //#line 41 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_long top27314 = ((x10_long) ((x10aux::nullCheck(this27319)->
                                        FMGL(size)) - (((x10_long)1ll))));
    
    //#line 42 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27315 = x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                                 FMGL(hash))->x10::lang::template Rail<myuts::SHA1Rand >::__apply(
                               top27314);
    
    //#line 43 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int d27316 = h27315->FMGL(depth);
    
    //#line 44 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int l27317 = x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                         FMGL(lower))->x10::lang::template Rail<x10_int >::__apply(
                       top27314);
    
    //#line 45 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int u27318 = ((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                                      FMGL(upper))->x10::lang::template Rail<x10_int >::__apply(
                                    top27314)) - (((x10_int)1))));
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
    if (((d27316) > (((x10_int)1)))) {
        
        //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(u27318, l27317))) {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
            myuts::UTSTree* x27306 = this27319;
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27306)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27306)->
                                                                    FMGL(size)) - (((x10_long)1ll))));
        } else {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                FMGL(upper))->x10::lang::template Rail<x10_int >::__set(
              top27314, u27318);
        }
        
        //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand h27309 = (__extension__ ({
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
            myuts::SHA1Rand alloc27310 =  myuts::SHA1Rand::_alloc();
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorCall_c
            (alloc27310)->::myuts::SHA1Rand::_constructor(
              h27315, u27318, ((x10_int) ((d27316) - (((x10_int)1)))));
            alloc27310;
        }))
        ;
        
        //#line 31 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        x10_int u27307 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27309->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27319)->
                                                                                                                                                                                                                  FMGL(den)))));
        
        //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if (((u27307) > (((x10_int)0)))) {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
            if (((x10aux::nullCheck(this27319)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                                                                               FMGL(hash))->FMGL(size)))))
            {
                
                //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this27319)->myuts::UTSTree::grow();
            }
            
            //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                FMGL(hash))->x10::lang::template Rail<myuts::SHA1Rand >::__set(
              x10aux::nullCheck(this27319)->FMGL(size), h27309);
            
            //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                FMGL(lower))->x10::lang::template Rail<x10_int >::__set(
              x10aux::nullCheck(this27319)->FMGL(size), ((x10_int)0));
            
            //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27319)->
                                FMGL(upper))->x10::lang::template Rail<x10_int >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
                  myuts::UTSTree* x27308 = this27319;
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x27308)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x27308)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), u27307);
        }
        
    } else {
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* x27311 = this27319;
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27311)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27311)->
                                                                FMGL(size)) - (((x10_long)1ll))));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* x27312 = this27319;
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        x10_int y27313 = ((x10_int) ((u27318) - (l27317)));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27312)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27312)->
                                                                 FMGL(count)) + (((x10_long) (y27313)))));
    }
    
}

//#line 83 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::incByI(
  x10_long i) {
    
    //#line 84 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* x27320 = this->FMGL(queue);
    
    //#line 84 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10LocalDecl_c
    x10_long y27321 = i;
    
    //#line 84 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27320)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27320)->
                                                             FMGL(count)) + (y27321)));
}

//#line 90 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> x10_long myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::getCount(
  ) {
    
    //#line 91 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10Return_c
    return x10aux::nullCheck(this->FMGL(queue))->FMGL(count);
    
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> myuts::UTSTaskBag<TPMGL(UTSTreeNode)>*
  myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::myuts__UTSTaskBag____this__myuts__UTSTaskBag(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": x10.ast.X10MethodDecl_c
template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::__fieldInitializers_myuts_UTSTaskBag(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTaskBag.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(branchFactor) = ((x10_int)0);
}
template<class TPMGL(UTSTreeNode)> const x10aux::serialization_id_t myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(queue));
    buf.write(this->FMGL(branchFactor));
    
}

template<class TPMGL(UTSTreeNode)> x10::lang::Reference* myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::UTSTaskBag<TPMGL(UTSTreeNode)>* this_ = new (x10aux::alloc_z<myuts::UTSTaskBag<TPMGL(UTSTreeNode)> >()) myuts::UTSTaskBag<TPMGL(UTSTreeNode)>();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

template<class TPMGL(UTSTreeNode)> void myuts::UTSTaskBag<TPMGL(UTSTreeNode)>::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(queue) = buf.read<myuts::UTSTree*>();
    FMGL(branchFactor) = buf.read<x10_int>();
}

#endif // MYUTS_UTSTASKBAG_H_IMPLEMENTATION
#endif // __MYUTS_UTSTASKBAG_H_NODEPS
