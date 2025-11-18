##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/base.sh

u=${1:-$user}
p=${2:-$pass}
dbz=${3:-"$db $osm_db"}

## create user (default is user='ott' with pass='ott' -- change in ./base.sh)
cmd="$psql -c \"CREATE USER ${u} WITH PASSWORD '${p}';\""
echo $cmd
eval $cmd

# create ott DB (and formally osm $osm_db)
for d in $dbz
do
  $psql -c "CREATE DATABASE ${d} WITH OWNER ${u};"
  $psql $d -c "CREATE EXTENSION postgis;"
done
