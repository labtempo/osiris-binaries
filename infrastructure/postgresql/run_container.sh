#!/bin/bash
# run_container.sh
# description: instantiate and run a container based on a docker image

#Check if docker is installed
. ./check_docker.sh || exit 1

#Retrieve parameters
CONTAINER_NAME=${1:-osiris-postgresql_development}
PORT=${2:-5432}
IMAGE_NAME=${3:-${CONTAINER_NAME}}

#Check if image exists
docker images | grep ${IMAGE_NAME} > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: Docker image [${IMAGE_NAME}] not found."
  echo "INFO: you need to build it before run the container."
  exit 1
fi

#Check if Container already exists
docker container ls -a | grep ${CONTAINER_NAME} > /dev/null
if [ $? -eq 0 ]
  echo "WARNING: Container [${CONTAINER_NAME}] already exists."
  echo "Do you want to remove it? (Y/n)"
  read OPTION
  case $OPTION in
    [Yy]) #Check if existing container is running
          docker container ls | grep ${CONTAINER_NAME} > /dev/null
          if [ $? -eq 0 ]
          then
            docker stop ${CONTAINER_NAME}
            if [ $? -ne 0 ]
            then
              echo "ERROR: Could not stop the running container [${CONTAINER_NAME}]"
              echo "Operation aborted."
              exit 1
            fi
          fi
          docker rm ${CONTAINER_NAME};
          if [ $? -eq 0 ]
          then
            echo "INFO: Container [${CONTAINER_NAME}] removed."
            exit 0
          else
            echo "ERROR: Could not remove the container [${CONTAINER_NAME}]"
            exit 1
          fi
          ;;
    *) echo "WARNING: Operation aborted."; exit 1;;
  esac
fi

#Instantiate the Container
echo "Running container [${CONTAINER_NAME}]..."
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}

#Check if the container was instantiated
if [ $? -eq 0 ]
then
  docker container inspect ${CONTAINER_NAME}
  echo "SUCCESS: The container [${CONTAINER_NAME}] instantiated successfully."
  exit 0
else
  echo "FAILED: The container [${CONTAINER_NAME}] could not be instantiated."
  exit 1
fi