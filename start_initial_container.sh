#!/bin/sh

source ent_env

PASSWORD=$1
IP_ADDRESS=$2

docker build --build-arg key_path=./keys/validator_key.info -t ent/node .
docker run --name $VALIDATOR_CONTAINER_NAME -d -p 26656:26656 -p 26657:26657 -p 8545:8545 ent/node:latest init $PASSWORD $IP_ADDRESS