user=${PG_USER:-"ott"}
pass=${PG_PASS:-"ott"}
def_db=${PG_DEF:-"postgres"}
db=${PG_DB:-"ott"}
osm_db=${PG_OSM:-"osm"}
db_path=postgresql://$user:$pass@127.0.0.1:5432
db_url=$db_path/$db

docker_exe="docker exec -i -u $def_db"
psql_term=${psql:-"$docker_exe -it db psql"}
psql_ott=${psql:-"$docker_exe -e PGUSER=$user -e PGPASSWORD=$pass db psql"}
psql=${psql:-"$docker_exe db psql"}
pg_isready=${pg_isready:-"$docker_exe db pg_isready"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}
pg_shp=${pg_shp:-"$docker_exe db shp2pgsql"}
