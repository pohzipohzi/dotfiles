# init directories
mkdir -p $HOME/Desktop/postgres/backups
mkdir -p $HOME/docker/volumes/postgres
sudo chown -R $USER:$USER $HOME/docker/volumes/postgres

# run docker
cp $GOPATH/src/github.com/wal-g/wal-g/main/pg/wal-g $(dirname "$0")
docker build -t postgresi $(dirname "$0")
docker run --rm --name pg-docker -e WALG_FILE_PREFIX=/tmp/ -e POSTGRES_USER=$USER -e POSTGRES_INITDB_ARGS="--data-checksums" -p 5432:5432 postgresi
