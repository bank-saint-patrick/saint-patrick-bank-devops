#!/bin/bash

echo "Creating database dumps"
docker exec -t postgrestest_serverpostgres_1 pg_dumpall -c -U admin | gzip > ./database.gz