#!/bin/bash
VERSION=1.6.0

echo 'postgres.server.db=OsirisVSN' > config.properties
echo 'postgres.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' db_postgres) >> config.properties
echo 'postgres.server.port=5432' >> config.properties
echo 'postgres.user.name=osiris' >> config.properties
echo 'postgres.user.pass=osiris' >> config.properties
echo 'rabbitmq.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' rabbitmq) >> config.properties
echo 'rabbitmq.user.name=guest' >> config.properties
echo 'rabbitmq.user.pass=guest' >> config.properties

cp ../../../virtualsensornet/${VERSION}/VirtualSensorNet-${VERSION}.jar VirtualSensorNet.jar
docker build -t virtualsensornet-omcp .
docker run --name virtualsensornet -d -p 8091:8091 virtualsensornet-omcp
