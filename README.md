# microservice-docker-demo-widget
#### Introduction
One of a set of Java Spring Boot microservices, for an upcoming post on scaling Spring Boot microservices with the latest Docker features.

#### Technologies
* Java
* Spring Boot
* Gradle
* MongoDB
* Spring Cloud Config Server
* Spring Cloud Netflix Eureka

#### Commands
```bash
# drop existing database
mongo
> use widgets
> db.widget.find()
> db.dropDatabase()
```

```bash
# import sample data
mongoimport --db widgets --collection widget --type json --jsonArray \
    --file /Users/gstaffo/IdeaProjects/widget-docker-demo/widget/src/main/resources/data/widget_data.json
```

```bash
# build and start service
./gradlew clean build && \
  java -jar -Dspring.profiles.active=development \
    build/libs/widgets-service-0.0.1-SNAPSHOT.jar

# production
./gradlew clean build && \
  java -jar -Dspring.profiles.active=production \
    build/libs/widgets-service-0.0.1-SNAPSHOT.jar
```

```bash
# test service
curl -i -X POST -H "Content-Type:application/json" -d '{
  "product_id": "N212QZOD9B",
  "name": "Pentwist",
  "color": "Gray",
  "size": "Huge",
  "price": 75,
  "inventory": 5,
  "preview": "https://s3.amazonaws.com/widgets-microservice-demo/N212QZOD9B.png"
}' http://localhost:8030/widgets

curl -i -X POST -H "Content-Type:application/json" -d '{
  "product_id": "N43WV5234S",
  "name": "Zapster",
  "color": "Green",
  "size": "Tiny",
  "price": 5,
  "inventory": 4,
  "preview": "https://s3.amazonaws.com/widgets-microservice-demo/N43WV5234S.png"
}' http://localhost:8030/widgets

curl -i -X GET http://localhost:8030/widgets | prettyjson
```
