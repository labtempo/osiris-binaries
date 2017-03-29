run:
	docker run -i -P -d --name=sensornet-postgresql -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=sensornet -p 5432:5432 kiasaki/alpine-postgres

stop:
	docker stop sensornet-postgresql

remove:
	docker rm sensornet-postgresql
