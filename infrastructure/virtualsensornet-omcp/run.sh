#!/bin/bash

"Running Docker container for VirtualSensorNet OMCP Server..."

#Check if Docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  echo "FAILED - Docker not found/installed. You need Docker in order to run the container."
  exit 1
fi

#Retrieving parameter variables
IMAGE_NAME=${1:-osiris-virtualsensornet-omcp_development}
PORT=${2:-8091}
CONTAINER_NAME={3:-${IMAGE_NAME}}

#Check if the image exists

#Check if the container already exists

#Running the container
docker run --name ${CONTAINER_NAME} -d -p ${PORT}:${PORT} ${IMAGE_NAME}

#Check if the container was instantiated
if [ $? -eq 0 ]
then
  "SUCCESS - VirtualSensorNet container [${CONTAINER_NAME}] instantiated succesfully."
  exit 0
else
  "FAILED - VirtualSensorNet container [${CONTAINER_NAME}] could not be instantiated."
  exit 1
fi
