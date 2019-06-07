ARGS=("$@")
if [ "${ARGS[@]}"==0 ]; then
    tree $(dirname "$0")
else
    /bin/bash $(dirname "$0")/${ARGS[0]}.sh ${ARGS[@]:1} 
fi
