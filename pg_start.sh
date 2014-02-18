#!/bin/bash
if [ -e /etc/default/postgres ]; then
  . /etc/default/postgres
fi

if [ -z $ROOT_PASS ]; then
  export ROOT_PASS=pgpass
fi

if [ -z $REPLICATION_USER ]; then
  export REPLICATION_USER=replication
fi

if [ -z $REPLICATION_PASS ]; then
  export REPLICATION_PASS=replpass
fi

if [ -z $MASTER_HOST ]; then
  MASTER_HOST=$MASTER_PORT_5432_TCP_ADDR
fi

if [ ! -e /var/lib/postgresql/db_setup ]; then
  sysctl -w kernel.shmmax=4418740224 && /etc/init.d/postgresql start && su postgres -c "createuser -s -d root && psql -c \"ALTER USER root with PASSWORD '${ROOT_PASS}'; CREATE USER ${REPLICATION_USER} REPLICATION LOGIN PASSWORD '${REPLICATION_PASS}'\"" && touch /var/lib/postgresql/db_setup
  /etc/init.d/postgresql stop
fi

if [[ ! -z "$MASTER_HOST" ]]; then
  conn_info="host=${MASTER_HOST} user=${REPLICATION_USER} password=${REPLICATION_PASS}"

  echo "primary_conninfo = '${conn_info}'" > /var/lib/postgresql/9.1/main/recovery.conf
  echo "standby_mode = 'on'" >> /var/lib/postgresql/9.1/main/recovery.conf
fi
sysctl -w kernel.shmmax=4418740224
chown -R postgres.postgres /var/lib/postgresql

exec su postgres -c "/usr/lib/postgresql/9.1/bin/postgres -D /var/lib/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf $PG_CONFIG"
