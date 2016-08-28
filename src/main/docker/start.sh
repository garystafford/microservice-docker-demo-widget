#!/bin/sh

# hack because elk was resolving to wrong IP of 198.105.244.228?
echo $(getent hosts elk) >> /etc/hosts

curl -XPUT 'http://elk:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
filebeat -c /etc/filebeat/filebeat.yml -e &

java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
