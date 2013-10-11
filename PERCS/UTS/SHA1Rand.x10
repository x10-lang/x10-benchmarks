import x10.compiler.*;

@NativeCPPInclude("brg_types.h")
@NativeCPPInclude("brg_sha1.h")
@NativeCPPCompilationUnit("brg_sha1.c")
public struct SHA1Rand {
    val w0 = 0n; val w1 = 0n; val w2 = 0n; val w3 = 0n; val w4 = 0n; // 20 bytes
    val depth:Int;

    def this(seed:Int, depth:Int) {
        @Native("c++", "rng_init((RNG_state*)this, seed);") {}
        this.depth = depth;
    }

    def this(parent:SHA1Rand, spawnNumber:Int, depth:Int) {
        @Native("c++", "rng_spawn((RNG_state*)&parent, (RNG_state*)this, spawnNumber);") {}
        this.depth = depth;
    }

    operator this():Int {
        @Native("c++", "return rng_rand((RNG_state*)this);") { return 0n; }
    }
}
