# A top-level Makefile to compile all X10 sources

# <BEGIN> user settings #

export X10CXX 		?= ~/Projects/x10/x10-2.0.6/x10.dist/bin/x10c++

#leave blank by default, X10 automatically chooses a transport for you. To
#force a particular implementation, please uncheck one of the other options.
#export X10RTTRANSPORT	?= 
export X10RTTRANSPORT	?= -x10rt mpi
#export X10RTTRANSPORT ?= -x10rt standalone
#export X10RTTRANSPORT ?= -x10rt pgas_lapi
#export X10RTTRANSPORT ?= -x10rt pgas_bgp
#export X10RTTRANSPORT ?= -x10rt pgas_sockets

export X10CXXFLAGS 	?= -report postcompile=5 -VERBOSE_CALLS

# <END> user settings #

ifeq ($(shell uname -s),AIX)
   include arch/aix.mk
endif
ifeq ($(shell uname -s),Linux)
   include arch/linux.mk
endif
ifeq ($(shell uname -s),Darwin)
   include arch/darwin.mk
endif
ifeq ($(firstword $(subst _, ,$(shell uname -s))),CYGWIN)
   include arch/cygwin.mk
endif
ifeq ($(BGP_CROSS_COMPILE), 1)
   include arch/bgp.mk
endif

X10RUN?=runx10
X10CXXFLAGS=-report \
            postcompile=5 \
            -STATIC_CALLS \
            $(X10RT_TRANSPORT) \
            -MAIN_CLASS=Brandes \
            -v \
            -NO_CHECKS \
            -O  

X10_CLASSES=Brandes.x10 
X10_CLASSES_CC=$(X10_CLASSES:.x10=.cc)
X10_CLASSES_H=$(X10_CLASSES:.x10=.h)

TARGET=brandes

all: ${TARGET}

brandes: Brandes.x10 \
         PriorityQueue.x10 \
         PriorityQueue.cc \
         PriorityQueue.h \
         PriorityQueue.struct_h
	touch PriorityQueue.inc
	${X10CXX} ${X10CXXFLAGS} $< -o $@ 
	rm -f PriorityQueue.inc

run-brandes: brandes
	mpirun -np 4 -hostfile host.list ./brandes

clean:
	rm -rf core*.* *.dSYM *.inc 
	rm -rf ${X10_CLASSES_CC} ${X10_CLASSES_H}
