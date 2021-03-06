#!/bin/bash


DUMP_LOCATION=${DUMP_LOCATION:-/tmp/dump.sql}

echo "Dumping from ${SOURCE_PG_DBNAME}@${SOURCE_PG_HOST}..."
PGHOST=$SOURCE_PG_HOST PGUSER=$SOURCE_PG_USER PGPORT=$SOURCE_PG_PORT pg_dump $SOURCE_PG_DBNAME > $DUMP_LOCATION

echo $(ls -la $DUMP_LOCATION)

echo "Importing to ${TARGET_PG_DBNAME}@${TARGET_PG_HOST}..."
PGHOST=$TARGET_PG_HOST PGUSER=$TARGET_PG_USER PGPORT=$TARGET_PG_PORT psql $TARGET_PG_DBNAME < $DUMP_LOCATION

if [[ -n "${WAIT_AFTER_RUN}" ]]; then
    while true;
    do
        echo "done, but waiting..."
        sleep 1
    done
fi
