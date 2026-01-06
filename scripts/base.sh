user=${1:-"ott"}
pass=${2:-"ott"}
def_db=${3:-"postgres"}
db=${4:-"ott"}
osm_db=${5:-"osm"}
db_url="postgresql://$user:$pass@127.0.0.1:5432"

docker_exe="docker exec -i -u $def_db"
psql_term=${psql:-"$docker_exe -it db psql"}
psql_ott=${psql:-"$docker_exe -e PGUSER=$user -e PGPASSWORD=$pass db psql"}
psql=${psql:-"$docker_exe db psql"}
pg_isready=${pg_isready:-"$docker_exe db pg_isready"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}
pg_shp=${pg_shp:-"$docker_exe db shp2pgsql"}

pg_data_dir="geo-db-data"

# creates a clean / postgres data directory in the geo project (done so docker doesn't make it root)
function new_db_dir() {
  # note: cd into the root of this project to delete the pg data dir
  rm -rf $pg_data_dir > /dev/null 2>&1
  date=$(date '+%Y%m%d')
  mv $pg_data_dir "z_deleteme_${date}"
  mkdir -p $pg_data_dir/17
}
