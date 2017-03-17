#!/bin/bash
# install_docker.sh
# description: script that installs Docker (for Ubuntu 16.04 64-bits)

sudo docker -v >> /dev/null
if [ $? -ne 0 ]
then
  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  sudo apt-get update
  apt-cache policy docker-engine
  sudo apt-get install -y docker-engine
  sudo systemctl status docker
  if [ $? -eq 0 ]
  then
    #includes current user into docker group
    sudo usermod -aG docker $(whoami)
    echo "SUCCESS: Docker [$(docker -v)] installed succesfully."
  else
    echo "ERROR: Docker was not installed correctly."
  fi
else
  echo "INFO: Docker [$(docker -v)] already installed."
fi
