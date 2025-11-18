function db_urls() {
  db_path=postgresql://$1:$2@127.0.0.1:5432
  db_url=$db_path/$3
}

user=${PG_USER:-"ott"}
pass=${PG_PASS:-"ott"}
db=${PG_DB:-"ott"}
db_urls $user $pass $db

def_db=${PG_DEF:-"postgres"}

docker_exe="docker exec -i -u $def_db"
psql_term=${PG_SQL:-"$docker_exe -it db psql"}
psql=${psql:-"$docker_exe db psql"}
pg_isready=${pg_isready:-"$docker_exe db pg_isready"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}
pg_shp=${pg_shp:-"$docker_exe db shp2pgsql"}
