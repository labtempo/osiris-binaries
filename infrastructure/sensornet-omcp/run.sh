#!/bin/bash

echo "Running Docker container for SensorNet OMCP Server..."

#Check if docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  echo "FAILED - Docker not installed/found. You need Docker in order to run the container."
  exit 1
fi

#Parameter variables
IMAGE_NAME=${1:-osiris-sensornet-omcp_development}
PORT=${2:-8090}
CONTAINER_NAME=${3:-${IMAGE_NAME}}

#Check if image image
sudo docker image ls | grep ${IMAGE_NAME} >> /dev/null
if [ $? -ne 0 ]
then
  echo "FAILED - SensorNet docker image [${IMAGE_NAME}] not found."
  exit 1
fi

#Check if the container already exists
sudo docker container ls -a | grep ${CONTAINER_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  sudo docker container ls | grep ${CONTAINER_NAME} >> /dev/null
  if [ $? -eq 0 ]
  then
    echo "FAILED - SensorNet OMCP container is already running"
  else
    echo "FAILED - SensorNet OMCP container [${CONTAINER_NAME}] already exists"
  fi
  exit 1
fi

#Instantiate the container 
docker run --name ${CONTAINER_NAME} -d -p ${PORT}:${PORT} ${IMAGE_NAME}

#Check if the container was instantiated
if [ $? -eq 0 ]
then
  echo "SUCCESS - SensorNet Container [${CONTAINER_NAME}] instantiated successfully."
  exit 0
else
  echo "FAILED - SensorNet Container [${CONTAINER_NAME}] could not be instantiated."
  exit 1
fi
