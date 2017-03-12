#!/bin/bash
# file: run.sh
# description: prepare osiris local development environment
# build PostgreSQL, RabbitMQ, SensorNet and VirtualSensorNet images
# and run the containers

function set_development_environment() {
  export ENVIRONMENT="development"

  export DOCKER_IMAGE_NAME_POSTGRESQL="osiris-postgresql_"${ENVIRONMENT}
  export DOCKER_IMAGE_NAME_RABBITMQ="osiris-rabbitmq_"${ENVIRONMENT}
  export DOCKER_IMAGE_NAME_SENSORNET_OMCP="osiris-sensornet-omcp_"${ENVIRONMENT}
  export DOCKER_IMAGE_NAME_VIRTUALSENSORNET_OMCP="osiris-virtualsensornet-omcp_"${ENVIRONMENT}

  export POSTGRESQL_HOST_IP="127.0.0.1"
  export POSTGRESQL_PORT=5432
  export POSTGRESQL_USER_NAME="osiris"
  export POSTGRESQL_USER_PASS="osiris"
  export POSTGRESQL_SENSORNET_DB_NAME="OsirisSN"
  export POSTGRESQL_VIRTUALSENSORNET_DB_NAME="OsirisVSN"
  export POSTGRESQL_SENSORNET_WEB_DB_NAME="OsirisWebSN"
  export POSTGRESQL_VIRTUALSENSORNET_WEB_DB_NAME="OsirisWebVSN"

  export RABBITMQ_HOST_IP="127.0.0.1"
  export RABBITMQ_PORT=5672
  export RABBITMQ_ADMIN_PORT=15672
  export RABBITMQ_USER_NAME="guest"
  export RABBITMQ_USER_PASS="guest"

  export OSIRIS_SENSORNET_CONFIG_FILE_NAME="config.properties"
  export OSIRIS_SENSORNET_OMCP_PORT=8090
  export OSIRIS_SENSORNET_MAJOR_VERSION=1.6.0
  export OSIRIS_SENSORNET_JAR_FILE_NAME=SensorNet-${OSIRIS_SENSORNET_MAJOR_VERSION:-1.6.0}.jar

  export OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME="config.properties"
  export OSIRIS_VIRTUALSENSORNET_OMCP_PORT=8091
  export OSIRIS_VIRTUALSENSORNET_MAJOR_VERSION=1.6.0
  export OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME=VirtualSensorNet-${OSIRIS_SENSORNET_MAJOR_VERSION:-1.6.0}.jar
}

function check_installed_docker() {
  docker --version >> /dev/null
  if [ $? -ne 0 ]
  then
    echo "You need Docker installed in order to raise the OSIRIS ${ENVIRONMENT} environment"
    echo "Installing Docker..."
    sudo apt-get install docker
  fi
}

function build_docker_image_postgresql() {
  echo "Building PostgreSQL Docker Image..."
docker build -t ${DOCKER_IMAGE_NAME_POSTGRESQL:-osiris-postgresql_development} \
  --build-arg POSTGRESQL_PORT=${POSTGRESQL_PORT:-5432} \
  --build-arg POSTGRESQL_USER_NAME=${POSTGRESQL_USER_NAME:-osiris} \
  --build-arg POSTGRESQL_USER_PASSWORD=${POSTGRESQL_USER_PASS:-osiris} \
  --build-arg POSTGRESQL_SENSORNET_DB_NAME=${POSTGRESQL_SENSORNET_DB_NAME:-OsirisSN} \
  --build-arg POSTGRESQL_SENSORNETWEB_DB_NAME=${POSTGRESQL_SENSORNET_WEB_DB_NAME:-OsirisWebSN} \
  --build-arg POSTGRESQL_VIRTUALSENSORNET_DB_NAME=${POSTGRESQL_VIRTUALSENSORNET_DB_NAME:-OsirisVSN} \
  --build-arg POSTGRESQL_VIRTUALSENSORNETWEB_DB_NAME=${POSTGRESQL_VIRTUALSENSORNET_WEB_DB_NAME:-OsirisWebVSN} \
  postgresql
}

function run_docker_container_postgresql() {
  echo "Running PostgreSQL Docker Container..."
docker run -d --name ${DOCKER_IMAGE_NAME_POSTGRESQL:-osiris-postgresql_development} -p ${POSTGRESQL_PORT:-5432}:${POSTGRESQL_PORT:-5432} ${DOCKER_IMAGE_NAME_POSTGRESQL:-osiris-postgresql_development}
}

function build_docker_image_rabbitmq() {
  echo "Building RabbitMQ Docker Image..."
  docker build -t ${DOCKER_IMAGE_NAME_RABBITMQ:-osiris-rabbitmq_development} rabbitmq
}

function run_docker_container_rabbitmq() {
  echo "Running RabbitMQ Docker Container..."
  docker run --name ${DOCKER_IMAGE_NAME_RABBITMQ:-osiris-rabbitmq_development} -d -p ${RABBITMQ_PORT:-5672}:${RABBITMQ_PORT:-5672} -p ${RABBITMQ_ADMIN_PORT:-15672}:${RABBITMQ_ADMIN_PORT:-15672} -v /opt/rabbitmq:/var/lib/rabbitmq ${DOCKER_IMAGE_NAME_RABBITMQ:-osiris-rabbitmq_development}
}

function build_docker_image_sensornet_omcp() {
  #Generate the sensornet configuration file
  echo 'postgres.server.db='${POSTGRESQL_SENSORNET_DB_NAME:-OsirisSN} > sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'postgres.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${DOCKER_IMAGE_NAME_POSTGRESQL}) >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'postgres.server.port='${POSTGRESQL_PORT} >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'postgres.user.name='${POSTGRESQL_USER_NAME} >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'postgres.user.pass='${POSTGRESQL_USER_PASS} >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${DOCKER_IMAGE_NAME_RABBITMQ}) >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.user.name='${RABBITMQ_USER_NAME} >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.user.pass='${RABBITMQ_USER_PASS} >> sensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME

  #copy the latest version to be deployed
  cp ./../../sensornet/${OSIRIS_SENSORNET_MAJOR_VERSION}/$OSIRIS_SENSORNET_JAR_FILE_NAME sensornet-omcp/SensorNet.jar

  docker build -t $DOCKER_IMAGE_NAME_SENSORNET_OMCP sensornet-omcp
}

function run_docker_container_sensornet_omcp() {
  docker run --name $OSIRIS_SENSORNET_JAR_FILE_NAME -d -p $OSIRIS_SENSORNET_OMCP_PORT:$OSIRIS_SENSORNET_OMCP_PORT $DOCKER_IMAGE_NAME_SENSORNET_OMCP
}

function build_docker_image_virtualsensornet_omcp() {
  #Generate the virtualsensornet configuration file
  echo 'postgres.server.db='${POSTGRESQL_VIRTUALSENSORNET_DB_NAME} > virtualsensornet-omcp/$OSIRIS_SENSORNET_CONFIG_FILE_NAME
  echo 'postgres.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${DOCKER_IMAGE_NAME_POSTGRESQL}) >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'postgres.server.port='${POSTGRESQL_PORT} >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'postgres.user.name='${POSTGRESQL_USER_NAME} >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'postgres.user.pass='${POSTGRESQL_USER_PASS} >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.server.ip='$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' ${DOCKER_IMAGE_NAME_RABBITMQ}) >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.user.name='${RABBITMQ_USER_NAME} >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME
  echo 'rabbitmq.user.pass='${RABBITMQ_USER_PASS} >> virtualsensornet-omcp/$OSIRIS_VIRTUALSENSORNET_CONFIG_FILE_NAME

  #copy the latest version to be deployed
  cp ./../../virtualsensornet/${OSIRIS_VIRTUALSENSORNET_MAJOR_VERSION}/$OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME virtualsensornet-omcp/VirtualSensorNet.jar

  docker build -t $DOCKER_IMAGE_NAME_VIRTUALSENSORNET_OMCP virtualsensornet-omcp
}

function run_docker_container_virtualsensornet_omcp() {
  docker run --name $OSIRIS_VIRTUALSENSORNET_JAR_FILE_NAME -d -p $OSIRIS_VIRTUALSENSORNET_OMCP_PORT:$OSIRIS_VIRTUALSENSORNET_OMCP_PORT $DOCKER_IMAGE_NAME_VIRTUALSENSORNET_OMCP
}

### MAIN
set_development_environment
check_installed_docker

build_docker_image_postgresql
run_docker_container_postgresql

build_docker_image_rabbitmq
run_docker_container_rabbitmq

build_docker_image_sensornet_omcp
run_docker_container_sensornet_omcp

build_docker_image_virtualsensornet_omcp
run_docker_container_virtualsensornet_omcp