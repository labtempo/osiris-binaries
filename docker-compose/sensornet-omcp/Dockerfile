FROM openjdk:8-jre-alpine

ENV SENSORNET_VERSION=1.6.0
ENV SENSORNET_DBNAME=sensornet
ENV POSTGRESQL_IP=localhost
ENV POSTGRESQL_PORT=4532
ENV POSTGRESQL_USERNAME=postgres
ENV POSTGRESQL_PASSWORD=postgres
ENV RABBITMQ_IP=localhost
ENV RABBITMQ_USERNAME=guest
ENV RABBITMQ_PASSWORD=guest

RUN mkdir -p /opt/sensornet

ADD ../../sensornet/${SENSORNET_VERSION}/SensorNet-${SENSORNET_VERSION}.jar /opt/sensornet/SensorNet.jar

RUN 	cd /opt/sensornet && \
	touch config.properties && \
	chmod -R 750 /opt/sensornet && \
	echo 'postgres.server.db='${SENSORNET_DBNAME} > config.properties && \
	echo 'postgres.server.ip='${POSTGRESQL_IP} >> config.properties && \
	echo 'postgres.server.port='${POSTGRESQL_PORT} >> config.properties && \
	echo 'postgres.user.name='${POSTGRESQL_USERNAME} >> config.properties && \
	echo 'postgres.user.pass='${POSTGRESQL_PASSWORD} >> config.properties && \
	echo 'rabbitmq.server.ip='${RABBITMQ_IP} >> config.properties && \
	echo 'rabbitmq.user.name='${RABBITMQ_USERNAME} >> config.properties && \
	echo 'rabbitmq.user.pass='${RABBITMQ_PASSWORD} >> config.properties

CMD ["java", "-jar", "/opt/sensornet/SensorNet.jar"]
