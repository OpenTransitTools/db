DIR=`dirname $0`
. $DIR/base.sh

sql_file=${1:-"NOPE"}

u=${2:-$user}
p=${3:-$pass}
d=${4:-$db}
db_urls $u $p $d

if [ -f $sql_file ]; then
  echo loading .sql file: $sql_file
  r="$pg_restore -d ${db_url} < $sql_file"
  echo $r
  eval $r
elif [ $sql_file == "NOPE" ]; then
  echo "file.sh <sql commands .sql>"
else
  echo "$sql_file doesn't exist"
fi
