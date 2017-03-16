#!/bin/bash

echo "Building Docker image for VirtualSensorNet OMCP Server..."

#Check if docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  echo "Docker not found/installed. You need Docker in order to build the image"
  exit 1
fi

#Getting parameter variables
OSIRIS_SENSORNET_VERSION=${1:-1.6.0}
IMAGE_NAME=${2:-osiris-sensornet-omcp_development}
POSTGRESQL_IMAGE_NAME=${3:-osiris-postgresql_development}
POSTGRESQL_IP=${4:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${POSTGRESQL_IMAGE_NAME})}
RABBITMQ_IMAGE_NAME={5:-osiris-rabbitmq_development}
RABBITMQ_IP=${6:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${RABBITMQ_IMAGE_NAME})}
SENSORNET_DBNAME={7:-OsirisSN}
POSTGRESQL_PORT=${8:-5432}
POSTGRESQL_USERNAME=${9:-osiris}
POSTGRESQL_PASSWORD=${10:-osiris}
RABBITMQ_USERNAME=${11:-guest}
RABBITMQ_PASSWORD=${12:-guest}

OSIRIS_SENSORNET_JAR_FILE_NAME=SensorNet-${OSIRIS_SENSORNET_VERSION}.jar

#Check for PostgreSQL IP Address
if [ -z ${POSTGRESQL_IP} ]
then
  echo "Could not find PostgreSQL Host IP Address"
  exit 1
fi

#Check for RabbitMQ IP Address
if [ -z ${RABBITMQ_IP} ]
then
  echo "Could not find RabbitMQ Host IP Address"
  exit 1
fi

#check if the image already exists
sudo docker image ls | grep ${IMAGE_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  echo "FAILED - Docker image [${IMAGE_NAME}] already exists."
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
JAR_FILE=./../sensornet/${OSIRIS_SENSORNET_VERSION}/${OSIRIS_SENSORNET_JAR_FILE_NAME}
if [ -e ${JAR_FILE} ]
then
  echo "FAILED - VirtualSensorNet jar file [${OSIRIS_SENSORNET_JAR_FILE_NAME}] could not be found."
  exit 1
fi

#copy the latest version that will be deployed
cp ${JAR_FILE} SensorNet.jar

#Build the image
docker build -t ${IMAGE_NAME} .

#Check if it was built
if [ $? -eq 0 ]
then
  echo "SUCCESS - VirtualSensorNet image [${IMAGE_NAME}] was built successfully"
  exit 0
else
  echo "FAILED - VirtualSensorNet image [${IMAGE_NAME}] could not be built."
  exit 1
fi


