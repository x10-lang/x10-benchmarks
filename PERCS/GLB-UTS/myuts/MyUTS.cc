/*************************************************/
/* START of MyUTS */
#include <myuts/MyUTS.h>

#include <core/GlobalJobRunner.h>
#include <myuts/UTSTreeNode.h>
#include <x10/lang/Long.h>
#include <x10/lang/Reducible.h>
#include <x10/lang/Rail.h>
#include <x10/lang/String.h>
#include <x10/util/OptionsParser.h>
#include <x10/util/Option.h>
#include <x10/lang/Int.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/Place.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <myuts/UTSResultReducible.h>
#include <x10/util/Timer.h>
#include <x10/lang/Fun_0_0.h>
#include <core/LocalJobRunner.h>
#include <core/TaskFrame.h>
#include <myuts/UTSTaskFrame.h>
#include <x10/lang/Double.h>
#ifndef MYUTS_MYUTS__CLOSURE__1_CLOSURE
#define MYUTS_MYUTS__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class myuts_MyUTS__closure__1 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*>::itable<myuts_MyUTS__closure__1> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>* __apply() {
        
        //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
        core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>* alloc15640 =
           (new (x10aux::alloc_z<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long> >()) core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>())
        ;
        
        //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10ConstructorCall_c
        (alloc15640)->::core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>::_constructor(
          reinterpret_cast<core::TaskFrame<myuts::UTSTreeNode*, x10_long>*>((__extension__ ({
              
              //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
              myuts::UTSTaskFrame* alloc15641 =  (new (x10aux::alloc_z<myuts::UTSTaskFrame>()) myuts::UTSTaskFrame())
              ;
              
              //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10ConstructorCall_c
              (alloc15641)->::myuts::UTSTaskFrame::_constructor(b,
                                                                r,
                                                                d);
              alloc15641;
          }))
          ), n, w, l, z, m);
        
        //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10Return_c
        return alloc15640;
        
    }
    
    // captured environment
    x10_int b;
    x10_int r;
    x10_int d;
    x10_int n;
    x10_int w;
    x10_int l;
    x10_int z;
    x10_int m;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->b);
        buf.write(this->r);
        buf.write(this->d);
        buf.write(this->n);
        buf.write(this->w);
        buf.write(this->l);
        buf.write(this->z);
        buf.write(this->m);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        myuts_MyUTS__closure__1* storage = x10aux::alloc_z<myuts_MyUTS__closure__1>();
        buf.record_reference(storage);
        x10_int that_b = buf.read<x10_int>();
        x10_int that_r = buf.read<x10_int>();
        x10_int that_d = buf.read<x10_int>();
        x10_int that_n = buf.read<x10_int>();
        x10_int that_w = buf.read<x10_int>();
        x10_int that_l = buf.read<x10_int>();
        x10_int that_z = buf.read<x10_int>();
        x10_int that_m = buf.read<x10_int>();
        myuts_MyUTS__closure__1* this_ = new (storage) myuts_MyUTS__closure__1(that_b, that_r, that_d, that_n, that_w, that_l, that_z, that_m);
        return this_;
    }
    
    myuts_MyUTS__closure__1(x10_int b, x10_int r, x10_int d, x10_int n, x10_int w, x10_int l, x10_int z, x10_int m) : b(b), r(r), d(d), n(n), w(w), l(l), z(z), m(m) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*> >(); }
    
    const char* toNativeString() {
        return "/home/weiz/outgoing/wglb/myuts/MyUTS.x10:70";
    }

};

#endif // MYUTS_MYUTS__CLOSURE__1_CLOSURE

//#line 16 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10FieldDecl_c

//#line 17 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10MethodDecl_c
x10::lang::Reducible<x10_long>* myuts::MyUTS::getResultReducer() {
    
    //#line 19 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10Return_c
    return this->FMGL(resultReducer);
    
}

//#line 22 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10MethodDecl_c
void myuts::MyUTS::setResultReducer(x10::lang::Reducible<x10_long>* r) {
    
    //#line 23 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(resultReducer) = r;
}

//#line 26 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10MethodDecl_c
void myuts::MyUTS::main(x10::lang::Rail<x10::lang::String* >* args) {
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10::util::OptionsParser* opts =  (new (x10aux::alloc_z<x10::util::OptionsParser>()) x10::util::OptionsParser())
    ;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10ConstructorCall_c
    (opts)->::x10::util::OptionsParser::_constructor(args, x10::lang::Rail<x10::util::Option >::_make(),
                                                     (x10::lang::Rail<x10::util::Option >*)(__extension__ ({
                                                         x10::lang::Rail<x10::util::Option >* __var3__(x10::lang::Rail<x10::util::Option>::_make(8));
                                                         __var3__->__set(0, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 28 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5967 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15616 =
                                                                x10aux::makeStringLit("b");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15617 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15618 =
                                                                x10aux::makeStringLit("Branching factor");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5967)->::x10::util::Option::_constructor(
                                                                s15616,
                                                                l15617,
                                                                d15618,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5967;
                                                          }))
                                                          ));
                                                         __var3__->__set(1, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 29 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5968 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15619 =
                                                                x10aux::makeStringLit("r");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15620 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15621 =
                                                                x10aux::makeStringLit("Seed (0 <= r < 2^31");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5968)->::x10::util::Option::_constructor(
                                                                s15619,
                                                                l15620,
                                                                d15621,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5968;
                                                          }))
                                                          ));
                                                         __var3__->__set(2, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 30 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5969 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15622 =
                                                                x10aux::makeStringLit("d");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15623 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15624 =
                                                                x10aux::makeStringLit("Tree depth");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5969)->::x10::util::Option::_constructor(
                                                                s15622,
                                                                l15623,
                                                                d15624,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5969;
                                                          }))
                                                          ));
                                                         __var3__->__set(3, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 31 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5970 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15625 =
                                                                x10aux::makeStringLit("n");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15626 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15627 =
                                                                x10aux::makeStringLit("Number of nodes to process before probing. Default 200.");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5970)->::x10::util::Option::_constructor(
                                                                s15625,
                                                                l15626,
                                                                d15627,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5970;
                                                          }))
                                                          ));
                                                         __var3__->__set(4, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 32 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5971 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15628 =
                                                                x10aux::makeStringLit("w");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15629 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15630 =
                                                                x10aux::makeStringLit("Number of thieves to send out. Default 1.");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5971)->::x10::util::Option::_constructor(
                                                                s15628,
                                                                l15629,
                                                                d15630,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5971;
                                                          }))
                                                          ));
                                                         __var3__->__set(5, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 33 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5972 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15631 =
                                                                x10aux::makeStringLit("l");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15632 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15633 =
                                                                x10aux::makeStringLit("Base of the lifeline");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5972)->::x10::util::Option::_constructor(
                                                                s15631,
                                                                l15632,
                                                                d15633,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5972;
                                                          }))
                                                          ));
                                                         __var3__->__set(6, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 34 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5973 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15634 =
                                                                x10aux::makeStringLit("m");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15635 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15636 =
                                                                x10aux::makeStringLit("Max potential victims");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5973)->::x10::util::Option::_constructor(
                                                                s15634,
                                                                l15635,
                                                                d15636,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5973;
                                                          }))
                                                          ));
                                                         __var3__->__set(7, 
                                                         ((__extension__ ({
                                                              
                                                              //#line 35 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                              x10::util::Option alloc5974 =
                                                                
                                                              x10::util::Option::_alloc();
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* s15637 =
                                                                x10aux::makeStringLit("v");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* l15638 =
                                                                x10aux::makeStringLit("");
                                                              
                                                              //#line 94 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10LocalDecl_c
                                                              x10::lang::String* d15639 =
                                                                x10aux::makeStringLit("Verbose. Default 0 (no).");
                                                              
                                                              //#line 95 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/util/Option.x10": x10.ast.X10ConstructorCall_c
                                                              (alloc5974)->::x10::util::Option::_constructor(
                                                                s15637,
                                                                l15638,
                                                                d15639,
                                                                ((x10_int)0),
                                                                false,
                                                                false,
                                                                false);
                                                              alloc5974;
                                                          }))
                                                          ));
                                                         __var3__;
                                                     })));
    
    //#line 37 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int b = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-b"),
                                                        ((x10_int)4));
    
    //#line 38 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int r = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-r"),
                                                        ((x10_int)19));
    
    //#line 39 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int d = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-d"),
                                                        ((x10_int)13));
    
    //#line 40 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int n = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-n"),
                                                        ((x10_int)511));
    
    //#line 41 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int l = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-l"),
                                                        ((x10_int)32));
    
    //#line 42 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int m = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-m"),
                                                        ((x10_int)1024));
    
    //#line 43 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_boolean verbose = (!x10aux::struct_equals(opts->x10::util::OptionsParser::__apply(
                                                    x10aux::makeStringLit("-v"),
                                                    ((x10_long)0ll)),
                                                  ((x10_long)0ll)));
    
    //#line 45 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_long P = ((x10_long)x10aux::num_hosts);
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int z0 = ((x10_int)1);
    
    //#line 48 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int zz = l;
    
    //#line 49 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10While_c
    while (((((x10_long) (zz))) < (P))) {
        
        //#line 50 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10LocalAssign_c
        z0 = ((x10_int) ((z0) + (((x10_int)1))));
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10LocalAssign_c
        zz = ((x10_int) ((zz) * (l)));
    }
    
    //#line 53 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int z = z0;
    
    //#line 55 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_int w = opts->x10::util::OptionsParser::__apply(x10aux::makeStringLit("-w"),
                                                        z);
    
    //#line 57 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("places="), P), x10aux::makeStringLit("   b=")), b), x10aux::makeStringLit("   r=")), r), x10aux::makeStringLit("   d=")), d), x10aux::makeStringLit("   w=")), w), x10aux::makeStringLit("   n=")), n), x10aux::makeStringLit("   l=")), l), x10aux::makeStringLit("   m=")), m), x10aux::makeStringLit("   z=")), z)));
    
    //#line 67 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    myuts::MyUTS* myuts =  (new (x10aux::alloc_z<myuts::MyUTS>()) myuts::MyUTS())
    ;
    
    //#line 67 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10ConstructorCall_c
    (myuts)->::myuts::MyUTS::_constructor();
    
    //#line 68 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(myuts)->setResultReducer(reinterpret_cast<x10::lang::Reducible<x10_long>*>((__extension__ ({
                                                   
                                                   //#line 68 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
                                                   myuts::UTSResultReducible* alloc5975 =
                                                      (new (x10aux::alloc_z<myuts::UTSResultReducible>()) myuts::UTSResultReducible())
                                                   ;
                                                   alloc5975;
                                               }))
                                               ));
    
    //#line 69 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_long time = x10::lang::RuntimeNatives::nanoTime();
    
    //#line 70 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    x10_long result = x10aux::nullCheck(myuts)->main(reinterpret_cast<x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*> >(sizeof(myuts_MyUTS__closure__1)))myuts_MyUTS__closure__1(b, r, d, n, w, l, z, m))));
    
    //#line 71 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10LocalAssign_c
    time = ((x10_long) ((x10::lang::RuntimeNatives::nanoTime()) - (time)));
    
    //#line 72 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10aux::makeStringLit("result: "), result)));
    
    //#line 73 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Throughput: "), ((((x10_double) (result))) / (((((x10_double) (time))) / (1000.0))))), x10aux::makeStringLit(" M nodes/s"))));
}

//#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10MethodDecl_c
myuts::MyUTS* myuts::MyUTS::myuts__MyUTS____this__myuts__MyUTS(
  ) {
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10ConstructorDecl_c
void myuts::MyUTS::_constructor() {
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long>* this15643 =
      this;
    
    //#line 15 "/home/weiz/outgoing/wglb/core/GlobalJobRunner.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this15643)->FMGL(resultReducer) = (x10aux::class_cast_unchecked<x10::lang::Reducible<x10_long>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.AssignPropertyCall_c
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10LocalDecl_c
    myuts::MyUTS* this15642 = this;
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this15642)->FMGL(resultReducer) = (x10aux::class_cast_unchecked<x10::lang::Reducible<x10_long>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
myuts::MyUTS* myuts::MyUTS::_make() {
    myuts::MyUTS* this_ = new (x10aux::alloc_z<myuts::MyUTS>()) myuts::MyUTS();
    this_->_constructor();
    return this_;
}



//#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": x10.ast.X10MethodDecl_c
void myuts::MyUTS::__fieldInitializers_myuts_MyUTS() {
    
    //#line 14 "/home/weiz/outgoing/wglb/myuts/MyUTS.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(resultReducer) = (x10aux::class_cast_unchecked<x10::lang::Reducible<x10_long>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
const x10aux::serialization_id_t myuts::MyUTS::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::MyUTS::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::MyUTS::_serialize_body(x10aux::serialization_buffer& buf) {
    core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long>::_serialize_body(buf);
    buf.write(this->FMGL(resultReducer));
    
}

x10::lang::Reference* myuts::MyUTS::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::MyUTS* this_ = new (x10aux::alloc_z<myuts::MyUTS>()) myuts::MyUTS();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::MyUTS::_deserialize_body(x10aux::deserialization_buffer& buf) {
    core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long>::_deserialize_body(buf);
    FMGL(resultReducer) = buf.read<x10::lang::Reducible<x10_long>*>();
}

x10aux::RuntimeType myuts::MyUTS::rtt;
void myuts::MyUTS::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[1] = { x10aux::getRTT<core::GlobalJobRunner<myuts::UTSTreeNode*, x10_long> >()};
    rtt.initStageTwo("myuts.MyUTS",x10aux::RuntimeType::class_kind, 1, parents, 0, NULL, NULL);
}

x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*>::itable<myuts_MyUTS__closure__1>myuts_MyUTS__closure__1::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &myuts_MyUTS__closure__1::__apply, &myuts_MyUTS__closure__1::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry myuts_MyUTS__closure__1::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<core::LocalJobRunner<myuts::UTSTreeNode*, x10_long>*> >, &myuts_MyUTS__closure__1::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t myuts_MyUTS__closure__1::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts_MyUTS__closure__1::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

/* END of MyUTS */
/*************************************************/
