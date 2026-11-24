#
# run pg_dump cmd via docker
#
DIR=`dirname $0`
. $DIR/base.sh

$pg_dump $*
