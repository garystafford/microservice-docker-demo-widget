Build:  
[![Build Status](https://travis-ci.org/garystafford/microservice-docker-demo-widget.svg?branch=master)](https://travis-ci.org/garystafford/microservice-docker-demo-widget)

Docker Hub (_status using [MicroBadger](https://microbadger.com/#/)_):  
[![](https://images.microbadger.com/badges/version/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own image badge on microbadger.com")

# Spring Boot Widget Microservice

## Introduction

The Widget service is a simple Spring Boot microservice, backed by MongoDB. It is easily deployed as a containerized application. This repository has been developed for the posts, [Distributed Service Configuration with Consul, Spring Cloud, and Docker](http://wp.me/p1RD28-36b) and [Streaming Docker Logs to the Elastic Stack using Fluentd](http://wp.me/p1RD28-3B3). The first post explores the use of HashiCorp Consul for distributed configuration of containerized Spring Boot microservices, deployed to a Docker swarm cluster. The second post adds the use of Fluentd for streaming Docker logs to the Elastic Stack.

In the first half of the post, we provision a series of VMs, build a Docker swarm cluster on top of those VMs, and install Consul and Registrator on each swarm host. In the second half of the post, we configure and deploy multiple, containerized instances of a Spring Boot microservice, backed by MongoDB, to the swarm cluster, using Docker Compose version 3\. The final objective of the post is have all the deployed services registered with Consul, via Registrator, and the Spring Boot service's configuration being provided dynamically by Consul, at service startup.

In the second post, we use Fluentd to stream Docker logs from our containerized Spring Boot service instances and MongoDB, to the Elastic Stack. Fluentd and Docker’s native logging driver for Fluentd makes it easy to stream Docker logs from multiple running containers to the Elastic stack.

### Objectives

1. Provision a series of virtual machine hosts, using Docker Machine and Oracle VirtualBox
2. Provide distributed and highly available cluster management and service orchestration, using Docker swarm mode
3. Provide distributed and highly available service discovery, health checking, and a hierarchical key/value store, using HashiCorp Consul
4. Provide automatic service registration of containerized services using Registrator, Glider Labs' service registry bridge for Docker
5. Provide distributed configuration for containerized services using Consul and Pivotal's Spring Cloud Consul Config
6. Provide centralized logging for containerized services using FluentD and the Elastic Stack (aka ELK)
7. Deploy multiple instances of a containerized Spring Boot microservice, backed by MongoDB, to the swarm cluster, using Docker Compose version 3.

### Technologies

- Docker
- Docker Compose (v3)
- Docker Hub
- Docker Machine
- Docker swarm mode
- Docker Swarm Visualizer (Mano Marks)
- Elastic Stack (aka ELK)
- FluentD
- Glider Labs Registrator
- Gradle
- HashiCorp Consul
- Java 8
- MongoDB
- Oracle VirtualBox VM Manager
- Spring Boot
- Spring Cloud Consul Config
- Travis CI

## Quick Start for Local Development

The Widget service runs on port 8030.

The service requires MongoDB to be pre-installed and running locally on port `27017`. The service will create the `widgets` database on startup.

The service also requires Consul to be pre-installed and running on ${CONSUL_SERVER_URL} locally on port `8500`. Consul needs to contain the widget's default profile, at minimum.

To clone, build, test, and run the service locally:

```bash
# clone the directory
git clone --depth 1 --branch fluentd \
  https://github.com/garystafford/microservice-docker-demo-widget.git
cd microservice-docker-demo-widget

# optional: import some seed data into MongoDB
mongoimport --host localhost:27017 \
  --db widgets --collection widget \
  --type json --jsonArray \
  --file widget-service/src/main/resources/data/data.json

# build and start the service
# with the default spring profile from consul
./gradlew clean cleanTest build
java -jar build/libs/widget-service-0.2.0.jar
```

## Using the Service Locally

Widgets represent inanimate objects that users purchase with points. Widgets have particular physical characteristics, such as product id, name, color, size, and current price. An inventory of widgets is stored in the `widgets` MongoDB database. They can created, modified, deleted, and read from MongoDB, by the service.

Create a new widget:

```bash
curl -i -X POST -H "Content-Type:application/json" -d \
  '{
    "product_id": "N212QZOD9B",
    "name": "Pentwist",
    "color": "Gray",
    "size": "Huge",
    "price": 75,
    "inventory": 5,
    "preview": "<no_preview_available>"
  }' \
  http://localhost:8030/widgets
```

Create another new widget:

```bash
curl -i -X POST -H "Content-Type:application/json" -d \
  '{
    "product_id": "N43WV5234S",
    "name": "Zapster",
    "color": "Green",
    "size": "Tiny",
    "price": 5,
    "inventory": 4,
    "preview": "<no_preview_available>"
  }' \
  http://localhost:8030/widgets
```

Get all widgets (command uses `[jq](https://stedolan.github.io/jq/)`)

```bash
curl -i -X GET http://localhost:8030/widgets | jq .
```

### Project Scripts

#### Stand-Up Project

```bash
cd microservice-docker-demo-widget/scripts/
sh ./run_all.sh # single uber-script

# alternately, run the individual scripts
sh ./profiles_to_consul.sh # pushes widget spring profiles to consul
sh ./stack_deploy.sh # deploys widget and mongodb containers
sh ./stack_validate.sh # waits/tests for all containers to start
sh ./seed_widgets.sh # creates a series of sample widget entries
```
