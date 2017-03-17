#!/bin/bash
# install_docker.sh
# description: Check if Docker is installed
# if not, asks to installs it by calling the install_docker.sh script

echo "Checking if Docker is installed..."
sudo docker --version > /dev/null
if [ $? -ne 0 ]
then
  echo "Docker was not found."
  echo "Do you want to install Docker? (Y/n)"
  READ OPTION
  case $OPTION in
    [Yy])
      . ./install_docker.sh ;;
    *) echo "WARNING: Operation Aborted."; exit 1 ;;
  esac
  exit 1
else
  echo "INFO: Docker already installed [$(sudo docker -v)]"
  exit 0
fi

