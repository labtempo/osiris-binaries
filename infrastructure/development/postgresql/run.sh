#!/bin/bash

docker build -t eg_postgresql .
docker run -d -p 5432:5432 eg_postgresql