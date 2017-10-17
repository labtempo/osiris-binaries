#!/bin/bash
cd ${OSIRIS_HOME}/osiris-web-backend/impl
git pull origin master
mvn clean install package -U
cp "${OSIRIS_HOME}/osiris-web-backend/impl/target/osiris-web-backend-0.0.1-SNAPSHOT.jar" "${OSIRIS_HOME}/osiris-binaries/web-backend/1.0.0/osiris-web-backend-1.0.0.jar"
