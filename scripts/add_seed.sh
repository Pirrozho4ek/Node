#!/bin/sh

source ent_env

IP_ADDRESS=$1
NODEID=$(entangled tendermint show-node-id)

if [[ $IP_ADDRESS == "" ]]; then
    echo wrong ip address
    exit 1
fi

if [[ $NODEID == "" ]]; then  
    echo wrong NODEID
    exit 1
fi

pushd .. > /dev/null
NEWSEED=$NODEID@$1:26656
[ -s env_seeds ] && NEWSEED=,$NEWSEED

echo $NEWSEED >> env_seeds
truncate --size -1 env_seeds
popd > /dev/null

# git add --all
# git commit -a -m "add"
# git push origin node_testing
