# Saint Patrick Bank Devops

This is a learning project

This repository is in charge of preparing and configuring a complete work environment for the Saint Patrick Bank project, by using it you will be able to automatically download and install a development environment.

### Enviroments, and others values

Configs
  - Configuration donet with postgres configs/appsettings.json

Ports
  - 5432 - postgres
  - 3000 - service node for app react

Envs
  - Postgres
    - POSTGRES_USER=admin
    - POSTGRES_PASSWORD=admin
    - PGDATA=/var/lib/postgresql/data/pgdata

### Postgres Data persistence And Init SQL
  - Postgres
    - postgers/data
    - postgers/init

### Install

For the installation you must execute a bash file that we have prepared to automate the entire process, in the commands section you can review all the commands that we have used to automate the process.
```sh
sh ./install.sh
```

### Install postgres schema
Access to postgres and create database "SaintPDB"
After run:
```bash
gunzip < ./backups/database.gz | docker exec -i saintp_postgres psql -U postgres -d SaintPDB
```

### How access
  - Api => http://localhost:5000/swagger/index.html
  - Website => http://localhost:3000

### Uninstall
For the uninstall you must execute a bash file that we have prepared that is responsible for removing all the created directories, stopping the containers and deleting the Docker images. BEWARE because all the generated postgres data is deleted.
```sh
sh ./uninstall.sh
```

### Commands

cloning backend repository
```bash
git clone git@github.com:bank-saint-patrick/saint-patrick-bank-backend.git api
```

cloning frontend repository
```bash
git clone git@github.com:bank-saint-patrick/saint-patrick-bank-frontend.git website
```

installing frontend dependencies
```bash
cd website && npm install
cd ..
```

building postgres directories
```bash
mkdir postgres
mkdir postgres/init
mkdir postgres/data
```

coping dockerfiles
```bash
cp dockerfiles/Dockerfile.postgres ./postgres/Dockerfile
cp dockerfiles/Dockerfile.aspnet ./api/Dockerfile
cp dockerfiles/Dockerfile.node ./website/Dockerfile
```

building postgres image
```bash
docker build -t saintp_postgres ./postgres/
```

building node image
```bash
docker build -t saintp_website ./website/
```

building service
```bash
docker-compose -p "saintp" up -d
```