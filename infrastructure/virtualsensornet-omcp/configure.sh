#!/bin/bash

#Getting parameter variables
OSIRIS_VIRTUALSENSORNET_VERSION=${1:-1.6.0}
IMAGE_NAME=${2:-alpine-virtualsensornet-omcp}

POSTGRESQL_CONTAINER_NAME=${3:-osiris-virtualsensornet-postgresql}
POSTGRESQL_IP=${4:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${POSTGRESQL_CONTAINER_NAME})}
echo "detected POSTGRESQL_IP = ${POSTGRESQL_IP}"
POSTGRESQL_PORT=${5:-5432}
VIRTUALSENSORNET_DBNAME=${6:-virtualsensornet}
POSTGRESQL_USERNAME=${7:-postgres}
POSTGRESQL_PASSWORD=${8:-postgres}



RABBITMQ_CONTAINER_NAME=${9:-osiris-rabbitmq}
RABBITMQ_IP=${10:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${RABBITMQ_CONTAINER_NAME})}
echo "detected RABBITMQ_IP = ${RABBITMQ_IP}"
RABBITMQ_PORT=5672
RABBITMQ_ADMIN_PORT=15672
RABBITMQ_USERNAME=${11:-guest}
RABBITMQ_PASSWORD=${12:-guest}
OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME=VirtualSensorNet-${OSIRIS_VIRTUALSENSORNET_VERSION}.jar



#Generate the virtualsensornet configuration file
rm config.properties
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
