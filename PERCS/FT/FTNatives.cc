#include "FTNatives.h"
#include "ft_natives.h"
#include "hpccfft.h"
#include "wrapfftw.h"


/*
 * Class:     FTNatives
 * Method:    create_plan
 * Signature: (III)J
 */
JNIEXPORT jlong JNICALL Java_FTNatives_create_1plan(JNIEnv *env, jclass klass, jlong SQRTN, jint direction, jint flags) {
    return create_plan((jint)SQRTN, direction, flags);
}

/*
 * Class:     FTNatives
 * Method:    execute_plan
 * Signature: (J[D[DIII)V
 */
JNIEXPORT void JNICALL Java_FTNatives_execute_1plan(JNIEnv *env, jclass klass, jlong plan, jdoubleArray Ajava, jdoubleArray Bjava, jlong SQRTN, jlong i0, jlong i1) {
  jdouble *A = env->GetDoubleArrayElements(Ajava, (jboolean*)NULL);
  jdouble *B = env->GetDoubleArrayElements(Bjava, (jboolean*)NULL);

  execute_plan(plan, A, B, (jint)SQRTN, (jint)i0, (jint)i1);

  env->ReleaseDoubleArrayElements(Ajava, A, 0);
  env->ReleaseDoubleArrayElements(Bjava, B, 0);
}
