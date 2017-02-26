```bash
docker-machine env manager1
eval $(docker-machine env manager1)

# create overlay network
docker network create \
  --driver overlay \
  --subnet=10.0.0.0/16 \
  --ip-range=10.0.11.0/24 \
  --opt encrypted \
  --attachable=true \
  widget_overlay_net

# create data volume
docker volume create --name=widget_data_vol

docker stack rm widget_stack

export CONSUL_SERVER_URL=$(docker-machine ip $(docker node ls | grep Leader | awk '{print $3}')) && \
export WIDGET_PROFILE=docker-local && \
docker stack deploy --compose-file=docker-compose.yml widget_stack

docker stack ls
docker stack ps widget_stack

docker-machine env worker1
eval $(docker-machine env worker1)
docker logs $(docker ps | grep widget_stack_widget | awk '{print $1}')

http $(docker-machine ip worker1):8030/env

dig +short @192.168.99.104 -p 8600 widget-service-docker-local-8030
dig +short @${CONSUL_SERVER_URL} -p 8600 widget-service.service.consul

http PUT 192.168.99.104:8500/v1/catalog/deregister \
  Datacenter=dc1 Node=consul-server1 CheckID=service:widget-service-docker-local-8030
```


https://blog.bugsnag.com/container-orchestration-with-docker-swarm-mode/
https://github.com/jhipster/consul-config-loader/blob/master/config/application.yml
http://www.kennybastani.com/2015/07/spring-cloud-docker-microservices.html
https://cloud.spring.io/spring-cloud-consul/#spring-cloud-consul-config


KEY="config/widget-service/data"
VALUE="/Users/gstaffo/Documents/projects/widget-docker-demo/widget-service/consul-configs/default.yaml"
curl -X POST --data-binary @${VALUE} -H "Content-type: text/x-yaml" ${CONSUL_SERVER_IP}:8500/v1/kv/${KEY}

curl -H "Content-Type: application/json" -X POST -d '{"username":"xyz","password":"xyz"}' ${CONSUL_SERVER_IP}:8030/widget
