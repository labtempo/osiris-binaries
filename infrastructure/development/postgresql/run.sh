#!/bin/bash

docker build -t osiris-postgresql_dev .
docker run --name osiris-postgresql_dev -d -p 5432:5432 osiris-postgresql_dev
