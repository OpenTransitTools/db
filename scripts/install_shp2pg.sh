#
# install postgis in the container to get shp2pgsql
#
IRDIR=`dirname $0`
. $IRDIR/base.sh

$pg_shp -v
has_shp=$?

if [ $has_shp -eq 0 ]; then
  echo; echo "system appears to have \"${pg_shp}\" installed"; echo
else
  echo "IMPORTANT: install postgis to get the shp2pgsql tools...starting up the docker container"
  echo "apt-get update"
  echo "apt-get install -y postgis"
  $IRDIR/wait.sh
  docker exec -it db /bin/bash
fi
