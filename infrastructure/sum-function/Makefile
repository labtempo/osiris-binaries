config:
	./configure.sh

build:
	docker build -t alpine-sum-function --rm=true .

run:
	docker run -i -P -d --name=osiris-sum-function -p 8092:8092 alpine-sum-function
