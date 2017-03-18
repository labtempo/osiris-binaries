run:
	docker run -i -P -d --name=virtualsensornet-postgresql -p 5432:5432 kiasaki/alpine-postgres

database:
	psql -h localhost -p 5432 -U postgres --command="CREATE DATABASE OsirisVSN OWNER postgres;"
