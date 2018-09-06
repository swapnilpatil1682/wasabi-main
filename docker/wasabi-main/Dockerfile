###############################################################################
# Docker image for wasabi - main 
###############################################################################\
FROM ubuntu:16.04

MAINTAINER Swapnil Patil <Swapnil.patil1682@gmail.com>

ENV WASABI_MODULE wasabi-main
ENV WASABI_UI_MODULE wasabi-ui-main
ENV WASABI_PORT 8080
ENV WASABI_JMX_PORT 8090
ENV WASABI_DEBUG_PORT 8180

ENV MYSQL_HOST wasabi-mysql 
ENV NODE_HOST cassandra.wasabi

ADD wasabi /usr/local/wasabi
COPY wasabi /usr/local/wasabi

ENV WASABI_SRC_DIR /usr/local/wasabi/modules/main/target/wasabi-main-1.0.20180226051442-SNAPSHOT-development
ENV WASABI_HOME /usr/local/wasabi/modules/main/target/wasabi-main-1.0.20180226051442-SNAPSHOT-development

RUN ls /usr/local/wasabi/modules/main/target/wasabi-main-1.0.20180226051442-SNAPSHOT-development

ENV WASABI_JAVA_OPTIONS ""
ENV JDK_MAJOR_VERSION 8u131
ENV JDK_MINOR_VERSION b11
ENV JDK_VERSION ${JDK_MAJOR_VERSION}-${JDK_MINOR_VERSION}

RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install git -y  && \ 
    apt-get install curl -y  && \
    apt-get install wget -y  && \
    apt-get install sudo -y && \
    apt-get clean

RUN echo "******************************************************************************************"
RUN ls -ltra /usr/local/wasabi
RUN echo "******************************************************************************************"

#Install Maven
RUN apt-get update

#Install JAVA
RUN apt-get install -y default-jdk
RUN cp /etc/environment /tmp/environment
RUN chmod 666 /tmp/environment
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /tmp/environment
RUN cp /tmp/environment /etc/environment
RUN rm -rf /tmp/environment

RUN java -version 

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

EXPOSE ${WASABI_PORT}
EXPOSE ${WASABI_JMX_PORT}
EXPOSE ${WASABI_DEBUG_PORT}


WORKDIR /usr/local/wasabi/

# Create required keyspaces in cassandra 
ENV CASSANDRA_KEYSPACE_PREFIX wasabi 
ENV CQLSH_USERNAME ""
ENV CQLSH_PASSWORD ""
ENV CQLSH_HOST cassandra.wasabi
ENV CASSANDRA_PORT "" 

# Install python pip and run the script.
RUN apt-get install python-pip -y
RUN chmod +x /usr/local/wasabi/bin/wasabi.sh 
RUN chmod +x /usr/local/wasabi/bin/container.sh

RUN echo "******************************************************************************************"
RUN ls /usr/local/wasabi/bin/
RUN echo "******************************************************************************************"

RUN apt-get install wget

ENV CASSANDRA_MIGRATION /usr/local/wasabi/cassandra-migration-0.9-jar-with-dependencies.jar
ENV MIGRATION_SCRIPT /usr/local/wasabi/bin/docker/ 

WORKDIR /usr/local/wasabi/

RUN sed -i -e $'s/1>>.*2>&1//' ${WASABI_HOME}/bin/run 2>/dev/null;

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["wasabi"]




