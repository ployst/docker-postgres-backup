# postgres-backup

Create a dump from a DB and load it into another database.

## Available env vars

DUMP_LOCATION
    The location used to store the dump between dumping and loading. Changing
    this can be useful for cases where you want to mount a persistent disk and
    retain a copy of the backup. Defaults to /tmp.

WAIT_AFTER_RUN
    If set, the container will stay alive at the end of the run. This can be
    useful for debugging purposes.

SOURCE_PG_HOST
SOURCE_PG_USER
SOURCE_PG_PORT
SOURCE_PG_DBNAME

TARGET_PG_HOST
TARGET_PG_USER
TARGET_PG_PORT
TARGET_PG_DBNAME

## Example

Given two database containers:
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
8aa0377b56f9        postgres:9.5.1      "/docker-entrypoint.s"   5 minutes ago       Up 5 minutes        0.0.0.0:32813->5432/tcp   api-db-backup
c4a023e46b2a        postgres            "/docker-entrypoint.s"   12 days ago         Up 12 days          0.0.0.0:5432->5432/tcp    api-db
```

Running this command would create a backup of `api-db`'s `main` db and load it into `api-db-backup` as `main2`:

```
docker run -it --link api-db:db  --link api-db-backup:db2 -e SOURCE_PG_HOST=db -e SOURCE_PG_USER=user1 -e SOURCE_PG_DBNAME=main -e TARGET_PG_HOST=db2 -e TARGET_PG_USER=user1 -e TARGET_PG_DBNAME=main2 pg-backup:test
```
