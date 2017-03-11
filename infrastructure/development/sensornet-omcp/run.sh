#!/bin/bash
VERSION=1.6.0
cp ../../../sensornet/${VERSION}/SensorNet-${VERSION}.jar SensorNet.jar
docker build -t sensornet-omcp .
docker run -d -p 8090:8090 sensornet-omcp