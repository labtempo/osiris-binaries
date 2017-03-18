#!/bin/bash
# Description: Installs PostgreSQL client (psql)
# Ubuntu 16.04 64-bits
psql --version > /dev/null
if [ $? -ne 0 ]
then
  sudo apt-get update && sudo apt-get install postgresql-client
else
  echo "PostgreSQL Client [$(psql --version)] is already installed."
fi