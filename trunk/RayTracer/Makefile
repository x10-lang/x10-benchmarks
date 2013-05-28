
COMP_OPTS = -report postcompile=5

OPTNOGCX10CPP  = time $(HOME)/x10-opt-nogc/x10.dist/bin/x10c++ -STATIC_CHECKS -DEBUG -O -NO_CHECKS $(COMP_OPTS)
OPTX10CPP  = time $(HOME)/x10-opt/x10.dist/bin/x10c++ -STATIC_CHECKS -DEBUG -O -NO_CHECKS $(COMP_OPTS)
DBGX10CPP  = time $(HOME)/x10-dbg/x10.dist/bin/x10c++ -STATIC_CHECKS -DEBUG $(COMP_OPTS)

ALL_TARGETS = Benchmark.opt Benchmark.dbg GLFrontend.opt GLFrontend.dbg QuatTest.opt QuatTest.dbg Texture2DTest.opt Texture2DTest.dbg Vector3Test.opt Vector3Test.dbg

RAYTRACER_SRC = \
        raytracer/AABB.x10 \
        raytracer/Benchmark.x10 \
        raytracer/Engine.x10 \
        raytracer/LooseOctree.x10 \
        raytracer/materials/DebugMaterial.x10 \
        raytracer/materials/SolidColour.x10 \
        raytracer/materials/Textured.x10 \
        raytracer/materials/Reflective.x10 \
        raytracer/materials/RefractingWater.x10 \
        raytracer/MeshVertex.x10 \
        raytracer/Octree.x10 \
        raytracer/primitives/CUDARectangle.x10 \
        raytracer/primitives/MeshTriangle.x10 \
        raytracer/primitives/Rectangle.x10 \
        raytracer/primitives/SpeckledSphere.x10 \
        raytracer/primitives/Sphere.x10 \
        raytracer/primitives/WaveyRectangle.x10 \
        raytracer/Primitive.x10 \
        raytracer/Quat.x10 \
        raytracer/RayState.x10 \
        raytracer/RGB.x10 \
        raytracer/SimpleBVH.x10 \
        raytracer/SceneLoader.x10 \
        raytracer/Texture2D.x10 \
        raytracer/Vector2.x10 \
        raytracer/Vector3.x10 \


GLFrontend.opt: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(OPTX10CPP) -d out-opt raytracer/GLFrontend.x10 -x10lib ~/x10-opt/x10.gl/x10_gl.properties -o $@
GLFrontend.optnogc: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/GLFrontend.x10 -x10lib ~/x10-opt-nogc/x10.gl/x10_gl.properties -o $@
GLFrontend.dbg: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(DBGX10CPP) -d out-dbg raytracer/GLFrontend.x10 -x10lib ~/x10-dbg/x10.gl/x10_gl.properties -o $@

Benchmark.opt: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(OPTX10CPP) -d out-opt raytracer/Benchmark.x10 -o $@
Benchmark.optnogc: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/Benchmark.x10 -o $@
Benchmark.dbg: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(DBGX10CPP) -d out-dbg raytracer/Benchmark.x10 -o $@

QuatTest.opt: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(OPTX10CPP) -d out-opt raytracer/QuatTest.x10 -o $@
QuatTest.optnogc: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/QuatTest.x10 -o $@
QuatTest.dbg: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(DBGX10CPP) -d out-dbg raytracer/QuatTest.x10 -o $@

Vector3Test.opt: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(OPTX10CPP) -d out-opt raytracer/Vector3Test.x10 -o $@
Vector3Test.optnogc: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/Vector3Test.x10 -o $@
Vector3Test.dbg: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(DBGX10CPP) -d out-dbg raytracer/Vector3Test.x10 -o $@

OctreeTest.opt: raytracer/OctreeTest.x10 raytracer/Octree.x10
	$(OPTX10CPP) -d out-opt raytracer/OctreeTest.x10 -o $@
OctreeTest.optnogc: raytracer/OctreeTest.x10 raytracer/Octree.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/OctreeTest.x10 -o $@
OctreeTest.dbg: raytracer/OctreeTest.x10 raytracer/Octree.x10
	$(DBGX10CPP) -d out-dbg raytracer/OctreeTest.x10 -o $@

Texture2DTest.opt: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(OPTX10CPP) -d out-opt raytracer/Texture2DTest.x10 -o $@
Texture2DTest.optnogc: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(OPTNOGCX10CPP) -d out-opt raytracer/Texture2DTest.x10 -o $@
Texture2DTest.dbg: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(DBGX10CPP) -d out-dbg raytracer/Texture2DTest.x10 -o $@


all: $(ALL_TARGETS)

clean:
	rm -rfv $(ALL_TARGETS) out-opt out-dbg xxx_main_xxx.cc

# vim: tabstop=8:shiftwidth=8:noexpandtab
