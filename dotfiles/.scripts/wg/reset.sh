pg_ctl -D $PGDATA stop
mkdir -p $PGDATA
mkdir -p $WALG_FILE_PREFIX
mkdir -p $HOME/Desktop/postgres/tblspc
rm -rf $PGDATA/*
rm -rf $WALG_FILE_PREFIX/*
rm -rf $HOME/Desktop/postgres/tblspc/*
pg_ctl init -D $PGDATA
sed -i '' 's/#wal_level = replica/wal_level = replica/g' $PGDATA/postgresql.conf
sed -i '' 's/#archive_mode = off/archive_mode = on/g' $PGDATA/postgresql.conf
sed -i '' "s/#archive_command = ''/archive_command = 'wal-g wal-push %p'/g" $PGDATA/postgresql.conf
pg_ctl -D $PGDATA start
createdb $USER
psql -h localhost -c "
CREATE TABLESPACE tblspc LOCATION '$HOME/Desktop/postgres/tblspc';
"
psql -f $(dirname "$0")/dvdrental/restore.sql
psql -h localhost -c "
SET default_tablespace = tblspc;
CREATE TABLE IF NOT EXISTS bins (id bigint);
INSERT INTO bins (id) SELECT g.id FROM generate_series(1, 1000000) AS g (id);
"
