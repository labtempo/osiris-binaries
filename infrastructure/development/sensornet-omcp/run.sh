#!/bin/bash
VERSION=1.6.0

echo 'postgres.server.db=OsirisSN' > config.properties
echo 'postgres.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' osiris-postgresql_dev) >> config.properties
echo 'postgres.server.port=5432' >> config.properties
echo 'postgres.user.name=osiris' >> config.properties
echo 'postgres.user.pass=osiris' >> config.properties
echo 'rabbitmq.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' osiris-postgresql_dev) >> config.properties
echo 'rabbitmq.user.name=guest' >> config.properties
echo 'rabbitmq.user.pass=guest' >> config.properties

cp ../../../sensornet/${VERSION}/SensorNet-${VERSION}.jar SensorNet.jar
docker build -t osiris-sensornet-omcp_dev .
docker run --name osiris-sensornet-omcp_dev -d -p 8090:8090 osiris-sensornet-omcp_dev
