#!/bin/bash
# file: run.sh
# description: Script that prepare a local environment for OSIRIS Framework.
# Uses Docker to build image and run containers for RabbitMQ, PostgreSQL and OMCP
# , all in the same machine, for the SensorNet and VirtualSensorNet modules.
# usage:
# cd infrastructure
# sudo ./run.sh

make -v > /dev/null
if [ $? -ne 0 ]
then
    echo "ERROR: make command not found."
    exit 1
fi

#Install Docker if is not installed
. ./install_docker.sh

#Install PostgreSQL CLient (psql), if is not installed
. ./install_postgresql_client.sh

#Stop local postgresql service (if exists) to prevent conflicts
sudo service postgresql stop > /dev/null

#RabbitMQ Server
cd rabbitmq
docker ps | grep osiris-rabbitmq > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: RabbitMQ container [osiris-rabbitmq] is already running."
else
    docker ps -a | grep osiris-rabbitmq > /dev/null
    if [ $? -eq 0 ]
    then
        docker start osiris-rabbitmq
    else
        cd rabbitmq
        make build
        make run
    fi
fi

#Create PostgreSQL database for SensorNet
cd ../sensornet-postgresql
make run
make drop
make create

#Create OMCP Server for SensorNet
cd ../sensornet-omcp
make config
make build
make run

#Create PostgreSQL database for VirtualSensorNet
cd ../virtualsensornet-postgresql
make run
make drop
make create

#Create OMCP Server for VirtualSensorNet
cd ../virtualsensornet-omcp
make config
make build
make run