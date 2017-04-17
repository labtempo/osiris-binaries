FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/osiris/function/min

ADD config.properties /opt/osiris/function/min/config.properties
ADD osiris-min-function.jar /opt/osiris/function/min/osiris-min-function.jar

CMD ["java", "-jar", "/opt/osiris/function/min/osiris-min-function.jar"]
