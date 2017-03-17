FROM openjdk:8-jre-alpine
    
RUN mkdir -p /opt/virtualsensornet

ADD config.properties /opt/virtualsensornet/config.properties
ADD VirtualSensorNet.jar /opt/virtualsensornet/VirtualSensorNet.jar

CMD ["java", "-jar", "/opt/virtualsensornet/VirtualSensorNet.jar"]
