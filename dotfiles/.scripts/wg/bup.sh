mkdir -p $WALG_FILE_PREFIX
$GOPATH/src/github.com/wal-g/wal-g/main/pg/wal-g backup-push $PGDATA
