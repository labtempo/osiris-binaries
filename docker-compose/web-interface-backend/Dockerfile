FROM openjdk:8-jre-alpine

ENV JAR_VERSION=1.0.0

RUN mkdir -p /opt/osiris-web-backend

ADD ../../web-backend/${JAR_VERSION}/osiris-web-backend-${JAR_VERSION}.jar /opt/osiris-web-backend/osiris-web-backend.jar

RUN chmod -R 750 /opt/osiris-web-backend

CMD ["java", "-jar", "/opt/osiris-web-backend/osiris-web-backend.jar"]
