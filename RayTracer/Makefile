
COMP_OPTS = -report postcompile=5

OPTX10CPP  = time $(HOME)/x10-opt/x10.dist/bin/x10c++ -STATIC_CHECKS -O -NO_CHECKS $(COMP_OPTS)
DBGX10CPP  = time $(HOME)/x10-dbg/x10.dist/bin/x10c++ -STATIC_CHECKS -DEBUG $(COMP_OPTS)


RAYTRACER_SRC = \
        raytracer/GLFrontend.x10 \
        raytracer/RayTracer.x10 \
        raytracer/Benchmark.x10 \
        raytracer/Vector3.x10 \
        raytracer/Quat.x10 \
        raytracer/RGB.x10

Benchmark.opt: $(RAYTRACER_SRC)
	$(OPTX10CPP) -d out-opt raytracer/Benchmark.x10 -o $@

Benchmark.dbg: $(RAYTRACER_SRC)
	$(DBGX10CPP) -d out-dbg raytracer/Benchmark.x10 -o $@

GLFrontend.opt: $(RAYTRACER_SRC)
	$(OPTX10CPP) -d out-opt raytracer/GLFrontend.x10 -x10lib ~/x10-opt/x10.gl/x10_gl.properties -o $@

GLFrontend.dbg: $(RAYTRACER_SRC)
	$(DBGX10CPP) -d out-dbg raytracer/GLFrontend.x10 -x10lib ~/x10-dbg/x10.gl/x10_gl.properties -o $@

clean:
	rm -rfv Benchmark.opt Benchmark.dbg GLFrontend.opt GLFrontend.dbg out-opt out-dbg

# vim: tabstop=8:shiftwidth=8:noexpandtab
