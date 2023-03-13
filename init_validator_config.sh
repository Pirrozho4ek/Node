#!/bin/sh

IP_ADDRESS=$1
RESTART_CHAIN=$2
NEED_P2_PConfig=$3
ADD_NODE_TO_SEED=$4
NODEID=$(entangled tendermint show-node-id)

if [[ $IP_ADDRESS == "" ]]; then
    echo wrong ip address
    exit 1
fi

if [[ $NODEID == "" ]]; then  
    echo wrong NODEID
    exit 1
fi

if [[ $NEED_P2_PConfig == "true" ]]; then  
    echo p2p config with $IP_ADDRESS
    ./p2p_config.sh $IP_ADDRESS
fi

if [[ $RESTART_CHAIN == "true" ]]; then
    echo restart chain
    rm -rf env_seeds
    touch env_seeds

    entangled export >  genesis_exported.json
    cp $HOME/.entangled/config/genesis.json $HOME/Documents/gh/Node/genesis.json
fi

if [[ $ADD_NODE_TO_SEED == "true" ]]; then
    echo restart chain
    NEWSEED=$NODEID@$1:26656
    [ -s env_seeds ] && NEWSEED=,$NEWSEED

    echo $NEWSEED >> env_seeds
    truncate --size -1 env_seeds
fi




# git add --all
# git commit -a -m "test"
# git push new node_testing
