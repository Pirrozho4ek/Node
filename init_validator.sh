#!/bin/sh

if [ "$1" != "" ]; then
    BUILD_TYPE=$1 
    echo "Received: ${1}" && shift;
fi

echo secondary params "$@"

if [ $BUILD_TYPE == "init" ]; then
    echo build type INIT 
    ./init_start.sh "$@"
fi

if [ $BUILD_TYPE == "validator" ]; then
    echo build type VALIDATOR 
    ./init_validator_secondary.sh "$@"
fi

if [ $BUILD_TYPE == "seed" ]; then
    echo build type VALIDATOR 
    ./init_validator_seed.sh "$@"
fi

if [ $BUILD_TYPE == "key" ]; then
    echo build type KEY 
    ./init_key.sh "$@"
fi
