#!/bin/bash

HOST=$1
SCRIPT="\
        sudo apt-get install git; \
        sudo apt install make; \
        sudo snap install go --classic; \
        sudo apt update; \
        sudo apt install build-essential; \
        sudo apt install apt-transport-https ca-certificates curl software-properties-common; \
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; \
        sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable\"; \
        sudo apt install docker-ce; \
        sudo usermod -aG docker ubuntu"


ssh -i "entangle.pem" ${HOST} "${SCRIPT}"


