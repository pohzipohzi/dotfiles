if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

psql -h localhost -U postgres -d postgres -c "
CREATE TABLE IF NOT EXISTS bins (id bigint);
INSERT INTO bins (id) SELECT g.id FROM generate_series(1, $1) AS g (id);
"
