#
# run pg_dump cmd via docker
#
# ~/db/scripts/pg_dump.sh  -n current -n load -n next -n future -n prod -Ft trimet > trimet.tar
# NOTE: to reload trimet.tar with pg_restore.sh, that file will need to be in a docker volume
#
DIR=`dirname $0`
. $DIR/base.sh

$pg_dump $*
