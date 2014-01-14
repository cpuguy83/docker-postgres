#!/bin/bash

if [[ ! -z "$MASTER_PORT_5432_TCP_ADDR" ]]; then
	conn_info="host=${MASTER_PORT_5432_TCP_ADDR} user=replication password=${REPLICATION_PASS}"

	echo "primary_conninfo = '${conn_info}'" > /var/lib/postgresql/9.1/main/recovery.conf
	echo "standby_mode = 'on'" >> /var/lib/postgresql/9.1/main/recovery.conf 
fi
sysctl -w kernel.shmmax=4418740224
su postgres -c "/usr/lib/postgresql/9.1/bin/postgres -D /var/lib/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf $PG_CONFIG"
