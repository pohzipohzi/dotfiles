ARGS=("$@")
/bin/bash $(dirname "$0")/${ARGS[0]}.sh ${ARGS[@]:1} 
