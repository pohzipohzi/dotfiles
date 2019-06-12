#!/bin/sh
PORTS=($(seq 30001 1 30006))

# set up servers
rm -f appendonly.aof
rm -f dump.rdb
for i in ${PORTS[@]}
do
    rm -rf $i
    mkdir $i
    touch $i/redis.conf
    touch $i/nodes.conf
    echo "port $i
cluster-enabled yes
cluster-config-file $i/nodes.conf
cluster-node-timeout 5000
appendonly yes" >> $i/redis.conf
done

# set up individual redis
tmux new-session -s rc -d
for i in ${PORTS[@]}
do
    tmux send-keys "redis-server ./$i/redis.conf" Enter
    tmux split-window -h
    tmux select-layout tiled
done

# set up redis cluster
CMD="redis-cli --cluster create"
for i in ${PORTS[@]}; do CMD+=" 127.0.0.1:$i"; done
CMD+=" --cluster-replicas 1"
tmux send-keys "$CMD" Enter

# attach session
tmux -2 attach-session -d

