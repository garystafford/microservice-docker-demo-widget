# Fluentd / ELK Stack

Helpful commands

```bash
docker build -t garystafford/elk:latest .
docker push garystafford/elk:latest

docker-machine env manager1
eval $(docker-machine env manager1)

docker stack rm widget_stack
docker stack ps widget_stack --no-trunc

docker service rm widget_stack_fluentd
sh deploy_stack.sh

docker-machine env worker2
eval $(docker-machine env worker2)

docker exec -it  $(docker ps | grep fluent | awk '{print $NF}') cat /fluentd/log/docker.log && date -u
docker logs  $(docker ps | grep fluent | awk '{print $NF}') --follow
docker container inspect  $(docker ps | grep fluent | awk '{print $NF}')
```

Refresh Spring service after changing logging level of in Consul

```bash
HOST_IP=$(docker-machine ip worker2)
curl -X POST "http://${HOST_IP}:8030/refresh"
```

# References

- <http://www.fluentd.org/guides/recipes/docker-logging>
- <https://github.com/fluent/fluentd-docker-image>

# Fix VM Max Error on VM for ELK Container

```bash
docker-machine ssh worker3 sudo sysctl -w vm.max_map_count=262144
docker-machine ssh worker3 sudo sysctl -n vm.max_map_count
```
