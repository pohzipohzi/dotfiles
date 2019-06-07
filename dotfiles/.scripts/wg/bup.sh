export PGHOST="/var/run/postgresql/"
export WALG_FILE_PREFIX=/var/lib/postgres/backups
sudo -E -u postgres wal-g backup-push /var/lib/postgresql/11/cluster/
