USAGE="Usage: $0 min-nplaces max-nplaces <args>"

if [ "$#" -lt 2 ]; then
	echo "$USAGE"
	exit 1
fi

MIN_PLACES=$1;
MAX_PLACES=$2;
shift; shift;

x10 -cp bin-managed/res_uts.jar -DX10RT_DATASTORE=Hazelcast uts.UTS -statsHeader csv | sed 's/CSV/# Places, Options/'
for i in `seq ${MIN_PLACES} ${MAX_PLACES}`; do X10_NPLACES=$i x10 -cp bin-managed/res_uts.jar -DX10RT_DATASTORE=Hazelcast uts.UTS -statsFormat csv "$@" | grep CSV | sed "s/CSV/$i, $*/"; done

