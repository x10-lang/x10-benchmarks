# runs experiments using all the given test configurations. in all the given modes  Outputs to BENCH_LOG_DIR
USAGE="Usage: $0 testConfigFiles>.  Set BENCH_MODES to specify the modes to run (default: all of them)."

BASE_DIR="`dirname $0`"
BASE_DIR=`cd ${BASE_DIR}; pwd`


if [ "$#" -lt "1" ]
then
	echo "$USAGE"
	exit 1
fi

BASE_BENCH_LOG_DIR=${BENCH_LOG_DIR:-logs}
BASE_RESULTS=${BENCH_RESULTS:-"${BASE_BENCH_LOG_DIR}/results.csv"}

BENCH_MODES=${BENCH_MODES:-"transact,atomic,atomic-submit,nomap"}

OIFS=$IFS
IFS=","
# braek it apart
BENCH_MODES_ARR=($BENCH_MODES)
IFS=$OIFS

for mode in "${BENCH_MODES_ARR[@]}"
do
    echo "Running experiments with transferMode $mode"
    unset BENCH_RESULTS
    BENCH_LOG_DIR="${BASE_BENCH_LOG_DIR}/$mode"
    BENCH_LOG_DIR="$BENCH_LOG_DIR" GLOBAL_BENCH_ARGS="-transferMode $mode" ${BASE_DIR}/runTestConfigs.sh "$@"
    cat $BENCH_LOG_DIR/results.csv >> ${BASE_RESULTS}
done
