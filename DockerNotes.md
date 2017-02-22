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

export CONSUL_SERVER_URL=192.168.99.104

export WIDGET_PROFILE=docker-local && \
docker stack deploy --compose-file=docker-compose.yml widget_stack


docker stack ls
docker stack ps widget_stack

dig +short @192.168.99.104 -p 8600 widget-service-docker-local-8030
dig +short @192.168.99.104 -p 8600 widget-service.service.consul

http PUT 192.168.99.104:8500/v1/catalog/deregister \
  Datacenter=dc1 Node=consul-server1 CheckID=service:widget-service-docker-local-8030
```
