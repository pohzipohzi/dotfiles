git diff --name-only | while read line ; do goimports -v -w $line ; done

