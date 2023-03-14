#!/bin/bash
USERNAME=someUser
HOSTS="ubuntu@ec2-34-239-248-230.compute-1.amazonaws.com"
SCRIPT="pwd; ls"
for HOSTNAME in ${HOSTS} ; do
    ssh -i "entangle.pem" ${HOSTNAME} "${SCRIPT}"
done
