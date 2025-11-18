##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/base.sh

sql_cmd=${1:-"INTERACTIVE"}
u=${2:-$user}

if [ "$sql_cmd" == "INTERACTIVE" ]; then
  cmd="$psql_term $db"
else
  cmd="$db_path/$u -h 127.0.0.1 -c '$sql_cmd'"
  echo $cmd
  eval $cmd
fi
