
COMP_OPTS = -report postcompile=5

OPTX10CPP  = time $(HOME)/x10-opt/x10.dist/bin/x10c++ -STATIC_CHECKS -O -NO_CHECKS $(COMP_OPTS)
DBGX10CPP  = time $(HOME)/x10-dbg/x10.dist/bin/x10c++ -STATIC_CHECKS -DEBUG $(COMP_OPTS)


RAYTRACER_SRC = \
        raytracer/AABB.x10 \
        raytracer/Benchmark.x10 \
        raytracer/Octree.x10 \
        raytracer/primitives/DoubleTriangle.x10 \
        raytracer/primitives/SpeckledSphere.x10 \
        raytracer/primitives/Sphere.x10 \
        raytracer/primitives/Triangle.x10 \
        raytracer/primitives/UVTriangle.x10 \
        raytracer/Primitive.x10 \
        raytracer/Quat.x10 \
        raytracer/RayTracer.x10 \
        raytracer/RayState.x10 \
        raytracer/RGB.x10 \
        raytracer/Texture2D.x10 \
        raytracer/Vector3.x10 \


GLFrontend.opt: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(OPTX10CPP) -d out-opt raytracer/GLFrontend.x10 -x10lib ~/x10-opt/x10.gl/x10_gl.properties -o $@

GLFrontend.dbg: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(DBGX10CPP) -d out-dbg raytracer/GLFrontend.x10 -x10lib ~/x10-dbg/x10.gl/x10_gl.properties -o $@

Benchmark.opt: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(OPTX10CPP) -d out-opt raytracer/Benchmark.x10 -o $@
Benchmark.dbg: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(DBGX10CPP) -d out-dbg raytracer/Benchmark.x10 -o $@

QuatTest.opt: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(OPTX10CPP) -d out-opt raytracer/QuatTest.x10 -o $@
QuatTest.dbg: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(DBGX10CPP) -d out-dbg raytracer/QuatTest.x10 -o $@

Vector3Test.opt: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(OPTX10CPP) -d out-opt raytracer/Vector3Test.x10 -o $@
Vector3Test.dbg: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(DBGX10CPP) -d out-dbg raytracer/Vector3Test.x10 -o $@

OctreeTest.opt: raytracer/OctreeTest.x10 raytracer/Octree.x10
	$(OPTX10CPP) -d out-opt raytracer/OctreeTest.x10 -o $@
OctreeTest.dbg: raytracer/OctreeTest.x10 raytracer/Octree.x10
	$(DBGX10CPP) -d out-dbg raytracer/OctreeTest.x10 -o $@

Texture2DTest.opt: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(OPTX10CPP) -d out-opt raytracer/Texture2DTest.x10 -o $@
Texture2DTest.dbg: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(DBGX10CPP) -d out-dbg raytracer/Texture2DTest.x10 -o $@


clean:
	rm -rfv "{Benchmark,GLFrontend,QuatTest,OctreeTest,Vector3Test}.{opt,dbg}" out-opt out-dbg xxx_main_xxx.cc

# vim: tabstop=8:shiftwidth=8:noexpandtab
