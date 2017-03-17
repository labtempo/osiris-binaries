build:
	docker build -t alpine-postgres --rm=true .

debug:
	docker run -i -t --entrypoint=sh alpine-postgres

run:
	docker run -i -P -d --name=osiris-postgresql -p 5432:5432 alpine-postgres
