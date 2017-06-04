#!/bin/bash

sudo docker-compose -f communication-layer/docker-compose.yml -f sensornet-database/docker-compose.yml -f sensornet-omcp/docker-compose.yml -f virtualsensornet-database/docker-compose.yml -f virtualsensornet-omcp/docker-compose.yml -f average-function/docker-compose.yml -f sum-function/docker-compose.yml -f min-function/docker-compose.yml -f max-function/docker-compose.yml -f web-interface-database/docker-compose.yml -f web-interface-backend/docker-compose.yml -f web-interface-frontend/docker-compose.yml down --force-recreate -d
