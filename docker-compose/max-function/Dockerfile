FROM openjdk:8-jre-alpine

ENV JAR_VERSION=1.0.0
ENV RABBITMQ_IP=localhost
ENV RABBITMQ_USERNAME=guest
ENV RABBITMQ_PASSWORD=guest

RUN mkdir -p /opt/osiris-max-function

ADD ../../function/max/${JAR_VERSION}/osiris-max-function-${JAR_VERSION}.jar /opt/osiris-max-function/osiris-max-function.jar

RUN 	cd /opt/osiris-max-function && \
		touch config.properties && \
		chmod -R 750 /opt/osiris-max-function && \
		echo "rabbitmq.server.ip="${RABBITMQ_IP} > config.properties && \
		echo "rabbitmq.user.name="${RABBITMQ_USERNAME} >> config.properties && \
		echo "rabbitmq.user.pass="${RABBITMQ_PASSWORD} >> config.properties

CMD ["java", "-jar", "/opt/osiris-max-function/osiris-max-function.jar"]