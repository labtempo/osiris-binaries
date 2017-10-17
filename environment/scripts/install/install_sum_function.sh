#!/bin/bash
#Sum Function
cd ${OSIRIS_HOME}
echo 'rabbitmq.server.ip=localhost' > osiris-binaries/function/sum/1.0.0/config.properties && \
echo 'rabbitmq.user.name=guest' >> osiris-binaries/function/sum/1.0.0/config.properties && \
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/function/sum/1.0.0/config.properties
