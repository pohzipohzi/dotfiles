mkdir -p $WALG_FILE_PREFIX
sudo chown postgres:postgres $WALG_FILE_PREFIX
sudo -E -u postgres wal-g backup-push --permanent $HOME/docker/volumes/postgres/

