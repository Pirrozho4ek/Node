#!/bin/sh

KEY="validator_key"
KEYRING="file"
KEYALGO="eth_secp256k1"

PASSWORD=$1

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon and client
rm -rf ~/.entangled*

make install

entangled config keyring-backend $KEYRING

# if $KEY exists it should be deleted
yes PASSWORD | entangled keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO
