sudo -u postgres psql -c "CREATE TABLE IF NOT EXISTS bins (id bigint);"
sudo -u postgres psql -c "INSERT INTO bins (id) SELECT g.id FROM generate_series(1, $1) AS g (id);"
