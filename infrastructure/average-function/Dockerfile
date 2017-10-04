FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/osiris/function/average

ADD config.properties /opt/osiris/function/average/config.properties
ADD osiris-average-function.jar /opt/osiris/function/average/osiris-average-function.jar

CMD ["java", "-jar", "/opt/osiris/function/average/osiris-average-function.jar"]
