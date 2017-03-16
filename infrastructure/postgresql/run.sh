#!/bin/bash

echo "Running PostgreSQL Docker Container..."

#Check if Docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  "FAILED - Docker not found. You need Docker installed in order to run the container."
   exit 1
fi 

#Retrieve parameters
CONTAINER_NAME=${1:-osiris-postgresql_development}
PORT=${2:-5432}
IMAGE_NAME=${3:-${CONTAINER_NAME}}

#Check if Container already exists
sudo docker container ls -a | grep ${CONTAINER_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  sudo docker container ls | grep ${CONTAINER_NAME} >> /dev/null
  if [ $? -eq 0 ]
  then
    echo "INFO - Container ${CONTAINER_NAME} is already running."
    exit 0
  else
    echo "FAILED - Container ${CONTAINER_NAME} already exist."
    exit 1
  fi  
fi

#Instantiate the Container
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}

#Check if the container was instantiated
if [ $? -eq 0 ]
then
  echo "SUCCESS - PostgreSQL Container instantiated successfully"
  exit 0
else
  echo "FAILED - PostgreSQL Container could not be instantiated"
  exit 1
fi
