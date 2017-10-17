#!/bin/bash
#Web Frontend
sudo apt-get install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
cd ${OSIRIS_HOME}/osiris-web-frontend
npm install
