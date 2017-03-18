run-container:
	docker run -i -P -d --name=sensornet-postgresql -p 5432:5432 kiasaki/alpine-postgres

stop-container:
	docker ps | grep sensornet-postgresql > /dev/null && docker stop sensornet-postgresql

remove-container:
	docker ps -a | grep sensornet-postgresql > /dev/null && docker rm sensornet-postgresql

create-database:
	psql -h localhost -p 5432 -U postgres --command="CREATE DATABASE OsirisSN OWNER postgres;"

drop-database:
	psql -h localhost -p 5432 -U postgres --command="DROP DATABASE IF EXISTS OsirisSN;"
