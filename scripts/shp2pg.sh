#
# run shp2pgsql via docker
# notes:
#  - all shp files must be in /shp, which is mapped to ~/shp/
#  - reprojecting everything now from 2913 (OR State Plane North) to 4326
#    TODO: look at .prj file to determine reprojection (and if needed)
#
IRDIR=`dirname $0`
. $IRDIR/base.sh

if [ "$1" == "" ]; then
  echo "$pg_shp -s 2913:4326 /shp/city.shp layers.city"
else
  $pg_shp -d -f id -s 2913:4326 $*
fi
