#!/bin/bash
# build_docker_image.sh
# description: build a PostgreSQL Docker image for OSIRIS Framework

#Check if Docker is installed
. ./check_docker.sh || exit 1

#Retrieve parameters
IMAGE_NAME=${1:-osiris-postgresql_development}
PORT=${2:-5432}
USERNAME=${3:-osiris}
PASSWORD=${4:-osiris}
SENSORNET_DB_NAME=${5:-OsirisSN}
SENSORNETWEB_DB_NAME=${6:-OsirisWebSN}
VIRTUALSENSORNET_DB_NAME=${7:-OsirisVSN}
VIRTUALSENSORNET_DB_NAME=${8:-OsirisWebSN}

. ./check_docker_image.sh || exit 1

echo "Building Docker Image [${IMAGE_NAME}]..."

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
  docker image inspect ${IMAGE_NAME}
  echo "SUCCESS: Docker image [${IMAGE_NAME}] was built successfully."
  exit 0
else
  echo "ERROR: Docker image [${IMAGE_NAME}] could not be built."
  exit 1
fi

