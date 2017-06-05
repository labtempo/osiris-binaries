#!bin/bash
#Install local OSIRIS environment for development purposes
#For linux Ubuntu/Debian 64-bits OS

cd ~
mkdir Server
cd Server

#Install git
sudo apt-get install git

#clone OSIRIS repositories
git clone https://github.com/aghigo/osiris osiris-framework
git clone https://github.com/aghigo/osiris-binaries
git clone https://github.com/aghigo/osiris-web-backend
git clone https://github.com/felippemauricio/osiris-web osiris-web-frontend

#Install java (jdk 1.8)
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default

echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
echo "export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre" >> ~/.bashrc
. ~/bashrc

#Install RabbitMQ
echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_management
sudo rabbitmq-server start

#Install PostgreSQL
LOCAL_USER=$(whoami)
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres
createdb sensornet
createdb virtualsensornet
createdb osirisweb
psql <<EOF
ALTER USER postgres PASSWORD 'postgres';
\q
EOF
su $LOCAL_USER

#Install SensorNet OMCP
echo 'postgres.server.db=sensornet' > osiris-binaries/sensornet/1.6.0/config.properties
echo 'postgres.server.ip=localhost' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'postgres.server.port=5432' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'postgres.user.name=postgres' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'postgres.user.pass=postgres' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'rabbitmq.server.ip=localhost' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/sensornet/1.6.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/sensornet/1.6.0/config.properties
nohup java -jar osiris-binaries/sensornet/1.6.0/SensorNet-1.6.0.jar &

#Install VirtualSensorNet OMCP
echo 'postgres.server.db=virtualsensornet' > osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'postgres.server.ip=localhost' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'postgres.server.port=5432' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'postgres.user.name=postgres' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'postgres.user.pass=postgres' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'rabbitmq.server.ip=localhost' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/virtualsensornet/1.6.0/config.properties
nohup java -jar osiris-binaries/virtualsensornet/1.6.0/VirtualSensorNet-1.6.0.jar &

#Average Function
echo 'rabbitmq.server.ip=localhost' > osiris-binaries/function/average/1.0.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/function/average/1.0.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/function/average/1.0.0/config.properties
nohup java -jar osiris-binaries/function/average/1.0.0/osiris-average-function-1.0.0.jar &

#Sum Function
echo 'rabbitmq.server.ip=localhost' > osiris-binaries/function/sum/1.0.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/function/sum/1.0.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/function/sum/1.0.0/config.properties
nohup java -jar osiris-binaries/function/sum/1.0.0/osiris-sum-function-1.0.0.jar &

#Min Function
echo 'rabbitmq.server.ip=localhost' > osiris-binaries/function/min/1.0.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/function/min/1.0.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/function/min/1.0.0/config.properties
nohup java -jar osiris-binaries/function/min/1.0.0/osiris-min-function-1.0.0.jar &

#Max Function
echo 'rabbitmq.server.ip=localhost' > osiris-binaries/function/max/1.0.0/config.properties
echo 'rabbitmq.user.name=guest' >> osiris-binaries/function/max/1.0.0/config.properties
echo 'rabbitmq.user.pass=guest' >> osiris-binaries/function/max/1.0.0/config.properties
nohup java -jar osiris-binaries/function/max/1.0.0/osiris-max-function-1.0.0.jar &

#Web Backend
sudo apt-get install maven
cd ~/Server/osiris-web-backend/impl
mvn clean install package -U

#Web Frontend
sudo apt-get install npm
cd ~/Server/osiris-web-frontend
npm install
nohup npm start &
