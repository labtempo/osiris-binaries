build:
	docker build -t alpine-virtualsensornet-omcp --rm=true .

config:
	./configure.sh

run:
	docker run -i -P -d --name=osiris-virtualsensornet-omcp -p 8091:8091 alpine-virtualsensornet-omcp
