#!/bin/bash
# Description: Installs PostgreSQL client (psql)
# Ubuntu 16.04 64-bits
# Requires: apt-get

#Check if apt-get is installed
apt-get -v > /dev/null
if [ $? -ne 0 ]
then
  echo "ERROR: apt-get not found."
  return 1
fi

#Check if psql is installed
psql --version > /dev/null
if [ $? -ne 0 ]
then
  sudo apt-get update && sudo apt-get install postgresql-client
else
  echo "PostgreSQL Client [$(psql --version)] is already installed."
fi

return 0