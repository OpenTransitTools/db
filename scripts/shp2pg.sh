#
# shp2pgsql 
#
IRDIR=`dirname $0`
. $IRDIR/base.sh

# include url 
cmd=$*
if [ "$1" == "" ]; then
  cmd="-?"
elif [ "$2" == "" ]; then
  cmd="$1 db url"
fi

$pg_shp $cmd
