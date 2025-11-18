#
# restart geoserver and postgis
#
STDIR=`dirname $0`
. $STDIR/base.sh

PRUNE=NTRUE
PG_LOG=pglog.out

# re-start postgis
cd $STDIR/../
echo $PWD
date

docker compose down
sleep 6

if [ $PRUNE == "TRUE" ]; then
  docker system prune -a -f
  sleep 2
fi

docker compose up -d >> $PG_LOG 2>&1
sleep 2
cd -
