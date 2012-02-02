#include <SHA1RandXX.h>
#include <x10/lang/Any.h>
#include <x10/lang/String.h>


class SHA1RandXX_ibox0 : public x10::lang::IBox<SHA1RandXX> {
public:
    static x10::lang::Any::itable<SHA1RandXX_ibox0 > itable;
    x10_boolean equals(x10aux::ref<x10::lang::Any> arg0) {
        return this->value->equals(arg0);
    }
    x10_int hashCode() {
        return this->value->hashCode();
    }
    x10aux::ref<x10::lang::String> toString() {
        return this->value->toString();
    }
    x10aux::ref<x10::lang::String> typeName() {
        return x10aux::type_name(this->value);
    }
    
};
x10::lang::Any::itable<SHA1RandXX_ibox0 >  SHA1RandXX_ibox0::itable(&SHA1RandXX_ibox0::equals, &SHA1RandXX_ibox0::hashCode, &SHA1RandXX_ibox0::toString, &SHA1RandXX_ibox0::typeName);
x10::lang::Any::itable<SHA1RandXX >  SHA1RandXX::_itable_0(&SHA1RandXX::equals, &SHA1RandXX::hashCode, &SHA1RandXX::toString, &SHA1RandXX::typeName);
x10aux::itable_entry SHA1RandXX::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &SHA1RandXX::_itable_0), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<SHA1RandXX>())};
x10aux::itable_entry SHA1RandXX::_iboxitables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &SHA1RandXX_ibox0::itable), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<SHA1RandXX>())};

x10_boolean SHA1RandXX::_struct_equals(SHA1RandXX that) {
    for (int i=0 ; i<20 ; ++i) {
        if (FMGL(cxx_sha1_rng).rng_state[i] != that.FMGL(cxx_sha1_rng).rng_state[i]) return false;
    }
    if (FMGL(depth) != that.FMGL(depth)) return false;
    if (FMGL(breadth) != that.FMGL(breadth)) return false;

    return true;
}
void SHA1RandXX::_serialize(SHA1RandXX this_, x10aux::serialization_buffer& buf) {
    for (int i=0 ; i<20 ; ++i) {
        buf.write(this_.FMGL(cxx_sha1_rng).rng_state[i]);
    }
    buf.write(this_.FMGL(depth));
    buf.write(this_.FMGL(breadth));
}

void SHA1RandXX::_deserialize_body(x10aux::deserialization_buffer& buf) {
    for (int i=0 ; i<20 ; ++i) {
        FMGL(cxx_sha1_rng).rng_state[i] = buf.read<unsigned char>();
    }
    FMGL(depth) = buf.read<x10_int>();
    FMGL(breadth) = buf.read<x10_int>();
}


x10_boolean SHA1RandXX::equals(x10aux::ref<x10::lang::Any> that) {
    x10aux::ref<x10::lang::Reference> thatAsRef(that);
    if (thatAsRef->_type()->equals(x10aux::getRTT<SHA1RandXX >())) {
        x10aux::ref<x10::lang::IBox<SHA1RandXX > > thatAsIBox(that);
        return _struct_equals(thatAsIBox->value);
    }
    return false;
}

x10_boolean SHA1RandXX::equals(SHA1RandXX that) {
    return _struct_equals(that);
}

x10aux::ref<x10::lang::String> SHA1RandXX::toString() {
    return x10::lang::String::Lit("SHA1RandXX: detailed toString not defined.");
}

x10_int SHA1RandXX::hashCode() {
    unsigned char *tmp = &(FMGL(cxx_sha1_rng).rng_state[0]);
    return *((x10_int*)tmp);
}

x10aux::ref<x10::lang::String> SHA1RandXX::typeName() {
    return x10aux::type_name(*this);
}

x10aux::RuntimeType SHA1RandXX::rtt;
void SHA1RandXX::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[2] = { x10aux::getRTT<x10::lang::Any>(), x10aux::getRTT<x10::lang::Any>()};
    rtt.initStageTwo("SHA1RandXX", x10aux::RuntimeType::struct_kind, 2, parents, 0, NULL, NULL);
    rtt.containsPtrs = false;
}


