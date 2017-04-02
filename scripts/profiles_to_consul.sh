#!/bin/sh

# Stores the Widget service’s Spring Profiles in Consul’s hierarchical key/value store

set -e

docker-machine env manager1
eval $(docker-machine env manager1)

CONSUL_SERVER=$(docker-machine ip $(docker node ls | grep Leader | awk '{print $3}'))

# default profile
KEY="config/widget-service/data"
VALUE="consul-configs/default.yml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}

echo "default profile complete..."

# docker-local profile
KEY="config/widget-service,docker-local/data"
VALUE="consul-configs/docker-local.yml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}

echo "docker-local profile complete..."

# docker-production profile
KEY="config/widget-service,docker-production/data"
VALUE="consul-configs/docker-production.yml"
curl -X PUT --data-binary @${VALUE} \
  -H "Content-type: text/x-yaml" \
  ${CONSUL_SERVER:localhost}:8500/v1/kv/${KEY}

echo "docker-production profile complete..."

echo "Script completed..."
