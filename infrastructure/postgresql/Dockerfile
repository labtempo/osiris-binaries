FROM ubuntu

ARG POSTGRESQL_PORT=5432
ARG POSTGRESQL_USER_NAME=osiris
ARG POSTGRESQL_USER_PASSWORD=osiris
ARG POSTGRESQL_SENSORNET_DB_NAME=OsirisSN
ARG POSTGRESQL_SENSORNETWEB_DB_NAME=OsirisWebSN
ARG POSTGRESQL_VIRTUALSENSORNET_DB_NAME=OsirisVSN
ARG POSTGRESQL_VIRTUALSENSORNETWEB_DB_NAME=OsirisWebVSN

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER ${POSTGRESQL_USER_NAME} WITH SUPERUSER PASSWORD '${POSTGRESQL_USER_PASSWORD}';" &&\
    psql --command "DROP DATABASE IF EXISTS ${POSTGRESQL_SENSORNET_DB_NAME};" &&\
    createdb -O ${POSTGRESQL_USER_NAME} ${POSTGRESQL_SENSORNET_DB_NAME} &&\
    psql --command "DROP DATABASE IF EXISTS ${POSTGRESQL_SENSORNETWEB_DB_NAME};" &&\
    createdb -O ${POSTGRESQL_USER_NAME} ${POSTGRESQL_SENSORNETWEB_DB_NAME} &&\
    psql --command "DROP DATABASE IF EXISTS ${POSTGRESQL_VIRTUALSENSORNET_DB_NAME};" &&\
    createdb -O ${POSTGRESQL_USER_NAME} ${POSTGRESQL_VIRTUALSENSORNET_DB_NAME} &&\
    psql --command "DROP DATABASE IF EXISTS ${POSTGRESQL_VIRTUALSENSORNETWEB_DB_NAME};" &&\
    createdb -O ${POSTGRESQL_USER_NAME} ${POSTGRESQL_VIRTUALSENSORNETWEB_DB_NAME}

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]