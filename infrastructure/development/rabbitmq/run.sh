#!/bin/bash
docker build -t myrabbitmq - < Dockerfile
docker run --name rabbitmq -d -it -h localhost -p 5672:5672 -p 15672:15672 -v /opt/rabbitmq:/var/lib/rabbitmq myrabbitmq
