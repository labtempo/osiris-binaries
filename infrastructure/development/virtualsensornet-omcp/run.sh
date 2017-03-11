#!/bin/bash
VERSION=1.6.0
cp ../../../virtualsensornet/${VERSION}/VirtualSensorNet-${VERSION}.jar VirtualSensorNet.jar
docker build -t virtualsensornet-omcp .
docker run -d -p 8091:8091 virtualsensornet-omcp
