#!/bin/bash

echo "Building RabbitMQ Docker Image..."

#Check if docker is installed
sudo docker --version >> /dev/null
if [ $? -ne 0 ]
then
  echo "FAILED - Docker not found. You need Docker installed in order to build the image."
  exit 1
fi

#Retrieve parameter variables
IMAGE_NAME=${1:-osiris-rabbitmq_development}

#Check if image already exists
sudo docker image ls | grep ${IMAGE_NAME} >> /dev/null
if [ $? -eq 0 ]
then
  echo "FAILED - RabbitMQ Image already exists"
  exit 1
fi

#Build the image
docker build -t ${IMAGE_NAME} .

#Check if image was built
if [ $? -eq 0 ]
then
  echo "SUCCESS - RabbitMQ Image built successfully"
else
  echo "FAILED - RabbitMQ Image could not be built"
fi

