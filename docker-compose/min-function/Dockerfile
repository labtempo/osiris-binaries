FROM openjdk:8-jre-alpine

ENV JAR_VERSION=1.0.0
ENV RABBITMQ_IP=localhost
ENV RABBITMQ_USERNAME=guest
ENV RABBITMQ_PASSWORD=guest

RUN mkdir -p /opt/osiris-min-function

ADD ../../function/min/${JAR_VERSION}/osiris-min-function-${JAR_VERSION}.jar /opt/osiris-min-function/osiris-min-function.jar

RUN 	cd /opt/osiris-min-function && \
		touch config.properties && \
		chmod -R 750 /opt/osiris-min-function && \
		echo "rabbitmq.server.ip="${RABBITMQ_IP} > config.properties && \
		echo "rabbitmq.user.name="${RABBITMQ_USERNAME} >> config.properties && \
		echo "rabbitmq.user.pass="${RABBITMQ_PASSWORD} >> config.properties

CMD ["java", "-jar", "/opt/osiris-min-function/osiris-min-function.jar"]
