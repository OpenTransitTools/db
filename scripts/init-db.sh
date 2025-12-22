#!/bin/bash
set -e


apt update && apt install -y osm2pgsql

echo "Connecting to PostgreSQL as user: $POSTGRES_USER"



# --- CREATE USER IF NOT EXISTS ---
echo "Checking if role 'tmpublic' exists..."
USER_EXISTS=$(psql -U postgres -d postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='tmpublic'")

if [ "$USER_EXISTS" = "1" ]; then
    echo "User 'tmpublic' already exists, skipping..."
else
    echo "Creating user 'tmpublic' "
    psql -U postgres -c "CREATE USER tmpublic WITH PASSWORD 'tmpublic';"
fi

DATABASES=("osm" "trimet")

for DB in "${DATABASES[@]}"; do
    echo "Checking if database $DB exists..."
    if psql -U "$POSTGRES_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB'" | grep -q 1; then
        echo "Database $DB already exists, skipping..."
    else
        echo "Creating database $DB..."
        createdb -U "$POSTGRES_USER" "$DB"
    fi
done

# Enable PostGIS extension in each DB
psql -U "$POSTGRES_USER" -d osm -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U "$POSTGRES_USER" -d trimet -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U "$POSTGRES_USER" -d trimet -c "CREATE EXTENSION IF NOT EXISTS hstore;"
psql -U "$POSTGRES_USER" -d osm -c "CREATE EXTENSION IF NOT EXISTS hstore;"

