build:
	docker build -t alpine-rabbitmq --rm=true .

debug:
	docker run -i -t --entrypoint=sh alpine-rabbitmq

run:
	docker run -i -P -d --name=osiris-rabbitmq -p 15672:15672 -p 5672:5672 alpine-rabbitmq
