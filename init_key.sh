#!/bin/sh

KEY="validator_key"
KEYRING="file"
KEYALGO="eth_secp256k1"

CUR_DATE="$(date +%Y-%m-%d_%H:%M:%S)"

BASEDIR=$(dirname "$0")
KEYS_DIR=$BASEDIR/keys
DATE_DIR=$KEYS_DIR/$CUR_DATE


PASSWORD=$1
if [ ${#PASSWORD} -le 7 ]; then 
    PASSWORD=""
    echo Enter the key password. It must be at list 8 symbols. Remember or write it somwhere safe. 
    echo If you forgot or lose the password your account can not be recovered.
fi

while [[ $PASSWORD == "" ]];
do
    read -sp "Enter The Key Password: " PASSWORD1
    echo ""
    if [ ${#PASSWORD1} -le 7 ]; then 
        echo Password must be at list 8 symbols
    else
        read -sp "Please repeat the password to check it is correct: " PASSWORD2
        echo ""
        if [ "$PASSWORD1" = "$PASSWORD2" ]; then
            PASSWORD=$PASSWORD1 
        else
            echo Password is not the same. Try again
        fi
    fi
done

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon and client
rm -rf ~/.entangled*

make install

entangled config keyring-backend $KEYRING

# if $KEY exists it should be deleted
yes $PASSWORD | entangled keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

mkdir -p $KEYS_DIR
mkdir -p $DATE_DIR

cp $HOME/.entangled/keyring-file/$KEY.info $KEYS_DIR
cp $HOME/.entangled/keyring-file/$KEY.info $DATE_DIR

