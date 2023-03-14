#!/bin/bash

# ssh -i "entangle.pem" ubuntu@ec2-34-239-248-230.compute-1.amazonaws.com
HOSTS="ubuntu@ec2-34-239-248-230.compute-1.amazonaws.com"
SCRIPT="docker stop \$(docker ps -q); cd Node; pwd; ./start_validator_container.sh entangle 34.239.248.230; sleep 20; echo 1\$(docker ps -q)1"
for HOSTNAME in ${HOSTS} ; do
    ssh -i "entangle.pem" ${HOSTNAME} "${SCRIPT}"
done
