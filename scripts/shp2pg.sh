#
# shp2pgsql 
#
IRDIR=`dirname $0`
. $IRDIR/base.sh

cmdline=$*
if [ "$1" == "" ]; then
  cmdline="-?"
elif [ "$2" == "" ]; then
  cmdline="$1 $db current.$file_name_table_blah"
fi

echo "$pg_shp $cmdline"
$pg_shp $cmdline
