if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

lsof -i:$1
