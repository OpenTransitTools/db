#
# run shp2pgsql via docker
# notes:
#  - all shp files must be in the ~/db/files volume
#  - reprojecting everything now from 2913 (OR State Plane North) to 4326
#    TODO: look at .prj file to determine reprojection (and if needed)
#
IRDIR=`dirname $0`
. $IRDIR/base.sh

if [ "$1" == "" ]; then
  echo "EXAMPLE: $pg_shp \"shp2pgsql -f id -s 2913:4326 /data/city.shp layers.city\""
else
  # fix cmdline params for docker volume, which is expecting files to be in the '/files' folder
  # eg: ~/shp/blah or data/blah or $HOME/files/blah converts to '/files/blah' for docker
  args=()
  for arg in "$@"; do
    # rewrite arguments containing 'shp', 'data' or 'files' to /files
    if [[ "$arg" == *shp* || "$arg" == *data* || "$arg" == *files* ]]; then
      arg="${arg#"$HOME"}"
      arg="${arg#\$HOME}"
      arg="${arg#\~}"
      arg="/${arg#/}"
      arg="${arg/\/shp\//\/files\/}"
      arg="${arg/\/data\//\/files\/}"
    fi
    args+=("$arg")
  done

  cmd="$pg_shp \"shp2pgsql -d -f id -s 2913:4326 ${args[*]}\""
  echo $cmd >&2
  eval $cmd
fi
