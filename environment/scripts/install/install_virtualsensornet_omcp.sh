#!/bin/bash
#Install VirtualSensorNet OMCP
cd ${OSIRIS_HOME}
echo 'postgres.server.db=virtualsensornet' > osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'postgres.server.ip=localhost' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'postgres.server.port=5432' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'postgres.user.name=postgres' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'postgres.user.pass=postgres' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'rabbitmq.server.ip=localhost' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'rabbitmq.user.name=guest' >> osiris-binaries/virtualsensornet/1.6.0/config.properties && \
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
