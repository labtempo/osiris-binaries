config:
	./configure.sh

build:
	docker build -t alpine-average-function --rm=true .

run:
	docker run -i -P -d --name=osiris-average-function -p 8093:8093 alpine-average-function
