# Widget / MongoDB Stack

Helpful commands

```bash
docker-machine env manager1
eval $(docker-machine env manager1)

docker stack rm widget_stack
docker stack ps widget_stack --no-trunc

sh deploy_stack.sh
```

Refresh Spring service after changing logging level of in Consul

```bash
HOST_IP=$(docker-machine ip worker2)
curl -X POST "http://${HOST_IP}:8030/refresh"
```
