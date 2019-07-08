mkdir -p $WALG_FILE_PREFIX
pgbench -i -s 1
wal-g backup-push --permanent $PGDATA
