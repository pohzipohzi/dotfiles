if [ "$#" -ne 1 ]; then    
    echo "invalid parameters"
    exit 1
fi

wal-g delete before $1
