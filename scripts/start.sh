#
# (re)start postgis
#
REDIR=`dirname $0`
. $REDIR/base.sh

DB_LOG=${1:-"log.out"}
DOC_PRUNE=${2:-"FALSE"}

date

# (re)start postgis
cd $REDIR/../
echo $PWD
docker compose down; sleep 2

if [ $DOC_PRUNE == "TRUE" ]; then
  docker system prune -a -f; sleep 2
fi

docker compose up -d >> $DB_LOG 2>&1
