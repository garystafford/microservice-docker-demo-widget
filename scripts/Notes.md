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

docker container inspect  $(docker ps | grep fluent | awk '{print $NF}')

docker exec -it  $(docker ps | grep fluent | awk '{print $NF}') cat /fluentd/log/docker.log && date -u
docker logs  $(docker ps | grep fluent | awk '{print $NF}') --follow
```

curl -X POST http://192.168.99.113:8030/refresh

http://www.fluentd.org/guides/recipes/docker-logging
https://github.com/fluent/fluentd-docker-image

sudo su -
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
docker-machine ssh worker3 sudo sysctl -w vm.max_map_count=262144
