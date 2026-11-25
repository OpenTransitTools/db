#
# run pg_restore cmd via docker
#
# ~/db/scripts/pg_restore.sh -d trimet --clean --if-exists -v /files/trimet.tar
# NOTE: /files/ is a docker volume mapped to ~/db/files/ 
#
DIR=`dirname $0`
. $DIR/base.sh

if [ "$1" == "" ]; then
  echo "EXAMPLE: $pg_restore -d trimet --clean --if-exists -v ~/files/trimet.tar"
else
  # fix cmdline params for docker volume, which is expecting files to be in the '/files' folder
  # eg: ~/shp/blah or data/blah or $HOME/files/blah converts to '/files/blah' for docker
  args=()
  for arg in "$@"; do
    # change file perms to read all (docker)
    if [ -f $arg ]; then
      chmod a+r $arg
    fi

    # rewrite arguments containing 'shp', 'data' or 'files' to /files
    if [[ "$arg" == *shp* || "$arg" == *data* || "$arg" == *files* ]]; then
      arg="${arg#"$HOME"}"
      arg="${arg#\$HOME}"
      arg="${arg#\~}"
      arg="/${arg#/}"
      arg="${arg/\/shp\//\/files\/}"
      arg="${arg/\/data\//\/files\/}"
      arg="${arg/\/db\/files\//\/files\/}"
    fi

    args+=("$arg")
  done

  cmd="$pg_restore ${args[*]}"
  echo $cmd >&2
  eval $cmd
fi
