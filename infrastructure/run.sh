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

#Stop local postgresql service (if exists) to prevent port conflict
sudo service postgresql stop > /dev/null

#RabbitMQ Server
cd rabbitmq
docker stop osiris-rabbitmq
docker rm osiris-rabbitmq
make build
make run

#Create PostgreSQL database for SensorNet
cd ../sensornet-postgresql
docker stop osiris-sensornet-postgresql
docker rm osiris-sensornet-postgresql
make run

#Create OMCP Server for SensorNet
cd ../sensornet-omcp
docker stop osiris-sensornet-omcp
docker rm osiris-sensornet-omcp
make config
make build
make run

#Create PostgreSQL database for VirtualSensorNet
cd ../virtualsensornet-postgresql
docker stop osiris-virtualsensornet-postgresql
docker rm osiris-virtualsensornet-postgresql
make run

#Create OMCP Server for VirtualSensorNet
cd ../virtualsensornet-omcp
docker stop osiris-virtualsensornet-omcp
docker rm osiris-virtualsensornet-omcp
make config
make build
make run

#Create sum.function module
cd ../sum-function
docker stop osiris-sum-function
docker rm osiris-sum-function
make config
make build
make run

#Create average.function module
cd ../average-function
docker stop osiris-average-function
docker rm osiris-average-function
make config
make build
make run

#Create min.function module
cd ../min-function
docker stop osiris-min-function
docker rm osiris-min-function
make config
make build
make run

#Create max.function module
cd ../max-function
docker stop osiris-max-function
docker rm osiris-max-function
make config
make build
make run