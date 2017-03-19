run:
	docker run -i -P -d --name=sensornet-postgresql -e POSTGRES_PASSWORD=postgres -p 5432:5432 kiasaki/alpine-postgres

stop:
	docker ps | grep sensornet-postgresql > /dev/null && docker stop sensornet-postgresql

remove:
	docker ps -a | grep sensornet-postgresql > /dev/null && docker rm sensornet-postgresql

create:
	export PGPASSWORD='postgres' && psql -h localhost -p 5432 -U postgres --command="CREATE DATABASE sensornet OWNER postgres;" && unset PGPASSWORD

drop:
	export PGPASSWORD='postgres' && psql -h localhost -p 5432 -U postgres --command="DROP DATABASE IF EXISTS sensornet;" && unset PGPASSWORD
