```bash
docker-machine env manager1
eval $(docker-machine env manager1)

# Create overlay network
docker network create \
  --driver overlay \
  --subnet=10.0.0.0/16 \
  --ip-range=10.0.11.0/24 \
  --opt encrypted \
  --attachable=true \
  widget_overlay_net

docker stack rm widget_stack

export WIDGET_PROFILE=docker-local && \
docker stack deploy --compose-file=docker-compose.yml widget_stack

docker stack ls
docker stack ps widget_stack
```
