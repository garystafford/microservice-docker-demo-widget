###### Build:  
![https://travis-ci.org/garystafford/microservice-docker-demo-widget.svg?branch=master](https://travis-ci.org/garystafford/microservice-docker-demo-widget.svg?branch=master)  [![Build Status](https://semaphoreci.com/api/v1/garystafford/microservice-docker-demo-widget/branches/master/badge.svg)](https://semaphoreci.com/garystafford/microservice-docker-demo-widget)

###### Docker Hub:  
[![](https://images.microbadger.com/badges/version/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own version badge on microbadger.com")  [![](https://images.microbadger.com/badges/image/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own image badge on microbadger.com")

# Spring Boot Widget Microservice

#### Introduction
The Widget microservice is one of a set of Java Spring Boot services, for an upcoming post on scaling microservices with the latest Spring and Docker features. Widgets are inanimate objects that users purchase with points. Widgets have particular physical characteristics, such as product id, name, color, size, and current price. An inventory of widgets is stored in the `widgets` MongoDB database.

The post and this associated project present two methods of building the Docker Image containing the Spring Boot service JAR. The Docker Image can be built locally, with Gradle, using Spring Boot with Docker, and pushed directly to DockerHub. Alternately, the Docker Image can be built using a typical continuous integration (CI) pipeline. The pipeline consists of GitHub, Gradle, Travis CI and/or Semaphore, and DockerHub, using DockerHub's automated Dockerfile build feature.


#### Technologies
* Java
* Spring Boot
* Gradle
* MongoDB
* Spring Cloud Config Server (migrating to Consul)
* Spring Cloud Netflix Eureka
* Spring Boot with Docker
* The Elastic Stack (Elasticsearch, Kibana, Logstash, and Beats)
* DockerHub
* Travis CI

#### MongoDB
Import sample data to MongoDB locally
```bash
# set your project root
PROJECT_ROOT='/Users/gstaffo/Documents/projects/widget-docker-demo'

mongoimport --host localhost:27017 --db widgets --collection widget \
  --type json --jsonArray \
  --file ${PROJECT_ROOT}/widget-service/src/main/resources/data/data.json
```

Common MongoDB commands
```bash
mongo # use mongo shell
> show dbs
> use widgets
> db.widget.find()
> db.dropDatabase()
```

#### Build Service Locally
Note to build, test, and run the Widget service locally, outside of a Docker container, both the [Spring Cloud Config Server](https://github.com/garystafford/microservice-docker-demo-config-server) and [Netflix Eureka](https://github.com/garystafford/microservice-docker-demo-eureka-server) projects must be started first.
```bash
./gradlew clean build && \
  java -jar -Dspring.profiles.active=local \
  build/libs/widget-service-0.1.0.jar
```

#### Test Service Locally
Create a new widget
```bash
curl -i -X POST -H "Content-Type:application/json" -d '{
  "product_id": "N212QZOD9B",
  "name": "Pentwist",
  "color": "Gray",
  "size": "Huge",
  "price": 75,
  "inventory": 5,
  "preview": "https://s3.amazonaws.com/widgets-microservice-demo/N212QZOD9B.png"
}' http://localhost:8030/widgets
```
Create another new widget
```bash
curl -i -X POST -H "Content-Type:application/json" -d '{
  "product_id": "N43WV5234S",
  "name": "Zapster",
  "color": "Green",
  "size": "Tiny",
  "price": 5,
  "inventory": 4,
  "preview": "https://s3.amazonaws.com/widgets-microservice-demo/N43WV5234S.png"
}' http://localhost:8030/widgets
```

Get all widgets
```bash
curl -i -X GET http://localhost:8030/widgets | prettyjson
```

#### Building Docker Images with Spring Boot with Docker
Change the `group` key in `build.gradle` to you DockerHub repository name, such as
```text
group = '<your_dockerhub_repo_name>'
```

Login to your Docker Hub account from command line
```bash
docker login
```

Build the Docker Image containing the Spring Boot service JAR
```bash
./gradlew clean build buildDocker
```
If `push = true` was set in the `buildDocker` method of the `build.gradle`, the images
is automatically pushed to your DockerHub account.

If you chose to set `push = false` within the `buildDocker` method of the `build.gradle`,
then use the following type of command to push the new Docker Image to DockerHub, after it is built.
```bash
docker push <your_dockerhub_repo_name>/widget-service:latest
```

Create and run a Docker container
```bash
docker run -e "SPRING_PROFILES_ACTIVE=production" -p 8030:8030 -t garystafford/widget-service
```

Import sample data to MongoDB running in the Docker container
```bash
# set your project root
PROJECT_ROOT='/Users/gstaffo/Documents/projects/widget-docker-demo'

mongoimport --host localhost:27018 --db widgets --collection widget \
  --type json --jsonArray \
  --file ${PROJECT_ROOT}/widget-service/src/main/resources/data/data.json
```

#### References
* [https://github.com/Transmode/gradle-docker](https://github.com/Transmode/gradle-docker)
