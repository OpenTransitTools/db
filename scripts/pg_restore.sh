#
# run pg_restore cmd via docker
#
# ~/db/scripts/pg_restore.sh -d trimet --clean --if-exists -v /data/trimet.tar
# NOTE: /data/ is a docker volume mapped to ~/pg_load/data/ 
#
DIR=`dirname $0`
. $DIR/base.sh

$pg_restore $*
