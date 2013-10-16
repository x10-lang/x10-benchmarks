#include "ESSL.h"
#include "essl_natives.h"


/*
 * Class:     ESSL
 * Method:    blockTriSolve
 * Signature: ([D[DI)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockTriSolve(JNIEnv *env, jclass klass, jdoubleArray meJ, jdoubleArray diagJ, jint B) {
  jdouble *me = env->GetDoubleArrayElements(meJ, (jboolean*)NULL);
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockTriSolve (me, diag, B);

  env->ReleaseDoubleArrayElements(meJ, me, 0);
  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}

/*
 * Class:     ESSL
 * Method:    blockTriSolveDiag
 * Signature: ([DIII)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockTriSolveDiag(JNIEnv *env, jclass klass, jdoubleArray diagJ, jint min, jint max, jint B) {
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockTriSolveDiag (diag, min, max, B);

  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}

/*
 * Class:     ESSL
 * Method:    blockBackSolve
 * Signature: ([D[DI)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockBackSolve(JNIEnv *env, jclass klass, jdoubleArray meJ, jdoubleArray diagJ, jint B) {
  jdouble *me = env->GetDoubleArrayElements(meJ, (jboolean*)NULL);
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockBackSolve (me, diag, B);

  env->ReleaseDoubleArrayElements(meJ, me, 0);
  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}

/*
 * Class:     ESSL
 * Method:    blockMulSub
 * Signature: ([D[D[DI)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockMulSub(JNIEnv *env, jclass klass, jdoubleArray meJ, jdoubleArray leftJ, jdoubleArray upperJ, jint B) {
  jdouble *me = env->GetDoubleArrayElements(meJ, (jboolean*)NULL);
  jdouble *left = env->GetDoubleArrayElements(leftJ, (jboolean*)NULL);
  jdouble *upper = env->GetDoubleArrayElements(upperJ, (jboolean*)NULL);

  blockMulSub (me, left, upper, B);

  env->ReleaseDoubleArrayElements(meJ, me, 0);
  env->ReleaseDoubleArrayElements(leftJ, left, 0);
  env->ReleaseDoubleArrayElements(upperJ, upper, 0);
}

/*
 * Class:     ESSL
 * Method:    blockMulSubDiag
 * Signature: ([DIII)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockMulSubDiag(JNIEnv *env, jclass klass, jdoubleArray diagJ, jint min, jint max, jint B) {
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockMulSubDiag (diag, min, max, B);

  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}

/*
 * Class:     ESSL
 * Method:    blockMulSubPanel
 * Signature: ([D[DIII)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockMulSubPanel(JNIEnv *env, jclass klass, jdoubleArray meJ, jdoubleArray diagJ, jint min, jint max, jint B) {
  jdouble *me = env->GetDoubleArrayElements(meJ, (jboolean*)NULL);
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockMulSubPanel (me, diag, min, max, B);

  env->ReleaseDoubleArrayElements(meJ, me, 0);
  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}

/*
 * Class:     ESSL
 * Method:    blockMulSubRow
 * Signature: ([D[DIIZ)V
 */
JNIEXPORT void JNICALL Java_ESSL_blockMulSubRow(JNIEnv *env, jclass klass, jdoubleArray meJ, jdoubleArray diagJ, jint B, jint j, jboolean cond) {
  jdouble *me = env->GetDoubleArrayElements(meJ, (jboolean*)NULL);
  jdouble *diag = env->GetDoubleArrayElements(diagJ, (jboolean*)NULL);

  blockMulSubRow (me, diag, B, j, cond);

  env->ReleaseDoubleArrayElements(meJ, me, 0);
  env->ReleaseDoubleArrayElements(diagJ, diag, 0);
}
