build:
	docker build -t alpine-rabbitmq --rm=true .

run:
	docker run -i -P -d --name=osiris-rabbitmq -p 15672:15672 -p 5672:5672 alpine-rabbitmq

stop:
	docker stop osiris-rabbitmq

remove:
	docker rm osiris-rabbitmq
