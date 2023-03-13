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

pushd ..
echo $(pwd)
echo restart chain
rm -rf env_seeds
touch env_seeds

entangled export >  genesis_exported.json
cp $HOME/.entangled/config/genesis.json $HOME/Documents/gh/Node/genesis.json

popd

# git add --all
# git commit -a -m "restart chain"
# git push origin $BRANCH 


