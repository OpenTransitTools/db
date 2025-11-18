RESTDIR=`dirname $0`
. $RESTDIR/base.sh


function restore_file_types() {
  ext=${1:-"sql"}

  for x in *.${ext}
  do
    echo restore backup: $x
    r="$pg_restore -d ${db_url}${db} < $x"
    echo $r
    eval $r

    m="mv $x $x-processed"
    echo $m
    eval $m

    echo
  done
}

echo "LOADING db with files (.schema, .sql, .views) from folder $PWD"
restore_file_types schema
restore_file_types sql
restore_file_types views
