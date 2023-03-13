#!/bin/sh

source ent_env

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon and client
rm -rf ~/.entangled*

make install

entangled config keyring-backend $KEYRING
entangled config chain-id $CHAINID

# if $KEY exists it should be deleted
entangled keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Entangle (Moniker can be anything, chain-id must be an integer)
entangled init $MONIKER --chain-id $CHAINID

./init_seeds.sh

cp genesis.json $HOME/.entangled/config/
entangled start  --evm.tracer=json $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001aENTGL --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable


# entangled tx staking create-validator \
#   --amount=170000000000000000000aENTGL \
#   --pubkey=$(entangled tendermint show-validator) \
#   --moniker="validator2" \
#   --chain-id=<chain_id> \
#   --commission-rate="0.10" \
#   --commission-max-rate="0.20" \
#   --commission-max-change-rate="0.01" \
#   --min-self-delegation="1" \
#   --gas="auto" \
#   --gas-prices="0.025uatom" \
#   --from=$KEY

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# entangled start --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001aENTGL --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable
