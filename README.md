###### Build:  
![https://travis-ci.org/garystafford/microservice-docker-demo-widget.svg?branch=master](https://travis-ci.org/garystafford/microservice-docker-demo-widget.svg?branch=master)

###### Docker Hub:  
[![](https://images.microbadger.com/badges/version/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own version badge on microbadger.com")  [![](https://images.microbadger.com/badges/image/garystafford/microservice-docker-demo-widget.svg)](http://microbadger.com/images/garystafford/microservice-docker-demo-widget "Get your own image badge on microbadger.com")

# microservice-docker-demo-widget

#### Introduction
One of a set of Java Spring Boot services, for an upcoming post on scaling Spring Boot microservices with the latest Spring and Docker features.

#### Technologies
* Java
* Spring Boot
* Gradle
* MongoDB
* Consul
* Spring Cloud Config Server (migrating to Consul)
* Spring Cloud Netflix Eureka
* Spring Boot with Docker

#### MongoDB
Common MongoDB Commands
```bash
mongo # use mongo shell
> show dbs
> use widgets
> db.widget.find()
> db.dropDatabase()
```

Import sample data to MongoDB locally
```bash
PROJECT_ROOT='/Users/gstaffo/Documents/projects/widget-docker-demo'
mongoimport --host localhost:27017 --db widgets --collection widget \
  --type json --jsonArray \
  --file ${PROJECT_ROOT}/widget-service/src/main/resources/data/data.json
```

#### Build Service
Build and start service locally
```bash
./gradlew clean build && \
  java -jar -Dspring.profiles.active=local \
  build/libs/widget-service-0.1.0.jar
```

#### Test Service
Create new widget document
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

# create another new widget document
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

Get widgets
```bash
curl -i -X GET http://localhost:8030/widgets | prettyjson
```

#### Docker
Login to Docker Hub first
```bash
docker login
```

Build the Docker Image containing service jar. The profile will be used to run
 Docker container not create Docker Image
```bash
./gradlew clean build buildDocker --info
```

If you chose to set `push = false` within the `buildDocker` method,
then use the following command to push the image to DockerHub
```bash
docker push garystafford/widget-service:latest
```

Create and run a Docker container
```bash
docker run -e "SPRING_PROFILES_ACTIVE=production" -p 8030:8030 -t garystafford/widget-service
```

Import sample data to MongoDB running in container
_Doesn't work right now even with sudo - error inserting documents: not authorized_
```bash
PROJECT_ROOT='/Users/gstaffo/Documents/projects/widget-docker-demo'
mongoimport --host localhost:27018 --db widgets --collection widget \
  --type json --jsonArray \
  --file ${PROJECT_ROOT}/widget-service/src/main/resources/data/data.json
```

#### References
* [https://github.com/Transmode/gradle-docker](https://github.com/Transmode/gradle-docker)
