/*************************************************/
/* START of UTSTree */
#include <myuts/UTSTree.h>

#include <myuts/SHA1Rand.h>
#include <x10/lang/Int.h>
#include <x10/lang/Long.h>
#include <x10/lang/Double.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Math.h>
#include <x10/lang/Boolean.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/String.h>
#include <myuts/Queue.h>
#include <x10/util/Timer.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>

//#line 5 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 6 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 10 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 14 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10FieldDecl_c

//#line 15 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorDecl_c
void myuts::UTSTree::_constructor(x10_int factor) {
    
    //#line 15 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* this27806 = this;
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27806)->FMGL(hash) = (x10aux::class_cast_unchecked<x10::lang::Rail<myuts::SHA1Rand >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27806)->FMGL(lower) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27806)->FMGL(upper) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27806)->FMGL(size) = ((x10_long)0ll);
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27806)->FMGL(count) = ((x10_long)0ll);
    
    //#line 18 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = x10::lang::Rail<myuts::SHA1Rand >::_make(((x10_long)4096ll));
    
    //#line 19 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = x10::lang::Rail<x10_int >::_make(((x10_long)4096ll));
    
    //#line 20 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = x10::lang::Rail<x10_int >::_make(((x10_long)4096ll));
    
    //#line 21 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(den) = x10::lang::MathNatives::log(((((x10_double) (factor))) / (((1.0) + (((x10_double) (factor)))))));
    
    //#line 22 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(factor) = factor;
}
myuts::UTSTree* myuts::UTSTree::_make(x10_int factor) {
    myuts::UTSTree* this_ = new (x10aux::alloc_z<myuts::UTSTree>()) myuts::UTSTree();
    this_->_constructor(factor);
    return this_;
}



//#line 25 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::init(x10_int seed, x10_int height) {
    
    //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* this27809 = this;
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27810 = (__extension__ ({
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand alloc27811 =  myuts::SHA1Rand::_alloc();
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorCall_c
        (alloc27811)->::myuts::SHA1Rand::_constructor(seed, height);
        alloc27811;
    }))
    ;
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int u27807 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27810->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27809)->
                                                                                                                                                                                                              FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
    if (((u27807) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if (((x10aux::nullCheck(this27809)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27809)->
                                                                                           FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this27809)->myuts::UTSTree::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27809)->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          x10aux::nullCheck(this27809)->FMGL(size), h27810);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27809)->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          x10aux::nullCheck(this27809)->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27809)->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
              myuts::UTSTree* x27808 = this27809;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27808)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27808)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u27807);
    }
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::UTSTree* x27812 = this;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27812)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27812)->
                                                             FMGL(count)) + (((x10_long)1ll))));
}

//#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::push(myuts::SHA1Rand h) {
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int u = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (this->
                                                                                                                                                                                                    FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
    if (((u) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if (((this->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(this->
                                                                   FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            this->myuts::UTSTree::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          this->FMGL(size), h);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          this->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
              myuts::UTSTree* x27336 = this;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27336)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27336)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u);
    }
    
}

//#line 40 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::expand() {
    
    //#line 41 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_long top = ((x10_long) ((this->FMGL(size)) - (((x10_long)1ll))));
    
    //#line 42 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h = x10aux::nullCheck(this->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__apply(
                          top);
    
    //#line 43 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int d = h->FMGL(depth);
    
    //#line 44 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int l = x10aux::nullCheck(this->FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                  top);
    
    //#line 45 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_int u = ((x10_int) ((x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                               top)) - (((x10_int)1))));
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
    if (((d) > (((x10_int)1)))) {
        
        //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(u, l))) {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
            myuts::UTSTree* x27813 = this;
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27813)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27813)->
                                                                    FMGL(size)) - (((x10_long)1ll))));
        } else {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
              top, u);
        }
        
        //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* this27816 = this;
        
        //#line 30 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand h27817 = (__extension__ ({
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
            myuts::SHA1Rand alloc27818 =  myuts::SHA1Rand::_alloc();
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorCall_c
            (alloc27818)->::myuts::SHA1Rand::_constructor(
              h, u, ((x10_int) ((d) - (((x10_int)1)))));
            alloc27818;
        }))
        ;
        
        //#line 31 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        x10_int u27814 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27817->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27816)->
                                                                                                                                                                                                                  FMGL(den)))));
        
        //#line 32 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
        if (((u27814) > (((x10_int)0)))) {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10If_c
            if (((x10aux::nullCheck(this27816)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27816)->
                                                                                               FMGL(hash))->FMGL(size)))))
            {
                
                //#line 33 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this27816)->myuts::UTSTree::grow();
            }
            
            //#line 34 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27816)->
                                FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
              x10aux::nullCheck(this27816)->FMGL(size), h27817);
            
            //#line 35 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27816)->
                                FMGL(lower))->x10::lang::Rail<x10_int >::__set(
              x10aux::nullCheck(this27816)->FMGL(size), ((x10_int)0));
            
            //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27816)->
                                FMGL(upper))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
                  myuts::UTSTree* x27815 = this27816;
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x27815)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x27815)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), u27814);
        }
        
    } else {
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* x27819 = this;
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27819)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27819)->
                                                                FMGL(size)) - (((x10_long)1ll))));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::UTSTree* x27820 = this;
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        x10_int y27821 = ((x10_int) ((u) - (l)));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27820)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27820)->
                                                                 FMGL(count)) + (((x10_long) (y27821)))));
    }
    
}

//#line 59 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::grow() {
    
    //#line 60 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_long capacity = ((x10_long) ((this->FMGL(size)) * (((x10_long)2ll))));
    
    //#line 61 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<myuts::SHA1Rand >* h = x10::lang::Rail<myuts::SHA1Rand >::_make(capacity);
    
    //#line 62 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<myuts::SHA1Rand >(this->
                                                     FMGL(hash),
                                                   ((x10_long)0ll),
                                                   h, ((x10_long)0ll),
                                                   this->
                                                     FMGL(size));
    
    //#line 63 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = h;
    
    //#line 64 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* l = x10::lang::Rail<x10_int >::_make(capacity);
    
    //#line 65 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(lower),
                                           ((x10_long)0ll),
                                           l, ((x10_long)0ll),
                                           this->FMGL(size));
    
    //#line 66 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = l;
    
    //#line 67 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* u = x10::lang::Rail<x10_int >::_make(capacity);
    
    //#line 68 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(upper),
                                           ((x10_long)0ll),
                                           u, ((x10_long)0ll),
                                           this->FMGL(size));
    
    //#line 69 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = u;
}

//#line 72 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
x10::lang::String* myuts::UTSTree::sub(x10::lang::String* str,
                                       x10_int start, x10_int end) {
    
    //#line 72 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10Return_c
    return (str)->substring(start, (__extension__ ({
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int a27353 = end;
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int b27354 = (str)->length();
        ((a27353) < (b27354)) ? (a27353) : (b27354);
    }))
    );
    
}

//#line 74 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::main(x10::lang::Rail<x10::lang::String* >* id__1999) {
    
    //#line 75 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* queue =  (new (x10aux::alloc_z<myuts::Queue>()) myuts::Queue())
    ;
    
    //#line 75 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10ConstructorCall_c
    (queue)->::myuts::Queue::_constructor(((x10_int)4));
    
    //#line 76 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
    x10_long time = x10::lang::RuntimeNatives::nanoTime();
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27824 = (__extension__ ({
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand alloc27825 =  myuts::SHA1Rand::_alloc();
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
        (alloc27825)->::myuts::SHA1Rand::_constructor(((x10_int)19),
                                                      ((x10_int)13));
        alloc27825;
    }))
    ;
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int u27822 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27824->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (queue->
                                                                                                                                                                                                              FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
    if (((u27822) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((queue->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(queue->
                                                                    FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            queue->myuts::Queue::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          queue->FMGL(size), h27824);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          queue->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
              myuts::Queue* x27823 = queue;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27823)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27823)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u27822);
    }
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* x27826 = queue;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27826)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27826)->
                                                             FMGL(count)) + (((x10_long)1ll))));
    
    //#line 78 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10While_c
    while (((queue->FMGL(size)) > (((x10_long)0ll)))) {
        
        //#line 41 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_long top27835 = ((x10_long) ((queue->FMGL(size)) - (((x10_long)1ll))));
        
        //#line 42 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand h27836 = x10aux::nullCheck(queue->
                                                     FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__apply(
                                   top27835);
        
        //#line 43 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int d27837 = h27836->FMGL(depth);
        
        //#line 44 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int l27838 = x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                           top27835);
        
        //#line 45 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int u27839 = ((x10_int) ((x10aux::nullCheck(queue->
                                                          FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                                        top27835)) - (((x10_int)1))));
        
        //#line 47 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((d27837) > (((x10_int)1)))) {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
            if ((x10aux::struct_equals(u27839, l27838))) {
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                myuts::Queue* x27827 = queue;
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x27827)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27827)->
                                                                        FMGL(size)) - (((x10_long)1ll))));
            } else {
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
                  top27835, u27839);
            }
            
            //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::SHA1Rand h27830 = (__extension__ ({
                
                //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                myuts::SHA1Rand alloc27831 =  myuts::SHA1Rand::_alloc();
                
                //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
                (alloc27831)->::myuts::SHA1Rand::_constructor(
                  h27836, u27839, ((x10_int) ((d27837) - (((x10_int)1)))));
                alloc27831;
            }))
            ;
            
            //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            x10_int u27828 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27830->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (queue->
                                                                                                                                                                                                                      FMGL(den)))));
            
            //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
            if (((u27828) > (((x10_int)0)))) {
                
                //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
                if (((queue->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(queue->
                                                                            FMGL(hash))->FMGL(size)))))
                {
                    
                    //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                    queue->myuts::Queue::grow();
                }
                
                //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
                  queue->FMGL(size), h27830);
                
                //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
                  queue->FMGL(size), ((x10_int)0));
                
                //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (((__extension__ ({
                      
                      //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                      myuts::Queue* x27829 = queue;
                      
                      //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
                      ;
                      x10aux::nullCheck(x27829)->FMGL(size) =
                        ((x10_long) ((x10aux::nullCheck(x27829)->
                                        FMGL(size)) + (((x10_long)1ll))));
                  }))
                  ) - (((x10_long)1ll)))), u27828);
            }
            
        } else {
            
            //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::Queue* x27832 = queue;
            
            //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27832)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27832)->
                                                                    FMGL(size)) - (((x10_long)1ll))));
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::Queue* x27833 = queue;
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            x10_int y27834 = ((x10_int) ((u27839) - (l27838)));
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27833)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27833)->
                                                                     FMGL(count)) + (((x10_long) (y27834)))));
        }
        
        //#line 80 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10LocalDecl_c
        myuts::Queue* x27840 = queue;
        
        //#line 80 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
        x27840->FMGL(count) = ((x10_long) ((x27840->FMGL(count)) + (((x10_long)1ll))));
    }
    
    //#line 82 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10LocalAssign_c
    time = ((x10_long) ((x10::lang::RuntimeNatives::nanoTime()) - (time)));
    
    //#line 83 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Performance = "), queue->
                                                                                                                                                                                                                                               FMGL(count)), x10aux::makeStringLit("/")), myuts::UTSTree::sub(
                                                                                                                                                                                                                                                                                            x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (time))) / (1.0E9))),
                                                                                                                                                                                                                                                                                            ((x10_int)0),
                                                                                                                                                                                                                                                                                            ((x10_int)6))), x10aux::makeStringLit(" = ")), myuts::UTSTree::sub(
                                                                                                                                                                                                                                                                                                                                             x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (queue->
                                                                                                                                                                                                                                                                                                                                                                                                                     FMGL(count)))) / (((((x10_double) (time))) / (1000.0))))),
                                                                                                                                                                                                                                                                                                                                             ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                             ((x10_int)6))), x10aux::makeStringLit("M nodes/s"))));
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
myuts::UTSTree* myuts::UTSTree::myuts__UTSTree____this__myuts__UTSTree(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": x10.ast.X10MethodDecl_c
void myuts::UTSTree::__fieldInitializers_myuts_UTSTree() {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = (x10aux::class_cast_unchecked<x10::lang::Rail<myuts::SHA1Rand >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = ((x10_long)0ll);
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/UTSTree.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(count) = ((x10_long)0ll);
}
const x10aux::serialization_id_t myuts::UTSTree::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::UTSTree::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::UTSTree::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(hash));
    buf.write(this->FMGL(lower));
    buf.write(this->FMGL(upper));
    buf.write(this->FMGL(size));
    buf.write(this->FMGL(den));
    buf.write(this->FMGL(count));
    buf.write(this->FMGL(factor));
    
}

x10::lang::Reference* myuts::UTSTree::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::UTSTree* this_ = new (x10aux::alloc_z<myuts::UTSTree>()) myuts::UTSTree();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::UTSTree::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(hash) = buf.read<x10::lang::Rail<myuts::SHA1Rand >*>();
    FMGL(lower) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(upper) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(size) = buf.read<x10_long>();
    FMGL(den) = buf.read<x10_double>();
    FMGL(count) = buf.read<x10_long>();
    FMGL(factor) = buf.read<x10_int>();
}

x10aux::RuntimeType myuts::UTSTree::rtt;
void myuts::UTSTree::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("myuts.UTSTree",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of UTSTree */
/*************************************************/
