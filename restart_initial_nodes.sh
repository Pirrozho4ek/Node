#!/bin/bash

INITIAL_HOST="ubuntu@ec2-34-239-248-230.compute-1.amazonaws.com"
INITIAL_IP=34.239.248.230
INITIAL_SCRIPT="docker stop \$(docker ps -q); \
        cd Node; \
        git pull; \
        ./start_initial_container.sh entangle $INITIAL_IP; \
        sleep 10; \
        sudo docker cp \$(docker ps -q):/genesis.json \$HOME/genesis.json; \
        sudo docker cp \$(docker ps -q):/env_seeds \$HOME/env_seeds"

ssh -i "entangle.pem" ${INITIAL_HOST} "${INITIAL_SCRIPT}"

scp -i "entangle.pem" $INITIAL_HOST:/home/ubuntu/genesis.json ./genesis.json
scp -i "entangle.pem" $INITIAL_HOST:/home/ubuntu/env_seeds ./env_seeds

git add --all
git commit -a -m "Restart initial node"
git push origin $(git symbolic-ref --short HEAD)


# SECONDARY_HOSTS="ubuntu@ec2-34-239-248-230.compute-1.amazonaws.com"

# # A pretend Python dictionary with bash 3 
# SECONDARY_NODES_ARRAY=( 
#         "cow:moo"
#         "dinosaur:roar"
#         "bird:chirp"
#         "bash:rock" 
#         )

# for machine in "${SECONDARY_NODES_ARRAY[@]}" ; do
#     HOST=${machine%%:*}
#     IP_ADDRESS=${machine#*:}
#     printf "%s likes to %s.\n" "$HOST" "$IP_ADDRESS"
# done

# for SECONDARY_HOSTS in ${HOSTS} ; do
#     ssh -i "entangle.pem" ${HOSTNAME} "${SCRIPT}"
# done