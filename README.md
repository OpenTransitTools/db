# db
postgis db docker compose + other tools (osm2pg, db management ./scripts/, etc...)

to get started:
 1. clone and cd db
 1. scripts/start.sh
 1. scripts/create.sh x x x
 1. scripts/file.sh scripts/test.sql x x x
 1. scripts/psql.sh "select agency_name from sam.agency" x x x
 1. scripts/drop.sh x x x
 1. docker compose down
 1. NOTE: see .env for more config junk

issues:
 - docker is creating data directories with root permissions
 