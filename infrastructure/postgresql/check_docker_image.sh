#!/bin/bash
# check_docker_image.sh
# description: Check if a docker image already exists and asks to remove it

IMAGE_NAME=${1}
CONTAINER_NAME=${2:-${IMAGE_NAME}}

if [ -z "${IMAGE_NAME}" ]
then
  echo "ERROR: Invalid image name."
  exit 1
fi

docker -v > /dev/null
if [ $? -ne 0 ]
then
    echo "ERROR: Docker not found."
    exit 1
fi

docker images | grep ${IMAGE_NAME} > /dev/null
if [ $? -eq 0 ]
then
  echo "Docker image [${IMAGE_NAME}] already exists."
  echo "Do you want to remove it? (Y/n)"
  read OPTION
  case $OPTION in
    [Yy]) docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME} && docker rmi ${IMAGE_NAME};
          if [ $? -eq 0 ]
          then
            echo "SUCCESS: Image [${IMAGE_NAME}] removed succesfully."
            exit 0
          else
            echo "ERROR: Could not remove image [${IMAGE_NAME}]"
            exit 1
          fi
          ;;
       *) echo "WARNING: Operation aborted."
          exit 1
          ;;
  esac
else
  echo "INFO: Docker image [${IMAGE_NAME}] does not exist."
  exit 0
fi


