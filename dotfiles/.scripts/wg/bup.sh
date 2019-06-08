export WALG_FILE_PREFIX=$HOME/Desktop/postgres/backups
export PGHOST=localhost

mkdir -p $WALG_FILE_PREFIX
sudo chown postgres:postgres $WALG_FILE_PREFIX
sudo -E -u postgres wal-g backup-push $HOME/docker/volumes/postgres/
