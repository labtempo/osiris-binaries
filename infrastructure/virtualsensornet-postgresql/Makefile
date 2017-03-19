run:
	docker run -i -P -d --name=virtualsensornet-postgresql -e PGPASSWORD='postgres' -p 5433:5432 kiasaki/alpine-postgres

stop:
	docker ps | grep virtualsensornet-postgresql > /dev/null && docker stop virtualsensornet-postgresql

remove:
	docker ps -a | grep virtualsensornet-postgresql > /dev/null && docker rm virtualsensornet-postgresql

create:
	export PGPASSWORD='postgres' && psql -h localhost -p 5433 -U postgres --command="CREATE DATABASE virtualsensornet OWNER postgres;" && unset PGPASSWORD='postgres'

drop:
	export PGPASSWORD='postgres' && psql -h localhost -p 5433 -U postgres --command="DROP DATABASE IF EXISTS virtualsensornet;" && unset PGPASSWORD='postgres'
