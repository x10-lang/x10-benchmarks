
X10CPP ?= x10c++
X10GL ?= $(X10_DIST)/../x10.gl

X10CPPFLG = -STATIC_CHECKS -DEBUG
#X10CPPDBG = -O -NO_CHECKS

X10CPPCOMP = time $(X10CPP) $(X10CPPFLG) $(X10CPPDBG) -report postcompile=5


ALL_TARGETS = GLFrontend Benchmark QuatTest Texture2DTest Vector3Test


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
        raytracer/SceneLoader.x10 \
        raytracer/SimpleBVH.x10 \
        raytracer/Texture2D.x10 \
        raytracer/Vector2.x10 \
        raytracer/Vector3.x10 \


all: $(ALL_TARGETS)


GLFrontend: $(RAYTRACER_SRC) raytracer/GLFrontend.x10
	$(X10CPPCOMP) -d out raytracer/GLFrontend.x10 -x10lib $(X10GL)/x10_gl.properties -o $@

Benchmark: $(RAYTRACER_SRC) raytracer/Benchmark.x10
	$(X10CPPCOMP) -d out raytracer/Benchmark.x10 -o $@

QuatTest: raytracer/QuatTest.x10 raytracer/Quat.x10
	$(X10CPPCOMP) -d out raytracer/QuatTest.x10 -o $@

Texture2DTest: raytracer/Texture2DTest.x10 raytracer/Texture2D.x10
	$(X10CPPCOMP) -d out raytracer/Texture2DTest.x10 -o $@

Vector3Test: raytracer/Vector3Test.x10 raytracer/Vector3.x10
	$(X10CPPCOMP) -d out raytracer/Vector3Test.x10 -o $@

clean:
	rm -rfv $(ALL_TARGETS) out *.cubin *.dSYM

# vim: tabstop=8:shiftwidth=8:noexpandtab
