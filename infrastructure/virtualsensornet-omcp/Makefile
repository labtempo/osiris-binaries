config:
	./configure.sh

build:
	docker build -t alpine-virtualsensornet-omcp --rm=true .

run:
	docker run -i -P -d --name=osiris-virtualsensornet-omcp -p 8091:8091 alpine-virtualsensornet-omcp
