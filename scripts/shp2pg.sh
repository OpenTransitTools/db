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
  echo "$pg_shp \"shp2pgsql -f id -s 2913:4326 /shp/city.shp layers.city\""
else
  # fix cmdline params for docker volumn, which is expecting files to be in the '/shp' folder
  # eg: ~/shp/blah or shp/blah or $HOME/shp/blah converts to '/shp/blah' for docker
  args=()
  for arg in "$@"; do
    # Only rewrite arguments containing 'shp'
    if [[ "$arg" == *shp* ]]; then
      arg="${arg#"$HOME"}"
      arg="${arg#\$HOME}"
      arg="${arg#\~}"
      arg="/${arg#/}"
    fi
    args+=("$arg")
  done

  cmd="$pg_shp \"shp2pgsql -d -f id -s 2913:4326 ${args[*]}\""
  echo $cmd >&2
  eval $cmd
fi
