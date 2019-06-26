if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

go test -v -run $1
