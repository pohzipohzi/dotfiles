if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

# see https://stackoverflow.com/a/32592965/6150999
#kill $(lsof -t -i:8080)
#kill -9 $(lsof -t -i:8080)

PROC=$(lsof -t -i:$1)
kill -9 $PROC
