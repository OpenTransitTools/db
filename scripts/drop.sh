##
## drop OTT database
##
DIR=`dirname $0`
. $DIR/base.sh

u=${1:-$user}
p=${2:-$pass}
d=${3:-$db}
db_urls $u $p $d

# drop DBz
cmd="$psql -d ${db_path}/${def_db} -c \"DROP DATABASE ${d};\";"
echo $cmd
eval $cmd

db_urls tmpublic tmpublic ${def_db}
cmd="$psql -d ${db_url} -c \"DROP USER ${u};\""
echo $cmd
eval $cmd
