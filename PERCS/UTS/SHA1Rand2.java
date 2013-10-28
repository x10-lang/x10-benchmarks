import java.io.IOException;
import java.security.MessageDigest;

import x10.serialization.X10JavaDeserializer;
import x10.serialization.X10JavaSerializable;
import x10.serialization.X10JavaSerializer;
import x10.rtt.NamedStructType;
import x10.rtt.RuntimeType;
import x10.rtt.Type;
import x10.rtt.Types;


@x10.runtime.impl.java.X10Generated
public final class SHA1Rand2 extends x10.core.Struct implements X10JavaSerializable {
    public static final RuntimeType<SHA1Rand2> $RTT = NamedStructType.<SHA1Rand2> make("SHA1Rand", SHA1Rand2.class, new Type[] { Types.STRUCT });
    public RuntimeType<?> $getRTT() { return $RTT; }
    public Type<?> $getParam(int i) { return null; }

    public MessageDigest md;
    public int depth;
    private static final boolean updateAsBatch = true;
    public final byte[] bytes = updateAsBatch ? new byte[4] : null; // work buffer

    public static X10JavaSerializable $_deserialize_body(SHA1Rand2 $_obj, X10JavaDeserializer $deserializer) throws IOException {
        $_obj.md = (MessageDigest) $deserializer.readRefUsingReflection();
        $_obj.depth = $deserializer.readInt();
        return $_obj;
    }
    public static X10JavaSerializable $_deserializer(X10JavaDeserializer $deserializer) throws IOException {
        SHA1Rand2 $_obj = new SHA1Rand2((System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
    }

    public void $_serialize(X10JavaSerializer $serializer) throws IOException {
        $serializer.writeObjectUsingReflection(this.md);
        $serializer.write(this.depth);
    }

    
    // zero value constructor
    public SHA1Rand2(System $dummy) {
        //this.md = null;
        //this.depth = 0;
    }

    // constructor just for allocation
    public SHA1Rand2(System[] $dummy) {
    }
    

    // creation method for java code (1-phase java constructor)
    public SHA1Rand2(int seed, int depth) {
        this((System[]) null);
        SHA1Rand$$init$S(seed,depth);
    }
    // constructor for non-virtual call
    public SHA1Rand2 SHA1Rand$$init$S(int seed, int depth) {
        RNG2.init(this, seed);
        this.depth = depth;
        return this;
    }
        
    // creation method for java code (1-phase java constructor)
    public SHA1Rand2(SHA1Rand2 parent, int spawnNumber, int depth) {
        this((System[]) null);
        SHA1Rand$$init$S(parent,spawnNumber,depth);
    }
    // constructor for non-virtual call
    public SHA1Rand2 SHA1Rand$$init$S(SHA1Rand2 parent, int spawnNumber, int depth) {
        RNG2.spawn(parent, this, spawnNumber);
        this.depth = depth;
        return this;
    }
        
        
    public int $apply$O() { return RNG2.rand(this); }
        
    public String typeName() { return "SHA1Rand"; }
    public String toString() { return "struct SHA1Rand:" + " md=" + md + " depth=" + depth; }
    public int hashCode() {
        int result = 1;

        {
            int a = 8191 * result;
            //int b = Types.hashCode(this.md);
            int b = this.md != null ? this.md.hashCode() : 0;
            result = a + b;
        }

        {
            int a = 8191 * result;
            //int b = Types.hashCode(this.depth);
            int b = this.depth;
            result = a + b;
        }

        return result;
    }
        
    public boolean equals(Object other) {
        if (!(other instanceof SHA1Rand2)) return false;
        return this.equals$O((SHA1Rand2) other);
    }
    public boolean equals$O(SHA1Rand2 other) {
        if (!this.md.equals(other.md)) return false;
        if (this.depth != other.depth) return false;
        return true;
    }
        
    public boolean _struct_equals$O(Object other) {
        if (!(other instanceof SHA1Rand2)) return false;
        return this.equals$O((SHA1Rand2) other);
    }
    public boolean _struct_equals$O(SHA1Rand2 other) {
        if (!this.md.equals(other.md)) return false;
        if (this.depth != other.depth) return false;
        return true;
    }
        
        
    public SHA1Rand2 SHA1Rand$$this$SHA1Rand() { return SHA1Rand2.this; }
        
    public void __fieldInitializers_SHA1Rand() {
        //this.md = null;
    }
}
