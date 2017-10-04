run:
	docker run -i -P -d --name=osiris-virtualsensornet-postgresql -e PGPASSWORD='postgres' -e POSTGRES_DB=virtualsensornet -p 5433:5432 kiasaki/alpine-postgres

stop:
	docker stop osiris-virtualsensornet-postgresql

remove:
	docker rm osiris-virtualsensornet-postgresql
