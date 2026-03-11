#
# crete OTT spatial db for OTT
#
DIR=`dirname $0`
. $DIR/base.sh

new_db=${1:-"$db"}
new_schema=${2:-"$1"}
new_user=${3:-"$user"}
new_pass=${4:-"$pass"}

# create new user 
if [ "$new_user" != " " ]; then
  cmd="$psql -c \"CREATE USER ${new_user} WITH PASSWORD '${new_pass}';\""
  echo $cmd
  eval $cmd
else
  new_user="$user"
fi

# create new database
if [ "$new_db" != " " ]; then
  cmd="$psql -c \"DROP DATABASE ${new_db} WITH FORCE;\""
  echo $cmd
  eval $cmd

  cmd="$psql -c \"CREATE DATABASE ${new_db} WITH OWNER ${user};\""
  echo $cmd
  eval $cmd

  $psql $new_db -c "CREATE EXTENSION postgis;"
else
  new_db=$db
fi


# create new schema in that db
if [ "$new_schema" != " " ]; then
  cmd="$psql -c \"\c ${new_db}; DROP SCHEMA '${new_schema}' CASCADE;\""
  echo $cmd
  eval $cmd

  cmd="$psql -c \"\c ${new_db}; CREATE SCHEMA ${new_schema};\""
  echo $cmd
  eval $cmd

  cmd="$psql -c \"\c ${new_db}; GRANT ALL ON SCHEMA '${new_schema}' TO '${new_user}';\""
  echo $cmd
  eval $cmd
fi
