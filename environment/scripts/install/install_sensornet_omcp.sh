#!/bin/bash
#Install SensorNet OMCP
cd ${OSIRIS_HOME}
echo 'postgres.server.db=sensornet' > osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'postgres.server.ip=localhost' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'postgres.server.port=5432' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'postgres.user.name=postgres' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'postgres.user.pass=postgres' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'rabbitmq.server.ip=localhost' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'rabbitmq.user.name=guest' >> osiris-binaries/sensornet/1.6.0/config.properties && \
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/sensornet/1.6.0/config.properties
