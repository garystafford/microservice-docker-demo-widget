# Builds the Widget Service MAINTAINER Gary A. Stafford <garystafford@rochester.rr.com>
ENV REFRESHED_AT 2016-07-30

FROM frolvlad/alpine-oraclejdk8:slim
VOLUME /tmp
ADD widget-service-0.1.0.jar /app.jar
RUN sh -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

#########################################################################################
# below from https://github.com/spujadas/elk-docker/blob/master/nginx-filebeat/Dockerfile
#########################################################################################

### install Filebeat
RUN curl -L -O https://download.elastic.co/beats/filebeat/filebeat_1.0.1_amd64.deb \
 && dpkg -i filebeat_1.0.1_amd64.deb \
 && rm filebeat_1.0.1_amd64.deb

### configure Filebeat
# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

### start Filebeat
ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
