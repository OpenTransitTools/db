DIR=`dirname $0`
. $DIR/base.sh

cd $HOME/gtfs/
for x in *-did_scp
do
  cmd="mv $x ${x%%-did_scp}"
  echo $cmd
  eval $cmd
done

for x in *-processed
do
  cmd="mv $x ${x%%-processed}"
  echo $cmd
  eval $cmd
done
