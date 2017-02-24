```bash
docker-machine env manager1
eval $(docker-machine env manager1)

docker stack rm widget_stack

export CONSUL_SERVER_URL=192.168.99.109 && \
export WIDGET_PROFILE=docker-local && \
docker stack deploy --compose-file=docker-compose.yml widget_stack


docker stack ls
docker stack ps widget_stack

docker-machine env worker1
eval $(docker-machine env worker1)


dig +short @192.168.99.104 -p 8600 widget-service-docker-local-8030
dig +short @${CONSUL_SERVER_URL} -p 8600 widget-service.service.consul

http PUT 192.168.99.104:8500/v1/catalog/deregister \
  Datacenter=dc1 Node=consul-server1 CheckID=service:widget-service-docker-local-8030
```


https://blog.bugsnag.com/container-orchestration-with-docker-swarm-mode/
https://github.com/jhipster/consul-config-loader/blob/master/config/application.yml
http://www.kennybastani.com/2015/07/spring-cloud-docker-microservices.html
