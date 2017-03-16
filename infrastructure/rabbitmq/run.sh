#!/bin/bash

echo "Running RabbitMQ Docker Container..."

#Check if docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  echo "FAILED - Docker not found. You need to install Docker in order to run the container."
fi

#Retrieve parameter variables
IMAGE_NAME=${1:-osiris-rabbitmq_development}
PORT=${2:-5672}
ADMIN_PORT=${3:-15672}
CONTAINER_NAME=${4:-${IMAGE_NAME}}

#Check if container already exists
sudo docker container ls -a | grep ${CONTAINER_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  #Container exists, check if its running
  sudo docker container ls | grep ${CONTAINER_NAME} >> /dev/null
  if [ $? -eq 0 ]
  then
    echo "FAILED - RabbitMQ container is already running"
  else
    echo "FAILED - RabbitMQ container already exists"  
  fi
  exit 1
fi

#Instantiate the container
docker run --name ${CONTAINER_NAME} -d -p ${PORT}:${PORT} -p ${ADMIN_PORT}:${ADMIN_PORT} -v /opt/rabbitmq:/var/lib/rabbitmq ${IMAGE_NAME}

#Check if container was instantiated
if [ $? -eq 0 ]
then
  echo "SUCCESS - RabbitMQ Container instantiated successfully"
else
  echo "FAILED - RabbitMQ Container could not be instantiated"
fi

