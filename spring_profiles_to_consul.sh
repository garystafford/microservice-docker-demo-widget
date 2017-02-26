#!/bin/sh

# Stores the Widget service’s Spring Profiles in Consul’s hierarchical key/value store

set -e

docker-machine env manager1
eval $(docker-machine env manager1)

CONSUL_SERVER=$(docker-machine ip $(docker node ls | grep Leader | awk '{print $3}'))

KEY="config/widget-service/data"
VALUE="consul-configs/default.yaml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}

KEY="config/widget-service/docker-local/data"
VALUE="consul-configs/docker-local.yaml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}

KEY="config/widget-service/docker-production/data"
VALUE="consul-configs/docker-production.yaml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}
