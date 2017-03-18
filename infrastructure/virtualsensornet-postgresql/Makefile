run-container:
	docker run -i -P -d --name=virtualsensornet-postgresql -p 5433:5432 kiasaki/alpine-postgres

stop-container:
	docker ps | grep virtualsensornet-postgresql > /dev/null && docker stop virtualsensornet-postgresql

remove-container:
	docker ps -a | grep virtualsensornet-postgresql > /dev/null && docker rm virtualsensornet-postgresql

create-database:
	psql -h localhost -p 5433 -U postgres --command="CREATE DATABASE OsirisVSN OWNER postgres;"

drop-database:
	psql -h localhost -p 5433 -U postgres --command="DROP DATABASE IF EXISTS OsirisVSN;"
