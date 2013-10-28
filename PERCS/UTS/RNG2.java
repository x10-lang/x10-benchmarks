/**
 * Pure Java implementation of SHA1 based random number generator for UTS
 * Author: Mikio Takeuchi, IBM Research-Tokyo
 */

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class RNG2 {

    private static void int2bytes(int w, byte[] bytes, int off) {
        int offby4 = off * 4;
        bytes[offby4+0] = (byte)(w >> 24);
        bytes[offby4+1] = (byte)(w >> 16);
        bytes[offby4+2] = (byte)(w >>  8);
        bytes[offby4+3] = (byte)(w >>  0);
    }
    private static int bytes2int(byte[] bytes, int off) {
        int offby4 = off * 4;
        return ((0xff & bytes[offby4+0]) << 24) | ((0xff & bytes[offby4+1]) << 16) | ((0xff & bytes[offby4+2]) << 8) | ((0xff & bytes[offby4+3]) << 0);
    }
    private static MessageDigest sha1_begin() {
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-1");
        } catch (NoSuchAlgorithmException e) {}
        return md;
    }
    private static void sha1_hash(byte[] bytes, MessageDigest md) {
        md.update(bytes);
    }
    private static void sha1_hash(int w, MessageDigest md, byte[] bytes) {
        if (bytes != null) {
            int2bytes(w, bytes, 0);
            md.update(bytes, 0, 4);
        } else {
            md.update((byte)(w >> 24));
            md.update((byte)(w >> 16));
            md.update((byte)(w >>  8));
            md.update((byte)(w >>  0));
        }
    }
    private static void sha1_hash(SHA1Rand2 mystate, MessageDigest md) {
        byte[] digest = mystate.md.digest();
        md.update(digest);
    }
    private static void sha1_end(SHA1Rand2 newstate, MessageDigest md) {
        newstate.md = md;
    }

    /*
    void rng_init(RNG_state *newstate, int seed) {
        struct sha1_context ctx;
        struct state_t gen;
        int i;

        for (i=0; i < 16; i++) 
            gen.state[i] = 0;
        gen.state[16] = 0xFF & (seed >> 24);
        gen.state[17] = 0xFF & (seed >> 16);
        gen.state[18] = 0xFF & (seed >> 8);
        gen.state[19] = 0xFF & (seed >> 0);
  
        sha1_begin(&ctx);
        sha1_hash(gen.state, 20, &ctx);
        sha1_end(newstate, &ctx);
    }
    */
    private static final byte[] zeroes16 = new byte[16];
    public static void init(SHA1Rand2 newstate, int seed) {
        MessageDigest md = sha1_begin();

        sha1_hash(zeroes16, md);
        sha1_hash(seed, md, newstate.bytes);

        sha1_end(newstate, md);
    }

    /*
    void rng_spawn(RNG_state *mystate, RNG_state *newstate, int spawnnumber) {
        struct sha1_context ctx;
        uint_8t  bytes[4];
        
        bytes[0] = 0xFF & (spawnnumber >> 24);
        bytes[1] = 0xFF & (spawnnumber >> 16);
        bytes[2] = 0xFF & (spawnnumber >> 8);
        bytes[3] = 0xFF & spawnnumber;
        
        sha1_begin(&ctx);
        sha1_hash(mystate, 20, &ctx);
        sha1_hash(bytes, 4, &ctx);
        sha1_end(newstate, &ctx);
    }
    */
    public static void spawn(SHA1Rand2 mystate, SHA1Rand2 newstate, int spawnnumber) {
        MessageDigest md = sha1_begin();

        sha1_hash(mystate, md);
        sha1_hash(spawnnumber, md, newstate.bytes);

        sha1_end(newstate, md);
    }

    /*
    int rng_rand(RNG_state *mystate) {
        int r;
        uint_32t b =  (mystate[16] << 24) | (mystate[17] << 16) | (mystate[18] << 8) | (mystate[19] << 0);
        b = b & POS_MASK;
        r = (int) b;
        return r;
    }
    */
    private static final int POS_MASK = 0x7fffffff;
    public static int rand(SHA1Rand2 mystate) {
        byte[] digest = mystate.md.digest();
        int w4 = bytes2int(digest, 4);
        return w4 & POS_MASK;
    }
}
