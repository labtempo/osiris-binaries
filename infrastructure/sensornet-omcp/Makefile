build:
	docker build -t alpine-sensornet-omcp --rm=true .

config:
	. ./configure.sh

run:
	docker run -i -P -d --name=osiris-sensornet-omcp -p 8090:8090 alpine-sensornet-omcp
