build:
	docker build -t alpine-sensornet-omcp --rm=true .

debug:
	docker run -i -t --entrypoint=sh alpine-sensornet-omcp

run:
	docker run -i -P --name=osiris-sensornet-omcp -p 8091:8091 alpine-sensornet-omcp
