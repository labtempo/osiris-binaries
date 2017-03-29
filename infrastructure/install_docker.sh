#!/bin/bash
# install_docker.sh
# description: script that installs Docker (for Ubuntu 16.04 64-bits)
# Requires: apt-get, apt-cache, systemctl, usermod

#Check if docker is installed
sudo docker -v > /dev/null
if [ $? -ne 0 ]
then

  #Check required tools to install Docker
  apt-get -v > /dev/null && apt-cache -v > /dev/null && systemctl --version > /dev/null && usermod -h > /dev/null
  if [ $? -ne 0 ]
  then
    echo "ERROR: apt-get, apt-cache, systemctl or usermod not found."
    return 1
  fi

  #Install Docker
  sudo apt-get update
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  sudo apt-get update
  apt-cache policy docker-engine
  sudo apt-get install -y docker-engine
  sudo systemctl status docker

  #Check if the installation was successful
  if [ $? -eq 0 ]
  then
    #includes current user into docker group
    sudo usermod -aG docker $(whoami)
    echo "SUCCESS: Docker [$(docker -v)] installed succesfully."
  else
    echo "ERROR: Failed to install Docker."
    return 1
  fi
else
  echo "INFO: Docker [$(docker -v)] is already installed."
fi

return 0