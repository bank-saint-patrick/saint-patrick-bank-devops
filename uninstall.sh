#!/bin/bash

echo "stoping containers"
docker container stop saintp_website saintp_api saintp_postgres
echo "\n"

echo "removing containers"
docker container rm saintp_website saintp_api saintp_postgres
echo "\n"

echo "removing images"
docker rmi saintp_website saintp_api saintp_postgres
echo "\n"

echo "removing backend directory"
rm -Rf ./api
echo "\n"

echo "removing frontend directory"
rm -Rf ./website
echo "\n"

echo "removing postgres directory"
rm -Rf ./postgres
echo "\n"