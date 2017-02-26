#!/bin/sh

# Deploys the widget_stack to the Docker swarm cluster

set -e

docker-machine env manager1
eval $(docker-machine env manager1)

CONSUL_SERVER=$(docker-machine ip $(docker node ls | grep Leader | awk '{print $3}'))
WIDGET_PROFILE=docker-local

docker stack deploy --compose-file=docker-compose.yml widget_stack

sleep 5

docker stack ls
docker stack ps widget_stack
