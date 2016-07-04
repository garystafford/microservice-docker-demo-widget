# microservice-docker-demo-widget
#### Introduction
One of a set of Java Spring Boot microservices, for an upcoming post on scaling Spring Boot microservices with the latest Docker features.

#### Technologies
* Java
* Spring Boot
* Gradle
* MongoDB

#### Commands
```bash
# drop existing database
mongo
> use user-development
> db.widget.find()
> db.dropDatabase()
```

```bash
# import sample data
mongoimport --db widget-development --collection widget --type json --jsonArray \
    --file /Users/gstaffo/IdeaProjects/widget-docker-demo/widget/src/main/resources/data/widget_data.json
```

```bash
# build and start service
./gradlew clean build && \
java -jar build/libs/widget-0.0.1-SNAPSHOT.jar
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

curl -i -X PUT -H "Content-Type:application/json" -d '{
  "product_id": "N212QZOD9B",
  "name": "Pentwist",
  "color": "Gray",
  "size": "Huge",
  "price": 75,
  "inventory": 5,
  "preview": "https://s3.amazonaws.com/widgets-microservice-demo/N212QZOD9B.png"
}' http://localhost:8030/widgets/577a7c43d4c6a73786bb6dc6

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