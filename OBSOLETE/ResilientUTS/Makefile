THIS_MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
RES_UTS_DIR := $(abspath $(THIS_MAKEFILE_DIR))

export X10_BIN ?= 
export X10C ?= $(X10_BIN)x10c

# X10_COMPILER_OPTS ?= -O -STATIC_CHECKS
X10_COMPILER_OPTS ?= -DEBUG -STATIC_CHECKS


RES_UTS_SRC= \
	uts/Bag.x10 \
	uts/Checkpoint.x10 \
	uts/Stats.x10 \
	uts/UTS.x10 \
	uts/UTSWorker.x10 \

default: bin-managed/res_uts.jar

bin-managed/res_uts.jar bin-managed/res_uts.properties: res_uts_dummy_managed_build

RES_UTS_SRC_ABS= $(addprefix $(RES_UTS_DIR)/src/,$(RES_UTS_SRC))


.SECONDARY: res_uts_dummy_managed_build
res_uts_dummy_managed_build: $(RES_UTS_SRC_ABS)
	@echo "Building Resilient UTS for Managed-X10..."
	@mkdir -p bin-managed
	@($(X10C) -cp . -sourcepath . $(X10_COMPILER_OPTS) $(RES_UTS_SRC_ABS) -o bin-managed/res_uts.jar -d bin-managed/out)
	@$(RM) -rf bin-managed/out

clean:
	rm -rf bin-managed

.PHONY: clean
