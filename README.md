docker-postgres
===============

Runs postgres as either standalone, or master/slave

### Configuration Options (Env vars)
```
ROOT_PASS=pgpass # sets the root password
REPLICATION_USER=replication # sets the replication user
REPLICATION_PASS=replpass # sets the replication user's password
MASTER_HOST=$MASTER_PORT_5432_TCP_ADDR # sets the master host address
PG_CONFIG # Passes into postgres process
```
You can either pass these options into the docker or add your customisations to /etc/default/postgres

