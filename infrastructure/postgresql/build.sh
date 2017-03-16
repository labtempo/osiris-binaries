#!/bin/bash

echo "Building PostgreSQL Docker Image..."

#Check if Docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  "FAILED - Docker not found. You need Docker installed in order to build the image."
  exit 1
fi 

#Retrieve parameters
IMAGE_NAME=${1:-osiris-postgresql_development}
PORT=${2:-5432}
USERNAME=${3:-osiris}
PASSWORD=${4:-osiris}
SENSORNET_DB_NAME=${5:-OsirisSN}
SENSORNETWEB_DB_NAME=${6:-OsirisWebSN}
VIRTUALSENSORNET_DB_NAME=${7:-OsirisVSN}
VIRTUALSENSORNET_DB_NAME=${8:-OsirisWebSN}

#Check if image already exist
sudo docker images | grep ${IMAGE_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  echo "FAILED - PostgreSQL Docker image already exists."
  exit 1
fi

#Build Image
docker build -t ${IMAGE_NAME} \
--build-arg POSTGRESQL_PORT=${PORT} \
--build-arg POSTGRESQL_USER_NAME=${USERNAME} \
--build-arg POSTGRESQL_USER_PASSWORD=${PASSWORD} \
--build-arg POSTGRESQL_SENSORNET_DB_NAME=${SENSORNET_DB_NAME} \
--build-arg POSTGRESQL_SENSORNETWEB_DB_NAME=${SENSORNETWEB_DB_NAME} \
--build-arg POSTGRESQL_VIRTUALSENSORNET_DB_NAME=${VIRTUALSENSORNET_DB_NAME} \
--build-arg POSTGRESQL_VIRTUALSENSORNETWEB_DB_NAME=${VIRTUALSENSORNET_DB_NAME} .

#Check if image was built
if [ $? -eq 0 ]
then
  echo "SUCCESS - PostgreSQL Docker image built successfully."
  exit 0
else
  echo "FAILED - PostgreSQL Docker image could not be built."
  exit 1
fi

