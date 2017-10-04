FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/osiris/function/max

ADD config.properties /opt/osiris/function/max/config.properties
ADD osiris-max-function.jar /opt/osiris/function/max/osiris-max-function.jar

CMD ["java", "-jar", "/opt/osiris/function/max/osiris-max-function.jar"]
