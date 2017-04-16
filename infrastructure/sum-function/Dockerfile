FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/osiris/function/sum

ADD config.properties /opt/osiris/function/sum/config.properties
ADD osiris-sum-function.jar /opt/osiris/function/sum/osiris-sum-function.jar

CMD ["java", "-jar", "/opt/osiris/function/sum/osiris-sum-function.jar"]
