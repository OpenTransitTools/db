#
# (re)start postgis
#
REDIR=`dirname $0`
. $REDIR/base.sh

NO_PRUNE=${1:-"TRUE"}
NEW_DATA_DIR=${2:-"TRUE"}
DB_LOG=${3:-"log.out"}

date

# (re)start postgis
cd $REDIR/../
echo "-> $PWD (should be in the db repo directory)"
docker compose down
sleep 2

if [ $NO_PRUNE != "TRUE" ]; then
  cmd="docker system prune -a -f"
  echo $cmd
  eval $cmd
  sleep 2
fi

if [ $NEW_DATA_DIR == "TRUE" ]; then
  echo "new data dir: rm -rf $PWD/new_db_dir"
  new_db_dir
fi

docker compose up -d >> $DB_LOG 2>&1
