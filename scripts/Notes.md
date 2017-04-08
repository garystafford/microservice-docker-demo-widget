# Widget / MongoDB Stack

Helpful commands

```bash
docker-machine env manager1
eval $(docker-machine env manager1)

sh deploy_stack.sh
docker stack ps widget_stack --no-trunc

docker stack rm widget_stack
```

Refresh Widget service after changing active Spring Profile in Consul
For example, changing logging level of in Consul

```bash
HOST_IP=$(docker-machine ip worker2)
curl -X POST "http://${HOST_IP}:8030/refresh"
```
