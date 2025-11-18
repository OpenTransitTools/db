##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/base.sh

u=${1:-$user}
p=${2:-$pass}
d=${3:-$db}
db_urls $u $p $d

## create user (default is user='ott' with pass='ott' -- change in ./base.sh)
cmd="$psql -c \"CREATE USER ${u} WITH PASSWORD '${p}';\""
echo $cmd
eval $cmd

# create postgis DB
cmd="$psql -c \"CREATE DATABASE ${d} WITH OWNER ${u};\""
echo $cmd
eval $cmd

cmd="$psql $d -c \"CREATE EXTENSION postgis;\""
echo $cmd
eval $cmd
