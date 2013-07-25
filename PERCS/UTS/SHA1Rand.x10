import x10.compiler.*;

@NativeCPPInclude("brg_types.h")
@NativeCPPInclude("brg_sha1.h")
@NativeCPPCompilationUnit("brg_sha1.c")
public struct SHA1Rand {
    val w0 = 0; val w1 = 0; val w2 = 0; val w3 = 0; val w4 = 0; // 20 bytes
    val depth:Int;

    def this(seed:int, depth:Int) {
        @Native("c++", "rng_init((RNG_state*)this, seed);") {}
        this.depth = depth;
    }

    def this(parent:SHA1Rand, spawnNumber:Int, depth:Int) {
        @Native("c++", "rng_spawn((RNG_state*)&parent, (RNG_state*)this, spawnNumber);") {}
        this.depth = depth;
    }

    operator this() {
        @Native("c++", "return rng_rand((RNG_state*)this);") { return 0; }
    }
}
