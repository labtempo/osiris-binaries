#!/bin/bash
# Description: Run a Local Environment for OSIRIS Framework with all modules: PostgreSQL, RabbitMQ, SensorNet and VirtualSensorNet
# (Ubuntu 16.04 64-bit)

#check docker
. ./install_docker.sh

#check postgresql client
. ./install_postgresql_client.sh

#run rabbitmq
cd rabbitmq
docker ps | grep osiris-rabbitmq > /dev/null && make stop 
docker ps -a | grep osiris-rabbitmq > /dev/null && make remove 
make build 
make run
cd ..

#run sensornet postgresql
cd sensornet-postgresql
docker ps | grep sensornet-postgresql > /dev/null && make stop
docker ps -a | grep sensornet-postgresql > /dev/null && make remove
make run
make drop 
make create 
cd ..

#run sensornet omcp
cd sensornet-omcp
docker ps | grep sensornet-omcp > /dev/null && make stop 
docker ps -a | grep sensornet-omcp > /dev/null && make remove 
. ./configure.sh 
make build 
make run 
cd ..

#run virtualsensornet postgresql
cd virtualsensornet-postgresql
docker ps | grep virtualsensornet-postgresql > /dev/null && make stop  
docker ps -a | grep virtualsensornet-postgresql > /dev/null && make remove 
make run  
make drop  
make create  
cd ..

#run virtualsensornet omcp
cd virtualsensornet-ocmp 
docker ps | grep virtualsensornet-ocmp > /dev/null && make stop  
docker ps -a | grep virtualsensornet-ocmp > /dev/null && make remove 
. ./configure.sh  
make build  
make run 
cd ..