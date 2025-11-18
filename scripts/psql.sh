##
## run psql interative or cmdline 
##
DIR=`dirname $0`
. $DIR/base.sh

sql_cmd=${1:-"INTERACTIVE"}

u=${2:-$user}
p=${3:-$pass}
d=${4:-$db}
db_urls $u $p $d

if [ "$sql_cmd" == "INTERACTIVE" ]; then
  cmd="$psql_term $d"
else
  cmd="$psql $db_url -h 127.0.0.1 -c '$sql_cmd'"
  echo $cmd
  eval $cmd
fi
