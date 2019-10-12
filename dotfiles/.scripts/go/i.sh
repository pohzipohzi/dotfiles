git diff --name-only |
    while read line; do
        if [[ $line == *.go ]]; then goimports -v -w $line; fi;
    done;

