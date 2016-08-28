# Builds the Widget Service using Spring Boot with Docker

FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER Gary A. Stafford <garystafford@rochester.rr.com>
ENV REFRESHED_AT 2016-08-28 16:45:13

VOLUME /tmp
ADD widget-service-0.1.0.jar /app.jar
RUN sh -c 'touch /app.jar' \
  && touch /widget-service.log

#########################################################################################
# below from:
#   https://github.com/spujadas/elk-docker/blob/master/nginx-filebeat/Dockerfile
#   https://hub.docker.com/r/zot24/filebeat/~/dockerfile/
#########################################################################################

### install Filebeat
ENV FILEBEAT_SRC_SHA1=3fde7f5f5ea837140965a193bbb387c131c16d9c \
    FILEBEAT_VERSION=1.2.3

RUN set -ex \
  && apk --no-cache add --virtual .build-dependencies \
    curl \
  \
  && curl -fsSL http://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz -o /tmp/filebeat.tar.gz \
  \
  && cd /tmp \
  && echo "${FILEBEAT_SRC_SHA1} *filebeat.tar.gz" | sha1sum -c - \
  && tar -xzf filebeat.tar.gz \
  \
  && cd filebeat-* \
  && cp filebeat /bin \
  \
  && rm -rf /tmp/filebeat*
  # \
  # && apk del .build-dependencies

### configure Filebeat
# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml
ADD filebeat.template.json /etc/filebeat/filebeat.template.json

# hack because elk was resolving to wrong IP of 198.105.244.228?
RUN echo $(getent hosts elk) >> /etc/hosts

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

### start Filebeat
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
