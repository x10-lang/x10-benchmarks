/*************************************************/
/* START of Logger */
#include <core/Logger.h>

#include <x10/lang/Long.h>
#include <x10/lang/Boolean.h>
#include <x10/util/Team.h>
#include <x10/util/Timer.h>
#include <x10/lang/Rail.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/String.h>
#include <x10/lang/Double.h>
#include <x10/lang/Int.h>
#include <x10/lang/Runtime.h>

//#line 3 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 4 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 6 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 9 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 10 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 13 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 14 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 15 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 16 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 18 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 19 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 20 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 21 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 22 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10FieldDecl_c

//#line 24 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10ConstructorDecl_c
void core::Logger::_constructor(x10_boolean b) {
    
    //#line 24 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.AssignPropertyCall_c
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
    this->core::Logger::__fieldInitializers_core_Logger();
    
    //#line 25 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10If_c
    if (b) {
        
        //#line 25 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
        x10::util::Team::FMGL(WORLD__get)()->x10::util::Team::barrier();
    }
    
    //#line 26 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(timeReference) = x10::lang::RuntimeNatives::nanoTime();
}
core::Logger* core::Logger::_make(x10_boolean b) {
    core::Logger* this_ = new (x10aux::alloc_z<core::Logger>()) core::Logger();
    this_->_constructor(b);
    return this_;
}



//#line 30 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::startLive() {
    
    //#line 31 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long time = x10::lang::RuntimeNatives::nanoTime();
    
    //#line 32 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(this->FMGL(startTime), ((x10_long)0ll)))) {
        
        //#line 32 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
        this->FMGL(startTime) = time;
    }
    
    //#line 33 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10If_c
    if (((this->FMGL(lastStartStopLiveTimeStamp)) >= (((x10_long)0ll)))) {
        
        //#line 34 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
        core::Logger* x26295 = this;
        
        //#line 34 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
        x10_long y26296 = ((x10_long) ((time) - (this->FMGL(lastStartStopLiveTimeStamp))));
        
        //#line 34 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x26295)->FMGL(timeDead) = ((x10_long) ((x10aux::nullCheck(x26295)->
                                                                    FMGL(timeDead)) + (y26296)));
    }
    
    //#line 36 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lastStartStopLiveTimeStamp) = time;
}

//#line 39 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::stopLive() {
    
    //#line 40 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long time = x10::lang::RuntimeNatives::nanoTime();
    
    //#line 41 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26297 = this;
    
    //#line 41 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26298 = ((x10_long) ((time) - (this->FMGL(lastStartStopLiveTimeStamp))));
    
    //#line 41 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26297)->FMGL(timeAlive) = ((x10_long) ((x10aux::nullCheck(x26297)->
                                                                 FMGL(timeAlive)) + (y26298)));
    
    //#line 42 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lastStartStopLiveTimeStamp) = time;
}

//#line 45 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::collect(x10::lang::Rail<core::Logger* >* logs) {
    
    //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<core::Logger* >* rail26299 = logs;
    
    //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long size26300 = (x10_long)(x10aux::nullCheck(rail26299)->FMGL(size));
    
    //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": polyglot.ast.For_c
    {
        x10_long idx26301;
        for (
             //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
             idx26301 = ((x10_long)0ll); ((idx26301) < (size26300));
             
             //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10LocalAssign_c
             idx26301 = ((x10_long) ((idx26301) + (((x10_long)1ll)))))
        {
            
            //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
            core::Logger* l26302 = x10aux::nullCheck(rail26299)->x10::lang::Rail<core::Logger* >::__apply(
                                     idx26301);
            
            //#line 46 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
            this->add(l26302);
        }
    }
    
}

//#line 49 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::stats(x10_long time) {
    
    //#line 50 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(this->
                                                                                                                                                                            FMGL(nodesGiven), x10aux::makeStringLit(" nodes stolen = ")), this->
                                                                                                                                                                                                                                            FMGL(nodesReceived)), x10aux::makeStringLit(" (direct) + ")), this->
                                                                                                                                                                                                                                                                                                            FMGL(lifelineNodesReceived)), x10aux::makeStringLit(" (lifeline)."))));
    
    //#line 52 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(this->
                                                                    FMGL(stealsPerpetrated), x10aux::makeStringLit(" successful direct steals."))));
    
    //#line 53 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(this->
                                                                    FMGL(lifelineStealsPerpetrated), x10aux::makeStringLit(" successful lifeline steals."))));
    
    //#line 54 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
    x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
      reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Performance: "), this->
                                                                                                                                                                                                                                              FMGL(nodesCount)), x10aux::makeStringLit("/")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (time))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                ((x10_int)0),
                                                                                                                                                                                                                                                                                                ((x10_int)6))), x10aux::makeStringLit(" = ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                 x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (this->
                                                                                                                                                                                                                                                                                                                                                                                                                         FMGL(nodesCount)))) / (((((x10_double) (time))) / (1000.0))))),
                                                                                                                                                                                                                                                                                                                                                 ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                 ((x10_int)6))), x10aux::makeStringLit("M nodes/s"))));
}

//#line 58 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
x10::lang::String* core::Logger::sub(x10::lang::String* str,
                                     x10_int start, x10_int end) {
    
    //#line 58 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10Return_c
    return (str)->substring(start, (__extension__ ({
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int a26281 = end;
        
        //#line 358 "/home/weiz/X10/x10_src/x10-trunk/x10.dist/stdlib/x10.jar:x10/lang/Math.x10": x10.ast.X10LocalDecl_c
        x10_int b26282 = (str)->length();
        ((a26281) < (b26282)) ? (a26281) : (b26282);
    }))
    );
    
}

//#line 60 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::add(core::Logger* other) {
    
    //#line 61 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26303 = this;
    
    //#line 61 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26304 = x10aux::nullCheck(other)->FMGL(nodesCount);
    
    //#line 61 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26303)->FMGL(nodesCount) = ((x10_long) ((x10aux::nullCheck(x26303)->
                                                                  FMGL(nodesCount)) + (y26304)));
    
    //#line 62 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26305 = this;
    
    //#line 62 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26306 = x10aux::nullCheck(other)->FMGL(nodesGiven);
    
    //#line 62 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26305)->FMGL(nodesGiven) = ((x10_long) ((x10aux::nullCheck(x26305)->
                                                                  FMGL(nodesGiven)) + (y26306)));
    
    //#line 63 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26307 = this;
    
    //#line 63 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26308 = x10aux::nullCheck(other)->FMGL(nodesReceived);
    
    //#line 63 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26307)->FMGL(nodesReceived) = ((x10_long) ((x10aux::nullCheck(x26307)->
                                                                     FMGL(nodesReceived)) + (y26308)));
    
    //#line 64 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26309 = this;
    
    //#line 64 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26310 = x10aux::nullCheck(other)->FMGL(stealsPerpetrated);
    
    //#line 64 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26309)->FMGL(stealsPerpetrated) = ((x10_long) ((x10aux::nullCheck(x26309)->
                                                                         FMGL(stealsPerpetrated)) + (y26310)));
    
    //#line 65 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26311 = this;
    
    //#line 65 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26312 = x10aux::nullCheck(other)->FMGL(lifelineNodesReceived);
    
    //#line 65 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26311)->FMGL(lifelineNodesReceived) =
      ((x10_long) ((x10aux::nullCheck(x26311)->FMGL(lifelineNodesReceived)) + (y26312)));
    
    //#line 66 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    core::Logger* x26313 = this;
    
    //#line 66 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10LocalDecl_c
    x10_long y26314 = x10aux::nullCheck(other)->FMGL(lifelineStealsPerpetrated);
    
    //#line 66 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(x26313)->FMGL(lifelineStealsPerpetrated) =
      ((x10_long) ((x10aux::nullCheck(x26313)->FMGL(lifelineStealsPerpetrated)) + (y26314)));
}

//#line 69 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
core::Logger* core::Logger::get(x10_boolean verbose) {
    
    //#line 70 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10If_c
    if (verbose) {
        
        //#line 71 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
          reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit(""), ((x10_long)x10aux::here)), x10aux::makeStringLit(" -> ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            FMGL(timeAlive)))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ((x10_int)6))), x10aux::makeStringLit(" : ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             FMGL(timeDead)))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ((x10_int)6))), x10aux::makeStringLit(" : ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (((x10_long) ((this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            FMGL(timeAlive)) + (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  FMGL(timeDead))))))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ((x10_int)6))), x10aux::makeStringLit(" : ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       x10::lang::String::__plus(x10aux::makeStringLit(""), ((((100.0) * (((x10_double) (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           FMGL(timeAlive)))))) / (((x10_double) (((x10_long) ((this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  FMGL(timeAlive)) + (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        FMGL(timeDead))))))))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ((x10_int)6))), x10aux::makeStringLit("%")), x10aux::makeStringLit(" :: ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (((x10_long) ((this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            FMGL(startTime)) - (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  FMGL(timeReference))))))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ((x10_int)6))), x10aux::makeStringLit(" : ")), core::Logger::sub(
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       x10::lang::String::__plus(x10aux::makeStringLit(""), ((((x10_double) (((x10_long) ((this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             FMGL(lastStartStopLiveTimeStamp)) - (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    FMGL(timeReference))))))) / (1.0E9))),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ((x10_int)0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ((x10_int)6))), x10aux::makeStringLit(" :: ")), this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         FMGL(stealsReceived)), x10aux::makeStringLit(" : ")), this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 FMGL(lifelineStealsReceived)), x10aux::makeStringLit(" : ")), this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 FMGL(stealsAttempted)), x10aux::makeStringLit(" : ")), this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          FMGL(lifelineStealsAttempted)), x10aux::makeStringLit(" : ")), ((x10_long) ((this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         FMGL(lifelineStealsAttempted)) - (this->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             FMGL(lifelineStealsPerpetrated)))))));
    }
    
    //#line 84 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
core::Logger* core::Logger::core__Logger____this__core__Logger(
  ) {
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": x10.ast.X10MethodDecl_c
void core::Logger::__fieldInitializers_core_Logger() {
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nodesCount) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nodesGiven) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(stealsAttempted) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(stealsPerpetrated) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(stealsReceived) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(stealsSuffered) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nodesReceived) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineStealsAttempted) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineStealsPerpetrated) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineStealsReceived) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineStealsSuffered) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lifelineNodesReceived) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(lastStartStopLiveTimeStamp) = ((x10_long)-1ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(timeAlive) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(timeDead) = ((x10_long)0ll);
    
    //#line 2 "/home/weiz/outgoing/wglb/core/Logger.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(startTime) = ((x10_long)0ll);
}
const x10aux::serialization_id_t core::Logger::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(core::Logger::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void core::Logger::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(nodesCount));
    buf.write(this->FMGL(nodesGiven));
    buf.write(this->FMGL(stealsAttempted));
    buf.write(this->FMGL(stealsPerpetrated));
    buf.write(this->FMGL(stealsReceived));
    buf.write(this->FMGL(stealsSuffered));
    buf.write(this->FMGL(nodesReceived));
    buf.write(this->FMGL(lifelineStealsAttempted));
    buf.write(this->FMGL(lifelineStealsPerpetrated));
    buf.write(this->FMGL(lifelineStealsReceived));
    buf.write(this->FMGL(lifelineStealsSuffered));
    buf.write(this->FMGL(lifelineNodesReceived));
    buf.write(this->FMGL(lastStartStopLiveTimeStamp));
    buf.write(this->FMGL(timeAlive));
    buf.write(this->FMGL(timeDead));
    buf.write(this->FMGL(startTime));
    buf.write(this->FMGL(timeReference));
    
}

x10::lang::Reference* core::Logger::_deserializer(x10aux::deserialization_buffer& buf) {
    core::Logger* this_ = new (x10aux::alloc_z<core::Logger>()) core::Logger();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void core::Logger::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(nodesCount) = buf.read<x10_long>();
    FMGL(nodesGiven) = buf.read<x10_long>();
    FMGL(stealsAttempted) = buf.read<x10_long>();
    FMGL(stealsPerpetrated) = buf.read<x10_long>();
    FMGL(stealsReceived) = buf.read<x10_long>();
    FMGL(stealsSuffered) = buf.read<x10_long>();
    FMGL(nodesReceived) = buf.read<x10_long>();
    FMGL(lifelineStealsAttempted) = buf.read<x10_long>();
    FMGL(lifelineStealsPerpetrated) = buf.read<x10_long>();
    FMGL(lifelineStealsReceived) = buf.read<x10_long>();
    FMGL(lifelineStealsSuffered) = buf.read<x10_long>();
    FMGL(lifelineNodesReceived) = buf.read<x10_long>();
    FMGL(lastStartStopLiveTimeStamp) = buf.read<x10_long>();
    FMGL(timeAlive) = buf.read<x10_long>();
    FMGL(timeDead) = buf.read<x10_long>();
    FMGL(startTime) = buf.read<x10_long>();
    FMGL(timeReference) = buf.read<x10_long>();
}

x10aux::RuntimeType core::Logger::rtt;
void core::Logger::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("core.Logger",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Logger */
/*************************************************/
