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

x10 -cp ${BENCH_JAR} -DX10RT_DATASTORE=Hazelcast uts.UTS -statsHeader csv | sed 's/CSV/#Machines, # Places\/ Machine, Depth, Options/' > ${BENCH_RESULTS}

for testConfigFile in "$@"
do
    echo "Running $testConfigFile" experiment
    source "$testConfigFile"

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
	# braek it apart
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
    
    ALL_BENCH_ARGS="${BENCH_ARGS}${GLOBAL_BENCH_ARGS}"
    export X10_NPLACES
    X10_NPLACES=$((BENCH_NODES * BENCH_PLACES_PER_NODE))
    
    BASE_FILE_NAME=`basename $testConfigFile`

    LOG_FILE="$BENCH_LOG_DIR/$BASE_FILE_NAME"
    RUN_DATE=`date` 
    
    echo "Running $testConfigFile on $RUN_DATE with $BENCH_NODES nodes: $MY_HOSTLIST with $BENCH_PLACES_PER_NODE per node ($X10_NPLACES total), a depth of $BENCH_DEPTH and the following additional options: $ALL_BENCH_ARGS" > ${LOG_FILE}

    x10 -cp ${BENCH_JAR} -DX10RT_DATASTORE=Hazelcast uts.UTS -statsFormat csv -depth ${BENCH_DEPTH} ${ALL_BENCH_ARGS} >> ${LOG_FILE} 2> ${LOG_FILE}.err

    grep CSV ${LOG_FILE} | sed "s/CSV/$BENCH_NODES, $BENCH_PLACES_PER_NODE, $BENCH_DEPTH, $ALL_BENCH_ARGS/" >> ${BENCH_RESULTS}

done
