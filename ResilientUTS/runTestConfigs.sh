#!/bin/bash
# runs experiments using all the given test configurations.  Outputs to BENCH_LOG_DIR
USAGE="Usage: $0 testConfigFiles>.  Set GLOBAL_BENCH_ARGS for additional options to pass to the benchmark."

if [ "$#" -lt "1" ]
then
    echo "$USAGE"
    exit 1
fi

BENCH_LOG_DIR=${BENCH_LOG_DIR:-logs}
BENCH_RESULTS=${BENCH_RESULTS:-${BENCH_LOG_DIR}/results.csv}

BENCH_JAR=bin-managed/res_uts.jar

mkdir -p "${BENCH_LOG_DIR}"

x10 -cp ${BENCH_JAR} uts.UTS -statsHeader csv | sed 's/CSV/Transfer Mode, #Machines, # Places\/ Machine, Workers, Depth, Options/' > ${BENCH_RESULTS}

for testConfigFile in "$@"
do
    echo "Running $testConfigFile experiments"
    while read -r line
    do
	OIFS=$IFS
	IFS=","
	line_parts=($line)
	IFS=$OIFS
	if [ ${#line_parts[@]} -lt 4  ]
	then
	    echo "Error.  Specified test configuration file $testConfigFile, line $line does not have enough arguments.  skipping"
	    continue
	fi
	
	BENCH_NODES=${line_parts[0]}
	BENCH_PLACES_PER_NODE=${line_parts[1]}
	BENCH_WORKERS=${line_parts[2]}
	BENCH_DEPTH=${line_parts[3]}

	if [ "x$BENCH_NODES" = "x" ]
	then
	    echo "Error.  Specified test configuration file $testConfigFile does not set BENCH_NODES.  Skipping test configuration"
	    continue
	elif [ "x$BENCH_PLACES_PER_NODE" = "x" ]
	then
	    echo "Error.  Specified test configuration file $testConfigFile does not set BENCH_PLACES_PER_NODE.  Skipping test configuration"
	    continue
	elif [ "x$BENCH_DEPTH" == "x" ]
	then
	    echo "Error.  Specified test configuration file $testConfigFile does not set BENCH_DEPTH.  Skipping test configuration"
	    continue
	fi

	MY_HOSTLIST=
	if [ -n "$X10_HOSTFILE" ]
	then
	    # create a hostlist with the specified machines
	    NODE_COUNT=0
	    for node_name in `cat $X10_HOSTFILE`
	    do
		if [ $NODE_COUNT -ge $BENCH_NODES ]
		then
		    break
		fi
		if [ -n "${MY_HOSTLIST}" ]
		then
		    MY_HOSTLIST="${MY_HOSTLIST},"
		fi
		MY_HOSTLIST="${MY_HOSTLIST}$node_name"
		NODE_COUNT=$((NODE_COUNT+1))
	    done
	    
	    if [ $NODE_COUNT -lt $BENCH_NODES ];
	    then
		echo "Error.  Specified test configuration file $testConfigFile sets BENCH_NODES to $BENCH_NODES, but the X10_HOSTFILE (=$X10_HOSTFILE) contains only $NODE_COUNT machines.  Skipping test configuration"
		continue

	    fi
	elif [ -n "$X10_HOSTLIST" ]
	then
	    # first read in the hostlist
	    OIFS=$IFS
	    IFS=","
	    # brake it apart
	    SPLIT_HOST_LIST=($X10_HOSTLIST)
	    if [ ${#SPLIT_HOST_LIST[@]} -lt $BENCH_NODES ]
	    then
		echo "Error.  Specified test configuration file $testConfigFile sets BENCH_NODES to $BENCH_NODES, but the $X10_HOSTLIST (=$X10_HOSTLIST) contains only ${#SPLIT_HOST_LIST[@]} machines.  Skipping test configuration"
		continue
	    fi

	    # and reassemble (part of) it
	    MY_HOSTLIST="${SPLIT_HOST_LIST[*]:0:BENCH_NODES}"
	    IFS=$OIFS
	else
	    if [ $BENCH_NODES -eq "1" ]
	    then
		MY_HOSTLIST=localhost
	    else
		echo "Error.  Specified test configuration file $testConfigFile sets BENCH_NODES to $BENCH_NODES, which is greater than 1, but neither X10_HOSTFILE nor X!0_HOSTLIST was set.  Skipping test configuration"
		continue
	    fi
	fi
	
	ALL_BENCH_ARGS="${BENCH_ARGS} ${GLOBAL_BENCH_ARGS}"
	ALL_BENCH_X10_ARGS="${BENCH_X10_ARGS} ${GLOBAL_BENCH_X10_ARGS}"
	export X10_NPLACES
	X10_NPLACES=$((BENCH_NODES * BENCH_PLACES_PER_NODE))
	
	BASE_FILE_NAME=`basename $testConfigFile`

	LOG_FILE="$BENCH_LOG_DIR/$BASE_FILE_NAME_$line"
	RUN_DATE=`date` 

	ACTUAL_BENCH_WORKERS=${BENCH_WORKERS:-${GLOBAL_BENCH_WORKERS:-1}}
	ACTUAL_BENCH_MODE=${BENCH_MODE:-${GLOBAL_BENCH_MODE:transact}}
	
	echo "Running $testConfigFile on $RUN_DATE with $BENCH_NODES nodes: $MY_HOSTLIST with $BENCH_PLACES_PER_NODE per node ($X10_NPLACES total), $ACTUAL_BENCH_WORKERS workers, a depth of $BENCH_DEPTH, with transfer mode $ACTUAL_BENCH_MODE and the following additional X10 options: ${ALL_BENCH_X10_ARGS} and program options: ${ALL_BENCH_ARGS}" > ${LOG_FILE}

	x10 ${ALL_BENCH_X10_ARGS} -cp ${BENCH_JAR} uts.UTS -statsFormat csv -workers ${ACTUAL_BENCH_WORKERS} -depth ${BENCH_DEPTH} -transferMode ${ACTUAL_BENCH_MODE} ${ALL_BENCH_ARGS} >> ${LOG_FILE} 2> ${LOG_FILE}.err

	grep CSV ${LOG_FILE} | sed "s/CSV/$ACTUAL_BENCH_MODE, $BENCH_NODES, $BENCH_PLACES_PER_NODE, $ACTUAL_BENCH_WORKERS, $BENCH_DEPTH, $ALL_BENCH_ARGS/" >> ${BENCH_RESULTS}
    done < $testConfigFile
done
