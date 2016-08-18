#!/bin/sh

# curl -XPUT 'http://elk:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
nohup filebeat -c /etc/filebeat/filebeat.yml -e &

java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
