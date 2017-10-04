FROM openjdk:8-jre-alpine

ENV JAR_VERSION=1.0.0
ENV RABBITMQ_IP=localhost
ENV RABBITMQ_USERNAME=guest
ENV RABBITMQ_PASSWORD=guest

RUN mkdir -p /opt/osiris-average-function

ADD ../../function/average/${JAR_VERSION}/osiris-average-function-${JAR_VERSION}.jar /opt/osiris-average-function/osiris-average-function.jar

RUN 	cd /opt/osiris-average-function && \
		touch config.properties && \
		chmod -R 750 /opt/osiris-average-function && \
		echo "rabbitmq.server.ip="${RABBITMQ_IP} > config.properties && \
		echo "rabbitmq.user.name="${RABBITMQ_USERNAME} >> config.properties && \
		echo "rabbitmq.user.pass="${RABBITMQ_PASSWORD} >> config.properties

CMD ["java", "-jar", "/opt/osiris-average-function/osiris-average-function.jar"]
