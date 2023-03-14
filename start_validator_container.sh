PASSWORD=$1
IP_ADDRESS=$2

docker build --build-arg key_path=./keys/validator_key.info -t ent/node .
docker run -p 26656:26656 -p 26657:26657 -p 8545:8545 ent/node:latest $PASSWORD $IP_ADDRESS false true false