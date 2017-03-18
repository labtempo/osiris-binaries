#!/bin/bash

#Getting parameter variables
OSIRIS_SENSORNET_VERSION=${1:-1.6.0}
IMAGE_NAME=${2:-alpine-sensornet-omcp}

POSTGRESQL_CONTAINER_NAME=${3:-sensornet-postgresql}
POSTGRESQL_IP=${4:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${POSTGRESQL_CONTAINER_NAME})}
POSTGRESQL_PORT=${5:-5432}
SENSORNET_DBNAME=${6:-OsirisSN}
POSTGRESQL_USERNAME=${7:-postgres}
POSTGRESQL_PASSWORD=${8:-postgres}

psql -h ${POSTGRESQL_IP} -p ${POSTGRESQL_PORT} -U postgres --command='\q' > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: PostgreSQL IP Address not found. Aborted."
  exit 1
fi

RABBITMQ_CONTAINER_NAME=${9:-osiris-rabbitmq}
RABBITMQ_IP=${10:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${RABBITMQ_CONTAINER_NAME})}
RABBITMQ_PORT=5672
RABBITMQ_ADMIN_PORT=15672
RABBITMQ_USERNAME=${11:-guest}
RABBITMQ_PASSWORD=${12:-guest}
OSIRIS_SENSORNET_JAR_FILE_NAME=SensorNet-${OSIRIS_SENSORNET_VERSION}.jar

wget http://${RABBITMQ_IP}:${RABBITMQ_ADMIN_PORT}/ > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: RabbitMQ IP Address not found. Aborted."
  exit 1
fi

#Generate the sensornet configuration file
echo 'postgres.server.db='${SENSORNET_DBNAME} > config.properties
echo 'postgres.server.ip='${POSTGRESQL_IP} >> config.properties
echo 'postgres.server.port='${POSTGRESQL_PORT} >> config.properties
echo 'postgres.user.name='${POSTGRESQL_USERNAME} >> config.properties
echo 'postgres.user.pass='${POSTGRESQL_PASSWORD} >> config.properties
echo 'rabbitmq.server.ip='${RABBITMQ_IP} >> config.properties
echo 'rabbitmq.user.name='${RABBITMQ_USERNAME} >> config.properties
echo 'rabbitmq.user.pass='${RABBITMQ_PASSWORD} >> config.properties

#Check if the .jar file exists
JAR_FILE=./../../sensornet/${OSIRIS_SENSORNET_VERSION}/${OSIRIS_SENSORNET_JAR_FILE_NAME}
if [ ! -e ${JAR_FILE} ]
then
  echo "ERROR: SensorNet jar file [${OSIRIS_SENSORNET_JAR_FILE_NAME}] could not be found"
  exit 1
fi

#copy the latest version that will be deployed
cp ${JAR_FILE} ./SensorNet.jar || echo "ERROR: failed to obtain the SensorNet.jar" && exit 1
