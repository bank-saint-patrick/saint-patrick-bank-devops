#!/bin/bash

echo "Restoring data from dump files"
gunzip < ./backups/database.gz | docker exec -i saintp_postgres psql -U postgres -d database