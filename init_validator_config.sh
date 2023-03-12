#!/bin/sh

./p2p_config.sh $1

entangled export >  genesis_exported.json
cp $HOME/.entangled/config/genesis.json $HOME/Documents/gh/Node/genesis.json

git add --all
git commit -a -m "test"
git push new node_testing
