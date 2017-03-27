#!/bin/bash

#Getting parameter variables
OSIRIS_VIRTUALSENSORNET_VERSION=${1:-1.6.0}
IMAGE_NAME=${2:-alpine-virtualsensornet-omcp}

POSTGRESQL_CONTAINER_NAME=${3:-virtualsensornet-postgresql}
POSTGRESQL_IP=${4:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${POSTGRESQL_CONTAINER_NAME})}
POSTGRESQL_PORT=${5:-5432}
VIRTUALSENSORNET_DBNAME=${6:-virtualsensornet}
POSTGRESQL_USERNAME=${7:-postgres}
POSTGRESQL_PASSWORD=${8:-postgres}

export PGPASSWORD='postgres'
psql -h ${POSTGRESQL_IP} -p ${POSTGRESQL_PORT} -U postgres --command='\q' > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: The PostgreSQL container could not be found with detected IP Address [${POSTGRESQL_IP}] and default port [${POSTGRESQL_PORT}]."
  echo "Please provide the PostgreSQL IP Address on Network..."
  echo
  read POSTGRESQL_IP
  psql -h ${POSTGRESQL_IP} -p ${POSTGRESQL_PORT} -U postgres --command='\q' > /dev/null
  if [ $? -ne 0 ]
  then
    echo "ERROR: Could not connect to PostgreSQL with provided IP Address [${POSTGRESQL_IP}]. Aborted."
    exit 1
  fi
  echo "INFO: PostgreSQL container found. OK."
fi
unset PGPASSWORD

RABBITMQ_CONTAINER_NAME=${9:-osiris-rabbitmq}
RABBITMQ_IP=${10:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${RABBITMQ_CONTAINER_NAME})}
RABBITMQ_PORT=5672
RABBITMQ_ADMIN_PORT=15672
RABBITMQ_USERNAME=${11:-guest}
RABBITMQ_PASSWORD=${12:-guest}
OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME=VirtualSensorNet-${OSIRIS_VIRTUALSENSORNET_VERSION}.jar

wget -qO- http://${RABBITMQ_IP}:${RABBITMQ_ADMIN_PORT}/ > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: The RabbitMQ container could not be found with detected IP Address [${RABBITMQ_IP}] and default port [${RABBITMQ_PORT}]. Aborted."
  echo "Please provide the RabbitMQ IP Address on Network..."
  echo
  read RABBITMQ_IP
  wget -qO- http://${RABBITMQ_IP}:${RABBITMQ_ADMIN_PORT}/ > /dev/null
  if [ $? -eq 0 ]
  then
    echo "ERROR: Could not connect to RabbitMQ with providaded IP Address [${RABBITMQ_IP}]. Aborted."
    exit 1
  fi
  echo "INFO: RabbitMQ container found. OK."
fi

#Generate the virtualsensornet configuration file
echo 'postgres.server.db='${VIRTUALSENSORNET_DBNAME} > config.properties
echo 'postgres.server.ip='${POSTGRESQL_IP} >> config.properties
echo 'postgres.server.port='${POSTGRESQL_PORT} >> config.properties
echo 'postgres.user.name='${POSTGRESQL_USERNAME} >> config.properties
echo 'postgres.user.pass='${POSTGRESQL_PASSWORD} >> config.properties
echo 'rabbitmq.server.ip='${RABBITMQ_IP} >> config.properties
echo 'rabbitmq.user.name='${RABBITMQ_USERNAME} >> config.properties
echo 'rabbitmq.user.pass='${RABBITMQ_PASSWORD} >> config.properties

#Check if the .jar file exists
JAR_FILE=./../../virtualsensornet/${OSIRIS_VIRTUALSENSORNET_VERSION}/${OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME}
if [ ! -e ${JAR_FILE} ]
then
  echo "ERROR: VirtualSensorNet jar file [${OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME}] could not be found"
  exit 1
fi

#copy the latest version that will be deployed
cp ${JAR_FILE} ./VirtualSensorNet.jar && chmod +x VirtualSensorNet.jar
if [ $? -ne 0 ]
then
  echo "ERROR: Failed to obtain VirtualSensorNet module .jar file ${OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME}."
  exit 1
fi
