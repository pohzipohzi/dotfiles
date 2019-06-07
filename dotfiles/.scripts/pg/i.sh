psql -h localhost -U postgres -d postgres -c "CREATE TABLE IF NOT EXISTS bins (id bigint);"
psql -h localhost -U postgres -d postgres -c "INSERT INTO bins (id) SELECT g.id FROM generate_series(1, $1) AS g (id);"
