#!/bin/bash
docker build -t osiris-rabbitmq_dev - < Dockerfile
docker run --name osiris-rabbitmq_dev -d -it -h localhost -p 5672:5672 -p 15672:15672 -v /opt/rabbitmq:/var/lib/rabbitmq myrabbitmq
