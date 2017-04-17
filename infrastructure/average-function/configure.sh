#!/bin/bash
# configure the average.function module

#Getting parameter variables
MODULE_NAME="average.function"
JAR_VERSION=${1:-1.0.0}
IMAGE_NAME=${2:-osiris-average-function}

RABBITMQ_CONTAINER_NAME=${9:-osiris-rabbitmq}
RABBITMQ_IP=${10:-$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${RABBITMQ_CONTAINER_NAME})}
echo "detected RABBITMQ_IP = ${RABBITMQ_IP}"
RABBITMQ_PORT=5672
RABBITMQ_ADMIN_PORT=15672
RABBITMQ_USERNAME=${11:-guest}
RABBITMQ_PASSWORD=${12:-guest}
VERSIONED_JAR_FILE_NAME=osiris-average-function-${JAR_VERSION}.jar
UNVERSIONED_JAR_FILE_NAME=osiris-average-function.jar

#Generate the sensornet configuration file
rm config.properties
echo "rabbitmq.server.ip="${RABBITMQ_IP} > config.properties
echo "rabbitmq.user.name="${RABBITMQ_USERNAME} >> config.properties
echo "rabbitmq.user.pass="${RABBITMQ_PASSWORD} >> config.properties

#Check if the .jar file exists
JAR_FILE=./../../function/average/${JAR_VERSION}/${VERSIONED_JAR_FILE_NAME}
if [ ! -e ${JAR_FILE} ]
then
  echo "ERROR: ${MODULE_NAME} jar file [${JAR_FILE}] could not be found"
  exit 1
fi

#copy the latest version that will be deployed
cp ${JAR_FILE} ./${UNVERSIONED_JAR_FILE_NAME} && chmod +x ${UNVERSIONED_JAR_FILE_NAME}
if [ $? -ne 0 ]
then
  echo "ERROR: Failed to obtain ${MODULE_NAME} module .jar file [${UNVERSIONED_JAR_FILE_NAME}]."
  exit 1
fi
