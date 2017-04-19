#!/bin/sh

# Runs all project scripts...

set -e

echo "Sending Widget Spring Profiles to Consul..."
sh ./profiles_to_consul.sh

echo "Deploying Stack: Widget, MongoDB..."
sh ./stack_deploy.sh

echo "Waiting for Stack to be ready..."
sh ./stack_validate.sh

echo "Seeding MongoDB with sample Widget database..."
sh ./seed_widgets.sh

echo "Evaluating manager1..."
eval $(docker-machine env manager1)
