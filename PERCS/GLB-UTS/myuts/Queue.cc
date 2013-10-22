/*************************************************/
/* START of Queue */
#include <myuts/Queue.h>

#include <myuts/SHA1Rand.h>
#include <x10/lang/Int.h>
#include <x10/lang/Long.h>
#include <x10/lang/Double.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Math.h>
#include <x10/lang/Boolean.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/String.h>
#include <x10/util/Timer.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>

//#line 5 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 6 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 10 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10FieldDecl_c

//#line 15 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorDecl_c
void myuts::Queue::_constructor(x10_int factor) {
    
    //#line 15 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* this27952 = this;
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27952)->FMGL(hash) = (x10aux::class_cast_unchecked<x10::lang::Rail<myuts::SHA1Rand >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27952)->FMGL(lower) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27952)->FMGL(upper) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27952)->FMGL(size) = ((x10_long)0ll);
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this27952)->FMGL(count) = ((x10_long)0ll);
    
    //#line 18 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = x10::lang::Rail<myuts::SHA1Rand >::_make(((x10_long)4096ll));
    
    //#line 19 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = x10::lang::Rail<x10_int >::_make(((x10_long)4096ll));
    
    //#line 20 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = x10::lang::Rail<x10_int >::_make(((x10_long)4096ll));
    
    //#line 21 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(den) = x10::lang::MathNatives::log(((((x10_double) (factor))) / (((1.0) + (((x10_double) (factor)))))));
}
myuts::Queue* myuts::Queue::_make(x10_int factor) {
    myuts::Queue* this_ = new (x10aux::alloc_z<myuts::Queue>()) myuts::Queue();
    this_->_constructor(factor);
    return this_;
}



//#line 25 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::init(x10_int seed, x10_int height) {
    
    //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* this27955 = this;
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27956 = (__extension__ ({
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand alloc27957 =  myuts::SHA1Rand::_alloc();
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
        (alloc27957)->::myuts::SHA1Rand::_constructor(seed, height);
        alloc27957;
    }))
    ;
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int u27953 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27956->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27955)->
                                                                                                                                                                                                              FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
    if (((u27953) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((x10aux::nullCheck(this27955)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27955)->
                                                                                           FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this27955)->myuts::Queue::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27955)->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          x10aux::nullCheck(this27955)->FMGL(size), h27956);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27955)->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          x10aux::nullCheck(this27955)->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(this27955)->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
              myuts::Queue* x27954 = this27955;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27954)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27954)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u27953);
    }
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* x27958 = this;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27958)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27958)->
                                                             FMGL(count)) + (((x10_long)1ll))));
}

//#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::push(myuts::SHA1Rand h) {
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int u = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (this->
                                                                                                                                                                                                    FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
    if (((u) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((this->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(this->
                                                                   FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            this->myuts::Queue::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          this->FMGL(size), h);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          this->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
              myuts::Queue* x27886 = this;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27886)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27886)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u);
    }
    
}

//#line 40 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::expand() {
    
    //#line 41 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_long top = ((x10_long) ((this->FMGL(size)) - (((x10_long)1ll))));
    
    //#line 42 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h = x10aux::nullCheck(this->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__apply(
                          top);
    
    //#line 43 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int d = h->FMGL(depth);
    
    //#line 44 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int l = x10aux::nullCheck(this->FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                  top);
    
    //#line 45 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int u = ((x10_int) ((x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                               top)) - (((x10_int)1))));
    
    //#line 47 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
    if (((d) > (((x10_int)1)))) {
        
        //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(u, l))) {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::Queue* x27959 = this;
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27959)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27959)->
                                                                    FMGL(size)) - (((x10_long)1ll))));
        } else {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(this->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
              top, u);
        }
        
        //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::Queue* this27962 = this;
        
        //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand h27963 = (__extension__ ({
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::SHA1Rand alloc27964 =  myuts::SHA1Rand::_alloc();
            
            //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
            (alloc27964)->::myuts::SHA1Rand::_constructor(
              h, u, ((x10_int) ((d) - (((x10_int)1)))));
            alloc27964;
        }))
        ;
        
        //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int u27960 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27963->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (x10aux::nullCheck(this27962)->
                                                                                                                                                                                                                  FMGL(den)))));
        
        //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((u27960) > (((x10_int)0)))) {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
            if (((x10aux::nullCheck(this27962)->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(x10aux::nullCheck(this27962)->
                                                                                               FMGL(hash))->FMGL(size)))))
            {
                
                //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this27962)->myuts::Queue::grow();
            }
            
            //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27962)->
                                FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
              x10aux::nullCheck(this27962)->FMGL(size), h27963);
            
            //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27962)->
                                FMGL(lower))->x10::lang::Rail<x10_int >::__set(
              x10aux::nullCheck(this27962)->FMGL(size), ((x10_int)0));
            
            //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(this27962)->
                                FMGL(upper))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((__extension__ ({
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                  myuts::Queue* x27961 = this27962;
                  
                  //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
                  ;
                  x10aux::nullCheck(x27961)->FMGL(size) =
                    ((x10_long) ((x10aux::nullCheck(x27961)->
                                    FMGL(size)) + (((x10_long)1ll))));
              }))
              ) - (((x10_long)1ll)))), u27960);
        }
        
    } else {
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::Queue* x27965 = this;
        
        //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27965)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27965)->
                                                                FMGL(size)) - (((x10_long)1ll))));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::Queue* x27966 = this;
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int y27967 = ((x10_int) ((u) - (l)));
        
        //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x27966)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27966)->
                                                                 FMGL(count)) + (((x10_long) (y27967)))));
    }
    
}

//#line 59 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::grow() {
    
    //#line 60 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_long capacity = ((x10_long) ((this->FMGL(size)) * (((x10_long)2ll))));
    
    //#line 61 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<myuts::SHA1Rand >* h = x10::lang::Rail<myuts::SHA1Rand >::_make(capacity);
    
    //#line 62 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<myuts::SHA1Rand >(this->
                                                     FMGL(hash),
                                                   ((x10_long)0ll),
                                                   h, ((x10_long)0ll),
                                                   this->
                                                     FMGL(size));
    
    //#line 63 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = h;
    
    //#line 64 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* l = x10::lang::Rail<x10_int >::_make(capacity);
    
    //#line 65 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(lower),
                                           ((x10_long)0ll),
                                           l, ((x10_long)0ll),
                                           this->FMGL(size));
    
    //#line 66 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = l;
    
    //#line 67 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* u = x10::lang::Rail<x10_int >::_make(capacity);
    
    //#line 68 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
    x10::lang::Rail<void >::copy<x10_int >(this->FMGL(upper),
                                           ((x10_long)0ll),
                                           u, ((x10_long)0ll),
                                           this->FMGL(size));
    
    //#line 69 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = u;
}

//#line 72 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
x10::lang::String* myuts::Queue::sub(x10::lang::String* str,
                                     x10_int start, x10_int end) {
    
    //#line 72 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10Return_c
    return (str)->substring(start, (__extension__ ({
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int a27903 = end;
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int b27904 = (str)->length();
        ((a27903) < (b27904)) ? (a27903) : (b27904);
    }))
    );
    
}

//#line 74 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::main(x10::lang::Rail<x10::lang::String* >* id__4009) {
    
    //#line 75 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* queue =  (new (x10aux::alloc_z<myuts::Queue>()) myuts::Queue())
    ;
    
    //#line 75 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
    (queue)->::myuts::Queue::_constructor(((x10_int)4));
    
    //#line 76 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_long time = x10::lang::RuntimeNatives::nanoTime();
    
    //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::SHA1Rand h27970 = (__extension__ ({
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand alloc27971 =  myuts::SHA1Rand::_alloc();
        
        //#line 26 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
        (alloc27971)->::myuts::SHA1Rand::_constructor(((x10_int)19),
                                                      ((x10_int)13));
        alloc27971;
    }))
    ;
    
    //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    x10_int u27968 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27970->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (queue->
                                                                                                                                                                                                              FMGL(den)))));
    
    //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
    if (((u27968) > (((x10_int)0)))) {
        
        //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((queue->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(queue->
                                                                    FMGL(hash))->FMGL(size)))))
        {
            
            //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
            queue->myuts::Queue::grow();
        }
        
        //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
          queue->FMGL(size), h27970);
        
        //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
          queue->FMGL(size), ((x10_int)0));
        
        //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((__extension__ ({
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
              myuts::Queue* x27969 = queue;
              
              //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
              ;
              x10aux::nullCheck(x27969)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27969)->
                                                                      FMGL(size)) + (((x10_long)1ll))));
          }))
          ) - (((x10_long)1ll)))), u27968);
    }
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
    myuts::Queue* x27972 = queue;
    
    //#line 27 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x27972)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27972)->
                                                             FMGL(count)) + (((x10_long)1ll))));
    
    //#line 78 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10While_c
    while (((queue->FMGL(size)) > (((x10_long)0ll)))) {
        
        //#line 41 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_long top27981 = ((x10_long) ((queue->FMGL(size)) - (((x10_long)1ll))));
        
        //#line 42 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::SHA1Rand h27982 = x10aux::nullCheck(queue->
                                                     FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__apply(
                                   top27981);
        
        //#line 43 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int d27983 = h27982->FMGL(depth);
        
        //#line 44 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int l27984 = x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__apply(
                           top27981);
        
        //#line 45 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        x10_int u27985 = ((x10_int) ((x10aux::nullCheck(queue->
                                                          FMGL(upper))->x10::lang::Rail<x10_int >::__apply(
                                        top27981)) - (((x10_int)1))));
        
        //#line 47 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
        if (((d27983) > (((x10_int)1)))) {
            
            //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
            if ((x10aux::struct_equals(u27985, l27984))) {
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                myuts::Queue* x27973 = queue;
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x27973)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27973)->
                                                                        FMGL(size)) - (((x10_long)1ll))));
            } else {
                
                //#line 48 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
                  top27981, u27985);
            }
            
            //#line 30 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::SHA1Rand h27976 = (__extension__ ({
                
                //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                myuts::SHA1Rand alloc27977 =  myuts::SHA1Rand::_alloc();
                
                //#line 49 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10ConstructorCall_c
                (alloc27977)->::myuts::SHA1Rand::_constructor(
                  h27982, u27985, ((x10_int) ((d27983) - (((x10_int)1)))));
                alloc27977;
            }))
            ;
            
            //#line 31 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            x10_int u27974 = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::floor(((x10::lang::MathNatives::log(((1.0) - (((((x10_double) (h27976->myuts::SHA1Rand::__apply()))) / (2.147483648E9)))))) / (queue->
                                                                                                                                                                                                                      FMGL(den)))));
            
            //#line 32 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
            if (((u27974) > (((x10_int)0)))) {
                
                //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10If_c
                if (((queue->FMGL(size)) >= ((x10_long)(x10aux::nullCheck(queue->
                                                                            FMGL(hash))->FMGL(size)))))
                {
                    
                    //#line 33 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                    queue->myuts::Queue::grow();
                }
                
                //#line 34 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(hash))->x10::lang::Rail<myuts::SHA1Rand >::__set(
                  queue->FMGL(size), h27976);
                
                //#line 35 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(lower))->x10::lang::Rail<x10_int >::__set(
                  queue->FMGL(size), ((x10_int)0));
                
                //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(queue->FMGL(upper))->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (((__extension__ ({
                      
                      //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
                      myuts::Queue* x27975 = queue;
                      
                      //#line 36 "/home/weiz/outgoing/wglb/myuts/Queue.x10": polyglot.ast.Empty_c
                      ;
                      x10aux::nullCheck(x27975)->FMGL(size) =
                        ((x10_long) ((x10aux::nullCheck(x27975)->
                                        FMGL(size)) + (((x10_long)1ll))));
                  }))
                  ) - (((x10_long)1ll)))), u27974);
            }
            
        } else {
            
            //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::Queue* x27978 = queue;
            
            //#line 51 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27978)->FMGL(size) = ((x10_long) ((x10aux::nullCheck(x27978)->
                                                                    FMGL(size)) - (((x10_long)1ll))));
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            myuts::Queue* x27979 = queue;
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
            x10_int y27980 = ((x10_int) ((u27985) - (l27984)));
            
            //#line 52 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x27979)->FMGL(count) = ((x10_long) ((x10aux::nullCheck(x27979)->
                                                                     FMGL(count)) + (((x10_long) (y27980)))));
        }
        
        //#line 80 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10LocalDecl_c
        myuts::Queue* x27986 = queue;
        
        //#line 80 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
        x27986->FMGL(count) = ((x10_long) ((x27986->FMGL(count)) + (((x10_long)1ll))));
    }
    
    //#line 82 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10LocalAssign_c
    time = ((x10_long) ((x10::lang::RuntimeNatives::nanoTime()) - (time)));
    
    //#line 83 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Performance = "), queue->
                                                                                                                                                                                                                                               FMGL(count)), x10aux::makeStringLit("/")), myuts::Queue::sub(
                                                                                                                                                                                                                                                                                            x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (time))) / (1.0E9))),
                                                                                                                                                                                                                                                                                            ((x10_int)0),
                                                                                                                                                                                                                                                                                            ((x10_int)6))), x10aux::makeStringLit(" = ")), myuts::Queue::sub(
                                                                                                                                                                                                                                                                                                                                             x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (queue->
                                                                                                                                                                                                                                                                                                                                                                                                                     FMGL(count)))) / (((((x10_double) (time))) / (1000.0))))),
                                                                                                                                                                                                                                                                                                                                             ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                             ((x10_int)6))), x10aux::makeStringLit("M nodes/s"))));
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
myuts::Queue* myuts::Queue::myuts__Queue____this__myuts__Queue(
  ) {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": x10.ast.X10MethodDecl_c
void myuts::Queue::__fieldInitializers_myuts_Queue() {
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(hash) = (x10aux::class_cast_unchecked<x10::lang::Rail<myuts::SHA1Rand >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lower) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(upper) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(size) = ((x10_long)0ll);
    
    //#line 4 "/home/weiz/outgoing/wglb/myuts/Queue.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(count) = ((x10_long)0ll);
}
const x10aux::serialization_id_t myuts::Queue::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(myuts::Queue::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void myuts::Queue::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(hash));
    buf.write(this->FMGL(lower));
    buf.write(this->FMGL(upper));
    buf.write(this->FMGL(size));
    buf.write(this->FMGL(den));
    buf.write(this->FMGL(count));
    
}

x10::lang::Reference* myuts::Queue::_deserializer(x10aux::deserialization_buffer& buf) {
    myuts::Queue* this_ = new (x10aux::alloc_z<myuts::Queue>()) myuts::Queue();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void myuts::Queue::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(hash) = buf.read<x10::lang::Rail<myuts::SHA1Rand >*>();
    FMGL(lower) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(upper) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(size) = buf.read<x10_long>();
    FMGL(den) = buf.read<x10_double>();
    FMGL(count) = buf.read<x10_long>();
}

x10aux::RuntimeType myuts::Queue::rtt;
void myuts::Queue::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("myuts.Queue",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Queue */
/*************************************************/
