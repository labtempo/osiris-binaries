FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/sensornet

ADD config.properties /opt/sensornet/config.properties
ADD SensorNet.jar /opt/sensornet/SensorNet.jar

CMD ["java", "-jar", "/opt/sensornet/SensorNet.jar"]
