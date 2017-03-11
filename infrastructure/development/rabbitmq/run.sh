#!/bin/bash
docker build -t myrabbitmq - < Dockerfile
    docker run -d -it -h localhost -p 15672:15672 -v /opt/rabbitmq:/var/lib/rabbitmq myrabbitmq