# Builds the Widget Service

FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER Gary A. Stafford <garystafford@rochester.rr.com>
ENV REFRESHED_AT 2016-08-13

VOLUME /tmp
ADD widget-service-0.1.0.jar /app.jar
RUN sh -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

#########################################################################################
# below from:
#   https://github.com/spujadas/elk-docker/blob/master/nginx-filebeat/Dockerfile
#   https://hub.docker.com/r/zot24/filebeat/~/dockerfile/
#########################################################################################

### install Filebeat
ENV FILEBEAT_SRC_SHA1=3fde7f5f5ea837140965a193bbb387c131c16d9c \
    FILEBEAT_VERSION=1.2.3

### configure Filebeat
# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

### start Filebeat
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
