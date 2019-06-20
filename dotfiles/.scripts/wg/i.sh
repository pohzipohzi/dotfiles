if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

psql -h localhost -c "
SET default_tablespace = tblspc;
CREATE TABLE IF NOT EXISTS bins (id bigint);
INSERT INTO bins (id) SELECT g.id FROM generate_series(1, $1) AS g (id);
"
