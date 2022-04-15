!/bin/bash

echo "cloning backend repository"
git clone git@github.com:bank-saint-patrick/saint-patrick-bank-backend.git api
echo "\n"

echo "using branch Developer"
cd api
git checkout Developers
git pull origin Developers
cd ..
echo "\n"

echo "cloning frontend repository"
git clone git@github.com:bank-saint-patrick/saint-patrick-bank-frontend.git website
echo "\n"

echo "configuring backend"
rm -Rf ./api/SPatrickBack/appsettings.json
cp ./configs/appsettings.json ./api/SPatrickBack/
echo "\n"

echo "installing frontend dependencies"
cp ./configs/.env-frontend ./website/.env
cd website && npm install
npm run build
cd ..
echo "\n"

echo "building postgres directories"
mkdir postgres
mkdir postgres/init
mkdir postgres/data
cp ./configs/init.sql ./postgres/init/init.sql
echo "\n"

echo "coping dockerfiles"
cp dockerfiles/Dockerfile.postgres ./postgres/Dockerfile
cp dockerfiles/Dockerfile.aspnet ./api/Dockerfile
cp dockerfiles/Dockerfile.node ./website/Dockerfile
echo "\n"

echo "building postgres image"
docker build -t saintp_postgres ./postgres/
echo "\n"

echo "building aspnet image"
docker build -t saintp_api ./api
echo "\n"

echo "building node image"
docker build -t saintp_website ./website/
echo "\n"

echo "building service"
docker-compose -p "saintp" up -d
echo "\n"

echo "run frontend"
docker run -v 80:80 --name saintp_website saintp_website
echo "\n"