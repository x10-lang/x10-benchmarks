#include <SHA1RandX.h>
#include <x10/lang/Any.h>
#include <x10/lang/String.h>


class SHA1RandX_ibox0 : public x10::lang::IBox<SHA1RandX> {
public:
    static x10::lang::Any::itable<SHA1RandX_ibox0 > itable;
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
x10::lang::Any::itable<SHA1RandX_ibox0 >  SHA1RandX_ibox0::itable(&SHA1RandX_ibox0::equals, &SHA1RandX_ibox0::hashCode, &SHA1RandX_ibox0::toString, &SHA1RandX_ibox0::typeName);
x10::lang::Any::itable<SHA1RandX >  SHA1RandX::_itable_0(&SHA1RandX::equals, &SHA1RandX::hashCode, &SHA1RandX::toString, &SHA1RandX::typeName);
x10aux::itable_entry SHA1RandX::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &SHA1RandX::_itable_0), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<SHA1RandX>())};
x10aux::itable_entry SHA1RandX::_iboxitables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Any>, &SHA1RandX_ibox0::itable), x10aux::itable_entry(NULL, (void*)x10aux::getRTT<SHA1RandX>())};

x10_boolean SHA1RandX::_struct_equals(SHA1RandX that) {
    for (int i=0 ; i<20 ; ++i) {
        if (FMGL(cxx_sha1_rng).rng_state[i] != that.FMGL(cxx_sha1_rng).rng_state[i]) return false;
    }
    if (FMGL(depth) != that.FMGL(depth)) return false;

    return true;
}
void SHA1RandX::_serialize(SHA1RandX this_, x10aux::serialization_buffer& buf) {
    for (int i=0 ; i<20 ; ++i) {
        buf.write(this_.FMGL(cxx_sha1_rng).rng_state[i]);
    }
    buf.write(this_.FMGL(depth));
}

void SHA1RandX::_deserialize_body(x10aux::deserialization_buffer& buf) {
    for (int i=0 ; i<20 ; ++i) {
        FMGL(cxx_sha1_rng).rng_state[i] = buf.read<unsigned char>();
    }
    FMGL(depth) = buf.read<x10_int>();
}


x10_boolean SHA1RandX::equals(x10aux::ref<x10::lang::Any> that) {
    x10aux::ref<x10::lang::Reference> thatAsRef(that);
    if (thatAsRef->_type()->equals(x10aux::getRTT<SHA1RandX >())) {
        x10aux::ref<x10::lang::IBox<SHA1RandX > > thatAsIBox(that);
        return _struct_equals(thatAsIBox->value);
    }
    return false;
}

x10_boolean SHA1RandX::equals(SHA1RandX that) {
    return _struct_equals(that);
}

x10aux::ref<x10::lang::String> SHA1RandX::toString() {
    return x10::lang::String::Lit("SHA1RandX: detailed toString not defined.");
}

x10_int SHA1RandX::hashCode() {
    unsigned char *tmp = &(FMGL(cxx_sha1_rng).rng_state[0]);
    return *((x10_int*)tmp);
}

x10aux::ref<x10::lang::String> SHA1RandX::typeName() {
    return x10aux::type_name(*this);
}

x10aux::RuntimeType SHA1RandX::rtt;
void SHA1RandX::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType* parents[2] = { x10aux::getRTT<x10::lang::Any>(), x10aux::getRTT<x10::lang::Any>()};
    rtt.initStageTwo("SHA1RandX", x10aux::RuntimeType::struct_kind, 2, parents, 0, NULL, NULL);
    rtt.containsPtrs = false;
}


