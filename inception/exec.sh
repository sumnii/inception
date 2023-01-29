clear

function trap_ctrlc ()
{
	echo ""
    exit 2
}
trap "trap_ctrlc" 2

make ps | awk '{ print ($1, $2) }'
echo ""
echo -n "Container ID or IMAGE: "
read INPUT

CID=`make ps | grep $INPUT | awk '{print $1}'`

docker exec -it $CID bash