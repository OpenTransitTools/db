# **note**: project name is *important* for networking between GeoServer and PostGIS
 export COMPOSE_PROJECT_NAME=kartozageoserver
 export POSTGRES_MAJOR_VERSION=17
 export POSTGIS_MAJOR_VERSION=3
 export POSTGIS_MINOR_RELEASE=5
 export # kartoza/postgis env variables https://github.com/kartoza/docker-postgis
 export POSTGRES_DB=gis
 export POSTGRES_USER=tmpublic
 export POSTGRES_PASS=tmpublic
 export ALLOW_IP_RANGE=0.0.0.0/0
 export POSTGRES_PORT=5432
 export POSTGRES_UID=724
 export POSTGRES_GID=724
 export RUN_AS_ROOT=false
