#!/bin/bash
LOCAL_USER=$(whoami)
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres
createdb sensornet
createdb virtualsensornet
createdb osirisweb
psql <<EOF
ALTER USER postgres PASSWORD 'postgres';
\q
EOF
su $LOCAL_USER
