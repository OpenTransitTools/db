RESTDIR=`dirname $0`
source_base() {
  # dont send cmdline params down to base.sh
  source $RESTDIR/base.sh
}
source_base

DATA_DIR=${1:-"."}
RENAME=${2-"TRUEx"}


function restore_file_types() {
  local ext=${1:-"sql"}
  local rename=${2:-$RENAME}

  for x in *.${ext}
  do
    echo restore backup: $x
    r="$pg_restore -d ${db_url} < $x"
    echo $r
    eval $r

    if [ $rename == "TRUE" ]; then
      m="mv $x $x-processed"
      eval $m
    fi
    echo
  done
}


# run load from cmdline. can be included in another script
# without the restore cmds below if that script defines a $SERVERS var
if [ -z "${SERVERS+xxx}" ]; then
  cd $DATA_DIR
  echo "LOADING db with files (.schema, .sql, .views) from folder $PWD"
  restore_file_types schema
  restore_file_types sql
  restore_file_types views
  cd -
fi
