#!/bin/sh

curl -XPUT 'http://elk:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
filebeat -c /etc/filebeat/filebeat.yml -e
