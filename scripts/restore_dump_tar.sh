#
# WIP - load a pg db with a .tar dump 
#
DIR=`dirname $0`
. $DIR/base.sh

tar_name=${1:-"ott.tar"}
this_db=${2:-"ott"}
this_db_user=${3:-"ott"}
this_db_pass=${4:-"ott"}


function execmd() {
  local cmd=$1
  local exe=${2:-"TRUE"}
  local pnt=${3:-"TRUE"}

  if [ "$pnt" == "TRUE" ]; then echo $cmd; fi
  if [ "$exe" == "TRUE" ]; then eval $cmd; fi
}

execmd "$psql -d ${db_url}${def_db} -c \"DROP DATABASE $this_db;\""
execmd "$psql -d ${db_url}${def_db} -c \"DROP USER ${this_db_user};\""
execmd "$psql -c \"CREATE USER ${this_db_user} WITH PASSWORD '${this_db_pass}';\""
execmd "$psql -c \"CREATE DATABASE ${this_db} WITH OWNER ${this_db_user};\""
execmd "$docker_exe db pg_restore -d ${this_db} < ${tar_name}"
 
