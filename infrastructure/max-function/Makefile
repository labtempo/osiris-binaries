config:
	./configure.sh

build:
	docker build -t alpine-max-function --rm=true .

run:
	docker run -i -P -d --name=osiris-max-function -p 8094:8094 alpine-max-function
