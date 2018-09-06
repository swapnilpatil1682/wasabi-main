###############################################################################
# Docker image for Wasabi-Migration
###############################################################################\

FROM ubuntu:16.04
MAINTAINER Swapnil Patil <Swapnil.patil1682@gmail.com>


RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install git -y  && \ 
    apt-get install curl -y  && \
    apt-get install wget -y  && \
    apt-get clean


COPY wasabi /usr/local/wasabi

ADD wasabi /usr/local/wasabi

RUN echo "******************************************************************************************"
RUN ls -ltra /usr/local/wasabi
RUN echo "******************************************************************************************"

#Update
RUN apt-get update

#Install JAVA
RUN apt-get install -y default-jdk
RUN cp /etc/environment /tmp/environment
RUN chmod 666 /tmp/environment
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /tmp/environment
RUN cp /tmp/environment /etc/environment
RUN rm -rf /tmp/environment

# Install netcat 
RUN apt-get install netcat-traditional

WORKDIR /usr/local/wasabi/

# Create required keyspaces in cassandra 

ENV CASSANDRA_KEYSPACE_PREFIX wasabi 
ENV CQLSH_USERNAME ""
ENV CQLSH_PASSWORD ""
ENV CQLSH_HOST cassandra.wasabi
ENV CQLSH_VERSION 3.2.1
ENV CASSANDRA_PORT 9042

# Install python pip and run the script.

RUN apt-get install python-pip -y
RUN apt-get install netcat-traditional
RUN chmod +x /usr/local/wasabi/bin/docker/create_keyspace.sh 

RUN pip install cqlsh==5.0.3 && \
    cp /usr/local/bin/cqlsh /usr/local/bin/cqlsh4 && \
    sed -i '/DEFAULT_PROTOCOL_VERSION = 4/c\DEFAULT_PROTOCOL_VERSION = 3' /usr/local/bin/cqlsh


RUN echo "******************************************************************************************"

RUN ls /usr/local/wasabi/bin/docker/

#RUN cd /usr/local/wasabi/bin/docker && ./create_keyspace.sh 
RUN echo "******************************************************************************************"



RUN echo "******************************************************************************************"
RUN apt-get install wget
RUN cd /usr/local/wasabi/ && wget https://oss.sonatype.org/content/repositories/public/com/builtamont/cassandra-migration/0.9/cassandra-migration-0.9-jar-with-dependencies.jar

ENV CASSANDRA_MIGRATION /usr/local/wasabi/cassandra-migration-0.9-jar-with-dependencies.jar
ENV MIGRATION_SCRIPT /usr/local/wasabi/modules/repository-datastax/src/main/resources/com/intuit/wasabi/repository/impl/cassandra/migration/ 

RUN chmod +x /usr/local/wasabi/bin/docker/migration.sh 
#RUN cd /usr/local/wasabi/bin/docker  && ./migration.sh 



WORKDIR /usr/local/wasabi/

RUN echo "***************"
RUN pwd
RUN echo "***************"
RUN chmod +x bin/wasabi.sh
ENTRYPOINT ["/usr/local/wasabi/bin/docker/migration.sh"]








