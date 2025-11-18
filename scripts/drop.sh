##
## drop OTT database
##
DIR=`dirname $0`
. $DIR/base.sh

u=${1:-$user}
p=${2:-$pass}
dbz=${3:-"$db $osm_db"}

# drop DBz
for d in $dbz
do
  cmd="$psql -d ${db_path}/${def_db} -c \"DROP DATABASE ${d};\";"
  echo $cmd
  eval $cmd
done
