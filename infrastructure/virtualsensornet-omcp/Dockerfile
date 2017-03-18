FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/virtualsensornet

ADD config.properties /opt/sensornet/config.properties
ADD VirtualSensorNet.jar /opt/sensornet/VirtualSensorNet.jar

CMD ["java", "-jar", "/opt/sensornet/VirtualSensorNet.jar"]
