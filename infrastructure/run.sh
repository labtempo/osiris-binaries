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
docker ps | grep osiris-rabbitmq > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: RabbitMQ container [osiris-rabbitmq] is already running."
else
    docker ps -a | grep osiris-rabbitmq > /dev/null
    if [ $? -eq 0 ]
    then
        #Docker container exists but is not running. Starting...
        docker start osiris-rabbitmq
    else
        #Docker container doesnt exist. Creating...
        cd rabbitmq
        make build
        make run
    fi
fi

#Create PostgreSQL database for SensorNet
cd ../sensornet-postgresql
docker ps | grep sensornet-postgresql > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: SensorNet PostgreSQL Database container [sensornet-postgresql] is already running."
else
    docker ps -a | grep sensornet-postgresql > /dev/null
    if [ $? -eq 0 ]
    then
        #Docker container exists but is not running. Starting...
        docker start sensornet-postgresql
    else
        #Docker container does not exist. Creating...
        make run
    fi
fi

#Create OMCP Server for SensorNet
cd ../sensornet-omcp
docker ps | grep osiris-sensornet-omcp > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: SensorNet OMCP container [osiris-sensornet-omcp] is already running."
else
    docker ps -a | grep osiris-sensornet-omcp > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running.
        docker start osiris-sensornet-omcp
    else
        #Container does not exist
        make config
        make build
        make run
    fi
fi

#Create PostgreSQL database for VirtualSensorNet
cd ../virtualsensornet-postgresql
docker ps | grep virtualsensornet-postgresql > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: VirtualSensorNet PostgreSQL Database container [virtualsensornet-postgresql] is already running."
else
    docker ps -a | grep virtualsensornet-postgresql > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start virtualsensornet-postgresql
    else
        #Container does not exists
        make run
    fi
fi

#Create OMCP Server for VirtualSensorNet
cd ../virtualsensornet-omcp
docker ps | grep osiris-virtualsensornet-omcp > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: VirtualSensorNet OMCP container [osiris-virtualsensornet-omcp] is already running."
else
    docker ps -a | grep osiris-virtualsensornet-omcp > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start osiris-virtualsensornet-omcp
    else
        #Container does not exists.
        make config
        make build
        make run
    fi
fi

#Create sum.function module
cd ../sum-function
docker ps | grep osiris-sum-function > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: sum.function container [osiris-sum-function] is already running."
else
    docker ps -a | grep osiris-sum-function > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start osiris-sum-function
    else
        #Container does not exists.
        make config
        make build
        make run
    fi
fi

#Create average.function module
cd ../average-function
docker ps | grep osiris-average-function > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: average.function container [osiris-average-function] is already running."
else
    docker ps -a | grep osiris-average-function > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start osiris-average-function
    else
        #Container does not exists.
        make config
        make build
        make run
    fi
fi


#Create min.function module
cd ../min-function
docker ps | grep osiris-min-function > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: min.function container [osiris-min-function] is already running."
else
    docker ps -a | grep osiris-min-function > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start osiris-min-function
    else
        #Container does not exists.
        make config
        make build
        make run
    fi
fi

#Create max.function module
cd ../max-function
docker ps | grep osiris-max-function > /dev/null
if [ $? -eq 0 ]
then
    echo "INFO: max.function container [osiris-max-function] is already running."
else
    docker ps -a | grep osiris-max-function > /dev/null
    if [ $? -eq 0 ]
    then
        #Container exists but is not running
        docker start osiris-max-function
    else
        #Container does not exists.
        make config
        make build
        make run
    fi
fi
