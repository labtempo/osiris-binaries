config:
	./configure.sh

build:
	docker build -t alpine-min-function --rm=true .

run:
	docker run -i -P -d --name=osiris-min-function -p 8095:8095 alpine-min-function
